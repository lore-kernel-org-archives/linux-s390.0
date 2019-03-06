Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: [PATCH] s390: Kconfig: pedantic cleanups
Date: Wed,  6 Mar 2019 21:32:01 +0100
Message-Id: <1551904321-23099-1-git-send-email-info@metux.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Formatting of Kconfig files doesn't look so pretty, so just
take damp cloth and clean it up.

Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
---
 arch/s390/Kconfig          |  2 +-
 drivers/s390/block/Kconfig |  2 +-
 drivers/s390/char/Kconfig  | 15 +++++++--------
 drivers/s390/net/Kconfig   |  8 ++++----
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index b6e3d06..8e7d632 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -723,7 +723,7 @@ config PCI_NR_FUNCTIONS
 	  This allows you to specify the maximum number of PCI functions which
 	  this kernel will support.
 
-endif	# PCI
+endif # PCI
 
 config HAS_IOMEM
 	def_bool PCI
diff --git a/drivers/s390/block/Kconfig b/drivers/s390/block/Kconfig
index 9ac7574..a8682f6 100644
--- a/drivers/s390/block/Kconfig
+++ b/drivers/s390/block/Kconfig
@@ -38,7 +38,7 @@ config DASD_PROFILE
 	depends on DASD
 	help
 	  Enable this option if you want to see profiling information
-          in /proc/dasd/statistics.
+	  in /proc/dasd/statistics.
 
 config DASD_ECKD
 	def_tristate y
diff --git a/drivers/s390/char/Kconfig b/drivers/s390/char/Kconfig
index ab0b243..e2c0c60 100644
--- a/drivers/s390/char/Kconfig
+++ b/drivers/s390/char/Kconfig
@@ -91,14 +91,14 @@ config SCLP_ASYNC
 	  need this feature and intend to run your kernel in LPAR.
 
 config SCLP_ASYNC_ID
-       string "Component ID for Call Home"
-       depends on SCLP_ASYNC
-       default "000000000"
-       help
-	 The Component ID for Call Home is used to identify the correct
-	 problem reporting queue the call home records should be sent to.
+	string "Component ID for Call Home"
+	depends on SCLP_ASYNC
+	default "000000000"
+	help
+	  The Component ID for Call Home is used to identify the correct
+	  problem reporting queue the call home records should be sent to.
 
-	 If your are unsure, please use the default value "000000000".
+	  If your are unsure, please use the default value "000000000".
 
 config HMC_DRV
 	def_tristate m
@@ -205,4 +205,3 @@ config S390_VMUR
 	depends on S390
 	help
 	  Character device driver for z/VM reader, puncher and printer.
-
diff --git a/drivers/s390/net/Kconfig b/drivers/s390/net/Kconfig
index 7c5a25d..ced896d 100644
--- a/drivers/s390/net/Kconfig
+++ b/drivers/s390/net/Kconfig
@@ -7,10 +7,10 @@ config LCS
 	prompt "Lan Channel Station Interface"
 	depends on CCW && NETDEVICES && (ETHERNET || FDDI)
 	help
-	   Select this option if you want to use LCS networking on IBM System z.
-	   This device driver supports FDDI (IEEE 802.7) and Ethernet.
-	   To compile as a module, choose M. The module name is lcs.
-	   If you do not know what it is, it's safe to choose Y.
+	  Select this option if you want to use LCS networking on IBM System z.
+	  This device driver supports FDDI (IEEE 802.7) and Ethernet.
+	  To compile as a module, choose M. The module name is lcs.
+	  If you do not know what it is, it's safe to choose Y.
 
 config CTCM
 	def_tristate m
-- 
1.9.1
