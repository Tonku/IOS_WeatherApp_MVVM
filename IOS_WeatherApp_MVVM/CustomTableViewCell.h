//
//  CustomTableViewCell.h
//  WestpackSample
//
//  Created by Tony Thomas on 09/04/16.
//  Copyright © 2016 Tony Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherCondition.h"

/**
 Custom table view cell, class it displays the formatted weather
 */
@interface CustomTableViewCell : UITableViewCell

//Set the weather condition in the cell
- (void)setWeather:(WeatherCondition*)weather;
//Set custom title for segments
- (void)setSegmentTitle:(NSString*)title;
//Convertion from fahrenheit to celsius
- (float)convertToCelsius:(float)fahrenheit;
//Convertion from celsius to fahrenheit
- (float)convertToFahrenheit:(float)celsius;
@end
