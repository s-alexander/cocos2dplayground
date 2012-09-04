//
//  ALXGameScene.m
//  Playground
//
//  Created by Александр Сергеев on 7/23/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "ALXGameScene.h"

#import "TestObject.h"
#import "LevelGround.h"

#import "ALXGamePadController.h"
#import "safe_cast.h"

@implementation ALXGameScene

@synthesize gamepadPointer;

-(id) init {
  self = [super init];
  if (self) {
    CCSprite *gamePadBackground = [CCSprite spriteWithFile:@"gamepad_background.png"];
    const CGSize winSize = [CCDirector sharedDirector].winSize;
    [gamePadBackground setPosition:CGPointMake(winSize.width-gamePadBackground.textureRect.size.width/2, gamePadBackground.textureRect.size.height/2)];
    [self addChild:gamePadBackground];
    
    CCSprite *gamePadPointer = [CCSprite spriteWithFile:@"gamepad_pointer.png"];
    [gamePadPointer setPosition:CGPointMake(0, 0)];
    
    [gamePadBackground addChild:gamePadPointer];
    [self setGamepadPointer:gamePadPointer];
    

    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];

//    ALXObject * o = [[[ALXObject alloc]init]autorelease];
    /*for (int i = 0; i < 10; ++i) {
      TestObject * o = [[[TestObject alloc]init]autorelease];
      [o setPosition:CGPointMake((5+rand()%10), 5+(rand()%10))];
//      [o setPosition:CGPointMake(10, 10)];
      [self addObject:o];
    }*/
    
    /*LevelGround * lg = [[[LevelGround alloc]init]autorelease];
    [lg setPosition:CGPointMake(5,0)];
    [self addObject:lg];*/
  }
  return self;
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
  //CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
  //[self selectSpriteForTouch:touchLocation];
  return YES;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
  const CGPoint touchLocation = [[gamepadPointer parent] convertTouchToNodeSpace:touch];
  [gamepadPointer setPosition:touchLocation];
  const CGSize sz = [safe_cast<CCSprite>([gamepadPointer parent]) textureRect].size;
  const CGPoint relPos = CGPointMake(touchLocation.x - sz.width/2, touchLocation.y - sz.height/2);
  NSLog(@"rel pos %@", NSStringFromCGPoint(relPos));
  [[ALXGamePadController sharedController] setPosition:relPos];
}



@end
