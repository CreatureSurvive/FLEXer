//
// Created by Dana Buehre on Wed Apr 24 2019
// Copyright © 2019 CreatureSurvive (CreatureCoding). All rights reserved.
//

@interface FLEXManager : NSObject
+ (instancetype)sharedManager;
- (void)toggleExplorer;
@end

@interface FLEXWindow : UIWindow 
@end

@interface UIStatusBarWindow : UIWindow 
@end