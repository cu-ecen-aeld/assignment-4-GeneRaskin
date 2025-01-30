
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

AESD_ASSIGNMENTS_VERSION = '96515cb82018fb6e47d5fb949ff2be40b6e3a67a'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_ASSIGNMENTS_SITE = 'git@github.com:/cu-ecen-aeld/assignments-3-and-later-GeneRaskin.git'
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES
# AESD_ASSIGNMENTS_OVERRIDE_SRCDIR=/home/eugeneraskin/embedded_course/assignment-2-GeneRaskin

define AESD_ASSIGNMENTS_BUILD_CMDS
	# $(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(AESD_ASSIGNMENTS_OVERRIDE_SRCDIR)/finder-app
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app
endef

define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -d 0755 $(@D)/conf/ $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/etc/finder-app/
	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/etc/finder-app/
	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin/
	$(SED) 's/\#PermitRootLogin prohibit-password/PermitRootLogin yes/' $(TARGET_DIR)/etc/ssh/sshd_config
    $(SED) 's/\#PasswordAuthentication yes/PasswordAuthentication yes/' $(TARGET_DIR)/etc/ssh/sshd_config
endef

$(eval $(generic-package))
