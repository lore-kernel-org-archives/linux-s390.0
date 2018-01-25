From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Thu, 25 Jan 2018 15:47:31 +0000
Subject: [PATCH v1 2/2] fbdev: Kconfig: Add HAS_IOMEM dependency for FB_OPENCORES
Message-Id: <033e4a497792b2fa484c1288b9ed05c068565088.1516892845.git.alifm@linux.vnet.ibm.com>
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

The Opencores framebuffer device uses I/O memory and with
CONFIG_HAS_IOMEM disabled will lead to build errors:

ERROR: "devm_ioremap_resource" [drivers/video/fbdev/ocfb.ko] undefined!

Fix this by adding HAS_IOMEM dependency for FB_OPENCORES.

Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
---
 drivers/video/fbdev/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 5e58f5e..8667e5d 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -976,7 +976,7 @@ config FB_PVR2
 
 config FB_OPENCORES
 	tristate "OpenCores VGA/LCD core 2.0 framebuffer support"
-	depends on FB && HAS_DMA
+	depends on FB && HAS_DMA && HAS_IOMEM
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
2.7.4
