//
//  ALXDynamicObject.mm
//  Playground
//
//  Created by Александр Сергеев on 8/22/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "ALXDynamicObject.h"

@implementation ALXDynamicObject

-(b2BodyType) bodyType {
  return b2_dynamicBody;
}

@end
