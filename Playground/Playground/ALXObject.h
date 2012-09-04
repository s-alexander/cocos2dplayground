//
//  ALXObject.h
//  Playground
//
//  Created by Александр Сергеев on 8/14/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCScene.h"
#import "ALXObjectController.h"
#import "Box2D/Box2D.h"

class b2Body;
class b2BodyDef;
class b2Shape;

@interface ALXObject : NSObject {
  b2Body * _body;
}

-(id) initWithProperties:(NSDictionary *) p;

@property (nonatomic, assign) CGPoint position;
@property (nonatomic, retain) CCNode * gra;
@property (nonatomic, retain) NSDictionary * properties;
@property (nonatomic, assign) id<ALXObjectController> controller;

-(b2BodyType) bodyType;
-(void) setupFixture:(b2FixtureDef *) fixture;
-(void) setupBodyDef:(b2BodyDef *) bodyDef;
-(b2Shape *) shape;

@property (nonatomic, assign) b2Body * body;

@end
