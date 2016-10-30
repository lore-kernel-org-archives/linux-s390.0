Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH 1/9] s390: cio: make it explicitly non-modular
Date: Sun, 30 Oct 2016 16:37:24 -0400
Message-ID: <20161030203732.26405-2-paul.gortmaker@windriver.com>
In-Reply-To: <20161030203732.26405-1-paul.gortmaker@windriver.com>
References: <20161030203732.26405-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Paul Gortmaker <paul.gortmaker@windriver.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Arnd Bergmann <arndb@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The Makefile currently controlling compilation of this code is:

  obj-y += airq.o blacklist.o chsc.o cio.o css.o chp.o idset.o isc.o \
          fcx.o itcw.o crw.o ccwreq.o trace.o ioasm.o
  ccw_device-objs += device.o device_fsm.o device_ops.o
  ccw_device-objs += device_id.o device_pgid.o device_status.o
  obj-y += ccw_device.o cmf.o

...meaning that the files here are not being built as modular.

Lets remove the couple traces of modular infrastructure use, so that
when reading the code there is no doubt it is builtin-only.

Since module_init translates to device_initcall in the non-modular
case, the init ordering remains unchanged with this commit.

Also note that MODULE_DEVICE_TABLE is a no-op for non-modular code.

We delete the MODULE_LICENSE tag etc. since all that information
was (or is now) contained at the top of the file in the comments.

We replace module.h with export.h where the file does export some
symbols.

Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>
Cc: Peter Oberparleiter <oberpar@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Arnd Bergmann <arndb@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/s390/cio/cmf.c        | 10 ++--------
 drivers/s390/cio/css.c        |  6 +++---
 drivers/s390/cio/device.c     |  6 +++---
 drivers/s390/cio/device_ops.c |  5 +++--
 4 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
index 268aa23afa01..6b6386e9a500 100644
--- a/drivers/s390/cio/cmf.c
+++ b/drivers/s390/cio/cmf.c
@@ -30,7 +30,7 @@
 #include <linux/device.h>
 #include <linux/init.h>
 #include <linux/list.h>
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/moduleparam.h>
 #include <linux/slab.h>
 #include <linux/timex.h>	/* get_tod_clock() */
@@ -1389,13 +1389,7 @@ static int __init init_cmf(void)
 		"%s (mode %s)\n", format_string, detect_string);
 	return 0;
 }
-module_init(init_cmf);
-
-
-MODULE_AUTHOR("Arnd Bergmann <arndb@de.ibm.com>");
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("channel measurement facility base driver\n"
-		   "Copyright IBM Corp. 2003\n");
+device_initcall(init_cmf);
 
 EXPORT_SYMBOL_GPL(enable_cmf);
 EXPORT_SYMBOL_GPL(disable_cmf);
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 3d2b20ee613f..bc099b61394d 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -5,12 +5,14 @@
  *
  * Author(s): Arnd Bergmann (arndb@de.ibm.com)
  *	      Cornelia Huck (cornelia.huck@de.ibm.com)
+ *
+ * License: GPL
  */
 
 #define KMSG_COMPONENT "cio"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/slab.h>
@@ -1285,5 +1287,3 @@ void css_driver_unregister(struct css_driver *cdrv)
 	driver_unregister(&cdrv->drv);
 }
 EXPORT_SYMBOL_GPL(css_driver_unregister);
-
-MODULE_LICENSE("GPL");
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 6a58bc8f46e2..79823ee9c100 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -5,12 +5,14 @@
  *    Author(s): Arnd Bergmann (arndb@de.ibm.com)
  *		 Cornelia Huck (cornelia.huck@de.ibm.com)
  *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
+ *
+ * License: GPL
  */
 
 #define KMSG_COMPONENT "cio"
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/spinlock.h>
 #include <linux/errno.h>
@@ -145,7 +147,6 @@ static struct css_device_id io_subchannel_ids[] = {
 	{ .match_flags = 0x1, .type = SUBCHANNEL_TYPE_IO, },
 	{ /* end of list */ },
 };
-MODULE_DEVICE_TABLE(css, io_subchannel_ids);
 
 static int io_subchannel_prepare(struct subchannel *sch)
 {
@@ -2150,7 +2151,6 @@ int ccw_device_siosl(struct ccw_device *cdev)
 }
 EXPORT_SYMBOL_GPL(ccw_device_siosl);
 
-MODULE_LICENSE("GPL");
 EXPORT_SYMBOL(ccw_device_set_online);
 EXPORT_SYMBOL(ccw_device_set_offline);
 EXPORT_SYMBOL(ccw_driver_register);
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index 877d9f601e63..cf8c4ac6323a 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -3,8 +3,10 @@
  *
  * Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
  *	      Cornelia Huck (cornelia.huck@de.ibm.com)
+ *
+ * License: GPL
  */
-#include <linux/module.h>
+#include <linux/export.h>
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/slab.h>
@@ -676,7 +678,6 @@ void ccw_device_get_schid(struct ccw_device *cdev, struct subchannel_id *schid)
 }
 EXPORT_SYMBOL_GPL(ccw_device_get_schid);
 
-MODULE_LICENSE("GPL");
 EXPORT_SYMBOL(ccw_device_set_options_mask);
 EXPORT_SYMBOL(ccw_device_set_options);
 EXPORT_SYMBOL(ccw_device_clear_options);
-- 
2.10.1
