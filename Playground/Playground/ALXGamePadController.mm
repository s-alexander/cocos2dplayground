//
//  ALXGamePadController.m
//  Playground
//
//  Created by Александр Сергеев on 9/4/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "ALXGamePadController.h"
#import "ALXObject.h"

@implementation ALXGamePadController
@synthesize puppet;
@synthesize pos;
+(ALXGamePadController *) sharedController {
  static ALXGamePadController * sharedController = [[ALXGamePadController alloc]init];
  return sharedController;
}

+(id<ALXObjectController>) getController {
  return [self sharedController];
}

-(void) setPosition:(CGPoint)p {
  [self setPos:p];
}

-(void) step {
  if (b2Body * body = [puppet body]) {
    body->ApplyForce(b2Vec2(pos.x, pos.y), body->GetWorldCenter());
  }
  
}

@end
