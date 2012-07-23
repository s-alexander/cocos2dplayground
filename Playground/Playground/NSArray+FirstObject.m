//
//  NSArray+FirstObject.m
//  Talerka
//
//  Created by Alexander on 11/21/11.
//  Copyright (c) 2012 Aleksandr Sergeev. All rights reserved.
//

#import "NSArray+FirstObject.h"

@implementation NSArray (FirstObject)
-(id) firstObject {
    if ([self count] > 0)  {
        return [self objectAtIndex:0];
    }
    return 0;
}
@end
