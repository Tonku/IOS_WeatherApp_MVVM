#import <XCTest/XCTest.h>
#import "RestServiceHandler.h"
#import "DailyWeatherCondition.h"
#import "WeatherCondition.h"
#import "CustomTableViewCell.h"
#import "LocationService.h"
#import <Mantle/Mantle.h>

@interface WeatherSampleTests : XCTestCase

@property (nonatomic, strong) RestServiceHandler *restHandler;
@property (nonatomic, strong) CustomTableViewCell *tableViewCell;
@property (nonatomic)  dispatch_semaphore_t semaphoreAsyncCallWait;
@end

@implementation WeatherSampleTests

- (void)setUp {
    [super setUp];
    self.restHandler = [[RestServiceHandler alloc]init];
    self.semaphoreAsyncCallWait = dispatch_semaphore_create(0);
    
    self.tableViewCell = [[CustomTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Test"];
    
}

- (void)tearDown {
    
    [super tearDown];
}


-(void)testWeatherAsyncAPICallLatency{
    
    
    double latitude = 33.85;
    double longitude = 151.201;
    CLLocation * location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"Get weather data in 3 seconds"];
    
    [self.restHandler getWeatherInLocation:location onSuccess:^(NSDictionary *weatherDataInJson) {
        
        XCTAssertNotNil(weatherDataInJson, "data cannot be nil");
        
        if (![weatherDataInJson isKindOfClass:[NSDictionary class]]) {
            
            XCTFail(@"Response was not a NSDictionary object");
            
        }
        else{
            
            [expectation fulfill];
        }
        
    } onFailure:^(NSError *error) {
        
        XCTAssertNil(error, "error should be nil");
    }];
    
    [self waitForExpectationsWithTimeout:2.0 handler:^(NSError *error) {
        
        if (error != nil) {
            
            NSLog(@"Error: %@", error.localizedDescription);
        }
        
    }];
}

/* This test checks the validity of the mantle objects created from json if this test fails,
 we can assume there are some changes in the webservice result*/
-(void)testMantleObjectMapping{
    
    
    double latitude = 33.85;
    double longitude = 151.201;
    CLLocation * location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    __weak XCTestExpectation *expectation = [self expectationWithDescription:@"JSON object mapping is a success"];
    
    [self.restHandler getWeatherInLocation:location onSuccess:^(NSDictionary *weatherDataInJson) {
        
        XCTAssertNotNil(weatherDataInJson, "data cannot be nil");
        
        if (![weatherDataInJson isKindOfClass:[NSDictionary class]]) {
            
            XCTFail(@"Response was not a NSDictionary object");
            
        }
        else{
            
            
            XCTAssertNotNil(weatherDataInJson, "data cannot be nil");
            
            NSError* error = nil;
            id weatherForcastAnticipation = [MTLJSONAdapter modelOfClass:WeatherForecast.class
                                                      fromJSONDictionary:weatherDataInJson error:&error];
            
            //Test the mapping
            XCTAssertNotNil(weatherDataInJson, "data cannot be nil");
            
            //Test the error code
            XCTAssertNil(error, "error should be nil");
            
            if ([weatherForcastAnticipation isKindOfClass:[WeatherForecast class]]) {
                
                
                //Test weather forcast full data integrity
                
                WeatherForecast* weatherForcastObj = (WeatherForecast*)weatherForcastAnticipation;
                
                id nowWeatherAnticipation = weatherForcastObj.weatherConditionNow;
                
                if (![nowWeatherAnticipation isKindOfClass: [WeatherCondition class]]) {
                    
                    XCTFail(@"nowWeatherAnticipation was not a WeatherCondition object");
                }
                
                
                //Test hourly forcast data integrity
                
                id hourlyForcastAnticipation = weatherForcastObj.hourlyForecast;
                
                if ([hourlyForcastAnticipation isKindOfClass:[NSArray class]]) {
                    
                    
                    id hourlyForecastAnticipationForFirstElement = [((NSArray*)hourlyForcastAnticipation) objectAtIndex:0];
                    
                    if (![hourlyForecastAnticipationForFirstElement isKindOfClass: [WeatherCondition class]]) {
                        
                        XCTFail(@"hourlyForecastAnticipationForFirstElement was not a WeatherCondition object");
                    }
                    
                }
                else{
                    
                    XCTFail(@"hourlyForcastAnticipation was not an array of hourly forcasts");
                }
                
                //Test daily forcast data integrity
                
                id dailyForcastAnticipation =  weatherForcastObj.dailyForecast;
                if ([dailyForcastAnticipation isKindOfClass:[NSArray class]]) {
                    
                    
                    id dailyForecastAnticipationForFirstElement = [((NSArray*)dailyForcastAnticipation) objectAtIndex:0];
                    
                    if (![dailyForecastAnticipationForFirstElement isKindOfClass: [DailyWeatherCondition class]]) {
                        
                        XCTFail(@"dailyForecastAnticipationForFirstElement was not a DailyWeatherCondition object");
                    }
                    
                }
                else{
                    
                    XCTFail(@"dailyForcastAnticipation was not an array of daily forcasts");
                }
                
            }
            else {
                
                
                XCTFail(@"Response was not a WeatherForecast object");
                
            }
            
            
            
            [expectation fulfill];
        }
        
    } onFailure:^(NSError *error) {
        
        XCTAssertNil(error, "error should be nil");
    }];
    
    [self waitForExpectationsWithTimeout:10.0 handler:^(NSError *error) {
        
        if (error != nil) {
            
            NSLog(@"Error: %@", error.localizedDescription);
        }
        
    }];
    
}
//Test the performance of matle object mapping from
-(void)testJasonToMantleModelPerformance{
    
    
    double latitude = 33.85;
    double longitude = 151.201;
    CLLocation * location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    
    [self.restHandler getWeatherInLocation:location onSuccess:^(NSDictionary *weatherDataInJson) {
        
        XCTAssertNotNil(weatherDataInJson, "data cannot be nil");
        
        
        [self measureBlock:^{
            
            
            NSError* error = nil;
            WeatherForecast* weatherForcast = [MTLJSONAdapter modelOfClass:WeatherForecast.class
                                                        fromJSONDictionary:weatherDataInJson error:&error];
            
        }];
        dispatch_semaphore_signal(self.semaphoreAsyncCallWait);
        
    } onFailure:^(NSError *error) {
        
        dispatch_semaphore_signal(self.semaphoreAsyncCallWait);
        XCTAssertNil(error, "error should be nil");
        
    }];
    //Wait for the async part (measure block) execution to complete, we need a semaphore wait because
    //there is a nested async call, so XCTest async testing will not work
    dispatch_semaphore_wait(self.semaphoreAsyncCallWait, DISPATCH_TIME_FOREVER);
}

//Temperature scale conversion tests
-(void)testFahrenheitCelsiusRoundConversion{
    
    //Given
    double initialValue = 0.0;
    
    //When
    double value1 = [self.tableViewCell convertToCelsius:initialValue];
    
    double value2 = [self.tableViewCell convertToFahrenheit:value1];
    
    //Then
    XCTAssertEqual(initialValue, value2);
}

-(void)testFahrenheitEqualsCelsiusAtMinus40{
    
    //Given
    double temperatureWhenBothScaleGiveEqualValue = -40.0;
    
    //When
    double value1 = [self.tableViewCell convertToCelsius:temperatureWhenBothScaleGiveEqualValue];
    
    double value2 = [self.tableViewCell convertToFahrenheit:temperatureWhenBothScaleGiveEqualValue];
    
    //Then
    XCTAssertEqual(value1, value2);//This should be equal
}

@end
