From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Thu, 25 Jan 2018 15:47:30 +0000
Subject: [PATCH v1 1/2] Kconfig : Remove HAS_IOMEM dependency for Graphics support
Message-Id: <a4d2db8f1f9e1b8fa36815eb6a562224f9ab2ca2.1516892845.git.alifm@linux.vnet.ibm.com>
References: <cover.1516892845.git.alifm@linux.vnet.ibm.com>
In-Reply-To: <cover.1516892845.git.alifm@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, stefan.kristiansson@saunalahti.fi, tomi.valkeinen@ti.com
List-ID: <linux-s390.vger.kernel.org>

The 'commit e25df1205f37 ("[S390] Kconfig: menus with depends on HAS_IOMEM.")'
added the HAS_IOMEM dependecy for "Graphics support". This disabled the
"Graphics support" menu for S390. But if we enable VT layer for S390,
we would also need to enable the dummy console. So let's remove the
HAS_IOMEM dependency.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Tested-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/video/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3c20af9..41e7ba9 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -3,7 +3,6 @@
 #
 
 menu "Graphics support"
-	depends on HAS_IOMEM
 
 config HAVE_FB_ATMEL
 	bool
-- 
2.7.4
