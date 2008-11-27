Return-Path: <linux-kernel-owner+w=401wt.eu-S1755869AbYK0KmP@vger.kernel.org>
Message-Id: <20081127103138.935400778@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:31:00 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 40/60] convert cio printks to pr_xxx macros.
Content-Disposition: inline; filename=155-kmsg-cio.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Ernst <mernst@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Ernst <mernst@de.ibm.com>

Signed-off-by: Michael Ernst <mernst@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/blacklist.c |   14 +++++++++-----
 drivers/s390/cio/chsc.c      |    8 ++++++--
 drivers/s390/cio/cio.c       |    5 ++++-
 drivers/s390/cio/cmf.c       |    8 +++++---
 drivers/s390/cio/css.c       |    8 ++++++--
 5 files changed, 30 insertions(+), 13 deletions(-)

Index: quilt-2.6/drivers/s390/cio/blacklist.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/blacklist.c
+++ quilt-2.6/drivers/s390/cio/blacklist.c
@@ -9,6 +9,9 @@
  *		 Arnd Bergmann (arndb@de.ibm.com)
  */
 
+#define KMSG_COMPONENT "cio"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/init.h>
 #include <linux/vmalloc.h>
 #include <linux/slab.h>
@@ -50,9 +53,10 @@ static int blacklist_range(range_action 
 {
 	if ((from_ssid > to_ssid) || ((from_ssid == to_ssid) && (from > to))) {
 		if (msgtrigger)
-			printk(KERN_WARNING "cio: Invalid cio_ignore range "
-			       "0.%x.%04x-0.%x.%04x\n", from_ssid, from,
-			       to_ssid, to);
+			pr_warning("0.%x.%04x to 0.%x.%04x is not a valid "
+				   "range for cio_ignore\n", from_ssid, from,
+				   to_ssid, to);
+
 		return 1;
 	}
 
@@ -140,8 +144,8 @@ static int parse_busid(char *str, unsign
 	rc = 0;
 out:
 	if (rc && msgtrigger)
-		printk(KERN_WARNING "cio: Invalid cio_ignore device '%s'\n",
-		       str);
+		pr_warning("%s is not a valid device for the cio_ignore "
+			   "kernel parameter\n", str);
 
 	return rc;
 }
Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c
+++ quilt-2.6/drivers/s390/cio/chsc.c
@@ -8,6 +8,9 @@
  *		 Arnd Bergmann (arndb@de.ibm.com)
  */
 
+#define KMSG_COMPONENT "cio"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -333,6 +336,7 @@ static void chsc_process_sei_chp_config(
 	struct chp_config_data *data;
 	struct chp_id chpid;
 	int num;
+	char *events[3] = {"configure", "deconfigure", "cancel deconfigure"};
 
 	CIO_CRW_EVENT(4, "chsc: channel-path-configuration notification\n");
 	if (sei_area->rs != 0)
@@ -343,8 +347,8 @@ static void chsc_process_sei_chp_config(
 		if (!chp_test_bit(data->map, num))
 			continue;
 		chpid.id = num;
-		printk(KERN_WARNING "cio: processing configure event %d for "
-		       "chpid %x.%02x\n", data->op, chpid.cssid, chpid.id);
+		pr_notice("Processing %s for channel path %x.%02x\n",
+			  events[data->op], chpid.cssid, chpid.id);
 		switch (data->op) {
 		case 0:
 			chp_cfg_schedule(chpid, 1);
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -9,6 +9,9 @@
  *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
 
+#define KMSG_COMPONENT "cio"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -779,7 +782,7 @@ cio_probe_console(void)
 	sch_no = cio_get_console_sch_no();
 	if (sch_no == -1) {
 		console_subchannel_in_use = 0;
-		printk(KERN_WARNING "cio: No ccw console found!\n");
+		pr_warning("No CCW console was found\n");
 		return ERR_PTR(-ENODEV);
 	}
 	memset(&console_subchannel, 0, sizeof(struct subchannel));
Index: quilt-2.6/drivers/s390/cio/cmf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cmf.c
+++ quilt-2.6/drivers/s390/cio/cmf.c
@@ -25,6 +25,9 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
+#define KMSG_COMPONENT "cio"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/bootmem.h>
 #include <linux/device.h>
 #include <linux/init.h>
@@ -1359,9 +1362,8 @@ static int __init init_cmf(void)
 	default:
 		return 1;
 	}
-
-	printk(KERN_INFO "cio: Channel measurement facility using %s "
-	       "format (%s)\n", format_string, detect_string);
+	pr_info("Channel measurement facility initialized using format "
+		"%s (mode %s)\n", format_string, detect_string);
 	return 0;
 }
 
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -6,6 +6,10 @@
  *    Author(s): Arnd Bergmann (arndb@de.ibm.com)
  *		 Cornelia Huck (cornelia.huck@de.ibm.com)
  */
+
+#define KMSG_COMPONENT "cio"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/device.h>
@@ -844,8 +848,8 @@ out:
 	s390_unregister_crw_handler(CRW_RSC_CSS);
 	chsc_free_sei_area();
 	kfree(slow_subchannel_set);
-	printk(KERN_WARNING"cio: failed to initialize css driver (%d)!\n",
-	       ret);
+	pr_alert("The CSS device driver initialization failed with "
+		 "errno=%d\n", ret);
 	return ret;
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
