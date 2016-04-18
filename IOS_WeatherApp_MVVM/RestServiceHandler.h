//
//  WeatherApiHandler.h
//  SampleWeather
//
//  Created by Tony Thomas on 07/04/16.
//  Copyright © 2016 Tony Thomas. All rights reserved.
//
@import CoreLocation;

#import "WeatherForecast.h"

/**
 Handles the rest service.Manages the download of the JSON from the webservice
*/
@interface RestServiceHandler : NSObject

//Get the weather at the location.`weatherDataInJson` is the weather data dictionary.`success` is the
//success block and `failure` is the failure block.
- (void)getWeatherInLocation:(CLLocation*)location onSuccess:(void (^)(NSDictionary *weatherDataInJson))success onFailure:(void (^)(NSError *error))failure;

@end
