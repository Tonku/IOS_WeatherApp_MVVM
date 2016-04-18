//
//  CustomTableViewCell.m
//  WestpackSample
//
//  Created by Tony Thomas on 09/04/16.
//  Copyright © 2016 Tony Thomas. All rights reserved.
//

#import "CustomTableViewCell.h"
#import "WeatherCondition.h"
#import "DailyWeatherCondition.h"

@interface CustomTableViewCell ()

@property (nonatomic, strong)   NSDateFormatter *hourFormatter;
@property (nonatomic, strong)   NSDateFormatter *dayFormatter;

@end

@implementation CustomTableViewCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    //Date and time format
    self.hourFormatter = [[NSDateFormatter alloc] init];
    self.hourFormatter.dateFormat = @"h a";
    
    self.dayFormatter = [[NSDateFormatter alloc] init];
    self.dayFormatter.dateFormat = @"EEE";
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];

    return self;
}

-(void)setWeather:(WeatherCondition*)weather{
    
    self.textLabel.textColor = [UIColor whiteColor];
    self.detailTextLabel.textColor = [UIColor whiteColor];

    //Check the type of the object and format the cells accordingly.
    if ( [weather isKindOfClass:DailyWeatherCondition.class]) {//Daily
        
        self.textLabel.font = [UIFont systemFontOfSize:12];
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
        DailyWeatherCondition* dailyWeather = (DailyWeatherCondition*)weather;
        
        self.textLabel.text =[NSString stringWithFormat:@"%@ : %.0f/%.0f°C\n\n",[self.dayFormatter stringFromDate:dailyWeather.time],
                              [self convertToCelsius:[dailyWeather.temperatureMinimum floatValue]],[self convertToCelsius:[dailyWeather.temperatureMmaximum floatValue]]];
        self.detailTextLabel.text =  weather.weatherSummery;
        self.imageView.image = [UIImage imageNamed:dailyWeather.icon];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    else{//Hourly
        
        self.textLabel.font = [UIFont systemFontOfSize:13];
        self.detailTextLabel.font = [UIFont systemFontOfSize:13];
        self.textLabel.text = weather.weatherSummery;
        self.detailTextLabel.text = [NSString stringWithFormat:@"%@ %.0f°C",[self.hourFormatter stringFromDate:weather.time],[self convertToCelsius:[weather.temperature floatValue]]];
        self.imageView.image = [UIImage imageNamed:weather.icon];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;

    }
}
-(void)setSegmentTitle:(NSString*)title{
    
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.font = [UIFont systemFontOfSize:18];
    self.textLabel.text = title;
    self.detailTextLabel.text = @"";
    self.imageView.image = nil;
}
- (float)convertToCelsius:(float)fahrenheit{
    
    return (fahrenheit-32)*5/9;
    
}
- (float)convertToFahrenheit:(float)celsius{
    
    return celsius*9/5+32;
}
@end
