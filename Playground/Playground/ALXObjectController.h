//
//  ALXObjectController.h
//  Playground
//
//  Created by Александр Сергеев on 9/4/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ALXObject;
@protocol ALXObjectController <NSObject>
@property (nonatomic, retain) ALXObject * puppet;
+(id<ALXObjectController>) getController;
-(void) step;
@end
