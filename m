From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed, 14 Mar 2018 19:28:54 +0000
Subject: [GIT PULL 06/10] Kconfig: Remove HAS_IOMEM dependency for Graphics support
Message-Id: <20180314192858.172855-7-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Farhan Ali <alifm@linux.vnet.ibm.com>

The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
added the HAS_IOMEM dependecy for "Graphics support". This disabled the
"Graphics support" menu for S390. But if we enable VT layer for S390,
we would also need to enable the dummy console. So let's remove the
HAS_IOMEM dependency.

Move this dependency to sub menu items and console drivers that use
io memory.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <6e8ef238162df5be4462126be155975c722e9863.1519315352.git.alifm@linux.vnet.ibm.com>
Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 drivers/video/Kconfig         | 5 ++++-
 drivers/video/console/Kconfig | 6 +++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3c20af999893..4f950c686055 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -3,7 +3,8 @@
 #
 
 menu "Graphics support"
-	depends on HAS_IOMEM
+
+if HAS_IOMEM
 
 config HAVE_FB_ATMEL
 	bool
@@ -36,6 +37,8 @@ config VIDEOMODE_HELPERS
 config HDMI
 	bool
 
+endif # HAS_IOMEM
+
 if VT
 	source "drivers/video/console/Kconfig"
 endif
diff --git a/drivers/video/console/Kconfig b/drivers/video/console/Kconfig
index 7f1f1fbcef9e..9485857228ea 100644
--- a/drivers/video/console/Kconfig
+++ b/drivers/video/console/Kconfig
@@ -9,7 +9,7 @@ config VGA_CONSOLE
 	depends on !4xx && !PPC_8xx && !SPARC && !M68K && !PARISC && !FRV && \
 		!SUPERH && !BLACKFIN && !AVR32 && !MN10300 && !CRIS && \
 		(!ARM || ARCH_FOOTBRIDGE || ARCH_INTEGRATOR || ARCH_NETWINDER) && \
-		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC
+		!ARM64 && !ARC && !MICROBLAZE && !OPENRISC && HAS_IOMEM
 	default y
 	help
 	  Saying Y here will allow you to use Linux in text mode through a
@@ -85,7 +85,7 @@ config MDA_CONSOLE
 
 config SGI_NEWPORT_CONSOLE
         tristate "SGI Newport Console support"
-        depends on SGI_IP22 
+        depends on SGI_IP22 && HAS_IOMEM
         select FONT_SUPPORT
         help
           Say Y here if you want the console on the Newport aka XL graphics
@@ -153,7 +153,7 @@ config FRAMEBUFFER_CONSOLE_ROTATION
 
 config STI_CONSOLE
         bool "STI text console"
-        depends on PARISC
+        depends on PARISC && HAS_IOMEM
         select FONT_SUPPORT
         default y
         help
-- 
2.14.3
