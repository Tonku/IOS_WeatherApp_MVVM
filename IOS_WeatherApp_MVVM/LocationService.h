//
//  LocationService.h
//  WestpackSample
//
//  Created by Tony Thomas on 07/04/16.
//  Copyright © 2016 Tony Thomas. All rights reserved.
//

@import Foundation;
@import CoreLocation;

/**
 The location service manages the location for the app.
 This class also brings the `placeName` from the location.
 */
@interface LocationService : NSObject

@property (nonatomic, strong, readonly) NSString *currentLocationName;

//Initializer , which accepts a completion handler block to call back the caller
//when the location is available.
-(id)initWithLocationUpdateHandler:(void(^)(CLLocation*)) locationUpdateHandler;


@end
