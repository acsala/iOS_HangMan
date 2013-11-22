//
//  FlipsideViewController.h
//  Hangman_UVA
//
//  Created by Attila Csala on 11/21/13.
//  Copyright (c) 2013 Attila Csala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlipsideViewController : UIViewController

// UILabel for displaying the length that user can manipulate
@property (weak, nonatomic) IBOutlet UILabel *wordsLength;
// UILabel for displaying the guesses that user can manipulate
@property (weak, nonatomic) IBOutlet UILabel *wordsGuesses;

// UISlider for manipulating the length
@property (weak, nonatomic) IBOutlet UISlider *wordsLengthSlider;
// UISlider for manipulating the guesses
@property (weak, nonatomic) IBOutlet UISlider *wordsGuessesSlider;

// IBaction to alter the length values if LengthSlider's value changes
-(IBAction)changeSliderLength:(id)sender;
// IBaction to alter the guesses values if GuessesSlider's value changes
-(IBAction)changeSliderGuesses:(id)sender;

@end
