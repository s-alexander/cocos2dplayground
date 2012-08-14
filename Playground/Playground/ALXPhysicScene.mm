//
//  ALXPhysicScene.m
//  Playground
//
//  Created by Александр Сергеев on 8/10/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "ALXPhysicScene.h"
#import <Box2D/Box2D.h>
#import "ALXObject.h"


@implementation ALXPhysicScene
-(id) init {
  self = [super init];
  if (self) {
    // Create a world
    b2Vec2 gravity = b2Vec2(0.0f, -30.0f);
    _world = new b2World(gravity, true);
    CGSize winSize = [CCDirector sharedDirector].winSize;
    // Create edges around the entire screen
/*    b2BodyDef groundBodyDef;
    groundBodyDef.position.Set(0,0);
    b2Body *groundBody = _world->CreateBody(&groundBodyDef);
    b2PolygonShape groundEdge;
    b2FixtureDef boxShapeDef;
    boxShapeDef.shape = &groundEdge;
    groundEdge.Set(b2Vec2(0,0), b2Vec2(winSize.width/PTM_RATIO, 0));
    groundBody->CreateFixture(&boxShapeDef);
    groundEdge.Set(b2Vec2(0,0), b2Vec2(0, winSize.height/PTM_RATIO));
    groundBody->CreateFixture(&boxShapeDef);
    groundEdge.Set(b2Vec2(0, winSize.height/PTM_RATIO),
                   b2Vec2(winSize.width/PTM_RATIO, winSize.height/PTM_RATIO));
    groundBody->CreateFixture(&boxShapeDef);
    groundEdge.Set(b2Vec2(winSize.width/PTM_RATIO,
                          winSize.height/PTM_RATIO), b2Vec2(winSize.width/PTM_RATIO, 0));
    groundBody->CreateFixture(&boxShapeDef);*/
    

  }
  return self;
}

-(void) dealloc {
//  delete _body;
  delete _world;
  [super dealloc];
}

-(void) addObject:(ALXObject *) o {
  b2Body * body = _world->CreateBody(&[o bodyDef]);
  [o setBody:body];
  [self addChild:[o gra]];
}

-(void) removeObject:(ALXObject *) o {
  
}


@end
