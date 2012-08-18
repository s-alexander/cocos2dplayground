//
//  ALXGameScene.m
//  Playground
//
//  Created by Александр Сергеев on 7/23/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "ALXGameScene.h"

#import "ALXObject.h"

@implementation ALXGameScene
-(id) init {
  self = [super init];
  if (self) {
//    ALXObject * o = [[[ALXObject alloc]init]autorelease];
    for (int i = 0; i < 10; ++i) {
      ALXObject * o = [[ALXObject alloc]init];
      [o setPosition:CGPointMake((5+rand()%10), 5+(rand()%10))];
//      [o setPosition:CGPointMake(10, 10)];
      [self addObject:o];
    }
  }
  return self;
}



@end
