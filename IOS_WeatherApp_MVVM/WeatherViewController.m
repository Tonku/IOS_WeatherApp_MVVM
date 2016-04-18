//
//  WeatherViewController.m
//  WestpackSample
//
//  Created by Tony Thomas on 08/04/16.
//  Copyright © 2016 Tony Thomas. All rights reserved.
//
#import "WeatherViewController.h"
#import "WeatherHandler.h"
#import "DailyWeatherCondition.h"
#import "CustomTableViewCell.h"
#import "WeatherNowView.h"
#import "Constants.h"
static void * WeatherContext = &WeatherContext;

@interface WeatherViewController()

@property (nonatomic, strong) WeatherHandler *weatherHandler;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
@property (nonatomic, strong) WeatherNowView *weatherNowView;
@end

@implementation WeatherViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    CGRect rect = self.view.bounds;
    rect.size.height = 250;
    //The header view
    self.weatherNowView = [[WeatherNowView alloc]initWithFrame:rect];
    self.tableView.tableHeaderView = self.weatherNowView;
    self.weatherHandler = [[WeatherHandler alloc]init];
    //KVO
    [self.weatherHandler addObserver:self forKeyPath:NSStringFromSelector(@selector(weatherForcast))
                             options:NSKeyValueObservingOptionNew  context:WeatherContext];
    //Notification center
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedNotification:)
                                                 name:kLocationDenied
                                               object:nil];
    self.statusLabel.text = @"Fetching weather...";
    self.tableView.hidden = YES;
 }
#pragma mark - Notifications and KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change
                                                                       context:(void *)context
{    if (context == WeatherContext) {
        
        if ([keyPath isEqualToString:NSStringFromSelector(@selector(weatherForcast))]) {
            //KVO notification need not be in main thread, so switch to the UI thread  
            dispatch_async(dispatch_get_main_queue(), ^{
                
                self.statusLabel.hidden = YES;
                self.tableView.hidden = NO;
                [self.tableView reloadData];
                [self.weatherNowView setWeatherConditionNow:self.weatherHandler.weatherForcast.weatherConditionNow];
                [self.weatherNowView SetCurrentPlaceName:self.weatherHandler.currentPlace];
            });
        }
    }
}
- (void)receivedNotification:(NSNotification *) notification{
    //Notification center notifications are delivered on the same thread, where they are send
    //Here the sender ensures main thread, so no context switching required
    if ([[notification name] isEqualToString:kLocationDenied]) {
        
         self.statusLabel.text = @"Please enable location service";
    }
}
#pragma mark - UITableViewDataSource
//Tableview will present the hourly and daily forcast in two diffrent sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}
//Currently displaying a part of the weather data available
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
     if (section == 0) {
        
        if (self.weatherHandler.weatherForcast.hourlyForecast.count) {
            
             return 7;
        }
     }
    else{
        if (self.weatherHandler.weatherForcast.hourlyForecast.count) {
            
            return [self.weatherHandler.weatherForcast.dailyForecast count];
        }
     }
     return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"WpSample.cell";
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (! cell) {
        
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == 0) {
        
        if (indexPath.row == 0) {
              [cell setSegmentTitle:@"Today"];
        }
        else {
            [cell setWeather:self.weatherHandler.weatherForcast.hourlyForecast[indexPath.row ]];
        }
    }
    else if (indexPath.section == 1) {
        
        if (indexPath.row == 0) {
            [cell setSegmentTitle:@"This Week"];
        }
        else {
           [cell setWeather:self.weatherHandler.weatherForcast.dailyForecast[indexPath.row - 1]];
        }
    }
    return cell;
}
@end
