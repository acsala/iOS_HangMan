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
    
    // set minimum and maximum values of GuessesSlider
    self.wordsGuessesSlider.minimumValue = 1.0f;
    self.wordsGuessesSlider.maximumValue = 26.0f;
    
    self.wordsGuessesSlider.value = [guesses floatValue];
    
    NSLog([NSString stringWithFormat:@"%f", [guesses floatValue]]);
    NSLog([NSString stringWithFormat:@"%f", 30.0f]);
    
    /* set minimum and maximum values of LengthSlider, set the value of the shortest word's length in dictonary to minimum and the longest word's length in dictornary to maximum */
    
    // find the length of the longest and shortest words in our list
    int longestWord = 0;
    int shortestWord = 10;
    for(NSString *word in [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"]])
    {
        // replace the current 'king of length' if a longer word is found
        if([word length] > longestWord)
        {
            longestWord = [word length];
        }
        if([word length] < shortestWord)
        {
            shortestWord = [word length];
        }
    }
    
    self.wordsLengthSlider.minimumValue = (float) shortestWord;
    self.wordsLengthSlider.maximumValue = (float) longestWord;
    self.wordsLengthSlider.value = [length floatValue];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)changeSliderLength:(id)sender{
    
    int newLength = (int) self.wordsLengthSlider.value;
    
    self.wordsLength.text = [NSString stringWithFormat:@"Length of the words in play: %d ", newLength];
    
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    [defs setObject:[NSString stringWithFormat:@"%d", newLength] forKey:@"length"];
    [defs synchronize];
}

-(IBAction)changeSliderGuesses:(id)sender{
    
    int newGuesses = (int) self.wordsGuessesSlider.value;
    self.wordsGuesses.text = [NSString stringWithFormat:@"Number of guesses: %d ", newGuesses];
    
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    [defs setObject:[NSString stringWithFormat:@"%d", newGuesses] forKey:@"guesses"];
    [defs synchronize];
    
}

@end
