//
//  CFDetailViewController.m
//  Github To Go
//
//  Created by John Clem on 1/23/14.
//  Copyright (c) 2014 Code Fellows. All rights reserved.
//

#import "CFDetailViewController.h"

@interface CFDetailViewController () <UIWebViewDelegate>

@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (void)configureView;

@end

@implementation CFDetailViewController

#pragma mark - Managing the detail item

- (void)setRepo:(id)repo
{
    if (_repo != repo) {
        _repo = repo;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.
//    [_webView setFrame:CGRectMake(0, 0, 768, 1024)];
    
    if (!self.repo.htmlString) {
        NSString *webString = [NSString stringWithContentsOfURL:[NSURL URLWithString:self.repo.html_url] encoding:NSUTF8StringEncoding error:nil];
        self.repo.htmlString = webString;
        [self.repo.managedObjectContext save:nil];
    }

    [_webView loadHTMLString:self.repo.htmlString baseURL:nil];
    self.navigationItem.title = self.repo.name;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Repos", @"Repos");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
