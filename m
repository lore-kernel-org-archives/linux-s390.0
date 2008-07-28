Return-Path: <linux-kernel-owner+w=401wt.eu-S1758980AbYG1Rz2@vger.kernel.org>
Message-Id: <20080728175511.495393312@de.ibm.com>
References: <20080728175355.734299984@de.ibm.com>
Date: Mon, 28 Jul 2008 19:53:58 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 03/15] kmsg: convert cio message to kmsg api.
Content-Disposition: inline; filename=802-kmsg-cio.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Ernst <mernst@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Ernst <mernst@de.ibm.com>

Signed-off-by: Michael Ernst <mernst@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 Documentation/s390/kmsg/cio  |   97 +++++++++++++++++++++++++++++++++++++++++++
 drivers/s390/cio/blacklist.c |   14 +++---
 drivers/s390/cio/chsc.c      |    9 ++-
 drivers/s390/cio/cio.c       |    5 +-
 drivers/s390/cio/cmf.c       |    8 ++-
 drivers/s390/cio/css.c       |    7 ++-
 6 files changed, 126 insertions(+), 14 deletions(-)

Index: quilt-2.6/Documentation/s390/kmsg/cio
===================================================================
--- /dev/null
+++ quilt-2.6/Documentation/s390/kmsg/cio
@@ -0,0 +1,97 @@
+/*?
+ * Tag: cio.1
+ * Text: "%s is not a valid device for the cio_ignore kernel parameter"
+ * Severity: Warning
+ * Parameter:
+ *   @1: device bus-ID
+ * Description:
+ * The device specification for the cio_ignore kernel parameter is
+ * syntactically incorrect or specifies an unknown device. This device is not
+ * excluded from being sensed and analyzed.
+ * User action:
+ * Correct your device specification in the kernel parameter line to have the
+ * device excluded when you next reboot Linux. You can write the correct
+ * device specification to /proc/cio_ignore to add the device to the list of
+ * devices to be excluded. This does not immediately make the device
+ * inaccessible but the device is ignored if it disappears and later reappears.
+ */
+
+/*?
+ * Tag: cio.2
+ * Text: "0.%x.%04x to 0.%x.%04x is not a valid range for cio_ignore"
+ * Severity: Warning
+ * Parameter:
+ *   @1: from subchannel set ID
+ *   @2: from device number
+ *   @3: to subchannel set ID
+ *   @4: to device number
+ * Description:
+ * The device range specified for the cio_ignore kernel parameter is
+ * syntactically incorrect. No devices specified with this range are
+ * excluded from being sensed and analyzed.
+ * User action:
+ * Correct your range specification in the kernel parameter line to have the
+ * range of devices  excluded when you next reboot Linux. You can write the
+ * correct range specification to /proc/cio_ignore to add the range of devices
+ * to the list of devices to be excluded. This does not immediately make the
+ * devices in the range inaccessible but any of these devices are ignored if
+ * they disappear and later reappear.
+ */
+
+/*?
+ * Tag: cio.3
+ * Text: "Processing %s for channel path %x.%02x"
+ * Severity: Notice
+ * Parameter:
+ *   @1: configuration change
+ *   @2: channel subsystem ID
+ *   @3: CHPID
+ * Description:
+ * A configuration change is in progress for the given channel path.
+ * User action:
+ * None.
+ */
+
+/*?
+ * Tag: cio.4
+ * Text: "No CCW console was found"
+ * Severity: Warning
+ * Description:
+ * Linux did not find the expected CCW console and tries to use an alternative
+ * console. A possible reason why the console was not found is that the console
+ * has been specified in the cio_ignore list.
+ * User action:
+ * None, if an appropriate alternative console has been found, and you want
+ * to use this alternative console. If you want to use the CCW console, ensure
+ * that is not specified in the cio_ignore list, explicitly specify the console
+ * with the 'condev=' kernel parameter, and reboot Linux.
+ */
+
+/*?
+ * Tag: cio.5
+ * Text: "Channel measurement facility initialized using format %s (mode %s)"
+ * Severity: Informational
+ * Parameter:
+ *   @1: format
+ *   @2: mode
+ * Description:
+ * The channel measurement facility has been initialized successfully. Format
+ * 'extended' should be used for z990 and later mainframe systems. Format
+ * 'basic' is intended for earlier mainframes. Mode 'autodetected' means that
+ * the format has been set automatically. Mode 'parameter' means that the
+ * format has been set according to the 'format=' kernel parameter.
+ * User action:
+ * None.
+ */
+
+/*?
+ * Tag: cio.6
+ * Text: "The CSS device driver initialization failed with errno=%d"
+ * Severity: Alert
+ * Parameter:
+ *   @1: Return code
+ * Description:
+ * The channel subsystem bus could not be established.
+ * User action:
+ * See the errno man page to find out what caused the problem.
+ */
Index: quilt-2.6/drivers/s390/cio/blacklist.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/blacklist.c
+++ quilt-2.6/drivers/s390/cio/blacklist.c
@@ -19,12 +19,15 @@
 
 #include <asm/cio.h>
 #include <asm/uaccess.h>
+#include <asm/kmsg.h>
 
 #include "blacklist.h"
 #include "cio.h"
 #include "cio_debug.h"
 #include "css.h"
 
+#define KMSG_COMPONENT "cio"
+
 /*
  * "Blacklisting" of certain devices:
  * Device numbers given in the commandline as cio_ignore=... won't be known
@@ -49,9 +52,10 @@ static int blacklist_range(range_action 
 {
 	if ((from_ssid > to_ssid) || ((from_ssid == to_ssid) && (from > to))) {
 		if (msgtrigger)
-			printk(KERN_WARNING "cio: Invalid cio_ignore range "
-			       "0.%x.%04x-0.%x.%04x\n", from_ssid, from,
-			       to_ssid, to);
+			kmsg_warn(2, "0.%x.%04x to 0.%x.%04x is not a valid "
+				  "range for cio_ignore\n", from_ssid, from,
+				  to_ssid, to);
+
 		return 1;
 	}
 
@@ -139,8 +143,8 @@ static int parse_busid(char *str, unsign
 	rc = 0;
 out:
 	if (rc && msgtrigger)
-		printk(KERN_WARNING "cio: Invalid cio_ignore device '%s'\n",
-		       str);
+		kmsg_warn(1, "%s is not a valid device for the cio_ignore "
+			  "kernel parameter\n", str);
 
 	return rc;
 }
Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c
+++ quilt-2.6/drivers/s390/cio/chsc.c
@@ -16,7 +16,7 @@
 #include <asm/cio.h>
 #include <asm/chpid.h>
 #include <asm/chsc.h>
-
+#include <asm/kmsg.h>
 #include "../s390mach.h"
 #include "css.h"
 #include "cio.h"
@@ -25,6 +25,8 @@
 #include "chp.h"
 #include "chsc.h"
 
+#define KMSG_COMPONENT "cio"
+
 static void *sei_page;
 
 /**
@@ -333,6 +335,7 @@ static void chsc_process_sei_chp_config(
 	struct chp_config_data *data;
 	struct chp_id chpid;
 	int num;
+	char *events[3] = {"configure", "deconfigure", "cancel deconfigure"};
 
 	CIO_CRW_EVENT(4, "chsc: channel-path-configuration notification\n");
 	if (sei_area->rs != 0)
@@ -343,8 +346,8 @@ static void chsc_process_sei_chp_config(
 		if (!chp_test_bit(data->map, num))
 			continue;
 		chpid.id = num;
-		printk(KERN_WARNING "cio: processing configure event %d for "
-		       "chpid %x.%02x\n", data->op, chpid.cssid, chpid.id);
+		kmsg_notice(3, "Processing %s for channel path %x.%02x\n",
+			    events[data->op], chpid.cssid, chpid.id);
 		switch (data->op) {
 		case 0:
 			chp_cfg_schedule(chpid, 1);
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -27,6 +27,7 @@
 #include <asm/isc.h>
 #include <asm/cpu.h>
 #include <asm/fcx.h>
+#include <asm/kmsg.h>
 #include "cio.h"
 #include "css.h"
 #include "chsc.h"
@@ -37,6 +38,8 @@
 #include "chp.h"
 #include "../s390mach.h"
 
+#define KMSG_COMPONENT "cio"
+
 debug_info_t *cio_debug_msg_id;
 debug_info_t *cio_debug_trace_id;
 debug_info_t *cio_debug_crw_id;
@@ -770,7 +773,7 @@ cio_probe_console(void)
 	sch_no = cio_get_console_sch_no();
 	if (sch_no == -1) {
 		console_subchannel_in_use = 0;
-		printk(KERN_WARNING "cio: No ccw console found!\n");
+		kmsg_warn(4, "No CCW console was found\n");
 		return ERR_PTR(-ENODEV);
 	}
 	memset(&console_subchannel, 0, sizeof(struct subchannel));
Index: quilt-2.6/drivers/s390/cio/cmf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cmf.c
+++ quilt-2.6/drivers/s390/cio/cmf.c
@@ -38,6 +38,7 @@
 #include <asm/cio.h>
 #include <asm/cmb.h>
 #include <asm/div64.h>
+#include <asm/kmsg.h>
 
 #include "cio.h"
 #include "css.h"
@@ -45,6 +46,8 @@
 #include "ioasm.h"
 #include "chsc.h"
 
+#define KMSG_COMPONENT "cio"
+
 /*
  * parameter to enable cmf during boot, possible uses are:
  *  "s390cmf" -- enable cmf and allocate 2 MB of ram so measuring can be
@@ -1359,9 +1362,8 @@ static int __init init_cmf(void)
 	default:
 		return 1;
 	}
-
-	printk(KERN_INFO "cio: Channel measurement facility using %s "
-	       "format (%s)\n", format_string, detect_string);
+	kmsg_info(5, "Channel measurement facility initialized using format "
+		  "%s (mode %s)\n", format_string, detect_string);
 	return 0;
 }
 
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -14,6 +14,7 @@
 #include <linux/list.h>
 #include <linux/reboot.h>
 #include <asm/isc.h>
+#include <asm/kmsg.h>
 
 #include "../s390mach.h"
 #include "css.h"
@@ -25,6 +26,8 @@
 #include "idset.h"
 #include "chp.h"
 
+#define KMSG_COMPONENT "cio"
+
 int css_init_done = 0;
 static int need_reprobe = 0;
 static int max_ssid = 0;
@@ -841,8 +844,8 @@ out:
 	s390_unregister_crw_handler(CRW_RSC_CSS);
 	chsc_free_sei_area();
 	kfree(slow_subchannel_set);
-	printk(KERN_WARNING"cio: failed to initialize css driver (%d)!\n",
-	       ret);
+	kmsg_alert(6, "The CSS device driver initialization failed with "
+		   "errno=%d\n", ret);
 	return ret;
 }
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
