//
//  ALXStaticObject.m
//  Playground
//
//  Created by Александр Сергеев on 8/22/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "ALXStaticObject.h"

@implementation ALXStaticObject

-(b2BodyType) bodyType {
  return b2_staticBody;
}

@end
