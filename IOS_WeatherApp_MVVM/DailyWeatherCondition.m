//
//  DailyWeatherCondition.m
//  SampleWeather
//
//  Created by Tony Thomas on 07/04/16.
//  Copyright © 2016 Tony Thomas. All rights reserved.
//

#import "DailyWeatherCondition.h"

@implementation DailyWeatherCondition


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
    NSMutableDictionary *map = [[super JSONKeyPathsByPropertyKey] mutableCopy];
  
    map[@"sunRiseTime"] = @"sunriseTime";
    map[@"sunSetTime"] = @"sunsetTime";
    map[@"precipitationIntensityMaximum"] = @"precipIntensityMax";
    map[@"precipitationIntensityMaximumTime"] = @"precipIntensityMaxTime";
    map[@"temperatureMinimum"] = @"temperatureMin";
    map[@"timeOfMinimumTemperature"] = @"temperatureMinTime";
    map[@"minimumApparentTemperature"] = @"apparentTemperatureMin";
    map[@"timeOfMinimumApparentTemperature"] = @"apparentTemperatureMinTime";
    map[@"temperatureMmaximum"] = @"temperatureMax";
    map[@"timeOfMaximumTemperature"] = @"temperatureMaxTime";
    map[@"maximumApparentTemperature"] = @"apparentTemperatureMax";
    map[@"timeOfMaximumApparentTemperature"] = @"apparentTemperatureMaxTime";
    return map;
    
}

//Custom transformation is needed only for time
+ (NSValueTransformer *)customDateJSONTransformer {
    
    
    return [MTLValueTransformer transformerUsingForwardBlock:^(NSString *str, BOOL *success, NSError **error){
        
        return [NSDate dateWithTimeIntervalSince1970:str.floatValue];
        
    } reverseBlock:^(NSDate *date, BOOL *success, NSError **error) {
        
        return [NSString stringWithFormat:@"%f", [date timeIntervalSince1970]];
    }];
    
}

+ (NSValueTransformer *)timeOfMinimumTemperatureJSONTransformer {
    
    return [DailyWeatherCondition customDateJSONTransformer];
}

+ (NSValueTransformer *)timeOfMinimumApparentTemperatureJSONTransformer {
    
    return [DailyWeatherCondition customDateJSONTransformer];
}

+ (NSValueTransformer *)timeOfMaximumTemperatureJSONTransformer {
    
    return [DailyWeatherCondition customDateJSONTransformer];
}

+ (NSValueTransformer *)timeOfMaximumApparentTemperatureJSONTransformer {
    
    return [DailyWeatherCondition customDateJSONTransformer];
}

@end
