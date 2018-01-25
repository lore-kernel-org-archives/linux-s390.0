From: Farhan Ali <alifm@linux.vnet.ibm.com>
Date: Thu, 25 Jan 2018 15:47:29 +0000
Subject: [PATCH v1 0/2] Kconfig changes to enable Graphics Support for S390
Message-Id: <cover.1516892845.git.alifm@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, stefan.kristiansson@saunalahti.fi, tomi.valkeinen@ti.com
List-ID: <linux-s390.vger.kernel.org>

Hi,

This series of patches are in preparation for enabling an additional
tty and console for a S390 KVM guest using a virtio-gpu device[1].
One of the steps to do this would be to enable CONFIG_VT for S390,
and this would also require the dummy console (CONFIG_DUMMY_CONSOLE).

Patch 1 enables the "Graphics support" menu which is
needed to enable dummy console, since the VT layer needs it.

Patch 2 fixes a Kconfig dependency issue for opencores
framebuffer devices. This issue was exposed by the previous
patch.

Thanks
Farhan


[1] https://lists.nongnu.org/archive/html/qemu-devel/2017-09/msg04184.html

Farhan Ali (2):
  Kconfig : Remove HAS_IOMEM dependency for Graphics support
  fbdev: Kconfig: Add HAS_IOMEM dependency for FB_OPENCORES

 drivers/video/Kconfig       | 1 -
 drivers/video/fbdev/Kconfig | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.7.4
