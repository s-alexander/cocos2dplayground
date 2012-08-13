//
//  ALXPhysicScene.h
//  Playground
//
//  Created by Александр Сергеев on 8/10/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "CCScene.h"

#define PTM_RATIO 32.0

class b2World;
class b2Body;

@interface ALXPhysicScene : CCScene {
  b2World *_world;
  b2Body *_body;
}

@end
