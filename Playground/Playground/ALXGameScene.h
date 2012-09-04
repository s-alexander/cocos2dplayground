//
//  ALXGameScene.h
//  Playground
//
//  Created by Александр Сергеев on 7/23/12.
//  Copyright (c) 2012 СУП Фабрик. All rights reserved.
//

#import "ALXPhysicScene.h"
#import "cocos2d.h"

@interface ALXGameScene : ALXPhysicScene <CCTargetedTouchDelegate> {
  
}

@property (nonatomic, retain) CCNode* gamepadPointer;



@end
