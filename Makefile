export TARGET = iphone:clang:latest:8.0

DEBUG 				= 0
GO_EASY_ON_ME 		= 0

ifeq ($(DEBUG), 1)
	export ARCHS 	= arm64
	BUILDNUMBER 	= -$(VERSION.INC_BUILD_NUMBER)
	FINALPACKAGE 	= 0
	BUILD_EXT 		= d
else
	export ARCHS 	= armv7 armv7s arm64 arm64e
	BUILDNUMBER 	= 
	FINALPACKAGE 	= 1
	BUILD_EXT 		=
endif

PACKAGE_VERSION 	= $(THEOS_PACKAGE_BASE_VERSION)$(BUILDNUMBER)$(BUILD_EXT)

include $(THEOS)/makefiles/common.mk

FLEX_PATH = /Volumes/data/Projects/Git/FLEX/Classes/

DIRTOIM = $(foreach d,$(1),-I$(d))

FLEX_FILES 		= $(shell find $(FLEX_PATH) -name '*.m') $(shell find $(FLEX_PATH) -name '*.mm')
FLEX_DIRS 		= $(shell /bin/ls -d $(FLEX_PATH)*/) $(shell /bin/ls -d $(FLEX_PATH)*/*/)
FLEX_IMPORTS 	= -I$(FLEX_PATH) $(call DIRTOIM, $(FLEX_DIRS))

PROJECT_NAME 				= FLEXer
TWEAK_NAME 					= $(PROJECT_NAME)
$(PROJECT_NAME)_FILES 		= $(wildcard source/*.x) $(FLEX_FILES)
$(PROJECT_NAME)_CFLAGS 		+= -fobjc-arc -w $(FLEX_IMPORTS)
$(PROJECT_NAME)_LIBRARIES 	= sqlite3 z


include $(THEOS_MAKE_PATH)/tweak.mk

before-stage::
	find . -name ".DS_Store" -delete

after-install::
	install.exec "killall -9 SpringBoard"

