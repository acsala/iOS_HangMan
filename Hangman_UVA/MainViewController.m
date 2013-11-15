//
//  ViewController.m
//  Hangman_UVA
//
//  Created by Attila Csala on 11/8/13.
//  Copyright (c) 2013 Attila Csala. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

@synthesize textField;
@synthesize guessLabel;
@synthesize answerLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // hide the textfield
    self.textField.hidden = YES;
    // let keybord pop up after loading the app
    [self.textField becomeFirstResponder];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
