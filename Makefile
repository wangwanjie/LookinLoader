THEOS_DEVICE_IP = 127.0.0.1
ARCHS = arm64 arm64e
TARGET = iphone:latest:11.0
ADDITIONAL_OBJCFLAGS = -fobjc-arc
include $(THEOS)/makefiles/common.mk

TOOL_NAME = LookinLoader
$(TOOL_NAME)_FILES = Tweak.xm
$(TOOL_NAME)_FRAMEWORKS := UIKit
# $(TOOL_NAME)_PRIVATE_FRAMEWORKS := IOMobileFramebuffer IOSurface
$(TOOL_NAME)_OBJCFLAGS += -Ivncbuild/include -Iinclude
$(TOOL_NAME)_LDFLAGS += -Wl,-segalign,4000 -Lvncbuild/lib -lvncserver -lpng -llzo2 -ljpeg -lssl -lcrypto -lz
$(TOOL_NAME)_CFLAGS = -w -fobjc-arc -Wdeprecated-declarations -Wno-deprecated-declarations
$(TOOL_NAME)_CODESIGN_FLAGS = "-Sen.plist"
$(TOOL_NAME)_INSTALL_PATH = /usr/libexec
# export ARCHS = arm64 arm64e
$(TOOL_NAME)_ARCHS = arm64 arm64e

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
