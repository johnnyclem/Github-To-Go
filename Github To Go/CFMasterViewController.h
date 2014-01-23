//
//  CFMasterViewController.h
//  Github To Go
//
//  Created by John Clem on 1/23/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CFDetailViewController;

#import <CoreData/CoreData.h>

@interface CFMasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) CFDetailViewController *detailViewController;

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
