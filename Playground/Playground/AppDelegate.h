//
//  AppDelegate.h
//  Playground
//
//  Created by Александр Сергеев on 7/23/12.
//  Copyright СУП Фабрик 2012. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
