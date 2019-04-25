export ARCHS = arm64
export TARGET = iphone:clang:latest:latest

DEBUG 				= 1
GO_EASY_ON_ME 		= 0
BUILD_EXT 			= b

ifeq ($(DEBUG), 1)
	BUILDNUMBER 	= -$(VERSION.INC_BUILD_NUMBER)
	FINALPACKAGE 	= 0
else
	BUILDNUMBER 	= 
	FINALPACKAGE 	= 1
endif

PACKAGE_VERSION 	= $(THEOS_PACKAGE_BASE_VERSION)$(BUILDNUMBER)$(BUILD_EXT)

include $(THEOS)/makefiles/common.mk

TWEAK_NAME 							= FLEXer
$(TWEAK_NAME)_FILES 				= $(wildcard source/*.xm)
$(TWEAK_NAME)_CFLAGS 				+= -fobjc-arc
$(TWEAK_NAME)_EXTRA_FRAMEWORKS 		= FLEX

include $(THEOS_MAKE_PATH)/tweak.mk

before-stage::
	find . -name ".DS_Store" -delete

after-install::
	install.exec "killall -9 SpringBoard"

