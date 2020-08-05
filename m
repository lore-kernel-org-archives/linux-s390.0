Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726869AbgHEQce (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 5 Aug 2020 12:32:34 -0400
From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] s390/Kconfig: add missing ZCRYPT dependency to VFIO_AP
Date: Wed,  5 Aug 2020 17:50:53 +0200
Message-Id: <20200805155053.3739-1-krzk@kernel.org>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Joerg Roedel <jroedel@suse.de>, Krzysztof Kozlowski <krzk@kernel.org>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

The VFIO_AP uses ap_driver_register() (and deregister) functions
implemented in ap_bus.c (compiled into ap.o).  However the ap.o will be
built only if CONFIG_ZCRYPT is selected.

This was not visible before commit e93a1695d7fb ("iommu: Enable compile
testing for some of drivers") because the CONFIG_VFIO_AP depends on
CONFIG_S390_AP_IOMMU which depends on the missing CONFIG_ZCRYPT.  After
adding COMPILE_TEST, it is possible to select a configuration with
VFIO_AP and S390_AP_IOMMU but without the ZCRYPT.

Add proper dependency to the VFIO_AP to fix build errors:

ERROR: modpost: "ap_driver_register" [drivers/s390/crypto/vfio_ap.ko] undefined!
ERROR: modpost: "ap_driver_unregister" [drivers/s390/crypto/vfio_ap.ko] undefined!

Reported-by: kernel test robot <lkp@intel.com>
Fixes: e93a1695d7fb ("iommu: Enable compile testing for some of drivers")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/s390/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8c0b52940165..2a31a5e74e42 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -766,6 +766,7 @@ config VFIO_AP
 	def_tristate n
 	prompt "VFIO support for AP devices"
 	depends on S390_AP_IOMMU && VFIO_MDEV_DEVICE && KVM
+	depends on ZCRYPT
 	help
 		This driver grants access to Adjunct Processor (AP) devices
 		via the VFIO mediated device interface.
-- 
2.17.1
