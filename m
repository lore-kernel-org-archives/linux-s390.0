Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 9/9] s390: virtio: make ccw explicitly non-modular
Date: Sun, 30 Oct 2016 16:37:32 -0400
Message-ID: <20161030203732.26405-10-paul.gortmaker@windriver.com>
In-Reply-To: <20161030203732.26405-1-paul.gortmaker@windriver.com>
References: <20161030203732.26405-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The Kconfig currently controlling compilation of this code is:

arch/s390/Kconfig:config S390_GUEST
arch/s390/Kconfig:      def_bool y

...meaning that it currently is not being built as a module by anyone.

Lets remove the modular code that is essentially orphaned, so that
when reading the driver there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We replace module.h with moduleparam.h since the file does declare
some module_param() and leaving that as-is is currently the easiest
way to remain compatible with existing boot arg use cases.

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/s390/virtio/virtio_ccw.c | 25 ++-----------------------
 1 file changed, 2 insertions(+), 23 deletions(-)

diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
index 8688ad4c825f..639ed4e6afd1 100644
--- a/drivers/s390/virtio/virtio_ccw.c
+++ b/drivers/s390/virtio/virtio_ccw.c
@@ -24,7 +24,7 @@
 #include <linux/wait.h>
 #include <linux/list.h>
 #include <linux/bitops.h>
-#include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/io.h>
 #include <linux/kvm_para.h>
 #include <linux/notifier.h>
@@ -235,16 +235,6 @@ static struct airq_info *new_airq_info(void)
 	return info;
 }
 
-static void destroy_airq_info(struct airq_info *info)
-{
-	if (!info)
-		return;
-
-	unregister_adapter_interrupt(&info->airq);
-	airq_iv_release(info->aiv);
-	kfree(info);
-}
-
 static unsigned long get_airq_indicator(struct virtqueue *vqs[], int nvqs,
 					u64 *first, void **airq_info)
 {
@@ -1294,7 +1284,6 @@ static struct ccw_device_id virtio_ids[] = {
 	{ CCW_DEVICE(0x3832, 0) },
 	{},
 };
-MODULE_DEVICE_TABLE(ccw, virtio_ids);
 
 static struct ccw_driver virtio_ccw_driver = {
 	.driver = {
@@ -1406,14 +1395,4 @@ static int __init virtio_ccw_init(void)
 	no_auto_parse();
 	return ccw_driver_register(&virtio_ccw_driver);
 }
-module_init(virtio_ccw_init);
-
-static void __exit virtio_ccw_exit(void)
-{
-	int i;
-
-	ccw_driver_unregister(&virtio_ccw_driver);
-	for (i = 0; i < MAX_AIRQ_AREAS; i++)
-		destroy_airq_info(airq_areas[i]);
-}
-module_exit(virtio_ccw_exit);
+device_initcall(virtio_ccw_init);
-- 
2.10.1
