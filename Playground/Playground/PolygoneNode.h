//
//  PolygoneNode.h
//  Playground
//
//  Created by Александр Сергеев on 8/22/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "CCNode.h"
#import <vector>

typedef std::vector<GLfloat> Verticles;

@interface PolygoneNode : CCNode {
  Verticles _verticles;
}

-(const Verticles &) verticles;
-(void) setVerticles:(const Verticles &) vert;

@end
