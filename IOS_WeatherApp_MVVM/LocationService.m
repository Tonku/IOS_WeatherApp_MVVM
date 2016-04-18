//
//  LocationService.m
//  WestpackSample
//
//  Created by Tony Thomas on 07/04/16.
//  Copyright © 2016 Tony Thomas. All rights reserved.
//

#import "LocationService.h"
#import "Constants.h"
@interface LocationService()  <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) void(^locationUpdateHandler)(CLLocation*);
@property (nonatomic, strong) NSString *currentLocationName;
@end

@implementation LocationService

-(id)initWithLocationUpdateHandler:(void(^)(CLLocation*)) locationUpdateHandler{
    
    self = [super init];
    
    [self initLocationService];
    self.locationUpdateHandler = locationUpdateHandler;
    
    [self getLocation];
    
    return self;
}

-(void)initLocationService{
    
    
    self.locationManager = [self createLocationManager];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers;
    
    //for the fisrt time its necessary
    if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        
        [self.locationManager requestWhenInUseAuthorization];
        
    }
    
    [self.locationManager startUpdatingLocation];
}
- (CLLocationManager *)createLocationManager
{
    return [[CLLocationManager alloc] init];
}
-(void)getLocation{
    
    if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusDenied){
        
        NSLog(@"Location service denied");
        //Its the ideal use of NSNotificationCenter , because there can be many observers for this
        //notification.And most of the time the observers are no way related to this `LocationService`
        //,so out of reach for KVO
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kLocationDenied object:self];
        });

        return;
        
    }
    
    // Request location authorization
    [self.locationManager requestWhenInUseAuthorization];
    
    // Request a location update
    [self.locationManager requestLocation];
}

//Respond to location errors if any, not handled currently
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    
    if (kCLErrorDenied!=error.code) {
        
        NSLog(@"Location Eror");
        
    }
    
}

//When the location is availble assign the location to the variable which is being observed by the main view controller
//Also find the frindly local name
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    
    static BOOL once ;
    
    if (!once) {
        
        once = YES;
        return;
    }
    CLLocation *location = [locations lastObject];
   
    if (location.horizontalAccuracy > 0) {
        
        [self.locationManager stopUpdatingLocation];
         
        CLGeocoder *geocoder = [[CLGeocoder alloc] init] ;
        [geocoder reverseGeocodeLocation:self.locationManager.location
                       completionHandler:^(NSArray *placemarks, NSError *error) {
                           
                           
                           if (error){
                               
                               NSLog(@"Geocode failed with error: %@", error);
                               
                               self.currentLocationName = @"Unknown Location";
                               self.locationUpdateHandler(location);
                               return;
                               
                           }
                           CLPlacemark *placemark = [placemarks objectAtIndex:0];
                           
                           
                           if (placemark.locality&&placemark.administrativeArea&&placemark.country) {
                               
                               self.currentLocationName = [NSString stringWithFormat:@"%@,%@,%@",placemark.locality,placemark.administrativeArea,placemark.country];
                           }
                           else if(placemark.administrativeArea&&placemark.country){
                               
                               self.currentLocationName = [NSString stringWithFormat:@"%@,%@",placemark.administrativeArea,placemark.country];
                           }
                           else if(placemark.country)
                           {
                               self.currentLocationName = [NSString stringWithFormat:@"%@",placemark.country];
                           }
                           else{
                               
                               self.currentLocationName = @"Unknown Location";
                           }
                           
                           self.locationUpdateHandler(location);
                           
                       }];
    }
}

@end
