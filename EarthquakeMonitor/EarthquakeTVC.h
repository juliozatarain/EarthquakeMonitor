//
//  ViewController.h
//  EarthquakeMonitor
//
//  Created by Julio Zatarain on 23/02/15.
//  Copyright (c) 2015 kamikaze. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Earthquake.h"

@interface EarthquakeTVC : UITableViewController<UITableViewDelegate,UITableViewDataSource>

// So we can have control of the task and terminate it when needed
@property NSURLSessionDataTask *requestTask;

// data source for the tableview
@property NSMutableArray *earthquakeData;

// color set
@property NSArray *colorArray;

//tableView IBOutlet
@property (weak, nonatomic) IBOutlet UITableView *earthquakesTableView;

//title item
@property (weak, nonatomic) IBOutlet UINavigationItem *titleItem;

// action for refresh button
- (IBAction)refreshButtonAction:(id)sender;

@end

