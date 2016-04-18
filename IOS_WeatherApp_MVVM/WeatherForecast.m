//
//  WeatherForecast.m
//  SampleWeather
//
//  Created by Tony Thomas on 07/04/16.
//  Copyright © 2016 Tony Thomas. All rights reserved.
//

#import "WeatherForecast.h"
#import "DailyWeatherCondition.h"

@implementation WeatherForecast


+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"weatherConditionNow": @"currently",
             @"hourlyForecast": @"hourly.data",
             @"dailyForecast": @"daily.data",
             
             };
}
//Array transformer returns the object array for hourly weather
+ (NSValueTransformer *)hourlyForecastJSONTransformer {
    
     return [MTLJSONAdapter arrayTransformerWithModelClass:WeatherCondition.class];
    
}
//Array transformer returns the object array for daily weather
+ (NSValueTransformer *)dailyForecastJSONTransformer {
    
   return [MTLJSONAdapter arrayTransformerWithModelClass:DailyWeatherCondition.class];
}
@end
