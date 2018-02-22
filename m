From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Thu, 22 Feb 2018 16:22:22 +0000
Subject: [PATCH v4 1/3] Kconfig : Remove HAS_IOMEM dependency for Graphics support
Message-Id: <6e8ef238162df5be4462126be155975c722e9863.1519315352.git.alifm@linux.vnet.ibm.com>
References: <cover.1519315352.git.alifm@linux.vnet.ibm.com>
In-Reply-To: <cover.1519315352.git.alifm@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: thuth@redhat.com, borntraeger@de.ibm.com, cohuck@redhat.com, tomi.valkeinen@ti.com, b.zolnierkie@samsung.com, geert@linux-m68k.org, alifm@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
added the HAS_IOMEM dependecy for "Graphics support". This disabled the
"Graphics support" menu for S390. But if we enable VT layer for S390,
we would also need to enable the dummy console. So let's remove the
HAS_IOMEM dependency.

Move this dependency to sub menu items and console drivers that use
io memory.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 drivers/video/Kconfig         | 5 ++++-
 drivers/video/console/Kconfig | 6 +++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3c20af9..4f950c6 100644
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
index 7f1f1fb..9485857 100644
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
2.7.4
