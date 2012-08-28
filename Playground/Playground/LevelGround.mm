//
//  LevelGround.m
//  Playground
//
//  Created by Александр Сергеев on 8/22/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "LevelGround.h"
#import "cocos2d.h"
#import "PolygoneNode.h"
#include "ALXPhysicScene.h"

@implementation LevelGround

-(id) initWithProperties:(NSDictionary *) dict {
  self = [super init];
  if (self) {
    PolygoneNode * node = [[[PolygoneNode alloc]init]autorelease];
    
    [node setColor:Color([dict objectForKey:@"color"])];
    Vertexes v;
    for (NSNumber * n in [dict objectForKey:@"points"]) {
      const float f = [n floatValue];
      v.push_back(f);
    }
    
    const int vertexCount = v.size()/2;
    b2Vec2 * b2vec = new b2Vec2[vertexCount];
    
    for (int i = 0; i < vertexCount; ++i) {
      const CGFloat x = v[i*2];
      const CGFloat y = v[i*2+1];
      const CGPoint p = gra2phys(x, y);
      b2vec[i].Set(p.x, p.y);
    }
    _shape = new b2PolygonShape();
    _shape->Set(b2vec, vertexCount);
    delete [] b2vec;
    
    [node setVertexes:v];
    [self setGra:node];
  }
  return self;
}

-(id) init {
  self = [super init];
  if (self) {
  }
  return self;
}

-(void) dealloc {
  if (_shape) {
    delete _shape;
  }
  [super dealloc];
}

-(b2Shape *) shape {
  return _shape;
}

-(void) setupFixture:(b2FixtureDef *)fixture {
  fixture->density = 1.0f;
  fixture->friction = 0.8f;
  fixture->restitution = 0.5f;
}

@end
