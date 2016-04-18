//
//  WeatherApiHandler.m
//  SampleWeather
//
//  Created by Tony Thomas on 07/04/16.
//  Copyright © 2016 Tony Thomas. All rights reserved.
//

#import "RestServiceHandler.h"

static NSString *const kApiKey = @"6b562c90366805a061b3f04a983de73f";

@implementation RestServiceHandler

-(void)getWeatherInLocation:(CLLocation*)location onSuccess:(void (^)(NSDictionary *weatherDataInJson))success onFailure:(void (^)(NSError *error))failure{
 
    

   
    
    NSString* path = [NSString stringWithFormat:@"https://api.forecast.io/forecast/%@/%f,%f",kApiKey, location.coordinate.latitude,location.coordinate.latitude];
    
    
    NSURLSessionDataTask * jsonTask = [[NSURLSession sharedSession]
                                       dataTaskWithURL:[NSURL URLWithString:path]
                                       completionHandler:^(NSData * _Nullable
                                                           data, NSURLResponse * _Nullable
                                                           response, NSError * _Nullable error){
                                            
                                           if (error) {
                                               
                                               failure(error);
                                               return;
                                           }
                                           
                                           
                                           NSDictionary *responseDict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
                                           
                                           if (error) {
                                               
                                                failure(error);
                                               return;
                                           }
                                            success(responseDict);
                                           
                                        }];
    
    [jsonTask resume];
     
}
@end
