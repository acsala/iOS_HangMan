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
    
    
    self.gameplay = [[GamePlay alloc] init];
    
    
    // resets the words array
    self.gameplay.wordsArray = [[NSMutableArray alloc] initWithObjects: nil];
    
    
    // we produce the correct number of blanks
    self.productText = [[NSMutableArray alloc] init];
    
   
    
    // make the array into a string
    self.displayLabel.text = [self.productText componentsJoinedByString:@""];
    
    // reset the remaining letters on screen
    [self resetLetters];
    
   
    [self.gameplay start: nil];
    
}

-(IBAction)receiveInput:(id)sender{
    
    
    
}

-(void)checkForLetter
{
    
   
    
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
    letterLabel.text = [NSString stringWithFormat: @"%c", (int)('A' + i )];
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
    
    // set up muatble dictonary to store defaults
    NSMutableDictionary *defaultValues = [[NSMutableDictionary alloc] init];
    [defaultValues setObject:@"5" forKey:@"length"];
    [defaultValues setObject:@"8" forKey:@"guesses"];
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
