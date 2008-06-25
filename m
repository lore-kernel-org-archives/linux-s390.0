Return-Path: <linux-kernel-owner+w=401wt.eu-S1759023AbYFYOjw@vger.kernel.org>
Message-Id: <20080625143613.141370129@de.ibm.com>
References: <20080625143459.100139455@de.ibm.com>
Date: Wed, 25 Jun 2008 16:35:06 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 07/21] Cleanup sclp printk messages.
Content-Disposition: inline; filename=806-printk-sclp.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/sclp.c         |    8 +++-----
 drivers/s390/char/sclp_con.c     |    2 --
 drivers/s390/char/sclp_config.c  |    4 +---
 drivers/s390/char/sclp_cpi_sys.c |   12 ++----------
 drivers/s390/char/sclp_quiesce.c |    8 +-------
 drivers/s390/char/sclp_rw.c      |    2 --
 drivers/s390/char/sclp_sdias.c   |    4 +---
 drivers/s390/char/sclp_tty.c     |    8 --------
 drivers/s390/char/sclp_vt220.c   |    7 +------
 9 files changed, 9 insertions(+), 46 deletions(-)

Index: quilt-2.6/drivers/s390/char/sclp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp.c
+++ quilt-2.6/drivers/s390/char/sclp.c
@@ -784,11 +784,9 @@ sclp_check_handler(__u16 code)
 	/* Is this the interrupt we are waiting for? */
 	if (finished_sccb == 0)
 		return;
-	if (finished_sccb != (u32) (addr_t) sclp_init_sccb) {
-		printk(KERN_WARNING SCLP_HEADER "unsolicited interrupt "
-		       "for buffer at 0x%x\n", finished_sccb);
-		return;
-	}
+	if (finished_sccb != (u32) (addr_t) sclp_init_sccb)
+		panic("sclp: unsolicited interrupt for buffer at 0x%x\n",
+		      finished_sccb);
 	spin_lock(&sclp_lock);
 	if (sclp_running_state == sclp_running_state_running) {
 		sclp_init_req.status = SCLP_REQ_DONE;
Index: quilt-2.6/drivers/s390/char/sclp_con.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_con.c
+++ quilt-2.6/drivers/s390/char/sclp_con.c
@@ -20,8 +20,6 @@
 #include "sclp_rw.h"
 #include "sclp_tty.h"
 
-#define SCLP_CON_PRINT_HEADER "sclp console driver: "
-
 #define sclp_console_major 4		/* TTYAUX_MAJOR */
 #define sclp_console_minor 64
 #define sclp_console_name  "ttyS"
Index: quilt-2.6/drivers/s390/char/sclp_config.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_config.c
+++ quilt-2.6/drivers/s390/char/sclp_config.c
@@ -74,10 +74,8 @@ static int __init sclp_conf_init(void)
 	INIT_WORK(&sclp_cpu_change_work, sclp_cpu_change_notify);
 
 	rc = sclp_register(&sclp_conf_register);
-	if (rc) {
-		printk(KERN_ERR TAG "failed to register (%d).\n", rc);
+	if (rc)
 		return rc;
-	}
 
 	if (!(sclp_conf_register.sclp_send_mask & EVTYP_CONFMGMDATA_MASK)) {
 		printk(KERN_WARNING TAG "no configuration management.\n");
Index: quilt-2.6/drivers/s390/char/sclp_cpi_sys.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_cpi_sys.c
+++ quilt-2.6/drivers/s390/char/sclp_cpi_sys.c
@@ -126,21 +126,15 @@ static int cpi_req(void)
 	int response;
 
 	rc = sclp_register(&sclp_cpi_event);
-	if (rc) {
-		printk(KERN_WARNING "cpi: could not register "
-			"to hardware console.\n");
+	if (rc)
 		goto out;
-	}
 	if (!(sclp_cpi_event.sclp_receive_mask & EVTYP_CTLPROGIDENT_MASK)) {
-		printk(KERN_WARNING "cpi: no control program "
-			"identification support\n");
 		rc = -EOPNOTSUPP;
 		goto out_unregister;
 	}
 
 	req = cpi_prepare_req();
 	if (IS_ERR(req)) {
-		printk(KERN_WARNING "cpi: could not allocate request\n");
 		rc = PTR_ERR(req);
 		goto out_unregister;
 	}
@@ -150,10 +144,8 @@ static int cpi_req(void)
 
 	/* Add request to sclp queue */
 	rc = sclp_add_request(req);
-	if (rc) {
-		printk(KERN_WARNING "cpi: could not start request\n");
+	if (rc)
 		goto out_free_req;
-	}
 
 	wait_for_completion(&completion);
 
Index: quilt-2.6/drivers/s390/char/sclp_quiesce.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_quiesce.c
+++ quilt-2.6/drivers/s390/char/sclp_quiesce.c
@@ -51,13 +51,7 @@ static struct sclp_register sclp_quiesce
 static int __init
 sclp_quiesce_init(void)
 {
-	int rc;
-
-	rc = sclp_register(&sclp_quiesce_event);
-	if (rc)
-		printk(KERN_WARNING "sclp: could not register quiesce handler "
-		       "(rc=%d)\n", rc);
-	return rc;
+	return sclp_register(&sclp_quiesce_event);
 }
 
 module_init(sclp_quiesce_init);
Index: quilt-2.6/drivers/s390/char/sclp_rw.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_rw.c
+++ quilt-2.6/drivers/s390/char/sclp_rw.c
@@ -19,8 +19,6 @@
 #include "sclp.h"
 #include "sclp_rw.h"
 
-#define SCLP_RW_PRINT_HEADER "sclp low level driver: "
-
 /*
  * The room for the SCCB (only for writing) is not equal to a pages size
  * (as it is specified as the maximum size in the SCLP documentation)
Index: quilt-2.6/drivers/s390/char/sclp_sdias.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_sdias.c
+++ quilt-2.6/drivers/s390/char/sclp_sdias.c
@@ -239,10 +239,8 @@ int __init sclp_sdias_init(void)
 	debug_register_view(sdias_dbf, &debug_sprintf_view);
 	debug_set_level(sdias_dbf, 6);
 	rc = sclp_register(&sclp_sdias_register);
-	if (rc) {
-		ERROR_MSG("sclp register failed\n");
+	if (rc)
 		return rc;
-	}
 	init_waitqueue_head(&sdias_wq);
 	TRACE("init done\n");
 	return 0;
Index: quilt-2.6/drivers/s390/char/sclp_tty.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_tty.c
+++ quilt-2.6/drivers/s390/char/sclp_tty.c
@@ -25,8 +25,6 @@
 #include "sclp_rw.h"
 #include "sclp_tty.h"
 
-#define SCLP_TTY_PRINT_HEADER "sclp tty driver: "
-
 /*
  * size of a buffer that collects single characters coming in
  * via sclp_tty_put_char()
@@ -736,9 +734,6 @@ sclp_tty_init(void)
 
 	rc = sclp_rw_init();
 	if (rc) {
-		printk(KERN_ERR SCLP_TTY_PRINT_HEADER
-		       "could not register tty - "
-		       "sclp_rw_init returned %d\n", rc);
 		put_tty_driver(driver);
 		return rc;
 	}
@@ -792,9 +787,6 @@ sclp_tty_init(void)
 	tty_set_operations(driver, &sclp_ops);
 	rc = tty_register_driver(driver);
 	if (rc) {
-		printk(KERN_ERR SCLP_TTY_PRINT_HEADER
-		       "could not register tty - "
-		       "tty_register_driver returned %d\n", rc);
 		put_tty_driver(driver);
 		return rc;
 	}
Index: quilt-2.6/drivers/s390/char/sclp_vt220.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_vt220.c
+++ quilt-2.6/drivers/s390/char/sclp_vt220.c
@@ -27,7 +27,6 @@
 #include <asm/uaccess.h>
 #include "sclp.h"
 
-#define SCLP_VT220_PRINT_HEADER 	"sclp vt220 tty driver: "
 #define SCLP_VT220_MAJOR		TTY_MAJOR
 #define SCLP_VT220_MINOR		65
 #define SCLP_VT220_DRIVER_NAME		"sclp_vt220"
@@ -716,12 +715,8 @@ static int __init sclp_vt220_tty_init(vo
 	tty_set_operations(driver, &sclp_vt220_ops);
 
 	rc = tty_register_driver(driver);
-	if (rc) {
-		printk(KERN_ERR SCLP_VT220_PRINT_HEADER
-		       "could not register tty - "
-		       "tty_register_driver returned %d\n", rc);
+	if (rc)
 		goto out_init;
-	}
 	sclp_vt220_driver = driver;
 	return 0;
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
