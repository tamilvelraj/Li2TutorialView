//
//  ViewController.m
//  Li2TutorialView
//
//  Created by Thamil Selvan V on 22/02/16.
//
//

#import "ViewController.h"
#import "TutorialScreenView.h"

@interface ViewController ()
{
    UIButton *showButton;
    CGRect screenBounds;
}
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    screenBounds = [UIScreen mainScreen].bounds;
    
    showButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [showButton setTintColor:[UIColor colorWithRed:9/255.f green:117.f/255.f blue:181.f/255.f alpha:1.f]];
    [showButton setTitle:@"Show Tutorial" forState:UIControlStateNormal];
    [showButton addTarget:self action:@selector(showTutorial) forControlEvents:UIControlEventTouchUpInside];
    
    showButton.layer.borderColor = [UIColor colorWithRed:69/255.f green:137.f/255.f blue:221.f/255.f alpha:1.f].CGColor;
    showButton.layer.borderWidth = 1.f;
    showButton.center = self.view.center;
    showButton.bounds = CGRectMake(40, 0, CGRectGetWidth(screenBounds)-80, 44);
    [self.view addSubview:showButton];
    
}

-(void)showTutorial
{
    TutorialScreenView *screenView=[[TutorialScreenView alloc] initWithFrame:screenBounds];
    
    [screenView addArrowAtPoint:CGPointMake(CGRectGetWidth(screenBounds)-60, 100) arrowDirection:ARROW_UP_RIGHT forTitle:@"Start new ios project for tutorial view."];
    
    [screenView addArrowAtPoint:CGPointMake(60, 250) arrowDirection:ARROW_UP_LEFT forTitle:@"Open an exist ios project from the project workspace."];
    
    [screenView addArrowAtPoint:CGPointMake(CGRectGetWidth(screenBounds)-60, CGRectGetHeight(screenBounds)-300) arrowDirection:ARROW_DOWN_RIGHT forTitle:@"Check out the project source from git repository."];
    
    [screenView addArrowAtPoint:CGPointMake(60, CGRectGetHeight(screenBounds)-100) arrowDirection:ARROW_DOWN_LEFT forTitle:@"Read Me: configuration documents and How-tos"];
    
    [screenView showTutorial];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
