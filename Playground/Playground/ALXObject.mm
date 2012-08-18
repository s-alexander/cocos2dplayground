//
//  ALXObject.m
//  Playground
//
//  Created by Александр Сергеев on 8/14/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "ALXObject.h"
#import <Box2D/Box2D.h>
#import "cocos2d.h"

#define PTM_RATIO 32.0

@implementation ALXObject
@synthesize gra;
@dynamic body;
@dynamic position;

-(id) init {
  self = [super init];
  if (self) {
    //To create a sprite from a file (png, jpg):
    CCSprite *mySprite = [CCSprite spriteWithFile:@"sprite_sample.png"]; //make sure you have imported the image file to your resources folder.
    
    //To set it's position on your scene:
    mySprite.position = CGPointMake(240,180);   // that position would be the center of an iPhone/iPod screen
    [self setGra:mySprite];
  }
  return self;
}

-(CGPoint) position {
  return gra.position;
}

-(void) setPosition:(CGPoint)position {
  [[self gra] setPosition:position];
}

-(b2Body *) body {
  return _body;
}

-(void) setupFixture {
  b2CircleShape circle;
  circle.m_radius = 26.0/PTM_RATIO;
  
  b2FixtureDef ballShapeDef;
  ballShapeDef.shape = &circle;
  ballShapeDef.density = 1.0f;
  ballShapeDef.friction = 0.2f;
  ballShapeDef.restitution = 0.8f;
  _body->CreateFixture(&ballShapeDef);
}

-(void) setBody:(b2Body *)body {
  if (_body && _body->GetWorld()) {
    _body->GetWorld()->DestroyBody(_body);
  }
  _body = body;
  [self setupFixture];
  _body->SetUserData(self);
}

-(b2BodyDef) bodyDef {
  b2BodyDef ballBodyDef;
  ballBodyDef.type = b2_dynamicBody;
  const CGPoint p = [self position];
  ballBodyDef.position.Set(p.x, p.y);
  return ballBodyDef;
}

-(void) dealloc {
  [super dealloc];
}

@end
