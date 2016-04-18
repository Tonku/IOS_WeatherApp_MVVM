//
//  WeatherCondition.m
//  SampleWeather
//
//  Created by Tony Thomas on 07/04/16.
//  Copyright © 2016 Tony Thomas. All rights reserved.
//

#import "WeatherCondition.h"

@implementation WeatherCondition



+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             
             @"time": @"time",
             @"weatherSummery": @"summary",
             @"icon": @"icon",
             @"precipitationIntensity": @"precipIntensity",
             @"precipitationProbability": @"precipProbability",
             @"precipitationType": @"precipType",
             @"precipitationAccumulation": @"precipAccumulation",
             @"temperature": @"temperature",
             @"apparentTemperature": @"apparentTemperature",
             @"dewPoint": @"dewPoint",
             @"humidity": @"humidity",
             @"windSpeed": @"windSpeed",
             @"windBearing": @"windBearing",
             @"cloudCover": @"cloudCover",
             @"pressure": @"pressure",
             @"ozone": @"ozone",
             
             };
}
//Custom transformation is needed only for time 
+ (NSValueTransformer *)timeJSONTransformer {
    
    
    return [MTLValueTransformer transformerUsingForwardBlock:^(NSString *str, BOOL *success, NSError **error){
        
        return [NSDate dateWithTimeIntervalSince1970:str.floatValue];
        
    } reverseBlock:^(NSDate *date, BOOL *success, NSError **error) {
        
        return [NSString stringWithFormat:@"%f", [date timeIntervalSince1970]];
    }];
    
}



@end
