export ARCHS = armv7 armv7s arm64 arm64e
export TARGET = iphone:clang:latest:8.0

DEBUG 				= 0
GO_EASY_ON_ME 		= 0
BUILD_EXT 			=

ifeq ($(DEBUG), 1)
	BUILDNUMBER 	= -$(VERSION.INC_BUILD_NUMBER)
	FINALPACKAGE 	= 0
else
	BUILDNUMBER 	= 
	FINALPACKAGE 	= 1
endif

PACKAGE_VERSION 	= $(THEOS_PACKAGE_BASE_VERSION)$(BUILDNUMBER)$(BUILD_EXT)

include $(THEOS)/makefiles/common.mk

FLEX_PATH = /Volumes/data/Projects/Git/FLEX/Classes/

DIRTOIM = $(foreach d,$(1),-I$(d))

FLEX_FILES 		= $(shell find $(FLEX_PATH) -name '*.m') $(shell find $(FLEX_PATH) -name '*.mm')
FLEX_DIRS 		= $(shell /bin/ls -d $(FLEX_PATH)*/) $(shell /bin/ls -d $(FLEX_PATH)*/*/)
FLEX_IMPORTS 	= -I$(FLEX_PATH) $(call DIRTOIM, $(FLEX_DIRS))

TWEAK_NAME 							= FLEXer
$(TWEAK_NAME)_FILES 				= $(wildcard source/*.xm) $(FLEX_FILES)
$(TWEAK_NAME)_CFLAGS 				+= -fobjc-arc -w $(FLEX_IMPORTS)
$(TWEAK_NAME)_LIBRARIES 			= sqlite3 z


include $(THEOS_MAKE_PATH)/tweak.mk

before-stage::
	find . -name ".DS_Store" -delete

after-install::
	install.exec "killall -9 SpringBoard"

