//
//  ALXGameScene.m
//  Playground
//
//  Created by Александр Сергеев on 7/23/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "ALXGameScene.h"
#import "cocos2d.h"

@implementation ALXGameScene
-(id) init {
  self = [super init];
  if (self) {
    //To create a sprite from a file (png, jpg):
    CCSprite *mySprite = [CCSprite spriteWithFile:@"sprite_sample.png"]; //make sure you have imported the image file to your resources folder.
    
    //To set it's position on your scene:
    mySprite.position = CGPointMake(240,180);   // that position would be the center of an iPhone/iPod screen
    [mySprite setTag:13];
    
    //To add it to the scene:
    [self addChild: mySprite];
    [mySprite runAction: [CCMoveTo actionWithDuration:1 position:CGPointZero]];
    
    [self schedule:@selector(nextFrame:)];
  }
  return self;
}

- (void) nextFrame:(ccTime)dt {
  //CCNode * node = [self getChildByTag:13];
  //[node setPosition:CGPointApplyAffineTransform([node position], CGAffineTransformMakeTranslation(1, 1))];
}

@end
