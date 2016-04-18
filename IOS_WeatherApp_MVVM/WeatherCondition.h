//
//  WeatherCondition.h
//  SampleWeather
//
//  Created by Tony Thomas on 07/04/16.
//  Copyright © 2016 Tony Thomas. All rights reserved.
//

@import Foundation;
#import <Mantle/Mantle.h>

/**
 Class represents the weather condition.
 This class has members for representing weather condition for the hour.
 This object is a direct mapping from JSON using Mantle framework.
 
  Full JSON data is used
 */
@interface WeatherCondition :  MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSDate *time;
@property (nonatomic, strong) NSString *weatherSummery;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSNumber *precipitationIntensity;
@property (nonatomic, strong) NSNumber *precipitationProbability;
@property (nonatomic, strong) NSString *precipitationType;
@property (nonatomic, strong) NSNumber *precipitationAccumulation;
@property (nonatomic, strong) NSNumber *temperature;
@property (nonatomic, strong) NSNumber *apparentTemperature;
@property (nonatomic, strong) NSNumber *dewPoint;
@property (nonatomic, strong) NSNumber *humidity;
@property (nonatomic, strong) NSNumber *windSpeed;
@property (nonatomic, strong) NSNumber *windBearing;
@property (nonatomic, strong) NSNumber *cloudCover;
@property (nonatomic, strong) NSNumber *pressure;
@property (nonatomic, strong) NSNumber *ozone;

@end


