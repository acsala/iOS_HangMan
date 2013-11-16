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

-(IBAction)startGame:(id)sender{
    
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
    
    // set uo the guessable letters list on screen
    for(int i = 0; i < 26; i++)
    {
        // with if else statement we are going to split our letters into two rows
        if( i < 13)
        {
            UILabel *letterLabel = [[UILabel alloc] initWithFrame:CGRectMake(distanceLetter, Height1, 20, 15)];
            
            [self setUpLetter:letterLabel withIndex:i];
        }
        
        else {
            if( i == 13)
                distanceLetter = 0;
            
            UILabel *letterLabel = [[UILabel alloc] initWithFrame:CGRectMake(distanceLetter, Height2, 20, 15)];
            
            [self setUpLetter:letterLabel withIndex:i];
        }
        
    }
    
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
        [self.productText addObject:@"- "];
    }
    
    // display productText on the screen
    self.displayLabel.text = [self.productText componentsJoinedByString:@""];
    
    // reset the remaining letters on screen
    [self resetLetters];
    
    // start the game with default values
    [self.gameplay start: defaults];
    
}

-(IBAction)receiveInput:(id)sender{
    
    // display the number of guesses left
    if([self.guessLabel.text  isEqual: @"Guess A Letter!"])
        self.guessLabel.text = [NSString stringWithFormat:@"Guesses Left: %d", guessCounter];
    
    // if there is already a letter, we only select the latest letter entered
    if([self.textInput.text length] > 1)
    {
        // track if the guess is correct
        BOOL correct_guess = NO;
        
        // find the letter that is entered last
        NSString *newOutput = [self.textInput.text substringFromIndex:[self.textInput.text length] -1];
        
        // display the new character in string form
        self.textInput.text = newOutput;
        
        // we create the char version to be passed to the check function
        char guess = [[newOutput lowercaseString] characterAtIndex:0];
        
        NSArray * answer = [self.gameplay wordCheck:guess];
        
        // see where to update the string being displayed
        for (int i = 0; i < [answer count]; i++)
        {
            if([answer objectAtIndex:i] == [NSNumber numberWithInt:1])
            {
                [self.productText replaceObjectAtIndex:(i) withObject:[NSString stringWithFormat: @"%c", tolower(guess)]];
                correct_guess = YES;
            }
            
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
                
            }
            
        }
        
        // if guess was incorrect
        else
        {
            for(UILabel *s in self.lettersArray)
            {
                
                if(guess == [s.text characterAtIndex:0])
                {
                    
                    // updates guesses fields
                    guessCounter--;
                    self.guessLabel.text = [NSString stringWithFormat:@"Guesses Left: %d", guessCounter];
                    
                    // if user has no more guesses left
                    if(guessCounter == 0 || guessCounter < 0)
                    {
                        self.guessLabel.text = [NSString stringWithFormat:@"You lost!"];
                    }
                    
                    break;
                }
            }
            
            self.displayLabel.text = [self.productText componentsJoinedByString:@""];
        }
        
        // checks if the letter is not guessed already
        [self checkLetter];

    }
    AudioServicesPlaySystemSound(sound);
    
}

-(void)checkLetter
{
    
    // iterate through the letters that are on the screen
    for (UILabel *s in self.lettersArray) {
        
        // check if textInput index 0 is equal to s.text index 0
        if([[self.textInput.text lowercaseString] characterAtIndex:0] == [s.text characterAtIndex:0]) {
            
            // if found change the guessed letter to an underscore
            s.text = @"✗";
        }
        
    }
    
}

- (void) resetLetters
{
    //self.answerLabel.frame = CGRectMake(0, 122, 320, 21);
    
    distanceLetter = 0;
    
    // display the letters that aren't guessed yet
    for(int i = 0; i < 26; i++){
        
        // with if else statement we are going to split our letters into two rows
        if( i < 13){
            // point to a new UILabel object s
            UILabel *s = [self.lettersArray objectAtIndex:i];
            // position of s
            s.frame = CGRectMake(distanceLetter, Height1, 20, 15);
            distanceLetter += 24;
            
        } else {
            
            // reset the x values for the beginning of row 2
            if( i == 13)
                distanceLetter = 0;
            
            UILabel *s = [self.lettersArray objectAtIndex:i];
            s.frame = CGRectMake(distanceLetter, Height2, 20, 15);
            distanceLetter += 24;
        }
        
    }
}

// method to create letters that are goung to be displayed
- (void)setUpLetter:(UILabel *)letterLabel withIndex: (int)i
{
    
    // programmatically create one of the available letter labels and add it to the view
    letterLabel.text = [NSString stringWithFormat: @"%c", (int)('a' + i )];
    letterLabel.textColor = [UIColor blackColor];
    letterLabel.textAlignment   = UITextAlignmentCenter;
    letterLabel.font = [UIFont systemFontOfSize:14];
    letterLabel.backgroundColor = [UIColor clearColor];
    [self.view addSubview:letterLabel];
    
    // set the next letter to be further to the right
    distanceLetter += 24;
    
    // add letter to array for checking if it has been guessed during the game
    [self.lettersArray insertObject:letterLabel atIndex:i];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // declear sound
    NSURL *button = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"cashreg" ofType:@"mp3"]];
    
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)button, &sound);
    
    // set up mutable dictonary to store defaults
    NSMutableDictionary *defaultValues = [[NSMutableDictionary alloc] init];
    [defaultValues setObject:@"5" forKey:@"length"];
    [defaultValues setObject:@"10" forKey:@"guesses"];
    [defaultValues setObject:@"20" forKey:@"longestWord"];
    
    // save defaults in standardUserDefaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults registerDefaults:defaultValues];
    
    // hide the textfield
    self.textInput.hidden = YES;
    // let keybord pop up after loading the app
    [self.textInput becomeFirstResponder];
    self.textInput.text = @"_";
    
    // initialize the lettersArray and wordArray
    self.lettersArray = [[NSMutableArray alloc] initWithObjects: nil];
    
    [self startGame: nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
