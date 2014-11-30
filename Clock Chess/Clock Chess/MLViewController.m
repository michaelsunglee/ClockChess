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
    NSDate *currentDate;
    int startTime;
    int p1Minutes;
    int p1Seconds;
    int p2Minutes;
    int p2Seconds;
    int firstMove;
    int mostRecentTouch;
}

@property (nonatomic, strong) IBOutlet UIViewController *main;
@property (nonatomic, weak) IBOutlet UIButton *settings;
@property (nonatomic, weak) IBOutlet UIButton *restart;
@property (nonatomic, weak) IBOutlet UILabel *test;
@property (nonatomic, strong) NSTimer *p1Timer;
@property (nonatomic, strong) NSDate *p1MoveStart;
@property (nonatomic, strong) NSDate *p2MoveStart;

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
    
    [super viewDidLoad];
   
}

-(void)updateP1Timer{
   // NSLog(@"updateP1Timer");
   
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:self.p1MoveStart];
    NSDate *timerDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    //Create date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss"];
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0.0]];
    
    //Format the elapsed time and update label
    NSString *timeString = [dateFormatter stringFromDate:timerDate];
    
    self.p1TimerLabel.text = timeString;
    NSString *timestamp = [self timeStamp:currentDate];
    NSLog(@"%@", timestamp);

    self.p2MoveStart = [NSDate date];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *elapsedTime = [formatter numberFromString:timestamp];
    NSNumber *timeLeft = [NSNumber numberWithInteger:timeReq];
    
    if([elapsedTime doubleValue] > [timeLeft doubleValue])
    {
        NSLog(@"DONE");
        NSLog(@"%@", elapsedTime);
        NSLog(@"%@", timeLeft);
        [self.p1Timer invalidate];
    p1TimerLabel.text = @"TIME UP";
    }
    
}

- (NSString *) timeStamp:(NSDate *)TheCurrentDate{
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSinceDate:currentDate]];
}

-(void)stopP1Timer{
    [self.p1Timer invalidate];
   // self.p1Timer = nil;
  // [self updateP1Timer];
    
}

-(IBAction)p2Touched:(NSTimer *)theTimer
{
    NSLog(@"P2TOUCH");
    [self stopP1Timer];
    mostRecentTouch = 2;
    
}

-(void)sigSel:(NSTimer *)timer
{
    NSLog(@"sigSel HERE");
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
    
   // p1Timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(p1UpdateTimer:) userInfo:nil repeats:YES];
 //   p2Timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(p2UpdateTimer:) userInfo:nil repeats:YES];

    //change HERE
    //[self  p1UpdateTimer:p1Timer];
    //[self p2UpdateTimer:p2Timer];
        firstMove = 0;
    

    
}


-(void)p1UpdateTimer:(NSTimer *)theP1Timer
{
    NSLog(@"P1UPDATE TIMER");
    
}

-(void)p2UpdateTimer:(NSTimer *)theP2Timer
{
    if(p2TimeReq > 0)
    {
        --p2TimeReq;
        p2Minutes = p2TimeReq / 60;
        p2Seconds = p2TimeReq % 60;
        p2TimerLabel.text = [NSString stringWithFormat:@"%02d:%02d", p2Minutes, p2Seconds];
    }
    else
    {
        p1TimerLabel.text = @"Time UP";
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
-(IBAction)p1Touched:(NSTimer *)theTimer
{
    NSLog(@"IBAction p1Touched");
    self.p1Timer = [NSTimer scheduledTimerWithTimeInterval:1.0/10.0
                                                    target:self
                                                  selector:@selector(updateP1Timer)
                                                  userInfo:nil
                                                   repeats:YES];
    currentDate = [NSDate date];
   // NSMethodSignature *sgn = [self methodSignatureForSelector:@selector(sigSel:)];
    //NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sgn];
    //[inv setTarget:self];
    //[inv setSelector:@selector(sigSel:)];
    
  //  NSTimer *p1Timer = [NSTimer timerWithTimeInterval: 1.0
                                         //  invocation:inv
                                           //   repeats:NO];

    //NSRunLoop *runner = [NSRunLoop currentRunLoop];
    //[runner addTimer:p1Timer forMode: NSDefaultRunLoopMode];
    
  
}




-(IBAction)restartTimer:(id)sender
{
    NSLog(@"restart timer!");
    timeReq = timeReqChosen;
}
@end