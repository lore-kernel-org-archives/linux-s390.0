Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:56964 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728080AbfGISdd (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 9 Jul 2019 14:33:33 -0400
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Subject: [PATCH 1/5] docs: don't use nested tables
Date: Tue,  9 Jul 2019 15:33:19 -0300
Message-Id: <925686792c61b584f05dd9f13f078cd82d5b6a54.1562696797.git.mchehab+samsung@kernel.org>
In-Reply-To: <cover.1562696797.git.mchehab+samsung@kernel.org>
References: <cover.1562696797.git.mchehab+samsung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Dan Williams <dan.j.williams@intel.com>, linux-doc@vger.kernel.org, linux-s390@vger.kernel.org

Nested tables aren't supported for pdf output on Sphinx 1.7.9:

	admin-guide/laptops/sonypi:: nested tables are not yet implemented.
	admin-guide/laptops/toshiba_haps:: nested tables are not yet implemented.
	driver-api/nvdimm/btt:: nested tables are not yet implemented.
	s390/debugging390:: nested tables are not yet implemented.

Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
---
 Documentation/admin-guide/laptops/sonypi.rst  | 26 +++++++++----------
 .../admin-guide/laptops/toshiba_haps.rst      |  8 +++---
 Documentation/driver-api/nvdimm/btt.rst       |  2 +-
 Documentation/s390/debugging390.rst           |  2 +-
 4 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/Documentation/admin-guide/laptops/sonypi.rst b/Documentation/admin-guide/laptops/sonypi.rst
index 2a1975ed7ee4..c6eaaf48f7c1 100644
--- a/Documentation/admin-guide/laptops/sonypi.rst
+++ b/Documentation/admin-guide/laptops/sonypi.rst
@@ -53,7 +53,7 @@ module or sonypi.<param>=<value> on the kernel boot line when sonypi is
 statically linked into the kernel). Those options are:
 
 	=============== =======================================================
-	minor: 		minor number of the misc device /dev/sonypi,
+	minor:		minor number of the misc device /dev/sonypi,
 			default is -1 (automatic allocation, see /proc/misc
 			or kernel logs)
 
@@ -89,24 +89,22 @@ statically linked into the kernel). Those options are:
 			set to 0xffffffff, meaning that all possible events
 			will be tried. You can use the following bits to
 			construct your own event mask (from
-			drivers/char/sonypi.h):
+			drivers/char/sonypi.h)::
 
-				========================	======
-				SONYPI_JOGGER_MASK 		0x0001
-				SONYPI_CAPTURE_MASK 		0x0002
-				SONYPI_FNKEY_MASK 		0x0004
-				SONYPI_BLUETOOTH_MASK 		0x0008
-				SONYPI_PKEY_MASK 		0x0010
-				SONYPI_BACK_MASK 		0x0020
-				SONYPI_HELP_MASK 		0x0040
-				SONYPI_LID_MASK 		0x0080
-				SONYPI_ZOOM_MASK 		0x0100
-				SONYPI_THUMBPHRASE_MASK 	0x0200
+				SONYPI_JOGGER_MASK		0x0001
+				SONYPI_CAPTURE_MASK		0x0002
+				SONYPI_FNKEY_MASK		0x0004
+				SONYPI_BLUETOOTH_MASK		0x0008
+				SONYPI_PKEY_MASK		0x0010
+				SONYPI_BACK_MASK		0x0020
+				SONYPI_HELP_MASK		0x0040
+				SONYPI_LID_MASK			0x0080
+				SONYPI_ZOOM_MASK		0x0100
+				SONYPI_THUMBPHRASE_MASK		0x0200
 				SONYPI_MEYE_MASK		0x0400
 				SONYPI_MEMORYSTICK_MASK		0x0800
 				SONYPI_BATTERY_MASK		0x1000
 				SONYPI_WIRELESS_MASK		0x2000
-				========================	======
 
 	useinput:	if set (which is the default) two input devices are
 			created, one which interprets the jogdial events as
diff --git a/Documentation/admin-guide/laptops/toshiba_haps.rst b/Documentation/admin-guide/laptops/toshiba_haps.rst
index 11dfc428c080..d28b6c3f2849 100644
--- a/Documentation/admin-guide/laptops/toshiba_haps.rst
+++ b/Documentation/admin-guide/laptops/toshiba_haps.rst
@@ -75,11 +75,11 @@ The sysfs files under /sys/devices/LNXSYSTM:00/LNXSYBUS:00/TOS620A:00/ are:
 protection_level   The protection_level is readable and writeable, and
 		   provides a way to let userspace query the current protection
 		   level, as well as set the desired protection level, the
-		   available protection levels are:
+		   available protection levels are::
 
-		   ============   =======   ==========   ========
-		   0 - Disabled   1 - Low   2 - Medium   3 - High
-		   ============   =======   ==========   ========
+		     ============   =======   ==========   ========
+		     0 - Disabled   1 - Low   2 - Medium   3 - High
+		     ============   =======   ==========   ========
 
 reset_protection   The reset_protection entry is writeable only, being "1"
 		   the only parameter it accepts, it is used to trigger
diff --git a/Documentation/driver-api/nvdimm/btt.rst b/Documentation/driver-api/nvdimm/btt.rst
index 2d8269f834bd..107395c042ae 100644
--- a/Documentation/driver-api/nvdimm/btt.rst
+++ b/Documentation/driver-api/nvdimm/btt.rst
@@ -83,7 +83,7 @@ flags, and the remaining form the internal block number.
 ======== =============================================================
 Bit      Description
 ======== =============================================================
-31 - 30	 Error and Zero flags - Used in the following way:
+31 - 30	 Error and Zero flags - Used in the following way::
 
 	   == ==  ====================================================
 	   31 30  Description
diff --git a/Documentation/s390/debugging390.rst b/Documentation/s390/debugging390.rst
index d49305fd5e1a..73ad0b06c666 100644
--- a/Documentation/s390/debugging390.rst
+++ b/Documentation/s390/debugging390.rst
@@ -170,7 +170,7 @@ currently running at.
 |        +----------------+-------------------------------------------------+
 |        |    32          | Basic Addressing Mode                           |
 |        |                |                                                 |
-|        |                | Used to set addressing mode                     |
+|        |                | Used to set addressing mode::                   |
 |        |                |                                                 |
 |        |                |    +---------+----------+----------+            |
 |        |                |    | PSW 31  | PSW 32   |          |            |
-- 
2.21.0
