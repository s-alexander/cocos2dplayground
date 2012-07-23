//
//  ALXMainMenu.m
//  Playground
//
//  Created by Александр Сергеев on 7/23/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "ALXMainMenu.h"
#import "CCMenu.h"
#import "ALXGameScene.h"

@implementation ALXMainMenu

+(CCMenu *) mainMenu:(CCScene *)s {
  CCMenuItemFont * resume = [[[CCMenuItemFont alloc]initFromString:@"Resume" target:s selector:@selector(resume:)]autorelease];
  CCMenuItemFont * newGame = [[[CCMenuItemFont alloc]initFromString:@"New game" target:s selector:@selector(newGame:)]autorelease];
  CCMenuItemFont * about = [[[CCMenuItemFont alloc]initFromString:@"About" target:s selector:@selector(about:)]autorelease];
  CCMenu * menu = [CCMenu menuWithItems:resume,newGame, about, nil];
  [menu alignItemsVerticallyWithPadding:20];
  return menu;
}

-(id) init {
  self = [super init];
  if (self) {
    CCMenu *menu = [ALXMainMenu mainMenu:self];
    
    // add layer as a child to scene
    [self addChild: menu];
  }
  return self;
}

- (void) resume: (CCMenuItem  *) menuItem 
{
	NSLog(@"Resume");
}

- (void) newGame: (CCMenuItem  *) menuItem 
{
  ALXGameScene * scene = [ALXGameScene node];
  [[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:scene]];
	NSLog(@"New game");
}

- (void) about: (CCMenuItem  *) menuItem 
{
	NSLog(@"About");
}

@end
