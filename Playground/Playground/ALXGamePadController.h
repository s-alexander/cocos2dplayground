//
//  ALXGamePadController.h
//  Playground
//
//  Created by Александр Сергеев on 9/4/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALXObjectController.h"
#import "ALXObject.h"

@interface ALXGamePadController : NSObject <ALXObjectController>

@property (nonatomic, assign) CGPoint pos;
+(ALXGamePadController *) sharedController;

-(void) setPosition:(CGPoint)position;

@end
