//
//  StoryPageViewController.m
//  AVStorybook
//
//  Created by Steve on 2015-09-11.
//  Copyright (c) 2015 Steve. All rights reserved.
//

#import "StoryPartViewController.h"
#import "ViewController.h"
#import "Page.h"

@interface StoryPartViewController ()

@property (strong, nonatomic) NSArray *pages;

@end

@implementation StoryPartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    self.dataSource = self;
    
//    ViewController *page1 = [self.storyboard instantiateViewControllerWithIdentifier:@"page"];
//    ViewController *page2 = [self.storyboard instantiateViewControllerWithIdentifier:@"page"];
//    ViewController *page3 = [self.storyboard instantiateViewControllerWithIdentifier:@"page"];
//    ViewController *page4 = [self.storyboard instantiateViewControllerWithIdentifier:@"page"];
//    ViewController *page5 = [self.storyboard instantiateViewControllerWithIdentifier:@"page"];
    
    
    Page *page1 = [[Page alloc] init];
    Page *page2 = [[Page alloc] init];
    Page *page3 = [[Page alloc] init];
    Page *page4 = [[Page alloc] init];
    Page *page5 = [[Page alloc] init];
    
    
    self.pages = @[page1, page2, page3, page4, page5];
    
    
    ViewController *pagecontroller = [self.storyboard instantiateViewControllerWithIdentifier:@"page"];
    pagecontroller.page = page1;
    
    [self setViewControllers:@[pagecontroller] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    
}

#pragma mark - UIPageViewController data soucre -

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSInteger currentIndex = [self.pages indexOfObject:((ViewController *)viewController).page];
    
    currentIndex--;
    
    if (currentIndex >= 0){
        ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"page"];
        vc.page = [self.pages objectAtIndex:currentIndex];
        return vc;
    }
    
    return nil;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSInteger currentIndex = [self.pages indexOfObject:((ViewController *)viewController).page];
    
    currentIndex++;
    
    if (currentIndex < [self.pages count]) {
        ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"page"];
        vc.page = [self.pages objectAtIndex:currentIndex];
        return vc;
    } 
    
    return nil;
}

@end
