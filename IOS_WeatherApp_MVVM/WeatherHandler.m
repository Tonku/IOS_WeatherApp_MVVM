//
//  WeatherHandler.m
//  SampleWeather
//
//  Created by Tony Thomas on 07/04/16.
//  Copyright © 2016 Tony Thomas. All rights reserved.
//

#import "WeatherHandler.h"
#import "RestServiceHandler.h"
#import "LocationService.h"
#import "WeatherForecast.h"

@interface WeatherHandler() <CLLocationManagerDelegate>

@property (nonatomic, strong) LocationService *locationServie;

@property (nonatomic, strong) RestServiceHandler * restService;

@end

@implementation WeatherHandler


-(id)init{
    
    self = [super init];
    
    self.restService = [[RestServiceHandler alloc]init];
    //Once the location is available fetch the weather data
    self.locationServie = [[LocationService alloc]initWithLocationUpdateHandler:^(CLLocation * location){
        
        [self getWeatherInLocation:location];
        
    }];
    
    return self;
}
#pragma mark Weather fetch
//Download weather info as json and convert it to Mantle model objects
-(void)getWeatherInLocation:(CLLocation*)location{
    
    //Restrict once reqest at a time
    static BOOL requstInProgress;
    
    if (requstInProgress) {
        
        return;
    }
    [self.restService getWeatherInLocation:location onSuccess:^(NSDictionary *weatherDataInJson) {
        
        NSError *error;
        WeatherForecast *weatherForcast = [MTLJSONAdapter modelOfClass:WeatherForecast.class
                                                    fromJSONDictionary:weatherDataInJson error:&error];
        self.weatherForcast = weatherForcast;
       
        self.currentPlace = self.locationServie.currentLocationName;
       
        requstInProgress = NO;

        
    } onFailure:^(NSError *error) {
        
        requstInProgress = NO;
    } ];
     
}



@end
