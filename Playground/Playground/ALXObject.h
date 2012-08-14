//
//  ALXObject.h
//  Playground
//
//  Created by Александр Сергеев on 8/14/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CCScene.h"

class b2Body;
class b2BodyDef;

@interface ALXObject : NSObject {
  b2Body * _body;
}


@property (nonatomic, retain) CCNode * gra;
-(b2BodyDef) bodyDef;

@property (nonatomic, assign) b2Body * body;

@end
