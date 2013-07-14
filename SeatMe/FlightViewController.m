//
//  FlightViewController.m
//  SeatMe
//
//  Created by Martin Skow Røed on 13.07.13.
//  Copyright (c) 2013 Martin Skow Røed. All rights reserved.
//

#import "FlightViewController.h"
#import "AFJSONRequestOperation.h"
#import "SMFlightSeat.h"

@interface FlightViewController ()

@end

@implementation FlightViewController

- (void) getSeatMapJSON {
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1:8888/seatme/get_seat_map.php"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        [self buildSeatMapWithJSON:JSON];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"%@", error);
    }];
    [operation start];

}

- (void) buildSeatMapWithJSON:(id)JSON {
    int min_x = [[JSON objectForKey:@"min_x"] intValue];
    int max_x = [[JSON objectForKey:@"max_x"] intValue];
    int min_y = [[JSON objectForKey:@"min_y"] intValue];
    int max_y = [[JSON objectForKey:@"max_y"] intValue];
    NSMutableDictionary *JSONd = (NSMutableDictionary *)[JSON mutableCopy];
    [JSONd removeObjectsForKeys:@[@"min_x", @"min_y", @"max_x", @"max_y"]];
    NSMutableDictionary *seatDict = [NSMutableDictionary dictionary];
    for (id key in [JSONd allKeys]) {
        NSString *index = [[JSONd objectForKey:key] objectForKey:@"row"];
        if (![seatDict objectForKey:index])
              [seatDict setObject:[NSMutableArray array] forKey:[[JSONd objectForKey:key] objectForKey:@"row"]];
        SMFlightSeat *seat = [[SMFlightSeat alloc] initWithJSON:[JSONd objectForKey:key] andMinX:min_x andMaxX:max_x andMinY:min_y];
        [seat setBackgroundColor:[UIColor redColor]];
        [[seatDict objectForKey:index] addObject:seat];
        [seat setSize:CGSizeMake(1, 1)];
        [self.scrollView addSubview:seat];
    }
    
    for (NSString *key in [[seatDict allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 intValue] > [obj2 intValue];
    }]) {
        NSMutableArray *row = [seatDict objectForKey:key];
        row = [[row sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            SMFlightSeat *first = (SMFlightSeat *)obj1;
            SMFlightSeat *second = (SMFlightSeat *)obj2;
            return [first.seat compare:second.seat];
        }] mutableCopy];
        int min_width = 1000;
        int min_height = 1000;
        for (int i=0; i<row.count-1; ++i) {
            SMFlightSeat *firstseat = (SMFlightSeat *)[row objectAtIndex:i];
            SMFlightSeat *secondseat = (SMFlightSeat *)[row objectAtIndex:i+1];
            int width = secondseat.xcoord - firstseat.xcoord - 10;
            if (width < min_width)
                min_width = width;
            int height = secondseat.xcoord - firstseat.xcoord- 10;
            if (height < min_height)
                min_height = height;
        }
        for (SMFlightSeat *seat in row) {
            [seat setSize:CGSizeMake(min_width, min_width)];
            [self.scrollView addSubview:seat];
        }
    }
    
    //NSLog(@"%@", [[seatDict allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
      //  return [obj1 intValue] > [obj2 intValue];
    //}]);

    
//    for (id key in [JSONd allKeys]) {
//        int x1 = [[[JSONd objectForKey:key] objectForKey:@"x1"] intValue];
//        int x2 = [[[JSONd objectForKey:key] objectForKey:@"x2"] intValue];
//        int y1 = [[[JSONd objectForKey:key] objectForKey:@"y1"] intValue];
//        int y2 = [[[JSONd objectForKey:key] objectForKey:@"y2"] intValue];
//        float new_x = (x1-min_x)/(float)(max_x-min_x)*290+10;
//        float new_y = (y1-min_y)/(float)(max_x-min_x)*180+20;
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        [button setFrame:CGRectMake(new_x, new_y, 20, 20)];
//    }
    [self.scrollView setContentSize:CGSizeMake(320, 2500)];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getSeatMapJSON];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
