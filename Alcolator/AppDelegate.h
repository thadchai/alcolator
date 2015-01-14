//
//  AppDelegate.h
//  Alcolator
//
//  Created by Work on 1/7/15.
//  Copyright (c) 2015 Thadchai Sattayatam. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UITabBarControllerDelegate <NSObject>

@optional

@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

