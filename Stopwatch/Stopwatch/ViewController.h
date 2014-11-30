//
//  ViewController.h
//  Stopwatch
//
//  Created by Michael Lee on 2014-11-29.
//  Copyright (c) 2014 leeemichael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (assign, nonatomic) IBOutlet UILabel *stopwatchLabel;
-(IBAction)onStartPressed:(id)sender;
-(IBAction)onStopPressed:(id)sender;

@end

