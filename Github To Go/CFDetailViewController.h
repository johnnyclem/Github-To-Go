//
//  CFDetailViewController.h
//  Github To Go
//
//  Created by John Clem on 1/23/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Repo.h"

@interface CFDetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) Repo *repo;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
