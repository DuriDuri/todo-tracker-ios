//
//  VONTaskObjectTableViewController.h
//  Overdue Task Assignment
//
//  Created by Duri Abdurahman Duri on 7/3/14.
//  Copyright (c) 2014 von. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VONAddTaskObjectViewController.h"
#import "VONDetailedTaskObjectViewController.h"

@interface VONTaskObjectTableViewController : UITableViewController <VONAddTaskObjectViewControllerDelegate, VONDetailedTaskObjectViewControllerDelegate>


@property (strong, nonatomic) NSMutableArray *taskObjectsArray;


- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender;


-(NSDictionary *)taskObjectAsAPropertyList:(VONTaskObject *)taskObject;
@end
