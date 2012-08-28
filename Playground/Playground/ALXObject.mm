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
@synthesize properties;

-(id) initWithProperties:(NSDictionary *) p {
  self = [super init];
  if (self) {
    [self setProperties:p];
  }
  return self;
  
}

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

-(void) setupBodyDef:(b2BodyDef *) bodyDef {
  if ([self properties]) {
    const float x = [[properties objectForKey:@"x"] floatValue];
    const float y = [[properties objectForKey:@"y"] floatValue];
    [self setPosition:CGPointMake(x, y)];
  }
}


-(void) setBody:(b2Body *)body {
  if (_body && _body->GetWorld()) {
    _body->GetWorld()->DestroyBody(_body);
  }
  _body = body;
  if (_body) {
    b2FixtureDef fixDef;
    [self setupFixture:&fixDef];
    fixDef.shape = [self shape];
    _body->CreateFixture(&fixDef);
    _body->SetUserData(self);
  }
}


-(void) dealloc {
  [self setBody:0];
  [self setProperties:0];
  [self setGra:0];
  [super dealloc];
}

@end
