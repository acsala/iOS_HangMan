//
//  FlipsideViewController.m
//  Hangman_UVA
//
//  Created by Attila Csala on 11/21/13.
//  Copyright (c) 2013 Attila Csala. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // display the dafault length and guesses
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    NSString *length = [defs stringForKey:@"length"];
    NSString *guesses = [defs stringForKey:@"guesses"];
    
    self.wordsGuesses.text = [NSString stringWithFormat:@"Number of guesses: %@", guesses];
    self.wordsLength.text = [NSString stringWithFormat:@"Length of the words in play: %@", length];
    
    self.wordsGuessesSlider.maximumValue = 26.0f;
    
    self.wordsGuessesSlider.value = [guesses floatValue];
    
    NSLog([NSString stringWithFormat:@"%f", [guesses floatValue]]);
    NSLog([NSString stringWithFormat:@"%f", 30.0f]);
    
    
    self.wordsLengthSlider.maximumValue = 12.0f;
    self.wordsLengthSlider.value = [length floatValue];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)changeSliderLength:(id)sender{
    self.wordsLength.text = [NSString stringWithFormat:@"Length of the words in play: %d ", (int) self.wordsLengthSlider.value];
}

-(IBAction)changeSliderGuesses:(id)sender{
    self.wordsGuesses.text = [NSString stringWithFormat:@"Number of guesses: %d ", (int) self.wordsGuessesSlider.value];
}

@end
