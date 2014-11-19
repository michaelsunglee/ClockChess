//
//  ViewController.m
//  Clock Chess
//
//  Created by Michael Lee on 2014-11-10.
//  Copyright (c) 2014 leeemichael. All rights reserved.
//

#import "MLViewController.h"
#import "MLAppDelegate.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface MLViewController ()
{
    NSArray *_timerData;
    NSNumber *timeRequested;
    NSInteger timeReq;
    NSInteger p1TimeReq;
    NSInteger p2TimeReq;
    NSInteger timeReqChosen;
    int startTime;
    int p1Minutes;
    int p1Seconds;
    int p2Minutes;
    int p2Seconds;
}

@property (nonatomic, strong) IBOutlet UIViewController *main;
@property (nonatomic, weak) IBOutlet UIButton *settings;
@property (nonatomic, weak) IBOutlet UIButton *restart;
@property (nonatomic, weak) IBOutlet UILabel *test;

@end

@implementation MLViewController
//@synthesize p1Timer;
//@synthesize p2Timer;
@synthesize p1TimerLabel;
@synthesize p2TimerLabel;
@synthesize timerValue;
@synthesize tBar;
@synthesize doneButton;
@synthesize action;
@synthesize tPicker;

-(void)viewDidLoad
{
    [super viewDidLoad];
    //MLViewController *mainView = [[MLViewController alloc] initWithFrame: mainViewRect];
    tPicker.hidden = YES;
    tBar.hidden = YES;
    _timerData = @[@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12",@"13",@"14",@"15",@"20", @"25", @"30"];
    self.tPicker.dataSource = self;
    self.tPicker.delegate = self;
    p2TimerLabel.layer.transform = CATransform3DMakeRotation(M_PI,0,0,1);
   
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_timerData count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    timeRequested = _timerData[row];
    return _timerData[row];
}

-(void)action:SEL
{
    NSLog(@"Done Button HIT!!!");
    timeReq = [tPicker selectedRowInComponent:0];
    
    ++timeReq;
    NSLog(@"Number chosen was %ld", (long)timeReq);
    timeReq = timeReq * 60;
    p1TimeReq = timeReq;
    p2TimeReq = timeReq;
    tPicker.hidden = YES;
    tBar.hidden = YES;
    p1TimerLabel.hidden = NO;
    p2TimerLabel.hidden = NO;
    
    p1TimerLabel.userInteractionEnabled = YES;
    //UITapGestureRecognizer *p1LabelGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(p1LabelTouched)];
    //[p1LabelGesture addGestureRecognizer:p1LabelGesture];
    
    p2TimerLabel.userInteractionEnabled = YES;
    
    NSTimer *p1Timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(p1UpdateTimer:) userInfo:nil repeats:YES];
   // NSTimer *p2Timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(p2UpdateTimer:) userInfo:nil repeats:YES];

    //change HERE
    //[self  p1UpdateTimer:p1Timer];
    //[self p2UpdateTimer:p2Timer];
    
}


-(void)p1UpdateTimer:(NSTimer *)theP1Timer
{
    if(timeReq > 0)
    {
        --timeReq;
        p1Minutes = timeReq / 60;
        p1Seconds = timeReq % 60;
        p1TimerLabel.text = [NSString stringWithFormat:@"%02d:%02d", p1Minutes, p1Seconds];
    }
    else
    {
        p1TimerLabel.text = @"TIME UP";
    }
}

-(void)p2UpdateTimer:(NSTimer *)theP2Timer
{
    if(timeReq > 0)
    {
        --timeReq;
        p2Minutes = timeReq / 60;
        p2Seconds = timeReq % 60;
        p2TimerLabel.text = [NSString stringWithFormat:@"%02d:%02d", p2Minutes, p2Seconds];
    }
}

-(void)countdownTimer
{
   // timeReq = 0;

}

-(instancetype)initWithNibName:(NSString *)nibNameOrNil
                        bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil
                           bundle:nibBundleOrNil];
    
    if(self)
    {
        NSLog(@"initWithNibName is executed");
    }
    return self;
}



-(IBAction)settingsPage:(id)sender
{
    NSLog(@"settingsPage is executed");
    if(tPicker.hidden == YES)
    {
        tPicker.hidden = NO;
        p1TimerLabel.hidden = YES;
        //p2TimerLabel.hidden = YES;
        tBar.hidden = NO;
        [UIView setAnimationDuration:0.3];
        

        self.navigationItem.rightBarButtonItem = self.doneButton;
        self.tBar.items = [NSArray arrayWithObjects: doneButton, nil];
        doneButton.action = @selector(action:);
      
    }
    
}
-(IBAction)p1Touched:(NSTimer *)theP1Timer
{
    NSLog(@"P1TOUCH");
    [self p1UpdateTimer:theP1Timer];
    [self countdownTimer];
}


-(IBAction)restartTimer:(id)sender
{
    NSLog(@"restart timer!");
    timeReq = timeReqChosen;
}
@end