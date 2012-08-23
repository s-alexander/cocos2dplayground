//
//  ALXLevelScene.m
//  Playground
//
//  Created by Александр Сергеев on 8/23/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "ALXLevelScene.h"
#import "TestObject.h"
#import "LevelGround.h"
#import "NSDictionary_JSONExtensions.h"
#import "PolygoneNode.h"

@implementation ALXLevelScene
-(id) init {
  self = [super init];
  if (self) {
    
    NSData * jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"level1" ofType:@"json"]];
    NSError * error = 0;
    NSDictionary * level = [NSDictionary dictionaryWithJSONData:jsonData error:&error];
    if (0 == error) {
      NSLog(@"%@", level);
    } else {
      NSLog(@"Error: %@", [error localizedDescription]);
    }
                             
    for (int i = 0; i < 10; ++i) {
      TestObject * o = [[[TestObject alloc]init]autorelease];
      [o setPosition:CGPointMake((5+rand()%10), 5+(rand()%10))];
      //      [o setPosition:CGPointMake(10, 10)];
      [self addObject:o];
    }
    
//    Verticles v;
    for (NSDictionary * s in [[level objectForKey:@"static"] objectForKey:@"vertexes"]) {
      LevelGround * lg = [[[LevelGround alloc]initWithDictionary:s]autorelease];
      [self addObject:lg];

    }
  }
  return self;
}

@end
