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

@interface MLViewController ()
{
    NSArray *_timerData;
    NSNumber *timeRequested;
    NSInteger timeReq;
    NSInteger timeReqChosen;
    int startTime;
    int p1Minutes;
    int p1Seconds;
}

@property (nonatomic, strong) IBOutlet UIViewController *main;
@property (nonatomic, weak) IBOutlet UIButton *settings;
@property (nonatomic, weak) IBOutlet UIButton *restart;
@property (nonatomic, weak) IBOutlet UILabel *test;

@end

@implementation MLViewController
@synthesize p1Timer;
@synthesize p2Timer;
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
    /*timeRequested = [self pickerView:self.tPicker
                         titleForRow:[self pickerView :selectedRowInComponent:0]
                       forCompoenent:0];*/
    timeReq = [tPicker selectedRowInComponent:0];
    
    ++timeReq;
    NSLog(@"Number chosen was %ld", (long)timeReq);
    timeReq = timeReq * 60;
    timeReqChosen = timeReq;
    tPicker.hidden = YES;
    tBar.hidden = YES;
    p1TimerLabel.hidden = NO;
    //p2TimerLabel.hidden = NO;
    [self p1UpdateTimer:p1Timer];
}

-(void)p1UpdateTimer:(NSTimer *)theP1Timer
{
    if(timeReq > 0)
    {
        --timeReq;
        p1Minutes = timeReq / 60;
        p1Seconds = timeReq % 60;
        p1TimerLabel.text = [NSString stringWithFormat:@"%02d:%20d", p1Minutes, p1Seconds];
    }
    else
    {
        p1TimerLabel.text = @"TIME'S UP";
    }
}

-(void)countdownTimer
{
    timeReq = 0;
    if([p1Timer isValid])
    {
        p1Timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(p1UpdateTimer:) userInfo:nil repeats:YES];
    }
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
        //[UIView beginAnimations:@"hideDatePicker" context:nil];
        [UIView setAnimationDuration:0.3];
        

        self.navigationItem.rightBarButtonItem = self.doneButton;
        self.tBar.items = [NSArray arrayWithObjects: doneButton, nil];
        doneButton.action = @selector(action:);
//       self.tBar.items = [[NSArray alloc] initWithObjects:flexSpace,doneB, nil];
        //doneB.tintColor = [UIColor colorWithRed:(102.0/255.0) green:(20.0/255.0) blue:(11.0/255.0) alpha:1];;
        //doneB.pickerShown = YES;
        //[UINavigationBar appearnace].TintColor = [UIColor redColor];
        //self.navigationItem.rightBarButtonItem = doneB;
        //[[NSArray alloc] initWithObjects: doneButton, self.doneButton,nil];
        //CGRect date
    }
    
}

-(IBAction)restartTimer:(id)sender
{
    NSLog(@"restart timer!");
    timeReq = timeReqChosen;
}
@end