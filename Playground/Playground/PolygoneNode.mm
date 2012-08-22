//
//  PolygoneNode.m
//  Playground
//
//  Created by Александр Сергеев on 8/22/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "PolygoneNode.h"

@implementation PolygoneNode

-(void) draw
{
  glDisable(GL_TEXTURE_2D);
  glDisableClientState(GL_TEXTURE_COORD_ARRAY);
  glDisableClientState(GL_COLOR_ARRAY);
  
  glVertexPointer(_verticles.size(), GL_FLOAT, 0, _verticles.data());
  glDrawArrays(GL_TRIANGLE_FAN, 0, _verticles.size());
  
  glEnableClientState(GL_COLOR_ARRAY);
  glEnableClientState(GL_TEXTURE_COORD_ARRAY);
  glEnable(GL_TEXTURE_2D);

}

-(void) setVerticles:(const Verticles &) vert {
  _verticles = vert;
}

-(const Verticles &) verticles {
  return _verticles;
}

@end
