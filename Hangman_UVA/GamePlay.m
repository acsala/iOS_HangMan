//
//  GamePlay.m
//  Hangman_UVA
//
//  Created by Attila Csala on 11/13/13.
//  Copyright (c) 2013 Attila Csala. All rights reserved.
//

#import "GamePlay.h"

@implementation GamePlay

// method to start the game with defaults
- (void)start: (NSUserDefaults *)defs
{
    // use the words provided in plist
    NSArray *list = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"]];
    
    // clear up wordsArray
    [self.wordsArray removeAllObjects];
    
    // find a word that match with default length
    for (NSString *item in list)
    {
        if([item length] ==  [[defs objectForKey:@"length"] intValue])
        {
            // add it to the wordsArray
            [self.wordsArray addObject:item];
        }
    }
    
    // if array is not empty, pick a word from it randomly
    if([self.wordsArray count] > 0)
    {
        // store a random word in guessWord
        self.guessWord = [self.wordsArray objectAtIndex:(arc4random() % [self.wordsArray count])];
    }
    
}

- (BOOL)processInput:(NSString *)word{
    
    BOOL correct_guess = YES;
    
    
        // find the letter that is entered last
        NSString *updateText = [word substringFromIndex:[word length] -1];
        
        // display the new character in string form, then create the char version to be passed to the check function
        word = updateText;
        
        char letter = [[updateText lowercaseString] characterAtIndex:[word length] -1];
        
        NSArray * checkedAnswer = [self.gameplay wordCheck:letter];
        
        // see where to update the string being displayed
        for (int i = 0; i < [checkedAnswer count]; i++)
        {
            if([checkedAnswer objectAtIndex:i] == [NSNumber numberWithInt:1])
            {
                correct_guess = YES;
            }
            else{
                correct_guess = NO;
            }
            
        }

    
    return correct_guess;
}

// method to check if the target word constains the guessed letter (with word variable received from the controller)
- (NSArray *)wordCheck:(char)word
{
    // store the word user has to guess for in an array of chars (char)
    const char * wordChar = [self.guessWord UTF8String];
    const NSNumber *zero = [NSNumber numberWithInteger:0];
    const NSNumber *one = [NSNumber numberWithInteger:1];
    
    // create a mutable array to store matches with the same length as the chosen word
    self.product = [[NSMutableArray alloc] initWithCapacity:strlen(wordChar)];
    
    for(int i = 0; i < strlen(wordChar); i++)
    {
        // check if the user guessed correctly
        
        if(word == tolower(wordChar[i]))
            // place correct guess to the correct position
            [self.product insertObject:one atIndex:i];
        else
            [self.product insertObject:zero atIndex:i];
    }
    
    return self.product;
    
}

-(void)setScore:(NSString *)word :(int)score{
    // create mutable dictonary to store defaults
    
    NSUserDefaults *scoreValues = [NSUserDefaults standardUserDefaults];
    
    if (scoreValues) {
         
         [scoreValues setObject:[NSString stringWithFormat:@"%@", word] forKey:@"words"];
        [scoreValues setObject:[NSString stringWithFormat:@"%d", score] forKey:@"scores"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

@end
