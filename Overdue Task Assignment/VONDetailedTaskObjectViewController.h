//
//  VONDetailedTaskObjectViewController.h
//  Overdue Task Assignment
//
//  Created by Duri Abdurahman Duri on 7/3/14.
//  Copyright (c) 2014 von. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VONTaskObject.h"
#import "VONEditTaskObjectViewController.h"

@protocol VONDetailedTaskObjectViewControllerDelegate <NSObject>

-(void)updateTask;

@end


@interface VONDetailedTaskObjectViewController : UIViewController <VONEditTaskObjectViewControllerDelegate>

@property (strong, nonatomic) VONTaskObject *currentDetailTask;


@property (strong, nonatomic) IBOutlet UILabel *taskTitleDetail;
@property (strong, nonatomic) IBOutlet UILabel *taskDateDetail;
@property (strong, nonatomic) IBOutlet UILabel *taskDescriptionDetail;

@property (weak, nonatomic) id <VONDetailedTaskObjectViewControllerDelegate> delegate;


- (IBAction)editButtonPressed:(UIBarButtonItem *)sender;

- (IBAction)cancelButtonPressed:(UIBarButtonItem *)sender;

@end
