PKG_DRIVERS += \
	rtlwifi rtlwifi-pci rtlwifi-btcoexist rtlwifi-usb rtl8192c-common \
	rtl8192ce rtl8192se rtl8192de rtl8192cu rtl8723-common rtl8723be rtl8723bs rtl8821ae \
	rtl8xxxu rtw88 rtw88-pci rtw88-usb rtw88-sdio rtw88-8821c rtw88-8822b rtw88-8822c \
	rtw88-8723d rtw88-8821ce rtw88-8821cu rtw88-8822be rtw88-8822bu \
	rtw88-8822ce rtw88-8822cu rtw88-8723de rtw88-8723ds rtw88-8723du

config-$(call config_package,rtlwifi) += RTL_CARDS RTLWIFI
config-$(call config_package,rtlwifi-pci) += RTLWIFI_PCI
config-$(call config_package,rtlwifi-btcoexist) += RTLBTCOEXIST
config-$(call config_package,rtlwifi-usb) += RTLWIFI_USB
config-$(call config_package,rtl8192c-common) += RTL8192C_COMMON
config-$(call config_package,rtl8192ce) += RTL8192CE
config-$(call config_package,rtl8192se) += RTL8192SE
config-$(call config_package,rtl8192de) += RTL8192DE
config-$(call config_package,rtl8192cu) += RTL8192CU
config-$(call config_package,rtl8821ae) += RTL8821AE
config-$(CONFIG_PACKAGE_RTLWIFI_DEBUG) += RTLWIFI_DEBUG

config-$(call config_package,rtl8xxxu) += RTL8XXXU
config-y += RTL8XXXU_UNTESTED

config-$(call config_package,rtl8723-common) += RTL8723_COMMON
config-$(call config_package,rtl8723be) += RTL8723BE

config-$(call config_package,rtl8723bs) += RTL8723BS
config-y += STAGING

config-$(call config_package,rtw88) += RTW88 RTW88_CORE
config-$(call config_package,rtw88-pci) += RTW88_PCI
config-$(call config_package,rtw88-usb) += RTW88_USB
config-$(call config_package,rtw88-sdio) += RTW88_SDIO
config-$(call config_package,rtw88-8821c) += RTW88_8821C
config-$(call config_package,rtw88-8821ce) += RTW88_8821CE
config-$(call config_package,rtw88-8821cu) += RTW88_8821CU
config-$(call config_package,rtw88-8822b) += RTW88_8822B
config-$(call config_package,rtw88-8822be) += RTW88_8822BE
config-$(call config_package,rtw88-8822bu) += RTW88_8822BU
config-$(call config_package,rtw88-8822c) += RTW88_8822C
config-$(call config_package,rtw88-8822ce) += RTW88_8822CE
config-$(call config_package,rtw88-8822cu) += RTW88_8822CU
config-$(call config_package,rtw88-8723d) += RTW88_8723D
config-$(call config_package,rtw88-8723de) += RTW88_8723DE
config-$(call config_package,rtw88-8723ds) += RTW88_8723DS
config-$(call config_package,rtw88-8723du) += RTW88_8723DU
config-$(CONFIG_PACKAGE_RTW88_DEBUG) += RTW88_DEBUG
config-$(CONFIG_PACKAGE_RTW88_DEBUGFS) += RTW88_DEBUGFS

define KernelPackage/rtlwifi/config
	config PACKAGE_RTLWIFI_DEBUG
		bool "Realtek wireless debugging"
		depends on PACKAGE_kmod-rtlwifi
		help
		  Say Y, if you want to debug realtek wireless drivers.

endef

define KernelPackage/rtlwifi
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek common driver part
  DEPENDS+= @(PCI_SUPPORT||USB_SUPPORT) +kmod-mac80211
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtlwifi/rtlwifi.ko
  HIDDEN:=1
endef

define KernelPackage/rtlwifi-pci
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek common driver part (PCI support)
  DEPENDS+= @PCI_SUPPORT +kmod-rtlwifi
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtlwifi/rtl_pci.ko
  AUTOLOAD:=$(call AutoProbe,rtl_pci)
  HIDDEN:=1
endef

define KernelPackage/rtlwifi-btcoexist
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek BT coexist support
  DEPENDS+= +kmod-rtlwifi
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtlwifi/btcoexist/btcoexist.ko
  AUTOLOAD:=$(call AutoProbe,btcoexist)
  HIDDEN:=1
endef

define KernelPackage/rtlwifi-usb
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek common driver part (USB support)
  DEPENDS+= @USB_SUPPORT +kmod-usb-core +kmod-rtlwifi
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtlwifi/rtl_usb.ko
  AUTOLOAD:=$(call AutoProbe,rtl_usb)
  HIDDEN:=1
endef

define KernelPackage/rtl8192c-common
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8192CE/RTL8192CU common support module
  DEPENDS+= +kmod-rtlwifi
  FILES:= $(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtlwifi/rtl8192c/rtl8192c-common.ko
  HIDDEN:=1
endef

define KernelPackage/rtl8192ce
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8192CE/RTL8188CE support
  DEPENDS+= +kmod-rtlwifi-pci +kmod-rtl8192c-common +rtl8192ce-firmware
  FILES:= $(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtlwifi/rtl8192ce/rtl8192ce.ko
  AUTOLOAD:=$(call AutoProbe,rtl8192ce)
endef

define KernelPackage/rtl8192se
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8192SE/RTL8191SE support
  DEPENDS+= +kmod-rtlwifi-pci +rtl8192se-firmware
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtlwifi/rtl8192se/rtl8192se.ko
  AUTOLOAD:=$(call AutoProbe,rtl8192se)
endef

define KernelPackage/rtl8192de
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8192DE/RTL8188DE support
  DEPENDS+= +kmod-rtlwifi-pci +rtl8192de-firmware
  FILES:= $(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtlwifi/rtl8192de/rtl8192de.ko
  AUTOLOAD:=$(call AutoProbe,rtl8192de)
endef

define KernelPackage/rtl8192cu
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8192CU/RTL8188CU support
  DEPENDS+= +kmod-rtlwifi-usb +kmod-rtl8192c-common +rtl8192cu-firmware
  FILES:= $(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtlwifi/rtl8192cu/rtl8192cu.ko
  AUTOLOAD:=$(call AutoProbe,rtl8192cu)
endef

define KernelPackage/rtl8821ae
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8821AE support
  DEPENDS+= +kmod-rtlwifi-btcoexist +kmod-rtlwifi-pci +rtl8821ae-firmware
  FILES:= $(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtlwifi/rtl8821ae/rtl8821ae.ko
  AUTOLOAD:=$(call AutoProbe,rtl8821ae)
endef

define KernelPackage/rtl8xxxu
  $(call KernelPackage/mac80211/Default)
  TITLE:=alternative Realtek RTL8XXXU support
  DEPENDS+= @USB_SUPPORT +kmod-usb-core +kmod-mac80211
  FILES:= $(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.ko
  AUTOLOAD:=$(call AutoProbe,rtl8xxxu)
endef

define KernelPackage/rtl8xxxu/description
  This is an alternative driver for various Realtek RTL8XXX
  parts written to utilize the Linux mac80211 stack.
  The driver is known to work with a number of RTL8723AU,
  RL8188CU, RTL8188RU, RTL8191CU, and RTL8192CU devices

  This driver is under development and has a limited feature
  set. In particular it does not yet support 40MHz channels
  and power management. However it should have a smaller
  memory footprint than the vendor drivers and benetifs
  from the in kernel mac80211 stack.

  It can coexist with drivers from drivers/staging/rtl8723au,
  drivers/staging/rtl8192u, and drivers/net/wireless/rtlwifi,
  but you will need to control which module you wish to load.

  RTL8XXXU_UNTESTED is enabled
  This option enables detection of Realtek 8723/8188/8191/8192 WiFi
  USB devices which have not been tested directly by the driver
  author or reported to be working by third parties.

  Please report your results!
endef

define KernelPackage/rtw88/config
	config PACKAGE_RTW88_DEBUG
		bool "Realtek wireless debugging (rtw88)"
		depends on PACKAGE_kmod-rtw88
		help
		  Enable debugging output for rtw88 devices

	config PACKAGE_RTW88_DEBUGFS
		bool "Enable rtw88 debugfS support"
		select KERNEL_DEBUG_FS
		depends on PACKAGE_kmod-rtw88
		help
		  Select this to see extensive information about
		  the internal state of rtw88 in debugfs.
endef

define KernelPackage/rtw88
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTW88 common part
  DEPENDS+= +kmod-mac80211
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_core.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_core)
  HIDDEN:=1
endef

define KernelPackage/rtw88-pci
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTW88 PCI chips support
  DEPENDS+= @PCI_SUPPORT +kmod-rtw88
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_pci.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_pci)
  HIDDEN:=1
endef

define KernelPackage/rtw88-sdio
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTW88 SDIO chips support
  DEPENDS+= +kmod-mmc +kmod-rtw88
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_sdio.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_sdio)
  HIDDEN:=1
endef

define KernelPackage/rtw88-usb
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTW88 USB chips support
  DEPENDS+= @USB_SUPPORT +kmod-rtw88 +kmod-usb-core
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_usb.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_usb)
  HIDDEN:=1
endef

define KernelPackage/rtw88-8821c
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8821C family support
  DEPENDS+= +kmod-rtw88 +rtl8821ce-firmware +@DRIVER_11AC_SUPPORT
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_8821c.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_8821c)
  HIDDEN:=1
endef

define KernelPackage/rtw88-8822b
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8822B family support
  DEPENDS+= +kmod-rtw88 +rtl8822be-firmware +@DRIVER_11AC_SUPPORT
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_8822b.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_8822b)
  HIDDEN:=1
endef

define KernelPackage/rtw88-8822c
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8822C family support
  DEPENDS+= +kmod-rtw88 +rtl8822ce-firmware +@DRIVER_11AC_SUPPORT
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_8822c.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_8822c)
  HIDDEN:=1
endef

define KernelPackage/rtw88-8723d
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8723D family support
  DEPENDS+= +kmod-rtw88 +rtl8723de-firmware
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_8723d.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_8723d)
  HIDDEN:=1
endef

define KernelPackage/rtw88-8821ce
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8821CE support
  DEPENDS+= +kmod-rtw88-pci +kmod-rtw88-8821c
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_8821ce.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_8821ce)
endef

define KernelPackage/rtw88-8821cu
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8821CU support
  DEPENDS+= +kmod-rtw88-usb +kmod-rtw88-8821c
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_8821cu.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_8821cu)
endef

define KernelPackage/rtw88-8822be
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8822BE support
  DEPENDS+= +kmod-rtw88-pci +kmod-rtw88-8822b
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_8822be.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_8822be)
endef

define KernelPackage/rtw88-8822bu
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8822BU support
  DEPENDS+= +kmod-rtw88-usb +kmod-rtw88-8822b
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_8822bu.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_8822bu)
endef

define KernelPackage/rtw88-8822ce
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8822CE support
  DEPENDS+= +kmod-rtw88-pci +kmod-rtw88-8822c
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_8822ce.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_8822ce)
endef

define KernelPackage/rtw88-8822cu
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8822CU support
  DEPENDS+= +kmod-rtw88-usb +kmod-rtw88-8822c
  FILES:=$(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_8822cu.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_8822cu)
endef

define KernelPackage/rtw88-8723de
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8723DE support
  DEPENDS+= +kmod-rtw88-pci +kmod-rtw88-8723d
  FILES:= $(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_8723de.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_8723de)
endef

define KernelPackage/rtw88-8723ds
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8723DS support
  DEPENDS+= +kmod-rtw88-sdio +kmod-rtw88-8723d
  FILES:= $(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_8723ds.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_8723ds)
endef

define KernelPackage/rtw88-8723du
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8723DU support
  DEPENDS+= +kmod-rtw88-usb +kmod-rtw88-8723d
  FILES:= $(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtw88/rtw88_8723du.ko
  AUTOLOAD:=$(call AutoProbe,rtw88_8723du)
endef

define KernelPackage/rtl8723-common
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8723AE/RTL8723BE common support module
  DEPENDS+= +kmod-rtlwifi
  FILES:= $(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtlwifi/rtl8723com/rtl8723-common.ko
  HIDDEN:=1
endef

define KernelPackage/rtl8723be
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8723AE/RTL8723BE support
  DEPENDS+= +kmod-rtlwifi-btcoexist +kmod-rtlwifi-pci +kmod-rtl8723-common +rtl8723be-firmware
  FILES:= $(PKG_BUILD_DIR)/drivers/net/wireless/realtek/rtlwifi/rtl8723be/rtl8723be.ko
  AUTOLOAD:=$(call AutoProbe,rtl8723be)
endef

define KernelPackage/rtl8723bs
  $(call KernelPackage/mac80211/Default)
  TITLE:=Realtek RTL8723BS SDIO Wireless LAN NIC driver (staging)
  DEPENDS+=+kmod-mmc +kmod-mac80211
  FILES:=$(PKG_BUILD_DIR)/drivers/staging/rtl8723bs/r8723bs.ko
  AUTOLOAD:=$(call AutoProbe,r8723bs)
endef

define KernelPackage/rtl8723bs/description
 This option enables support for RTL8723BS SDIO drivers, such as the wifi found
 on the 1st gen Intel Compute Stick, the CHIP and many other Intel Atom and ARM
 based devices.
endef