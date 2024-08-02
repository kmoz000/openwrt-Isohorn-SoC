#
# Copyright (C) 2024 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=ath12k-firmware
PKG_SOURCE_DATE:=2024-08-01
PKG_SOURCE_VERSION:=6ed267e22501be2cdd63ea564d407fb64eb879dd
PKG_MIRROR_HASH:=skip
PKG_RELEASE:=1

PKG_SOURCE_PROTO:=git
PKG_SOURCE_URL:=https://github.com/quic/upstream-wifi-fw.git

PKG_LICENSE_FILES:=LICENSE.md

PKG_MAINTAINER:=Your Name <your.email@example.com>

include $(INCLUDE_DIR)/package.mk

RSTRIP:=:
STRIP:=:

define Package/ath12k-firmware-default
  SECTION:=firmware
  CATEGORY:=Firmware
  URL:=$(PKG_SOURCE_URL)
  DEPENDS:=
endef

define Package/ath12k-firmware-ipq5322
$(Package/ath12k-firmware-default)
  TITLE:=IPQ5322 ath12k firmware
endef

define Package/ath12k-firmware-ipq5322_qcn6432
$(Package/ath12k-firmware-default)
  TITLE:=IPQ5322_QCN6432 ath12k firmware
endef

define Package/ath12k-firmware-ipq5322_qcn6432_qcn6432
$(Package/ath12k-firmware-default)
  TITLE:=IPQ5322_QCN6432_QCN6432 ath12k firmware
endef

define Package/ath12k-firmware-qcn9274
$(Package/ath12k-firmware-default)
  TITLE:=QCN9274 ath12k firmware
endef

define Build/Compile

endef

QCN9274_BOARD_REV:=latest
QCN9274_BOARD_FILE:=board-2.bin.$(QCN9274_BOARD_REV)

define Download/qcn9274-board
  URL:=https://github.com/quic/upstream-wifi-fw/raw/main/ath12k-firmware/QCN9274/hw2.0_split_phy/
  URL_FILE:=board-2.bin
  FILE:=$(QCN9274_BOARD_FILE)
  HASH:=skip
endef
$(eval $(call Download,qcn9274-board))

define Package/ath12k-firmware-ipq5322/install
	$(INSTALL_DIR) $(1)/lib/firmware/IPQ5322
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/ath12k-firmware/IPQ5322/hw1.0/* \
		$(1)/lib/firmware/IPQ5322/
endef

define Package/ath12k-firmware-ipq5322_qcn6432/install
	$(INSTALL_DIR) $(1)/lib/firmware/IPQ5322_QCN6432
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/ath12k-firmware/IPQ5322_QCN6432/hw1.0/* \
		$(1)/lib/firmware/IPQ5322_QCN6432/
endef

define Package/ath12k-firmware-ipq5322_qcn6432_qcn6432/install
	$(INSTALL_DIR) $(1)/lib/firmware/IPQ5322_QCN6432_QCN6432
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/ath12k-firmware/IPQ5322_QCN6432_QCN6432/hw1.0/* \
		$(1)/lib/firmware/IPQ5322_QCN6432_QCN6432/
endef

define Package/ath12k-firmware-qcn9274/install
	$(INSTALL_DIR) $(1)/lib/firmware/ath12k/QCN9274/hw2.0_split_phy
	$(INSTALL_DATA) \
		$(PKG_BUILD_DIR)/ath12k-firmware/QCN9274/hw2.0_split_phy/* \
		$(1)/lib/firmware/ath12k/QCN9274/hw2.0_split_phy/
	$(INSTALL_BIN) \
		$(DL_DIR)/$(QCN9274_BOARD_FILE) $(1)/lib/firmware/ath12k/QCN9274/hw2.0_split_phy/board-2.bin
endef

$(eval $(call BuildPackage,ath12k-firmware-ipq5322))
$(eval $(call BuildPackage,ath12k-firmware-ipq5322_qcn6432))
$(eval $(call BuildPackage,ath12k-firmware-ipq5322_qcn6432_qcn6432))
$(eval $(call BuildPackage,ath12k-firmware-qcn9274))
