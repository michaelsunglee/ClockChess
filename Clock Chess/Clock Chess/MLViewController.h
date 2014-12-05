//
//  ViewController.h
//  Clock Chess
//
//  Created by Michael Lee on 2014-11-10.
//  Copyright (c) 2014 leeemichael. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>


@property (nonatomic, weak) IBOutlet UIPickerView *tPicker;
//@property (assign, nonatomic)  NSTimer *p1Timer;
//@property (assign, nonatomic)  NSTimer *p2Timer;
@property (assign, nonatomic) IBOutlet UILabel *p1TimerLabel;
@property (assign, nonatomic) IBOutlet UILabel *p2TimerLabel;
@property (assign, nonatomic) IBOutlet UIToolbar *tBar;
@property (assign, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (assign, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (assign, nonatomic) IBOutlet UIBarButtonItem *spaceHolder;
@property (nonatomic) SEL action;

//@property (assign, nonatomic) IBOutlet UIBarButtonSystemItem *t;

@property int *timerValue;
//extern NSTimer *p1Timer;
//extern NSTimer *p2Timer;


@end