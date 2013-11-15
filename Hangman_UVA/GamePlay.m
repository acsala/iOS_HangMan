//
//  GamePlay.m
//  Hangman_UVA
//
//  Created by Attila Csala on 11/13/13.
//  Copyright (c) 2013 Attila Csala. All rights reserved.
//

#import "GamePlay.h"

@implementation GamePlay

- (void)start: (NSUserDefaults *)defaults
{
    // remove all words to begin new game
    [self.wordsArray removeAllObjects];
    
    // load the dictionary from the plist, store it in words
    NSArray *words = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"]];
    
    // find a word that match with default length
    for (NSString *word in words)
    {
        if([word length] ==  [[defaults objectForKey:@"length"] intValue])
        {
            // add it to the wordsArray
            [self.wordsArray addObject:word];
        }
    }
    
    // if array is not empty, pick a word from it randomly
    if([self.wordsArray count] != 0)
    {
        // store a random word in guessWord
        int random = (arc4random() % [self.wordsArray count]);
        self.guessWord = [self.wordsArray objectAtIndex:random];
    }
    
}

- (NSArray *)wordCheck:(char)guess
{
    // turn the randomely chosen word into a c string (array of chars)
    const char * cString = [self.guessWord UTF8String];
    
    self.product = [[NSMutableArray alloc] initWithCapacity:strlen(cString)];
    
    // iterate thru, look for matches against the user's guess
    for(int i = 0; i < strlen(cString); i++)
    {
        // user guessed corrently
        if((guess == toupper(cString[i])) || (guess == tolower(cString[i])))
            [self.product insertObject:[NSNumber numberWithInt:1] atIndex:i];
        // or incorrectly
        else
            [self.product insertObject:[NSNumber numberWithInt:0] atIndex:i];
    }
    
    return self.product;
    
}

@end
