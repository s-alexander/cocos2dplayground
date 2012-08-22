//
//  ALXPhysicScene.m
//  Playground
//
//  Created by Александр Сергеев on 8/10/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "ALXPhysicScene.h"
#import <Box2D/Box2D.h>
#import "cocos2d.h"
#import "ALXObject.h"

#define PTM_RATIO 32.0

@implementation ALXPhysicScene
-(id) init {
  self = [super init];
  if (self) {
    _objects = [[NSMutableSet alloc]init];
    // Create a world
    b2Vec2 gravity = b2Vec2(0.0f, -30.0f);
    _world = new b2World(gravity);
    CGSize winSize = [CCDirector sharedDirector].winSize;
    // Create edges around the entire screen
    b2BodyDef groundBodyDef;
    groundBodyDef.position.Set(0,0);
    b2Body *groundBody = _world->CreateBody(&groundBodyDef);
    b2EdgeShape groundEdge;
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
    groundBody->CreateFixture(&boxShapeDef);
    [self schedule:@selector(nextFrame:)];

  }
  return self;
}

-(void) dealloc {
//  delete _body;
  for (ALXObject * o in _objects) {
    [self removeObject:0];
  }
  [_objects release];
  delete _world;
  [super dealloc];
}

-(void) addObject:(ALXObject *) o {
  b2BodyDef bodyDef;
  bodyDef.type = [o bodyType];
  const CGPoint p = [o position];
  bodyDef.position.Set(p.x, p.y);

  b2Body * body = _world->CreateBody(&bodyDef);
  [o setBody:body];
  CCNode * node = [o gra];
  if (node) {
    [self addChild:[o gra]];
  }
  [_objects addObject:o];
}

-(void) removeObject:(ALXObject *) o {
  
}

- (void) nextFrame:(ccTime)dt {
#define PTM_RATIO 32.0
  
  _world->Step(dt, 10, 10);
  for(b2Body *b = _world->GetBodyList(); b; b=b->GetNext()) {
    if (b->GetUserData() != NULL) {
      ALXObject * o = (ALXObject *)b->GetUserData();
      
      if (CCNode *ballData = [o gra]) {
        ballData.position = ccp(b->GetPosition().x * PTM_RATIO,
                                b->GetPosition().y * PTM_RATIO);
        ballData.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
      }
    }
  }
}

@end
