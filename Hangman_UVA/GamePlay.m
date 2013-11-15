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
    
    // load the dictionary from the plist
    NSArray *words = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"words" ofType:@"plist"]];
    
}

- (NSArray *)wordCheck:(char)guess
{
    
    
    return nil;
    
}

@end
