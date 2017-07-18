From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH 1/2] vfio/ccw: allocate irq info with the right size
Date: Tue, 18 Jul 2017 03:49:25 +0200
Message-ID: <20170718014926.44781-2-bjsdjshi@linux.vnet.ibm.com>
References: <20170718014926.44781-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170718014926.44781-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, Jing Zhang <bjzhjing@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jing Zhang <bjzhjing@linux.vnet.ibm.com>

When allocating memory for the vfio_irq_info parameter of the
VFIO_DEVICE_GET_IRQ_INFO ioctl, we used the wrong size. Let's
fix it by using the right size.

Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Jing Zhang <bjzhjing@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 hw/vfio/ccw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 12d0262336..8d97b53e77 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -168,7 +168,7 @@ static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
         return;
     }
 
-    argsz = sizeof(*irq_set);
+    argsz = sizeof(*irq_info);
     irq_info = g_malloc0(argsz);
     irq_info->index = VFIO_CCW_IO_IRQ_INDEX;
     irq_info->argsz = argsz;
-- 
2.11.2
