//
// Created by Dana Buehre on Wed Apr 24 2019
// Copyright © 2019 CreatureSurvive (CreatureCoding). All rights reserved.
//

#import "FLEXer.h"

// ===================== FLEXManager ==================== //
// ===== add toggle gesture support to trigger once ===== //
// ====================================================== //

%hook FLEXManager

%new - (void)__flexer_toggleExplorer:(UIGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self toggleExplorer];
    }
}

%end

// ===================== FLEXWindow ===================== //
// === let FLEX to open on the lockscreen while locked == //
// ====================================================== //

%hook FLEXWindow

- (BOOL)_shouldCreateContextAsSecure {
    return YES;
}

%end

// ================== UIStatusBarWindow ================= //
// ====== use the topmost window for the recognizer ===== //
// ====================================================== //

%hook UIStatusBarWindow

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ((self = %orig)) {

        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:FLEXManager.sharedManager action:@selector(__flexer_toggleExplorer:)]];
    }

    return self;
}

%end
