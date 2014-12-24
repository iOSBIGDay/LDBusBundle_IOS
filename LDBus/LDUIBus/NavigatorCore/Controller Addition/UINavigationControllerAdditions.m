//
//  Created by 庞辉 on 12/5/14.
//  Copyright (c) 2014 庞辉. All rights reserved.
//


#import "UINavigationControllerAdditions.h"
// Core
#import "TTCorePreprocessorMacros.h"
// UI
#import "TTBaseNavigationController.h"
// UICommon
#import "UIViewControllerAdditions.h"



///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Additions.
 */
TT_FIX_CATEGORY_BUG(UINavigationControllerAdditions)

@implementation UINavigationController (TTCategory)


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIView*)rotatingHeaderView {
  UIViewController* popup = [self popupViewController];
  if (popup) {
    return [popup rotatingHeaderView];

  } else {
    return [super rotatingHeaderView];
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIViewController (TTCategory)


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)canContainControllers {
  return YES;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIViewController*)topSubcontroller {
  return self.topViewController;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)addSubcontroller:(UIViewController*)controller animated:(BOOL)animated
        transition:(UIViewAnimationTransition)transition {
  if (animated && transition) {
    if ([self isKindOfClass:[TTBaseNavigationController class]]) {
      [(TTBaseNavigationController*)self pushViewController: controller
                                 animatedWithTransition: transition];

    } else {
      [self pushViewController:controller animated:YES];
    }

  } else {
    [self pushViewController:controller animated:animated];
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)bringControllerToFront:(UIViewController*)controller animated:(BOOL)animated {
  if ([self.viewControllers indexOfObject:controller] != NSNotFound
      && controller != self.topViewController) {
    [self popToViewController:controller animated:animated];
  }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)keyForSubcontroller:(UIViewController*)controller {
    NSInteger controllerIndex = [self.viewControllers indexOfObject:controller];
    if (controllerIndex != NSNotFound) {
        return [NSNumber numberWithInteger:controllerIndex].stringValue;
    } else {
        return nil;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIViewController*)subcontrollerForKey:(NSString*)key {
  NSInteger controllerIndex = key.intValue;
  if (controllerIndex < self.viewControllers.count) {
    return [self.viewControllers objectAtIndex:controllerIndex];

  } else {
    return nil;
  }
}

@end