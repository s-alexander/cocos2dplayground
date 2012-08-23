//
//  LevelGround.h
//  Playground
//
//  Created by Александр Сергеев on 8/22/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "ALXStaticObject.h"

@interface LevelGround : ALXStaticObject {
  b2PolygonShape * _shape;
}

-(id) initWithDictionary:(NSDictionary *) dict;

@end
