//
//  ViewController.h
//  Hangman_UVA
//
//  Created by Attila Csala on 11/8/13.
//  Copyright (c) 2013 Attila Csala. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController

// textfield in order to get input from user
@property (weak, nonatomic) IBOutlet UITextField *textField;
//here we will display the answer
@property (weak, nonatomic) IBOutlet UILabel *answerLabel;
// display the reminding guesses
@property (weak, nonatomic) IBOutlet UILabel *guessLabel;

@end
