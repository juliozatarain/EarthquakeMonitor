//
//  ViewController.m
//  EarthquakeMonitor
//
//  Created by Julio Zatarain on 23/02/15.
//  Copyright (c) 2015 kamikaze. All rights reserved.
//

#import "EarthquakeTVC.h"
#import "RequestHelper.h"

@interface EarthquakeTVC ()

@end

@implementation EarthquakeTVC

- (void)viewDidLoad {
    [super viewDidLoad];
    //initialize data source
    [self setEarthquakeData:[[NSMutableArray alloc] init]];
    // we set the delegate
    [[self earthquakesTableView] setDelegate:self];
    // we set the data source
    [[self earthquakesTableView] setDataSource:self];
    // we initialize the color set
    [self setColorArray:[[NSArray alloc] initWithObjects:
                         //green
                         [UIColor colorWithRed:0.0f green:102.0f/255.0f blue:0.0f alpha:1.0f],
                         //med yellow
                         [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:102.0f/255.0f alpha:1.0f],
                         //dark yellow
                         [UIColor colorWithRed:204.0f/255.0f green:204.0f/255.0f blue:0.0f alpha:1.0f],
                         //light orange
                         [UIColor colorWithRed:204.0f/255.0f green:102.0f/255.0f blue:0.0f alpha:1.0f],
                         //med orange
                         [UIColor colorWithRed:153.0f/255.0f green:76.0f/255.0f blue:0.0f alpha:1.0f],
                         //dark orange,
                         [UIColor colorWithRed:102.0f/255.0f green:51.0f/255.0f blue:0.0f alpha:1.0f],
                         // light red
                         [UIColor colorWithRed:255.0f/255.0f green:0.0f blue:0.0f alpha:1.0f],
                         //medium red
                         [UIColor colorWithRed:153.0f/255.0f green:0.0f blue:0.0f alpha:1.0f],
                         //dark red
                         [UIColor colorWithRed:102.0f/255.0f green:0.0f blue:0.0f alpha:1.0f],nil]];
    
    // We request the summarized information
    [self loadData];
    
    // We schedule a timer to  reload data every minute
    [NSTimer scheduledTimerWithTimeInterval:60.0f target:self selector:@selector(loadData) userInfo:nil repeats:YES];
}
-(void) loadData {
    [[RequestHelper sharedHTTPClient] get:@"summary/all_hour.geojson" completion:^(id responseObject) {
        if([responseObject objectForKey:@"features"] && [responseObject objectForKey:@"features"] != [NSNull null]) {
            NSLog(@"%@",responseObject);
            [[self earthquakeData] removeAllObjects];
            for( id eDict in [responseObject objectForKey:@"features"]) {
                if([eDict objectForKey:@"properties"] && [eDict objectForKey:@"properties"] != [NSNull null] &&  [eDict objectForKey:@"id"] && [eDict objectForKey:@"id"] != [NSNull null])
                    [[self earthquakeData] addObject:[[Earthquake alloc] initWithDict:[eDict objectForKey:@"properties"] andWithId:[eDict objectForKey:@"id"]]];
            }
        }
        [[self earthquakesTableView] reloadData];
        // update title
        [self updateTitle];
    } failure:^(NSError *error) {
        NSLog(@"error %@",[error description]);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"earthquakeCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"earthquakeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    // we set the earthquake information
    [[cell textLabel] setText:[[[self earthquakeData] objectAtIndex:[indexPath row]] ePlace]];
    [[cell detailTextLabel] setText:[[[[self earthquakeData] objectAtIndex:[indexPath row]] eMagnitude] stringValue]];
    // we get the appropriate color index from the magnitude
    int colorIndex = (int)floor([[[[self earthquakeData] objectAtIndex:[indexPath row]] eMagnitude] floatValue]);
    if(colorIndex > 9 )
        colorIndex = 9;
    else if(colorIndex < 0)
        colorIndex = 0;
    [cell setBackgroundColor:[[self colorArray] objectAtIndex:colorIndex]];
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self earthquakeData] count];
}
- (IBAction)refreshButtonAction:(id)sender {
    [self loadData];
}
-(void) updateTitle {
    [[self titleItem] setTitle:[NSString stringWithFormat:@" %d Eartquakes in the last hour", [[self earthquakeData] count]]];
}
@end
