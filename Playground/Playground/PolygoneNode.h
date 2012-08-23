//
//  PolygoneNode.h
//  Playground
//
//  Created by Александр Сергеев on 8/22/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "CCNode.h"
#import <vector>

typedef std::vector<GLfloat> Vertexes;

class Color {
private:
  GLfloat colorFromString(NSNumber * f) {
    return [f floatValue];
  }
public:
  Color() {;;}
  Color(NSDictionary * d) {
    _color[0] = colorFromString([d objectForKey:@"r"]);
    _color[1] = colorFromString([d objectForKey:@"g"]);
    _color[2] = colorFromString([d objectForKey:@"b"]);
    _color[3] = colorFromString([d objectForKey:@"a"]);
  }
  Color(GLfloat r, GLfloat g, GLfloat b, GLfloat a) {
     _color[0] = r; _color[1] = g; _color[2] = b; _color[3] = a;
    ;;
  }
  ~Color() throw() { ;; }
  GLfloat red() const { return _color[0]; }
  GLfloat green() const { return _color[1]; }
  GLfloat blue() const { return _color[2]; }
  GLfloat alpha() const { return _color[3]; }
private:
  GLfloat _color[4];
};

@interface PolygoneNode : CCNode {
  Vertexes _vertexes;
  Color _color;
}

-(void) setColor:(const Color &) c;

-(const Vertexes &) vertexes;
-(void) setVertexes:(const Vertexes &) vert;

@end
