//
//  WeatherForecast.h
//  SampleWeather
//
//  Created by Tony Thomas on 07/04/16.
//  Copyright © 2016 Tony Thomas. All rights reserved.
//

@import Foundation;
#import <Mantle/Mantle.h>
#import "WeatherCondition.h"

/**
 The entire weather details available from the webservice is mapped to this
 model object.this object is a direct mapping from JSON using Mantle framework.
 It has a weather condition for the current hour.It has an array of hourly weather
 condition for the next 47 hours.Daily weather condition is available for the entire
 week.
 
 Entire JSON is mapped
 */
@interface WeatherForecast :  MTLModel <MTLJSONSerializing>

//Weather condition for the time being
@property (nonatomic, strong, readonly) WeatherCondition *weatherConditionNow;
//Weather condition for the next 48 hours
@property (nonatomic, strong, readonly) NSArray *hourlyForecast;
//Weather condition for the next 7 days
@property (nonatomic, strong, readonly) NSArray *dailyForecast;

@end
