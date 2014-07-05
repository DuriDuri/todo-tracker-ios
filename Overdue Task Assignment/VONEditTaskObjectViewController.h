//
//  VONEditTaskObjectViewController.h
//  Overdue Task Assignment
//
//  Created by Duri Abdurahman Duri on 7/3/14.
//  Copyright (c) 2014 von. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VONTaskObject.h"

@protocol VONEditTaskObjectViewControllerDelegate <NSObject>

-(void)didUpdateTask;

@end


@interface VONEditTaskObjectViewController : UIViewController<UITextFieldDelegate, UITextViewDelegate>


@property (weak, nonatomic) id <VONEditTaskObjectViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *editTitleTextField;
@property (strong, nonatomic) IBOutlet UITextView *editDescriptionTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *editDate;


@property (strong, nonatomic) VONTaskObject *editCurrenttask;

- (IBAction)editTaskButtonPressed:(UIButton *)sender;
- (IBAction)cancelButtonPressed:(UIButton *)sender;


@end
