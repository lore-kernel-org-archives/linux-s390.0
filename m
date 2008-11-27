Return-Path: <linux-kernel-owner+w=401wt.eu-S1757600AbYK0KvV@vger.kernel.org>
Message-Id: <20081127103142.364476710@de.ibm.com>
References: <20081127103020.528516828@de.ibm.com>
Date: Thu, 27 Nov 2008 11:31:12 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 52/60] convert sclp printks to pr_xxx macros.
Content-Disposition: inline; filename=167-kmsg-sclp.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/sclp_cmd.c     |   29 ++++++++++++++++-------------
 drivers/s390/char/sclp_config.c  |   10 ++++++----
 drivers/s390/char/sclp_cpi_sys.c |   12 ++++++++----
 drivers/s390/char/sclp_sdias.c   |   18 +++++++++++-------
 4 files changed, 41 insertions(+), 28 deletions(-)

Index: quilt-2.6/drivers/s390/char/sclp_cmd.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_cmd.c
+++ quilt-2.6/drivers/s390/char/sclp_cmd.c
@@ -6,6 +6,9 @@
  *		 Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "sclp_cmd"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/completion.h>
 #include <linux/init.h>
 #include <linux/errno.h>
@@ -16,9 +19,8 @@
 #include <linux/memory.h>
 #include <asm/chpid.h>
 #include <asm/sclp.h>
-#include "sclp.h"
 
-#define TAG	"sclp_cmd: "
+#include "sclp.h"
 
 #define SCLP_CMDW_READ_SCP_INFO		0x00020001
 #define SCLP_CMDW_READ_SCP_INFO_FORCED	0x00120001
@@ -169,8 +171,8 @@ static int do_sync_request(sclp_cmdw_t c
 
 	/* Check response. */
 	if (request->status != SCLP_REQ_DONE) {
-		printk(KERN_WARNING TAG "sync request failed "
-		       "(cmd=0x%08x, status=0x%02x)\n", cmd, request->status);
+		pr_warning("sync request failed (cmd=0x%08x, "
+			   "status=0x%02x)\n", cmd, request->status);
 		rc = -EIO;
 	}
 out:
@@ -224,8 +226,8 @@ int sclp_get_cpu_info(struct sclp_cpu_in
 	if (rc)
 		goto out;
 	if (sccb->header.response_code != 0x0010) {
-		printk(KERN_WARNING TAG "readcpuinfo failed "
-		       "(response=0x%04x)\n", sccb->header.response_code);
+		pr_warning("readcpuinfo failed (response=0x%04x)\n",
+			   sccb->header.response_code);
 		rc = -EIO;
 		goto out;
 	}
@@ -262,8 +264,9 @@ static int do_cpu_configure(sclp_cmdw_t 
 	case 0x0120:
 		break;
 	default:
-		printk(KERN_WARNING TAG "configure cpu failed (cmd=0x%08x, "
-		       "response=0x%04x)\n", cmd, sccb->header.response_code);
+		pr_warning("configure cpu failed (cmd=0x%08x, "
+			   "response=0x%04x)\n", cmd,
+			   sccb->header.response_code);
 		rc = -EIO;
 		break;
 	}
@@ -626,9 +629,9 @@ static int do_chp_configure(sclp_cmdw_t 
 	case 0x0450:
 		break;
 	default:
-		printk(KERN_WARNING TAG "configure channel-path failed "
-		       "(cmd=0x%08x, response=0x%04x)\n", cmd,
-		       sccb->header.response_code);
+		pr_warning("configure channel-path failed "
+			   "(cmd=0x%08x, response=0x%04x)\n", cmd,
+			   sccb->header.response_code);
 		rc = -EIO;
 		break;
 	}
@@ -695,8 +698,8 @@ int sclp_chp_read_info(struct sclp_chp_i
 	if (rc)
 		goto out;
 	if (sccb->header.response_code != 0x0010) {
-		printk(KERN_WARNING TAG "read channel-path info failed "
-		       "(response=0x%04x)\n", sccb->header.response_code);
+		pr_warning("read channel-path info failed "
+			   "(response=0x%04x)\n", sccb->header.response_code);
 		rc = -EIO;
 		goto out;
 	}
Index: quilt-2.6/drivers/s390/char/sclp_config.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_config.c
+++ quilt-2.6/drivers/s390/char/sclp_config.c
@@ -5,15 +5,17 @@
  *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "sclp_config"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/init.h>
 #include <linux/errno.h>
 #include <linux/cpu.h>
 #include <linux/sysdev.h>
 #include <linux/workqueue.h>
 #include <asm/smp.h>
-#include "sclp.h"
 
-#define TAG	"sclp_config: "
+#include "sclp.h"
 
 struct conf_mgm_data {
 	u8 reserved;
@@ -31,7 +33,7 @@ static void sclp_cpu_capability_notify(s
 	int cpu;
 	struct sys_device *sysdev;
 
-	printk(KERN_WARNING TAG "cpu capability changed.\n");
+	pr_warning("cpu capability changed.\n");
 	get_online_cpus();
 	for_each_online_cpu(cpu) {
 		sysdev = get_cpu_sysdev(cpu);
@@ -78,7 +80,7 @@ static int __init sclp_conf_init(void)
 		return rc;
 
 	if (!(sclp_conf_register.sclp_send_mask & EVTYP_CONFMGMDATA_MASK)) {
-		printk(KERN_WARNING TAG "no configuration management.\n");
+		pr_warning("no configuration management.\n");
 		sclp_unregister(&sclp_conf_register);
 		rc = -ENOSYS;
 	}
Index: quilt-2.6/drivers/s390/char/sclp_cpi_sys.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_cpi_sys.c
+++ quilt-2.6/drivers/s390/char/sclp_cpi_sys.c
@@ -7,6 +7,9 @@
  *		 Michael Ernst <mernst@de.ibm.com>
  */
 
+#define KMSG_COMPONENT "sclp_cpi"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/stat.h>
@@ -20,6 +23,7 @@
 #include <linux/completion.h>
 #include <asm/ebcdic.h>
 #include <asm/sclp.h>
+
 #include "sclp.h"
 #include "sclp_rw.h"
 #include "sclp_cpi_sys.h"
@@ -150,16 +154,16 @@ static int cpi_req(void)
 	wait_for_completion(&completion);
 
 	if (req->status != SCLP_REQ_DONE) {
-		printk(KERN_WARNING "cpi: request failed (status=0x%02x)\n",
-			req->status);
+		pr_warning("request failed (status=0x%02x)\n",
+			   req->status);
 		rc = -EIO;
 		goto out_free_req;
 	}
 
 	response = ((struct cpi_sccb *) req->sccb)->header.response_code;
 	if (response != 0x0020) {
-		printk(KERN_WARNING "cpi: failed with "
-			"response code 0x%x\n", response);
+		pr_warning("request failed with response code 0x%x\n",
+			   response);
 		rc = -EIO;
 	}
 
Index: quilt-2.6/drivers/s390/char/sclp_sdias.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_sdias.c
+++ quilt-2.6/drivers/s390/char/sclp_sdias.c
@@ -5,15 +5,18 @@
  * Author(s): Michael Holzheu
  */
 
+#define KMSG_COMPONENT "sclp_sdias"
+#define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
+
 #include <linux/sched.h>
 #include <asm/sclp.h>
 #include <asm/debug.h>
 #include <asm/ipl.h>
+
 #include "sclp.h"
 #include "sclp_rw.h"
 
 #define TRACE(x...) debug_sprintf_event(sdias_dbf, 1, x)
-#define ERROR_MSG(x...) printk ( KERN_ALERT "SDIAS: " x )
 
 #define SDIAS_RETRIES 300
 #define SDIAS_SLEEP_TICKS 50
@@ -131,7 +134,7 @@ int sclp_sdias_blk_count(void)
 
 	rc = sdias_sclp_send(&request);
 	if (rc) {
-		ERROR_MSG("sclp_send failed for get_nr_blocks\n");
+		pr_err("sclp_send failed for get_nr_blocks\n");
 		goto out;
 	}
 	if (sccb.hdr.response_code != 0x0020) {
@@ -145,7 +148,8 @@ int sclp_sdias_blk_count(void)
 			rc = sccb.evbuf.blk_cnt;
 			break;
 		default:
-			ERROR_MSG("SCLP error: %x\n", sccb.evbuf.event_status);
+			pr_err("SCLP error: %x\n",
+			       sccb.evbuf.event_status);
 			rc = -EIO;
 			goto out;
 	}
@@ -201,7 +205,7 @@ int sclp_sdias_copy(void *dest, int star
 
 	rc = sdias_sclp_send(&request);
 	if (rc) {
-		ERROR_MSG("sclp_send failed: %x\n", rc);
+		pr_err("sclp_send failed: %x\n", rc);
 		goto out;
 	}
 	if (sccb.hdr.response_code != 0x0020) {
@@ -219,9 +223,9 @@ int sclp_sdias_copy(void *dest, int star
 		case EVSTATE_NO_DATA:
 			TRACE("no data\n");
 		default:
-			ERROR_MSG("Error from SCLP while copying hsa. "
-				  "Event status = %x\n",
-				sccb.evbuf.event_status);
+			pr_err("Error from SCLP while copying hsa. "
+			       "Event status = %x\n",
+			       sccb.evbuf.event_status);
 			rc = -EIO;
 	}
 out:

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
