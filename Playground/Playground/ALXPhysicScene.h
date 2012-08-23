//
//  ALXPhysicScene.h
//  Playground
//
//  Created by Александр Сергеев on 8/10/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "CCScene.h"

class b2World;
class b2Body;

@class ALXObject;

@interface ALXPhysicScene : CCScene {
  b2World *_world;
  NSMutableSet * _objects;
}

-(void) addObject:(ALXObject *) o;
-(void) removeObject:(ALXObject *) o;

@end

inline CGPoint gra2phys(CGFloat x, CGFloat y) {
  return CGPointMake(x/32.0f, y/32.0f);
}

inline CGPoint gra2phys(CGPoint p) {
  return gra2phys(p.x, p.y);
}

