//
//  VONAddTaskObjectViewController.h
//  Overdue Task Assignment
//
//  Created by Duri Abdurahman Duri on 7/3/14.
//  Copyright (c) 2014 von. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "VONTaskObject.h"

@protocol VONAddTaskObjectViewControllerDelegate <NSObject>

-(void)didCancel;
-(void)didAddTask:(VONTaskObject *)task;

@end


@interface VONAddTaskObjectViewController : UIViewController  <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *taskTitle;
@property (strong, nonatomic) IBOutlet UITextView *taskDescription;
@property (strong, nonatomic) IBOutlet UIDatePicker *taskDate;


//IB Outlets
- (IBAction)addTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;

//For Protocol
@property (weak, nonatomic) id <VONAddTaskObjectViewControllerDelegate> delegate;

@end
