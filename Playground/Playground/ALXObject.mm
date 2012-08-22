//
//  ALXObject.m
//  Playground
//
//  Created by Александр Сергеев on 8/14/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "ALXObject.h"
#import <Box2D/Box2D.h>

#define PTM_RATIO 32.0

@implementation ALXObject
@synthesize gra;
@dynamic body;
@dynamic position;

-(id) init {
  self = [super init];
  if (self) {
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

-(b2BodyType) bodyType {
  return b2_staticBody;
}

-(b2Shape *) shape {
  return 0;
}

-(void) setupFixture:(b2FixtureDef *) fixture {
}


-(void) setBody:(b2Body *)body {
  if (_body && _body->GetWorld()) {
    _body->GetWorld()->DestroyBody(_body);
  }
  _body = body;
  b2FixtureDef fixDef;
  [self setupFixture:&fixDef];
  fixDef.shape = [self shape];
  _body->CreateFixture(&fixDef);
  _body->SetUserData(self);
}


-(void) dealloc {
  [super dealloc];
}

@end
