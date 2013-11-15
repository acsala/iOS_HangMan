//
//  GamePlay.h
//  Hangman_UVA
//
//  Created by Attila Csala on 11/13/13.
//  Copyright (c) 2013 Attila Csala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GamePlay : NSObject <UITextFieldDelegate>


@property (strong, nonatomic) NSMutableArray *wordsArray;
@property (strong, nonatomic) NSString *guessWord;
@property (strong, nonatomic) NSMutableArray *product;

/*
method for retrieving the words from our plist, load every word that match the requirements into an array,
then pick a random word from the array and store it as a string
*/
 - (void)start:(NSUserDefaults *)defaults;

/* wordCheck method will check the user's guesses,
 all the matched found will be returned to the controller in a mutable array
*/
- (NSArray*)wordCheck:(char)guess;

@end
