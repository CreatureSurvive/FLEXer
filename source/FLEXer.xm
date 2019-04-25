//
// Created by Dana Buehre on Wed Apr 24 2019
// Copyright © 2019 CreatureSurvive (CreatureCoding). All rights reserved.
//

#import "FLEXer.h"

// ===================== FLEXManager ==================== //

%hook FLEXManager

%new - (void)__flexer_toggleExplorer:(UIGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self toggleExplorer];
    }
}

%end

// ===================== FLEXWindow ===================== //

%hook FLEXWindow

- (BOOL)_shouldCreateContextAsSecure {
    return YES;
}

%end

// ================== UIStatusBarWindow ================= //

%hook UIStatusBarWindow

- (instancetype)initWithFrame:(CGRect)frame {
    
    if ((self = %orig)) {

        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:FLEXManager.sharedManager action:@selector(__flexer_toggleExplorer:)]];
    }

    return self;
}

%end
