//
//  CFDetailViewController.h
//  Github To Go
//
//  Created by John Clem on 1/23/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CFDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) NSDictionary *repo;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
