//
//  GamePlay.h
//  Hangman_UVA
//
//  Created by Attila Csala on 11/13/13.
//  Copyright (c) 2013 Attila Csala. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GamePlay : NSObject <UITextFieldDelegate>

// array to store words that match length from defaults
@property (strong, nonatomic) NSMutableArray *wordsArray;
// radnomly picked word from wordsArray
@property (strong, nonatomic) NSString *guessWord;
// product of wordCheck
@property (strong, nonatomic) NSMutableArray *product;

@property (strong, nonatomic) GamePlay *gameplay;

/*
method for retrieving the words from our plist, load every word that match the requirements into an array,
then pick a random word from the array and store it as a string
*/
 - (void)start:(NSUserDefaults *)defs;

/* wordCheck method will check the user's guesses,
 all the matched found will be returned to the controller in a mutable array
*/
- (NSArray*)wordCheck:(char)word;

- (BOOL)processInput:(NSString *)word;

@end
