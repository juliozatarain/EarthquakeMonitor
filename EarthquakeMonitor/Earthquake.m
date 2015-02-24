//
//  Earthquake.m
//  EarthquakeMonitor
//
//  Created by Julio Zatarain on 24/02/15.
//  Copyright (c) 2015 kamikaze. All rights reserved.
//

#import "Earthquake.h"

@implementation Earthquake
-(id)initWithDict:(NSDictionary*)earthquakeDic andWithId:(NSString*)eId{
    if(self)
    {
        [self setEId:eId];
        if([earthquakeDic objectForKey:@"place"] && [earthquakeDic objectForKey:@"place"] != [NSNull null])
        [self setEPlace:[earthquakeDic objectForKey:@"place"]];
        else
            [self setEPlace:@"Place not determined"];
        if([earthquakeDic objectForKey:@"place"] && [earthquakeDic objectForKey:@"place"] != [NSNull null])
            [self setEPlace:[earthquakeDic objectForKey:@"place"]];
        else
            [self setEPlace:@"Place not determined"];
        if([earthquakeDic objectForKey:@"mag"] && [earthquakeDic objectForKey:@"mag"] != [NSNull null])
            [self setEMagnitude:[earthquakeDic objectForKey:@"mag"]];
        else
            [self setEMagnitude:[NSNumber numberWithFloat:0.0f]];
    }
    return self;

}
@end
