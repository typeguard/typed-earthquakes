#import "earthquakes.h"

#define λ(decl, expr) (^(decl) { return (expr); })

static id NSNullify(id _Nullable x) {
    return (x == nil || x == NSNull.null) ? NSNull.null : x;
}

NS_ASSUME_NONNULL_BEGIN

@interface QTEarthquakes (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTFeature (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTGeometry (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTProperties (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

@interface QTMetadata (JSONConversion)
+ (instancetype)fromJSONDictionary:(NSDictionary *)dict;
- (NSDictionary *)JSONDictionary;
@end

static id map(id collection, id (^f)(id value)) {
    id result = nil;
    if ([collection isKindOfClass:NSArray.class]) {
        result = [NSMutableArray arrayWithCapacity:[collection count]];
        for (id x in collection) [result addObject:f(x)];
    } else if ([collection isKindOfClass:NSDictionary.class]) {
        result = [NSMutableDictionary dictionaryWithCapacity:[collection count]];
        for (id key in collection) [result setObject:f([collection objectForKey:key]) forKey:key];
    }
    return result;
}

#pragma mark - JSON serialization

QTEarthquakes *_Nullable QTEarthquakesFromData(NSData *data, NSError **error)
{
    @try {
        id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:error];
        return *error ? nil : [QTEarthquakes fromJSONDictionary:json];
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

QTEarthquakes *_Nullable QTEarthquakesFromJSON(NSString *json, NSStringEncoding encoding, NSError **error)
{
    return QTEarthquakesFromData([json dataUsingEncoding:encoding], error);
}

NSData *_Nullable QTEarthquakesToData(QTEarthquakes *earthquakes, NSError **error)
{
    @try {
        id json = [earthquakes JSONDictionary];
        NSData *data = [NSJSONSerialization dataWithJSONObject:json options:kNilOptions error:error];
        return *error ? nil : data;
    } @catch (NSException *exception) {
        *error = [NSError errorWithDomain:@"JSONSerialization" code:-1 userInfo:@{ @"exception": exception }];
        return nil;
    }
}

NSString *_Nullable QTEarthquakesToJSON(QTEarthquakes *earthquakes, NSStringEncoding encoding, NSError **error)
{
    NSData *data = QTEarthquakesToData(earthquakes, error);
    return data ? [[NSString alloc] initWithData:data encoding:encoding] : nil;
}

@implementation QTEarthquakes
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"type": @"type",
        @"metadata": @"metadata",
        @"features": @"features",
        @"bbox": @"bbox",
    };
}

+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error
{
    return QTEarthquakesFromData(data, error);
}

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return QTEarthquakesFromJSON(json, encoding, error);
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[QTEarthquakes alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _metadata = [QTMetadata fromJSONDictionary:(id)_metadata];
        _features = map(_features, λ(id x, [QTFeature fromJSONDictionary:x]));
    }
    return self;
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTEarthquakes.properties.allValues] mutableCopy];

    [dict addEntriesFromDictionary:@{
        @"metadata": [_metadata JSONDictionary],
        @"features": map(_features, λ(id x, [x JSONDictionary])),
    }];

    return dict;
}

- (NSData *_Nullable)toData:(NSError *_Nullable *)error
{
    return QTEarthquakesToData(self, error);
}

- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error
{
    return QTEarthquakesToJSON(self, encoding, error);
}
@end

@implementation QTFeature
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"type": @"type",
        @"properties": @"properties",
        @"geometry": @"geometry",
        @"id": @"identifier",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[QTFeature alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        _properties = [QTProperties fromJSONDictionary:(id)_properties];
        _geometry = [QTGeometry fromJSONDictionary:(id)_geometry];
    }
    return self;
}

- (void)setValue:(nullable id)value forKey:(NSString *)key
{
    id resolved = QTFeature.properties[key];
    if (resolved) [super setValue:value forKey:resolved];
}

- (NSDictionary *)JSONDictionary
{
    id dict = [[self dictionaryWithValuesForKeys:QTFeature.properties.allValues] mutableCopy];

    for (id jsonName in QTFeature.properties) {
        id propertyName = QTFeature.properties[jsonName];
        if (![jsonName isEqualToString:propertyName]) {
            dict[jsonName] = dict[propertyName];
            [dict removeObjectForKey:propertyName];
        }
    }

    [dict addEntriesFromDictionary:@{
        @"properties": [_properties JSONDictionary],
        @"geometry": [_geometry JSONDictionary],
    }];

    return dict;
}
@end

@implementation QTGeometry
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"type": @"type",
        @"coordinates": @"coordinates",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[QTGeometry alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTGeometry.properties.allValues];
}
@end

@implementation QTProperties
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"mag": @"mag",
        @"place": @"place",
        @"time": @"time",
        @"updated": @"updated",
        @"tz": @"tz",
        @"url": @"url",
        @"detail": @"detail",
        @"felt": @"felt",
        @"cdi": @"cdi",
        @"mmi": @"mmi",
        @"alert": @"alert",
        @"status": @"status",
        @"tsunami": @"tsunami",
        @"sig": @"sig",
        @"net": @"net",
        @"code": @"code",
        @"ids": @"ids",
        @"sources": @"sources",
        @"types": @"types",
        @"nst": @"nst",
        @"dmin": @"dmin",
        @"rms": @"rms",
        @"gap": @"gap",
        @"magType": @"magType",
        @"type": @"type",
        @"title": @"title",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[QTProperties alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTProperties.properties.allValues];
}
@end

@implementation QTMetadata
+ (NSDictionary<NSString *, NSString *> *)properties
{
    static NSDictionary<NSString *, NSString *> *properties;
    return properties = properties ? properties : @{
        @"generated": @"generated",
        @"url": @"url",
        @"title": @"title",
        @"status": @"status",
        @"api": @"api",
        @"count": @"count",
    };
}

+ (instancetype)fromJSONDictionary:(NSDictionary *)dict
{
    return dict ? [[QTMetadata alloc] initWithJSONDictionary:dict] : nil;
}

- (instancetype)initWithJSONDictionary:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

- (NSDictionary *)JSONDictionary
{
    return [self dictionaryWithValuesForKeys:QTMetadata.properties.allValues];
}
@end

NS_ASSUME_NONNULL_END
