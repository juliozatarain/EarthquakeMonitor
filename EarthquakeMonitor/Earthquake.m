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
        
        if([earthquakeDic objectForKey:@"mag"] && [earthquakeDic objectForKey:@"mag"] != [NSNull null])
            [self setEMagnitude:[earthquakeDic objectForKey:@"mag"]];
        
        if([earthquakeDic objectForKey:@"time"] && [earthquakeDic objectForKey:@"time"] != [NSNull null])
            [self setEDate:[[earthquakeDic objectForKey:@"time"] longLongValue]];
    }
    return self;
}

-(void) setDetailInfoWithDict:(NSDictionary*)dataDict{
    if([dataDict objectForKey:@"geometry"] && [dataDict objectForKey:@"geometry"] != [NSNull null]) {
        if([[dataDict objectForKey:@"geometry"] objectForKey:@"coordinates"] && [[dataDict objectForKey:@"geometry"] objectForKey:@"coodinates"] != [NSNull null]) {
            if([[[dataDict objectForKey:@"geometry"] objectForKey:@"coordinates"] isKindOfClass:[NSMutableArray class]] && [[[dataDict objectForKey:@"geometry"] objectForKey:@"coordinates"] count] == 3) {
                [self setELongitude:[[[[dataDict objectForKey:@"geometry"] objectForKey:@"coordinates"] objectAtIndex:0] floatValue]];
                [self setELatitude:[[[[dataDict objectForKey:@"geometry"] objectForKey:@"coordinates"] objectAtIndex:1] floatValue]];
                [self setDepth:[[[[dataDict objectForKey:@"geometry"] objectForKey:@"coordinates"] objectAtIndex:2] floatValue]];
            }
        }
    }
}
@end
