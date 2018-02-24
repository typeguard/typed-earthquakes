// To parse and unparse this JSON data, add this code to your project and do:
//
//    earthquakes, err := UnmarshalEarthquakes(bytes)
//    bytes, err = earthquakes.Marshal()

package main

import "encoding/json"

func UnmarshalEarthquakes(data []byte) (Earthquakes, error) {
	var r Earthquakes
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *Earthquakes) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

type Earthquakes struct {
	Type     string    `json:"type"`    
	Metadata Metadata  `json:"metadata"`
	Features []Feature `json:"features"`
	Bbox     []float64 `json:"bbox"`    
}

type Feature struct {
	Type       string     `json:"type"`      
	Properties Properties `json:"properties"`
	Geometry   Geometry   `json:"geometry"`  
	ID         string     `json:"id"`        
}

type Geometry struct {
	Type        string    `json:"type"`       
	Coordinates []float64 `json:"coordinates"`
}

type Properties struct {
	Mag     float64     `json:"mag"`    
	Place   string      `json:"place"`  
	Time    int64       `json:"time"`   
	Updated int64       `json:"updated"`
	Tz      int64       `json:"tz"`     
	URL     string      `json:"url"`    
	Detail  string      `json:"detail"` 
	Felt    interface{} `json:"felt"`   
	Cdi     interface{} `json:"cdi"`    
	MMI     interface{} `json:"mmi"`    
	Alert   interface{} `json:"alert"`  
	Status  string      `json:"status"` 
	Tsunami int64       `json:"tsunami"`
	Sig     int64       `json:"sig"`    
	Net     string      `json:"net"`    
	Code    string      `json:"code"`   
	IDS     string      `json:"ids"`    
	Sources string      `json:"sources"`
	Types   string      `json:"types"`  
	Nst     int64       `json:"nst"`    
	Dmin    float64     `json:"dmin"`   
	RMS     float64     `json:"rms"`    
	Gap     int64       `json:"gap"`    
	MagType string      `json:"magType"`
	Type    string      `json:"type"`   
	Title   string      `json:"title"`  
}

type Metadata struct {
	Generated int64  `json:"generated"`
	URL       string `json:"url"`      
	Title     string `json:"title"`    
	Status    int64  `json:"status"`   
	API       string `json:"api"`      
	Count     int64  `json:"count"`    
}
