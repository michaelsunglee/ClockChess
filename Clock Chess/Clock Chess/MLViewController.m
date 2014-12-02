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
    NSNumber *p1ElapsedTime;
    NSNumber *p1TimeLeft;
    NSNumber *p2ElapsedTime;
    NSNumber *p2TimeLeft;
    int startTime;
    int p1Minutes;
    int p1Seconds;
    int p2Minutes;
    int p2Seconds;
    int firstMove;
    int mostRecentTouch;
    BOOL p1MoveYet;
    BOOL p2MoveYet;
    BOOL veryFirstMove;
}

@property (nonatomic, strong) IBOutlet UIViewController *main;
@property (nonatomic, weak) IBOutlet UIButton *settings;
@property (nonatomic, weak) IBOutlet UIButton *restart;
@property (nonatomic, weak) IBOutlet UILabel *test;
@property (nonatomic, strong) NSTimer *p1Timer;
@property (nonatomic, strong) NSTimer *p2Timer;
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
    veryFirstMove = TRUE;
    [super viewDidLoad];
}

-(void)updateP1Timer{
    NSTimeInterval p1TimeInterval = [currentDate timeIntervalSinceDate:self.p1MoveStart];
    NSDate *p1TimerDate = [NSDate dateWithTimeIntervalSince1970:p1TimeInterval];
    
    //Create date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss"];
    
    //Format the elapsed time and update label
    NSString *p1TimeString = [dateFormatter stringFromDate:p1TimerDate];
    
    self.p1TimerLabel.text = p1TimeString;
    p1TimeLeft = [NSNumber numberWithInt:[p1TimeLeft intValue] - 1];
    NSString *p1Timestamp = [self timeStamp:currentDate];

    self.p2MoveStart = [NSDate date];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    p1ElapsedTime = [formatter numberFromString:p1Timestamp];
    //timeLeft = [NSNumber numberWithInteger:timeReq];
    if(veryFirstMove == TRUE)
    {
        p1TimeLeft = [NSNumber numberWithInteger:timeReq];
        p2TimeLeft = [NSNumber numberWithInteger:timeReq];
        p1Minutes = [p1TimeLeft intValue] / 60;
        p1Seconds = [p1TimeLeft intValue] % 60;
        p2Minutes = [p2TimeLeft intValue] / 60;
        p2Seconds = [p2TimeLeft intValue] % 60;
        veryFirstMove = FALSE;
    }
    if(p1MoveYet == FALSE)
    {
        p1MoveYet = TRUE;
    }
    
    p1Minutes = [p1TimeLeft intValue] / 60;
    p1Seconds = [p1TimeLeft intValue] % 60;
    NSLog(@"p1Seconds = %d", p1Seconds);
    [self updateLabel];
    NSLog(@"UPDATE");
    
    if([p1ElapsedTime doubleValue] > [p1TimeLeft doubleValue])
    {
        NSLog(@"DONE");
        NSLog(@"%@", p1ElapsedTime);
        NSLog(@"%@", p1TimeLeft);
        [self.p1Timer invalidate];
        p1TimerLabel.text = @"TIME UP";
    }
}

-(void)updateP2Timer{
    NSTimeInterval p2TimeInterval = [currentDate timeIntervalSinceDate:self.p2MoveStart];
    NSDate *p2TimerDate = [NSDate dateWithTimeIntervalSince1970:p2TimeInterval];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"mm:ss"];
    
    NSString *p2TimeString = [dateFormatter stringFromDate:p2TimerDate];
    
    self.p2TimerLabel.text = p2TimeString;
    p2TimeLeft = [NSNumber numberWithInt:[p2TimeLeft intValue] - 1];
    NSString *p2Timestamp = [self timeStamp:currentDate];
    
    self.p1MoveStart = [NSDate date];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    p2ElapsedTime = [formatter numberFromString:p2Timestamp];
    if(veryFirstMove == TRUE)
    {
        p1TimeLeft = [NSNumber numberWithInteger:timeReq];
        p2TimeLeft = [NSNumber numberWithInteger:timeReq];
        p1Minutes = [p1TimeLeft intValue] / 60;
        p1Seconds = [p1TimeLeft intValue] % 60;
        p2Minutes = [p2TimeLeft intValue] / 60;
        p2Seconds = [p2TimeLeft intValue] % 60;
        veryFirstMove = FALSE;
    }
    
    if(p2MoveYet == FALSE)
    {
        p2MoveYet = TRUE;
    }
    
    p2Minutes = [p2TimeLeft intValue] / 60;
    p2Seconds = [p2TimeLeft intValue] % 60;
    NSLog(@"p2Seconds = %d", p2Seconds);
    [self updateLabel];
    NSLog(@"UPDATE");
    
    if([p2ElapsedTime doubleValue] > [p2TimeLeft doubleValue])
    {
        NSLog(@"DONE");
        NSLog(@"%@", p2ElapsedTime);
        NSLog(@"%@", p2TimeLeft);
        [self.p2Timer invalidate];
        p2TimerLabel.text = @"TIME UP";
    }
    
}

-(void)updateLabel{
    p1TimerLabel.text = [NSString stringWithFormat:@"%02d:%02d", p1Minutes, p1Seconds];
    p2TimerLabel.text = [NSString stringWithFormat:@"%02d:%02d", p2Minutes, p2Seconds];

}

- (NSString *) timeStamp:(NSDate *)TheCurrentDate{
    return [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSinceDate:currentDate]];
}

-(void)stopP1Timer{
    [self.p1Timer invalidate];
   // self.p1Timer = nil;
  // [self updateP1Timer];
    
}

-(void)stopP2Timer{
    [self.p2Timer invalidate];
}

-(IBAction)p1Touched
{
    if(p1MoveYet == FALSE)
    {
        NSLog(@"P1TOUCH");
        self.p1Timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                        target:self
                                                      selector:@selector(updateP1Timer)
                                                      userInfo:nil
                                                       repeats:YES];
        currentDate = [NSDate date];
    }
    else if(p1MoveYet == TRUE)
    {
        [self stopP1Timer];
        p2MoveYet = FALSE;
        [self p2Touched];
        
    }
    
    
}
-(IBAction)p2Touched
{
    if(p2MoveYet == FALSE)
    {
       
        self.p2Timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                        target:self
                                                      selector:@selector(updateP2Timer)
                                                      userInfo:nil
                                                       repeats:YES];
        NSLog(@"P2TOUCH");
        NSLog(@"%@", p1ElapsedTime);
        // timeLeft = [NSNumber numberWithFloat:([timeLeft floatValue] - [elapsedTime floatValue])];
        NSLog(@"%@", p1TimeLeft);
        [self stopP1Timer];
        mostRecentTouch = 2;
    }
    else if(p2MoveYet == TRUE)
    {
        [self stopP2Timer];
        p1MoveYet = FALSE;
        [self p1Touched];
        
    }
   
    
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
/*

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
 */

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

-(IBAction)restartTimer:(id)sender
{
    NSLog(@"restart timer!");
    timeReq = timeReqChosen;
}




// NSMethodSignature *sgn = [self methodSignatureForSelector:@selector(sigSel:)];
//NSInvocation *inv = [NSInvocation invocationWithMethodSignature:sgn];
//[inv setTarget:self];
//[inv setSelector:@selector(sigSel:)];

//  NSTimer *p1Timer = [NSTimer timerWithTimeInterval: 1.0
//  invocation:inv
//   repeats:NO];

//NSRunLoop *runner = [NSRunLoop currentRunLoop];
//[runner addTimer:p1Timer forMode: NSDefaultRunLoopMode];
@end