//
//  ViewController.h
//  Hangman_UVA
//
//  Created by Attila Csala on 11/8/13.
//  Copyright (c) 2013 Attila Csala. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GamePlay.h"
#import "AudioToolbox/AudioToolbox.h"

int guessCounter;
int distanceLetter;

// height of the first line letters
static const int Height1 = 80;
// height of the second line letters
static const int Height2 = 110;

@interface MainViewController : UIViewController{
    
    SystemSoundID guessSound;
    SystemSoundID gameoverSound;
    SystemSoundID gamewonSound;
    
}

// textfield in order to get input from user
@property (weak, nonatomic) IBOutlet UITextField *textInput;
//here we will display the answer
@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
// display the reminding guesses
@property (weak, nonatomic) IBOutlet UILabel *guessLabel;
// mutable array to store guessed letters
@property (strong, nonatomic) NSMutableArray *lettersArray;
// 
@property (strong, nonatomic) NSMutableArray *productText;

// make a property of model GamePlay
@property (strong, nonatomic) GamePlay *gameplay;

// method for new game
-(IBAction)startGame:(id)sender;
// capture input from user
-(IBAction)receiveInput:(id)sender;

@end
