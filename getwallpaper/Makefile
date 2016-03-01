include $(THEOS)/makefiles/common.mk

TWEAK_NAME = getWallpaper
getWallpaper_FILES = Springboardhooks.xm
getWallpaper_LIBRARIES = rocketbootstrap

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
