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

-(id) initWithDictionary:(NSDictionary *) dict {
  self = [super init];
  if (self) {
    PolygoneNode * node = [[[PolygoneNode alloc]init]autorelease];
    
    [node setColor:Color([dict objectForKey:@"color"])];
    
    Verticles v;
    for (NSNumber * n in [dict objectForKey:@"points"]) {
//      const float f = atof([s cStringUsingEncoding:NSUTF8StringEncoding]);
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
    
    [node setVerticles:v];
    [self setGra:node];
  }
  return self;
}

-(id) init {
  self = [super init];
  if (self) {
    _shape = new b2PolygonShape();

    PolygoneNode * node = [[[PolygoneNode alloc]init]autorelease];
    Verticles verticles;
    verticles.push_back(0.0);
    verticles.push_back(0.0);
    
    verticles.push_back(200.0);
    verticles.push_back(0.0);
    
    verticles.push_back(100.0);
    verticles.push_back(100.0);
    
    const int vertexCount = verticles.size()/2;
    b2Vec2 * b2vec = new b2Vec2[vertexCount];
    
    for (int i = 0; i < vertexCount; ++i) {
      const CGFloat x = verticles[i*2];
      const CGFloat y = verticles[i*2+1];
      const CGPoint p = gra2phys(x, y);
      b2vec[i].Set(p.x, p.y);
    }
    _shape->Set(b2vec, vertexCount);
    delete [] b2vec;
    
    [node setVerticles:verticles];
    [self setGra:node];

  }
  return self;
}

-(void) dealloc {
  delete _shape;
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
