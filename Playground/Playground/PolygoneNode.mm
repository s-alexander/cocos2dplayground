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
  glEnableClientState(GL_VERTEX_ARRAY);
  
  glColor4f(_color.red(), _color.green(), _color.blue(), _color.alpha());
  glVertexPointer(2, GL_FLOAT, 0, _vertexes.data());
  glDrawArrays(GL_TRIANGLES, 0, _vertexes.size());

  glDisableClientState(GL_VERTEX_ARRAY);
  glEnableClientState(GL_COLOR_ARRAY);
  glEnableClientState(GL_TEXTURE_COORD_ARRAY);
  glEnable(GL_TEXTURE_2D);

}

-(void) setColor:(const Color &) c {
  _color = c;
}

-(void) setVertexes:(const Vertexes &) vert {
  _vertexes = vert;
}

-(const Vertexes &) vertexes {
  return _vertexes;
}

@end
