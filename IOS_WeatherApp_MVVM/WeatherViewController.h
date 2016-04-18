//
//  WeatherViewController.h
//  WestpackSample
//
//  Created by Tony Thomas on 08/04/16.
//  Copyright © 2016 Tony Thomas. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 The main ViewController, holds the view model classes and views, view model communicate
 to this class via KVO and notification center.
 `WeatherViewController` interact with view model and view via direct messages.
 */
@interface WeatherViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
