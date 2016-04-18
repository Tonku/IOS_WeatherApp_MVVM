//
//  DailyWeatherCondition.h
//  SampleWeather
//
//  Created by Tony Thomas on 07/04/16.
//  Copyright © 2016 Tony Thomas. All rights reserved.
//

#import "WeatherCondition.h"

/**
 Class represents the daily weather condition,a sub class of Weather condition.
 This class has members for representing weather condition for the day.
 This object is a direct mapping from JSON using Mantle framework.
 
 Full JSON data is used
 */
@interface DailyWeatherCondition : WeatherCondition

@property (nonatomic, strong) NSDate *day;
@property (nonatomic, strong) NSNumber *sunRiseTime;
@property (nonatomic, strong) NSNumber *sunSetTime;
@property (nonatomic, strong) NSNumber *moonPhase;
@property (nonatomic, strong) NSNumber *precipitationIntensityMaximum;
@property (nonatomic, strong) NSNumber *precipitationIntensityMaximumTime;
@property (nonatomic, strong) NSNumber *temperatureMinimum;
@property (nonatomic, strong) NSDate *timeOfMinimumTemperature;
@property (nonatomic, strong) NSNumber *minimumApparentTemperature;
@property (nonatomic, strong) NSDate *timeOfMinimumApparentTemperature;
@property (nonatomic, strong) NSNumber *temperatureMmaximum;
@property (nonatomic, strong) NSDate *timeOfMaximumTemperature;
@property (nonatomic, strong) NSNumber *maximumApparentTemperature;
@property (nonatomic, strong) NSDate *timeOfMaximumApparentTemperature;


@end


