//
//  VONTaskObjectTableViewController.m
//  Overdue Task Assignment
//
//  Created by Duri Abdurahman Duri on 7/3/14.
//  Copyright (c) 2014 von. All rights reserved.
//

#import "VONTaskObjectTableViewController.h"
#import "VONTaskObject.h"
#import "VONAddTaskObjectViewController.h"
#import "VONDetailedTaskObjectViewController.h"

@interface VONTaskObjectTableViewController ()

@end

@implementation VONTaskObjectTableViewController

-(NSMutableArray *)taskObjectsArray
{
    if (!_taskObjectsArray) {
        _taskObjectsArray = [[NSMutableArray alloc] init];
    }
    return _taskObjectsArray;
}

- (IBAction)addTaskButtonPressed:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"toAddTaskObject" sender:sender];
}

- (IBAction)reorderButtonPressed:(UIBarButtonItem *)sender {
    if (self.tableView.editing ==YES) [self.tableView setEditing:NO animated:YES];
    else [self.tableView setEditing:YES animated:YES];
    
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    // Access and dispaly tasks from NSUserDefaults
    NSArray *storedTaskObjects = [[NSUserDefaults standardUserDefaults] objectForKey:ADDED_TASK_OBJECTS_KEY];
    for (NSDictionary *taskDictionary in storedTaskObjects) {
        VONTaskObject *tempTask = [self taskObjectFromDictionary:taskDictionary];
        [self.taskObjectsArray addObject:tempTask];
    }
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark -Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[VONAddTaskObjectViewController class]])
        {
            VONAddTaskObjectViewController *nextAddTaskObjectVC = segue.destinationViewController;
            nextAddTaskObjectVC.delegate = self;
        }
    else if ([segue.destinationViewController isKindOfClass:[VONDetailedTaskObjectViewController class]])
         {
             VONDetailedTaskObjectViewController *detailVC = segue.destinationViewController;
             NSIndexPath *path = sender;
             
             VONTaskObject *taskObject = [self.taskObjectsArray objectAtIndex:path.row];
             detailVC.currentDetailTask = taskObject;
             detailVC.delegate = self;
         }
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [self.taskObjectsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"TaskObject";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    VONTaskObject *currentTask = [self.taskObjectsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = currentTask.title;
    
    //Set date for the subtitle
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    cell.detailTextLabel.text = [formatter stringFromDate:currentTask.date];
    
    
    //Set Background depending on completion
    NSDate *today = [NSDate date];
    
    BOOL isOverDue = [self isDateGreaterThanDate:today and:currentTask.date];
    
    
    if (currentTask.isComplete == YES) cell.backgroundColor = [UIColor greenColor];
    else if (isOverDue) cell.backgroundColor = [UIColor redColor];
    else cell.backgroundColor = [UIColor yellowColor];
    
    
    return cell;
}



#pragma mark -Protocol Methods

-(void)didCancel{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)didAddTask:(VONTaskObject *)task
{
    // Add object to array of tasks
    [self.taskObjectsArray addObject:task];
    
    // Configure NSUserDefaults
    
    NSMutableArray *taskObjectsInPropertyList = [[[NSUserDefaults standardUserDefaults] arrayForKey: ADDED_TASK_OBJECTS_KEY] mutableCopy];
    
    if (!taskObjectsInPropertyList) {
        taskObjectsInPropertyList = [[NSMutableArray alloc] init];
    }
    
    NSDictionary *addedTaskAsPropertyList = [self taskObjectAsAPropertyList:task];
    [taskObjectsInPropertyList addObject:addedTaskAsPropertyList];
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsInPropertyList forKey:ADDED_TASK_OBJECTS_KEY];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark Helper Methods


-(void)saveTasks
{
    NSMutableArray *taskObjectsAsAPropertyList = [[NSMutableArray alloc] init];
    for (int x= 0; x<[self.taskObjectsArray count]; x ++) {
        [taskObjectsAsAPropertyList addObject:[self taskObjectAsAPropertyList:self.taskObjectsArray[x]]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsAPropertyList forKey:ADDED_TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];

}

-(NSDictionary *)taskObjectAsAPropertyList:(VONTaskObject *)taskObject
{
    NSDictionary *dictionary = @{TASK_TITLE: taskObject.title,
                                 TASK_DESCRIPTION : taskObject.description,
                                 TASK_COMPLETION: @(taskObject.isComplete),
                                 TASK_DATE: taskObject.date};
    return dictionary;
}


-(VONTaskObject *)taskObjectFromDictionary: (NSDictionary *)dictionary
{
    VONTaskObject *taskObject = [[VONTaskObject alloc] initWithData:dictionary];
    return taskObject;
}



- (BOOL)isDateGreaterThanDate:(NSDate*)today and:(NSDate*)otherDate
{
    if ([today timeIntervalSince1970] > [otherDate timeIntervalSince1970]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    VONTaskObject *task = self.taskObjectsArray[indexPath.row];
    [self updateCompletionOfTask:task forIndexPath:indexPath];

    
}

-(void)updateCompletionOfTask:(VONTaskObject *)task forIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *taskObjectsAsPropertyLists = [[[NSUserDefaults standardUserDefaults] arrayForKey:ADDED_TASK_OBJECTS_KEY] mutableCopy];
    if (!taskObjectsAsPropertyLists) {
        taskObjectsAsPropertyLists = [[NSMutableArray alloc] init];
    }
    [taskObjectsAsPropertyLists removeObjectAtIndex:indexPath.row];
    
    if (task.isComplete ==YES) {
        task.isComplete = NO;
    } else {
        task.isComplete = YES;
    }
    
    [taskObjectsAsPropertyLists insertObject:[self taskObjectAsAPropertyList:task] atIndex:indexPath.row];
    
    [[NSUserDefaults standardUserDefaults] setObject:taskObjectsAsPropertyLists forKey:ADDED_TASK_OBJECTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self.tableView reloadData];
}



- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}



// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [self.taskObjectsArray removeObjectAtIndex:indexPath.row];
        
        NSMutableArray *newTaskObjectsData = [[NSMutableArray alloc] init];
        
        for (VONTaskObject *task in newTaskObjectsData) {
            [newTaskObjectsData addObject:[self taskObjectAsAPropertyList:task]];
        }
        
        [[NSUserDefaults standardUserDefaults] setObject:newTaskObjectsData forKey:ADDED_TASK_OBJECTS_KEY];
        [[NSUserDefaults standardUserDefaults] synchronize];
                
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"toTaskObjectDetail" sender:indexPath];
}



- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    VONTaskObject *task = self.taskObjectsArray[fromIndexPath.row];
    [self.taskObjectsArray removeObjectAtIndex:fromIndexPath.row];
    [self.taskObjectsArray insertObject:task atIndex:toIndexPath.row];
    [self saveTasks];
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


#pragma mark VONDetailVC Delegate

-(void)updateTask
{
    [self saveTasks];
    [self.tableView reloadData];
}

@end
