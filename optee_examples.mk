OPTEE_EXAMPLES_VERSION = 1.0
OPTEE_EXAMPLES_SOURCE = local
OPTEE_EXAMPLES_SITE = $(BR2_PACKAGE_OPTEE_EXAMPLES_SITE)
OPTEE_EXAMPLES_SITE_METHOD = local
OPTEE_EXAMPLES_INSTALL_STAGING = YES
OPTEE_EXAMPLES_DEPENDENCIES = optee_client host-python-pycrypto
OPTEE_EXAMPLES_SDK = $(BR2_PACKAGE_OPTEE_EXAMPLES_SDK)
OPTEE_EXAMPLES_CONF_OPTS = -DOPTEE_EXAMPLES_SDK=$(OPTEE_EXAMPLES_SDK)

define OPTEE_EXAMPLES_BUILD_TAS
	@(set -e; for f in $(@D)/*/ta/Makefile; \
	do \
	  echo Building $$f && \
			$(MAKE) CROSS_COMPILE="$(shell echo $(BR2_PACKAGE_OPTEE_EXAMPLES_CROSS_COMPILE))" \
			O=out TA_DEV_KIT_DIR=$(OPTEE_EXAMPLES_SDK) \
			$(TARGET_CONFIGURE_OPTS) -C $${f%/*} all; \
	done)
endef

# FL: add chmod below
define OPTEE_EXAMPLES_INSTALL_TAS
	@$(foreach f,$(wildcard $(@D)/*/ta/out/*.ta), \
		mkdir -p $(TARGET_DIR)/lib/optee_armtz && \
		chmod 755 $(TARGET_DIR)/lib/optee_armtz && \
		$(INSTALL) -v -p  --mode=444 \
			--target-directory=$(TARGET_DIR)/lib/optee_armtz $f \
			&&) true
endef

OPTEE_EXAMPLES_POST_BUILD_HOOKS += OPTEE_EXAMPLES_BUILD_TAS
OPTEE_EXAMPLES_POST_INSTALL_TARGET_HOOKS += OPTEE_EXAMPLES_INSTALL_TAS

$(eval $(cmake-package))
