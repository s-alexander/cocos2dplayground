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

@implementation LevelGround

-(id) init {
  self = [super init];
  if (self) {
    _shape = new b2PolygonShape();
    b2Vec2 vertices[3];
    
    vertices[0].Set(5.0f, 5.0f);
    vertices[1].Set(6.0f, 5.0f);
    vertices[2].Set(5.0f, 6.0f);
    
    int32 count = 3;
    
    _shape->Set(vertices, count);

    PolygoneNode * node = [[[PolygoneNode alloc]init]autorelease];
    std::vector<GLfloat> verticles;
    verticles.push_back(0.0);
    verticles.push_back(0.0);
    
    verticles.push_back(0.0);
    verticles.push_back(1.0);
    
    verticles.push_back(0.5);
    verticles.push_back(1.0);

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
