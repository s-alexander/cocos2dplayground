//
//  ALXGameScene.m
//  Playground
//
//  Created by Александр Сергеев on 7/23/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "ALXGameScene.h"
#import "cocos2d.h"
#import <Box2D/Box2D.h>
#import "ALXObject.h"

@implementation ALXGameScene
-(id) init {
  self = [super init];
  if (self) {
//    ALXObject * o = [[[ALXObject alloc]init]autorelease];
    ALXObject * o = [[ALXObject alloc]init];
    [self addObject:o];

    [self schedule:@selector(nextFrame:)];
  }
  return self;
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
