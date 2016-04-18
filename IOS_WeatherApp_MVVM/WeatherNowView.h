//
//  WeatherNowView.h
//  WestpackSample
//
//  Created by Tony Thomas on 08/04/16.
//  Copyright © 2016 Tony Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherCondition.h"

/**
 Custom view used as the tableview header view.Shows the location
 time and weather. The weather codition is displayed as weather icon
 */
@interface WeatherNowView : UIView

//Set the weather condition now.
- (void)setWeatherConditionNow:(WeatherCondition*)now;
- (void)SetCurrentPlaceName:(NSString*)name;
@end
