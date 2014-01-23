//
//  CFAppDelegate.h
//  Github To Go
//
//  Created by John Clem on 1/23/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
