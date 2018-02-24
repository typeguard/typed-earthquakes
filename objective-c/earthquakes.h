// To parse this JSON:
// 
//   NSError *error;
//   QTEarthquakes *earthquakes = [QTEarthquakes fromJSON:json encoding:NSUTF8Encoding error:&error];

#import <Foundation/Foundation.h>

@class QTEarthquakes;
@class QTFeature;
@class QTGeometry;
@class QTProperties;
@class QTMetadata;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Object interfaces

@interface QTEarthquakes : NSObject
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, strong) QTMetadata *metadata;
@property (nonatomic, copy)   NSArray<QTFeature *> *features;
@property (nonatomic, copy)   NSArray<NSNumber *> *bbox;

+ (_Nullable instancetype)fromJSON:(NSString *)json encoding:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
+ (_Nullable instancetype)fromData:(NSData *)data error:(NSError *_Nullable *)error;
- (NSString *_Nullable)toJSON:(NSStringEncoding)encoding error:(NSError *_Nullable *)error;
- (NSData *_Nullable)toData:(NSError *_Nullable *)error;
@end

@interface QTFeature : NSObject
@property (nonatomic, copy)   NSString *type;
@property (nonatomic, strong) QTProperties *properties;
@property (nonatomic, strong) QTGeometry *geometry;
@property (nonatomic, copy)   NSString *identifier;
@end

@interface QTGeometry : NSObject
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSArray<NSNumber *> *coordinates;
@end

@interface QTProperties : NSObject
@property (nonatomic, assign)         double mag;
@property (nonatomic, copy)           NSString *place;
@property (nonatomic, assign)         NSInteger time;
@property (nonatomic, assign)         NSInteger updated;
@property (nonatomic, assign)         NSInteger tz;
@property (nonatomic, copy)           NSString *url;
@property (nonatomic, copy)           NSString *detail;
@property (nonatomic, nullable, copy) id felt;
@property (nonatomic, nullable, copy) id cdi;
@property (nonatomic, nullable, copy) id mmi;
@property (nonatomic, nullable, copy) id alert;
@property (nonatomic, copy)           NSString *status;
@property (nonatomic, assign)         NSInteger tsunami;
@property (nonatomic, assign)         NSInteger sig;
@property (nonatomic, copy)           NSString *net;
@property (nonatomic, copy)           NSString *code;
@property (nonatomic, copy)           NSString *ids;
@property (nonatomic, copy)           NSString *sources;
@property (nonatomic, copy)           NSString *types;
@property (nonatomic, assign)         NSInteger nst;
@property (nonatomic, assign)         double dmin;
@property (nonatomic, assign)         double rms;
@property (nonatomic, assign)         NSInteger gap;
@property (nonatomic, copy)           NSString *magType;
@property (nonatomic, copy)           NSString *type;
@property (nonatomic, copy)           NSString *title;
@end

@interface QTMetadata : NSObject
@property (nonatomic, assign) NSInteger generated;
@property (nonatomic, copy)   NSString *url;
@property (nonatomic, copy)   NSString *title;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, copy)   NSString *api;
@property (nonatomic, assign) NSInteger count;
@end

NS_ASSUME_NONNULL_END
