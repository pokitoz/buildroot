IOCTL_DRIVER_VERSION = 71248c5
IOCTL_DRIVER_SITE = 'https://github.com/pokitoz/ioctl_driver'
IOCTL_DRIVER_SITE_METHOD = git
IOCTL_DRIVER_GIT_SUBMODULES = NO

define IOCTL_DRIVER_BUILD_CMDS
	ARCH=arm64 KDIR=$(BUILD_DIR)/linux-$(BR2_LINUX_KERNEL_VERSION) $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/dev
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/app
endef # IOCTL_DRIVER_BUILD_CMDS

define IOCTL_DRIVER_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0755 $(@D)/dev/ioctl.ko $(TARGET_DIR)/bin
	$(INSTALL) -m 0755 $(@D)/ioctl-module-start-stop $(TARGET_DIR)/etc/init.d/S99ioctl-module-start-stop
	$(INSTALL) -m 0755 $(@D)/load_module.sh $(TARGET_DIR)/bin
	$(INSTALL) -m 0755 $(@D)/app/ioctl_app $(TARGET_DIR)/bin
endef # IOCTL_DRIVER_INSTALL_TARGET_CMDS

$(eval $(generic-package))
