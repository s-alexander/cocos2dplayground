//
//  TestObject.m
//  Playground
//
//  Created by Александр Сергеев on 8/22/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "TestObject.h"
#import "cocos2d.h"
#import <Box2D/Box2D.h>

@implementation TestObject
-(id) init {
  self = [super init];
  if (self) {
    //To create a sprite from a file (png, jpg):
    CCSprite *mySprite = [CCSprite spriteWithFile:@"sprite_sample.png"]; //make sure you have imported the image file to your resources folder.
    
    //To set it's position on your scene:
    //mySprite.position = CGPointMake(240,180);   // that position would be the center of an iPhone/iPod screen
    [self setGra:mySprite];
  }
  return self;
}

- (id)initWithProperties:(NSDictionary *)p {
  self = [super initWithProperties:p];
  if (self) {
    CCSprite *mySprite = [CCSprite spriteWithFile:[p objectForKey:@"sprite"]];
    [self setGra:mySprite];
  }
  return self;
}

-(b2Shape *) shape {
  static b2CircleShape shape;
  shape.m_radius = 26.0f/32.0f;
  return &shape;
}

-(void) setupFixture:(b2FixtureDef *)fixture {
  fixture->density = 1.0f;
  fixture->friction = 0.8f;
  fixture->restitution = 0.5f;
}

-(void) setupBodyDef:(b2BodyDef *) bodyDef {
//  bodyDef->linearDamping = 10.0f;
//  bodyDef->angularDamping = 10.0f;
  [super setupBodyDef:bodyDef];
//  bodyDef->linearVelocity = b2Vec2(10, 1000);
}

@end
