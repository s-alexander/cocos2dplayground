//
//  ALXObject.h
//  Playground
//
//  Created by Александр Сергеев on 8/14/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCScene.h"
#import "Box2D/Box2D.h"

class b2Body;
class b2BodyDef;
class b2Shape;

@interface ALXObject : NSObject {
  b2Body * _body;
}

@property (nonatomic, assign) CGPoint position;
@property (nonatomic, retain) CCNode * gra;

-(b2BodyType) bodyType;
-(void) setupFixture:(b2FixtureDef *) fixture;
-(b2Shape *) shape;

@property (nonatomic, assign) b2Body * body;

@end
