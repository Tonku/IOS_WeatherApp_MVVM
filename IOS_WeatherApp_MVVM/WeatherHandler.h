//
//  WeatherHandler.h
//  SampleWeather
//
//  Created by Tony Thomas on 07/04/16.
//  Copyright © 2016 Tony Thomas. All rights reserved.
//


@import Foundation;

#import "WeatherForecast.h"

/**
 `WeatherHandler` is the class which manages the location service and 
  rest services.It also manages the model object for the json obtained from
  the webservice call.This object is the view model class which is owned by 
  the main view controller `WeatherViewController`.The `weatherForcast` property
  of this object is KV observed by the view controller and hence get notified about
  the change in model.This will trigger a reload of the tableview data.
 */
@interface WeatherHandler : NSObject

//The model object mapped from the JSON model.
@property (nonatomic, strong) WeatherForecast *weatherForcast;
@property (nonatomic, strong) NSString *currentPlace;
@end
