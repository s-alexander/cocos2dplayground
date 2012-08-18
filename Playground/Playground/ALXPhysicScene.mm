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

- (void) nextFrame:(ccTime)dt {
#define PTM_RATIO 32.0
  
  _world->Step(dt, 10, 10);
  for(b2Body *b = _world->GetBodyList(); b; b=b->GetNext()) {
    if (b->GetUserData() != NULL) {
      ALXObject * o = (ALXObject *)b->GetUserData();
      
      CCNode *ballData = [o gra];
      ballData.position = ccp(b->GetPosition().x * PTM_RATIO,
                              b->GetPosition().y * PTM_RATIO);
      ballData.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
    }
  }
}

@end
