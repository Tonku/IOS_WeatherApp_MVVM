//
//  WeatherNowView.m
//  WestpackSample
//
//  Created by Tony Thomas on 08/04/16.
//  Copyright © 2016 Tony Thomas. All rights reserved.
//

#import "WeatherNowView.h"

@interface WeatherNowView(){
    
    
}


@property (nonatomic, strong)   UILabel *currentLocation;
@property (nonatomic, strong)   UIImageView *weatherIcon;
@property (nonatomic, strong)   UILabel *temperature;
@property (nonatomic, strong)   UILabel *weatherSummery;
@end

@implementation WeatherNowView


-(id)initWithFrame:(CGRect)frame{
    
    
    self = [super initWithFrame:frame];
    [self setupSubViews];
    return self;
}


-(void)setupSubViews{
    
    CGRect bounds = self.bounds;
    
    int labelHeight = 40;
    int weatherIconHeight = 60;

    int topPadding = bounds.size.height/4;
    int screenWidth = bounds.size.width;
    int verticalSpacing = 40;
    int iconRectWidth = 60;
    int temperatureWidth = 100;
    
    CGRect rectLocation = CGRectMake(0, topPadding, screenWidth, labelHeight);
    CGRect rectWeatherIcon = CGRectMake(screenWidth/2-iconRectWidth, topPadding+labelHeight+verticalSpacing, iconRectWidth, weatherIconHeight);
    CGRect rectTemperature = CGRectMake(screenWidth/2, topPadding+labelHeight+verticalSpacing, temperatureWidth, weatherIconHeight);
    CGRect rectWeatherSummery = CGRectMake(0, topPadding+labelHeight+3*verticalSpacing, screenWidth, labelHeight);
    
    
    self.currentLocation = [[UILabel alloc]initWithFrame:rectLocation];
    self.currentLocation.textAlignment = NSTextAlignmentCenter;
    self.currentLocation.textColor = [UIColor whiteColor];
    self.currentLocation.font = [UIFont systemFontOfSize:18];
    
    
    self.weatherIcon = [[UIImageView alloc]initWithFrame:rectWeatherIcon];
    self.weatherIcon.contentMode = UIViewContentModeScaleAspectFill;
    
    
    self.temperature = [[UILabel alloc]initWithFrame:rectTemperature];
    self.temperature.textAlignment = NSTextAlignmentCenter;
    self.temperature.textColor = [UIColor whiteColor];
    self.temperature.font = [UIFont systemFontOfSize:28];
    
    
    UILabel* weatherSummery = [[UILabel alloc]initWithFrame:rectWeatherSummery];
    weatherSummery.textAlignment = NSTextAlignmentCenter;
    weatherSummery.textColor = [UIColor whiteColor];
    weatherSummery.font = [UIFont systemFontOfSize:16];
    
    [self addSubview:self.currentLocation];
    [self addSubview:self.weatherIcon];
    [self addSubview:self.temperature];
    [self addSubview:self.weatherSummery];
}

-(void)setWeatherConditionNow:(WeatherCondition*)now{
    
  
    self.weatherIcon.image = [UIImage imageNamed:now.icon];
    self.temperature.text = [NSString stringWithFormat:@"%.1f°C",[self convertToCelsius:now.temperature.floatValue]];
    self.weatherSummery.text = now.weatherSummery;
}
//convert to celsius 
- (float)convertToCelsius:(float)fahrenheit{
    
    return (fahrenheit-32)*5/9;
    
}
- (void)SetCurrentPlaceName:(NSString*)name{
    
    self.currentLocation.text = name;
}
@end
