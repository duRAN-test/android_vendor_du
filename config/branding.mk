# Versioning System
DU_BASE_VERSION = v13.0

ifndef DU_BUILD_TYPE
    DU_BUILD_TYPE := duRAN
endif

TARGET_PRODUCT_SHORT := $(subst du_,,$(DU_BUILD_TYPE))

# Only include DU-Updater for official, weeklies, and rc builds
ifeq ($(filter-out OFFICIAL WEEKLIES RC,$(DU_BUILD_TYPE)),)
    PRODUCT_PACKAGES += \
        DU-Updater
endif

# Sign builds if building an official or weekly build
ifeq ($(filter-out OFFICIAL WEEKLIES,$(DU_BUILD_TYPE)),)
    PRODUCT_DEFAULT_DEV_CERTIFICATE := ../.keys/releasekey
endif

# Set all versions
DATE := $(shell date -u +%Y%m%d)
DU_VERSION := $(TARGET_PRODUCT)-$(DU_BASE_VERSION)-$(DATE)-$(shell date -u +%H%M)-$(DU_BUILD_TYPE)
TARGET_BACON_NAME := $(DU_VERSION)
ROM_FINGERPRINT := DirtyUnicorns/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(shell date -u +%H%M)

PRODUCT_PROPERTY_OVERRIDES += \
    BUILD_DISPLAY_ID=$(BUILD_ID) \
    ro.du.version=$(DU_VERSION) \
    ro.mod.version=$(DU_BUILD_TYPE)-$(DU_BASE_VERSION)-$(DATE) \
    ro.du.fingerprint=$(ROM_FINGERPRINT)
