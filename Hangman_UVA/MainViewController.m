/*
//  ViewController.m
//  Hangman_UVA
//
//  Created by Attila Csala on 11/8/13.
//  Copyright (c) 2013 Attila Csala. All rights reserved.
//
// this HangMan implementation is inspired by the walkthrough for evil hangman of CS76, a grea deal
// of help was Shawn Arney's tutorial (link www.youtube.com/watch?v=I63BSGsFnEw) reating and displaying
// the arrays of letters along with the logics are partly implemented from github.com/buffalohird/Evil-
// Hangman/blob/master/Project2_5/MainViewController.m
*/

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

-(IBAction)startGame:(id)sender{
    
    // show keyboard
    [self.textInput becomeFirstResponder];
    
    // clean the screen from guessed letters at beginning of the game
    for (UILabel *s in self.lettersArray)
    {
        
        [s removeFromSuperview];
        
    }
    
    // set up variable defaults as standardUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // start the game with
    [self.gameplay start: defaults];
    
    // distance of first letter from the left edge of the screen
    distanceLetter= 0;
    
    // set up the guessable letters list on screen
    [self setLetters];
    
    // change taxt on label
    self.guessLabel.text = @"Please Guess A Letter!";
    
    // initialize gameplay
    self.gameplay = [[GamePlay alloc] init];
    
    
    // set wordsArray to an epty array
    self.gameplay.wordsArray = [[NSMutableArray alloc] initWithObjects: nil];
    
    
    // load the guesses counter from the user's chosen value
    guessCounter = [[defaults stringForKey:@"guesses"] intValue];
    
    // initialize productText
    self.productText = [[NSMutableArray alloc] init];
    
    // for loop for filling the productText with the corresponding number of underscores
    for(int counter = 0; counter < ([[defaults objectForKey:@"length"] intValue]); counter++)
    {
        // fill up the array productText with underscores
        [self.productText addObject:@"_ "];
    }
    
    // display productText on the screen
    self.displayLabel.text = [self.productText componentsJoinedByString:@""];
    
    // reset the remaining letters on screen
    [self resetLetters];
    
    // start the game with default values
    [self.gameplay start: defaults];
    
}

// IBAction, takes the guesses from the player
-(IBAction)receiveInput:(id)sender{
    
    // display the number of guesses left
    self.guessLabel.text = [NSString stringWithFormat:@"Guesses Left: %d", guessCounter];
    
    // if there is already a letter, we only select the latest letter entered
    if([self.textInput.text length] > 1)
    {
        // find the letter that is entered last
        NSString *updateText = [self.textInput.text substringFromIndex:[self.textInput.text length] -1];
        
        // display the new character in string form, then create the char version to be passed to the check function
        self.textInput.text = updateText;
        
        char letter = [[updateText lowercaseString] characterAtIndex:[self.textInput.text length] -1];
        
        NSArray * checkedAnswer = [self.gameplay wordCheck:letter];
        
        // track if the guess is correct
        BOOL correct_guess = NO;
        
        // see where to update the string being displayed
        for (int i = 0; i < [checkedAnswer count]; i++)
        {
            if([checkedAnswer objectAtIndex:i] == [NSNumber numberWithInt:1])
            {
                [self.productText replaceObjectAtIndex:(i) withObject:[NSString stringWithFormat: @"%c", tolower(letter)]];
                correct_guess = YES;
                self.TEST.text = [NSString stringWithFormat:@"%d", correct_guess];
                NSLog([NSString stringWithFormat:@"%s", correct_guess ? "true" : "false"]);
            }
            else{
                correct_guess = NO;
                NSLog([NSString stringWithFormat:@"%s", correct_guess ? "true" : "false"]);
            }
            
        }
        
        // if guess was incorrect
        if (correct_guess == NO)
        {
            for(UILabel *display in self.lettersArray)
            {
                
                if(letter == [display.text characterAtIndex:0])
                {
                    
                    // updates guesses fields
                    guessCounter--;
                    self.guessLabel.text = [NSString stringWithFormat:@"Guesses Left: %d", guessCounter];
                    
                    // if user has no more guesses left
                    if(guessCounter == 0 || guessCounter < 0)
                    {
                        self.guessLabel.text = [NSString stringWithFormat:@"You lost! The word was: %@", [self.gameplay.guessWord lowercaseString]];
                        [self.textInput resignFirstResponder];
                        AudioServicesPlaySystemSound(gameoverSound);
                        
                    }
                    
                    break;
                }
            }
            
            self.displayLabel.text = [self.productText componentsJoinedByString:@""];
        }
        
        // if the user guessed correctly
        if(correct_guess == YES)
        {
            /*
             componentsJoinedByString:
             Constructs and returns an NSString object that is the result of interposing a given separator between the elements of the array.
             */
            self.displayLabel.text = [self.productText componentsJoinedByString:@""];
            
            // if user won
            if([[self.gameplay.guessWord lowercaseString] isEqualToString:[self.displayLabel.text lowercaseString]]){
                
                self.guessLabel.text = [NSString stringWithFormat:@"You won!"];
                [self.textInput resignFirstResponder];
                AudioServicesPlaySystemSound(gamewonSound);
                
            }
            
        }
        
        // checks if the letter is not guessed already
        [self checkLetter];

    }
    AudioServicesPlaySystemSound(guessSound);
    
}

-(void)checkLetter
{
    
    // iterate through the letters that are on the screen
    for (UILabel *display in self.lettersArray) {
        
        // check if textInput index 0 is equal to s.text index 0
        if([[self.textInput.text lowercaseString] characterAtIndex:0] == [display.text characterAtIndex:0]) {
            
            // if found change the guessed letter to an underscore
            display.text = @"✗";
        }
        
    }
    
}

- (void) resetLetters
{
    distanceLetter = 0;
    int count = 0;
    
    // display the letters that aren't guessed yet
    while(count < 26){
        
        // with if else statement we are going to split our letters into two rows
        if( count < 13){
            // point to a new UILabel object s
            UILabel *s = [self.lettersArray objectAtIndex:count];
            // position of s
            s.frame = CGRectMake(distanceLetter, Height1, 20, 15);
            distanceLetter += 24;
            
        } else {
            
            // reset the x values for the beginning of row 2
            if( count == 13)
                distanceLetter = 0;
            
            UILabel *s = [self.lettersArray objectAtIndex:count];
            s.frame = CGRectMake(distanceLetter, Height2, 20, 15);
            distanceLetter += 24;
        }
        count++;
    }
}

- (void) setLetters
{
    int count = 0;
    while(count < 26)
    {
        // with if else statement we are going to split our letters into two rows
        if( count < 13)
        {
            UILabel *letterLabel = [[UILabel alloc] initWithFrame:CGRectMake(distanceLetter, Height1, 20, 15)];
            
            [self setUpLetter:letterLabel withIndex:count];
            count++;
        }
        
        else {
            if( count == 13)
                distanceLetter = 0;
            
            UILabel *letterLabel = [[UILabel alloc] initWithFrame:CGRectMake(distanceLetter, Height2, 20, 15)];
            
            [self setUpLetter:letterLabel withIndex:count];
            count++;
        }
        
    }
    
}

// method to create letters that are goung to be displayed
- (void)setUpLetter:(UILabel *)letterLabel withIndex: (int)i
{
    
    // programmatically create one of the available letter labels and add it to the view
    letterLabel.text = [NSString stringWithFormat: @"%c", (int)('a' + i )];
    letterLabel.backgroundColor = [UIColor clearColor];
    letterLabel.font = [UIFont systemFontOfSize:16];
    letterLabel.textColor = [UIColor blackColor];
    letterLabel.textAlignment   = UITextAlignmentCenter;
    [self.view addSubview:letterLabel];
    
    // set distance between letters
    distanceLetter += 24;
    
    // lettersArray for adding letters for checking if it has been guessed during the game
    [self.lettersArray insertObject:letterLabel atIndex:i];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // lettersArray and wordArray
    self.lettersArray = [[NSMutableArray alloc] initWithObjects: nil];
    
    // let keybord pop up after loading the app
    [self.textInput becomeFirstResponder];
    
    // declear sound
    NSURL *guessLetterSound = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cashreg" ofType:@"mp3"]];
    NSURL *lostSound = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"lost" ofType:@"mp3"]];
    NSURL *wonSound = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"won" ofType:@"mp3"]];
    
    // guessound
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)guessLetterSound, &guessSound);
    // gameoverSound
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)lostSound, &gameoverSound);
    // gamewonSOund
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)wonSound, &gamewonSound);
    
    // create mutable dictonary to store defaults
    NSMutableDictionary *defs = [[NSMutableDictionary alloc] init];
    [defs setObject:@"25" forKey:@"guesses"];
    [defs setObject:@"3" forKey:@"length"];
    
    // save defaults in standardUserDefaults
    NSUserDefaults *defValues = [NSUserDefaults standardUserDefaults];
    [defValues registerDefaults:defs];
    
    // hide the textfield
    self.textInput.hidden = YES;
    
    [self startGame: nil];
    
}

@end
