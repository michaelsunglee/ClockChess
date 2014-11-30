//
//  ViewController.m
//  Stopwatch
//
//  Created by Michael Lee on 2014-11-29.
//  Copyright (c) 2014 leeemichael. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSTimer *p1Timer;
@property (nonatomic, strong) NSDate *moveStart;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)onStartPressed:(id)sender {
    self.moveStart = [NSDate date];
    
    //timer fires every 100 ms
    self.p1Timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                           target:self
                                                         selector:@selector(updateTimer)
                                                         userInfo:nil
                                                          repeats:YES];
}

-(IBAction)onStopPressed:(id)sender {
    [self.p1Timer invalidate];
    self.p1Timer = nil;
    [self updateTimer];
}

-(void)updateTimer {
    //static NSInteger counter = 0;
    //self.stopwatchLabel.text = [NSString stringWithFormat:@"Counter: %i", counter++];
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.moveStart];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    //Create date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss.SSS"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    //Format the elapsed time and update label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    self.stopwatchLabel.text = timeString;
}


@end
