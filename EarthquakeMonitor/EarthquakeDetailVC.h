//
//  EarthquakeDetailVC.h
//  EarthquakeMonitor
//
//  Created by Julio Zatarain on 24/02/15.
//  Copyright (c) 2015 kamikaze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Earthquake.h"
#import "RequestHelper.h"
@interface EarthquakeDetailVC : UIViewController
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end
