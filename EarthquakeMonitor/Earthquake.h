//
//  Earthquake.h
//  EarthquakeMonitor
//
//  Created by Julio Zatarain on 24/02/15.
//  Copyright (c) 2015 kamikaze. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Earthquake : NSObject
// place
@property NSString *ePlace;
// magnitude
@property NSNumber *eMagnitude;
// geocoordinates
@property float eLatitude;
@property float eLongitude;
@property float depth;
@property long long int eDate;
@property NSString *eId;

-(id)initWithDict:(NSDictionary*)earthquakeDic andWithId:(NSString*)eId;
-(void) setDetailInfoWithDict:(NSDictionary*)dataDict;
@end
