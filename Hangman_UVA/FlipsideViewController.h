//
//  FlipsideViewController.h
//  Hangman_UVA
//
//  Created by Attila Csala on 11/21/13.
//  Copyright (c) 2013 Attila Csala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FlipsideViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *wordsLength;
@property (weak, nonatomic) IBOutlet UILabel *wordsGuesses;
@property (weak, nonatomic) IBOutlet UISlider *wordsLengthSlider;
@property (weak, nonatomic) IBOutlet UISlider *wordsGuessesSlider;

-(IBAction)changeSliderLength:(id)sender;
-(IBAction)changeSliderGuesses:(id)sender;

@end
