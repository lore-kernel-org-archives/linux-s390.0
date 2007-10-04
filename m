Return-Path: <linux-kernel-owner+w=401wt.eu-S1758743AbXJDLdz@vger.kernel.org>
Message-Id: <20071004112830.296155736@de.ibm.com>
References: <20071004112706.574737175@de.ibm.com>
Date: Thu, 04 Oct 2007 13:27:27 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 21/34] Get rid of a bunch of sparse warnings again.
Content-Disposition: inline; filename=021-sparse.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Also removes a bunch of ^L in drivers/s390/cio/cmf.c

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/audit.c        |    7 +------
 arch/s390/kernel/audit.h        |   15 +++++++++++++++
 arch/s390/kernel/compat_audit.c |    1 +
 drivers/s390/char/con3270.c     |    3 +--
 drivers/s390/char/sclp.c        |    5 ++---
 drivers/s390/char/tty3270.c     |    9 ++++++---
 drivers/s390/char/tty3270.h     |   16 ++++++++++++++++
 drivers/s390/cio/chp.c          |    8 ++++++--
 drivers/s390/cio/cmf.c          |    4 +---
 drivers/s390/scsi/zfcp_dbf.c    |   10 +++++-----
 drivers/s390/scsi/zfcp_erp.c    |   18 ++++++++----------
 11 files changed, 62 insertions(+), 34 deletions(-)

Index: quilt-2.6/arch/s390/kernel/audit.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/audit.c
+++ quilt-2.6/arch/s390/kernel/audit.c
@@ -2,6 +2,7 @@
 #include <linux/types.h>
 #include <linux/audit.h>
 #include <asm/unistd.h>
+#include "audit.h"
 
 static unsigned dir_class[] = {
 #include <asm-generic/audit_dir_write.h>
@@ -40,7 +41,6 @@ int audit_classify_arch(int arch)
 int audit_classify_syscall(int abi, unsigned syscall)
 {
 #ifdef CONFIG_COMPAT
-	extern int s390_classify_syscall(unsigned);
 	if (abi == AUDIT_ARCH_S390)
 		return s390_classify_syscall(syscall);
 #endif
@@ -61,11 +61,6 @@ int audit_classify_syscall(int abi, unsi
 static int __init audit_classes_init(void)
 {
 #ifdef CONFIG_COMPAT
-	extern __u32 s390_dir_class[];
-	extern __u32 s390_write_class[];
-	extern __u32 s390_read_class[];
-	extern __u32 s390_chattr_class[];
-	extern __u32 s390_signal_class[];
 	audit_register_class(AUDIT_CLASS_WRITE_32, s390_write_class);
 	audit_register_class(AUDIT_CLASS_READ_32, s390_read_class);
 	audit_register_class(AUDIT_CLASS_DIR_WRITE_32, s390_dir_class);
Index: quilt-2.6/arch/s390/kernel/audit.h
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/audit.h
@@ -0,0 +1,15 @@
+#ifndef __ARCH_S390_KERNEL_AUDIT_H
+#define __ARCH_S390_KERNEL_AUDIT_H
+
+#include <linux/types.h>
+
+#ifdef CONFIG_COMPAT
+extern int s390_classify_syscall(unsigned);
+extern __u32 s390_dir_class[];
+extern __u32 s390_write_class[];
+extern __u32 s390_read_class[];
+extern __u32 s390_chattr_class[];
+extern __u32 s390_signal_class[];
+#endif /* CONFIG_COMPAT */
+
+#endif /* __ARCH_S390_KERNEL_AUDIT_H */
Index: quilt-2.6/arch/s390/kernel/compat_audit.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/compat_audit.c
+++ quilt-2.6/arch/s390/kernel/compat_audit.c
@@ -1,5 +1,6 @@
 #undef __s390x__
 #include <asm/unistd.h>
+#include "audit.h"
 
 unsigned s390_dir_class[] = {
 #include <asm-generic/audit_dir_write.h>
Index: quilt-2.6/drivers/s390/char/con3270.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/con3270.c
+++ quilt-2.6/drivers/s390/char/con3270.c
@@ -22,6 +22,7 @@
 #include <asm/ebcdic.h>
 
 #include "raw3270.h"
+#include "tty3270.h"
 #include "ctrlchar.h"
 
 #define CON3270_OUTPUT_BUFFER_SIZE 1024
@@ -507,8 +508,6 @@ con3270_write(struct console *co, const 
 	spin_unlock_irqrestore(&cp->view.lock,flags);
 }
 
-extern struct tty_driver *tty3270_driver;
-
 static struct tty_driver *
 con3270_device(struct console *c, int *index)
 {
Index: quilt-2.6/drivers/s390/char/sclp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp.c
+++ quilt-2.6/drivers/s390/char/sclp.c
@@ -93,6 +93,7 @@ static volatile enum sclp_mask_state_t {
 #define SCLP_RETRY_INTERVAL	30
 
 static void sclp_process_queue(void);
+static void __sclp_make_read_req(void);
 static int sclp_init_mask(int calculate);
 static int sclp_init(void);
 
@@ -115,7 +116,6 @@ sclp_service_call(sclp_cmdw_t command, v
 	return 0;
 }
 
-static inline void __sclp_make_read_req(void);
 
 static void
 __sclp_queue_read_req(void)
@@ -318,8 +318,7 @@ sclp_read_cb(struct sclp_req *req, void 
 }
 
 /* Prepare read event data request. Called while sclp_lock is locked. */
-static inline void
-__sclp_make_read_req(void)
+static void __sclp_make_read_req(void)
 {
 	struct sccb_header *sccb;
 
Index: quilt-2.6/drivers/s390/char/tty3270.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tty3270.c
+++ quilt-2.6/drivers/s390/char/tty3270.c
@@ -25,8 +25,8 @@
 #include <asm/ebcdic.h>
 #include <asm/uaccess.h>
 
-
 #include "raw3270.h"
+#include "tty3270.h"
 #include "keyboard.h"
 
 #define TTY3270_CHAR_BUF_SIZE 256
@@ -1338,8 +1338,11 @@ tty3270_getpar(struct tty3270 *tp, int i
 static void
 tty3270_goto_xy(struct tty3270 *tp, int cx, int cy)
 {
-	tp->cx = min_t(int, tp->view.cols - 1, max_t(int, 0, cx));
-	cy = min_t(int, tp->view.rows - 3, max_t(int, 0, cy));
+	int max_cx = max(0, cx);
+	int max_cy = max(0, cy);
+
+	tp->cx = min_t(int, tp->view.cols - 1, max_cx);
+	cy = min_t(int, tp->view.rows - 3, max_cy);
 	if (cy != tp->cy) {
 		tty3270_convert_line(tp, tp->cy);
 		tp->cy = cy;
Index: quilt-2.6/drivers/s390/char/tty3270.h
===================================================================
--- /dev/null
+++ quilt-2.6/drivers/s390/char/tty3270.h
@@ -0,0 +1,16 @@
+/*
+ *  drivers/s390/char/tty3270.h
+ *
+ *    Copyright IBM Corp. 2007
+ *
+ */
+
+#ifndef __DRIVERS_S390_CHAR_TTY3270_H
+#define __DRIVERS_S390_CHAR_TTY3270_H
+
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+
+extern struct tty_driver *tty3270_driver;
+
+#endif /* __DRIVERS_S390_CHAR_TTY3270_H */
Index: quilt-2.6/drivers/s390/cio/chp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.c
+++ quilt-2.6/drivers/s390/cio/chp.c
@@ -140,9 +140,11 @@ static ssize_t chp_measurement_chars_rea
 					  char *buf, loff_t off, size_t count)
 {
 	struct channel_path *chp;
+	struct device *device;
 	unsigned int size;
 
-	chp = to_channelpath(container_of(kobj, struct device, kobj));
+	device = container_of(kobj, struct device, kobj);
+	chp = to_channelpath(device);
 	if (!chp->cmg_chars)
 		return 0;
 
@@ -193,9 +195,11 @@ static ssize_t chp_measurement_read(stru
 {
 	struct channel_path *chp;
 	struct channel_subsystem *css;
+	struct device *device;
 	unsigned int size;
 
-	chp = to_channelpath(container_of(kobj, struct device, kobj));
+	device = container_of(kobj, struct device, kobj);
+	chp = to_channelpath(device);
 	css = to_css(chp->dev.parent);
 
 	size = sizeof(struct cmg_entry);
Index: quilt-2.6/drivers/s390/cio/cmf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cmf.c
+++ quilt-2.6/drivers/s390/cio/cmf.c
@@ -489,7 +489,6 @@ static struct cmb_area cmb_area = {
 	.num_channels  = 1024,
 };
 
-
 /* ****** old style CMB handling ********/
 
 /*
@@ -812,7 +811,7 @@ static struct cmb_operations cmbops_basi
 	.align	    = align_cmb,
 	.attr_group = &cmf_attr_group,
 };
-
+
 /* ******** extended cmb handling ********/
 
 /**
@@ -1079,7 +1078,6 @@ static struct cmb_operations cmbops_exte
 	.align	    = align_cmbe,
 	.attr_group = &cmf_attr_group_ext,
 };
-
 
 static ssize_t cmb_show_attr(struct device *dev, char *buf, enum cmb_index idx)
 {
Index: quilt-2.6/drivers/s390/scsi/zfcp_dbf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_dbf.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_dbf.c
@@ -19,8 +19,8 @@
  * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
  */
 
-#include <asm/debug.h>
 #include <linux/ctype.h>
+#include <asm/debug.h>
 #include "zfcp_ext.h"
 
 static u32 dbfsize = 4;
@@ -35,17 +35,17 @@ static int
 zfcp_dbf_stck(char *out_buf, const char *label, unsigned long long stck)
 {
 	unsigned long long sec;
-	struct timespec xtime;
+	struct timespec dbftime;
 	int len = 0;
 
 	stck -= 0x8126d60e46000000LL - (0x3c26700LL * 1000000 * 4096);
 	sec = stck >> 12;
 	do_div(sec, 1000000);
-	xtime.tv_sec = sec;
+	dbftime.tv_sec = sec;
 	stck -= (sec * 1000000) << 12;
-	xtime.tv_nsec = ((stck * 1000) >> 12);
+	dbftime.tv_nsec = ((stck * 1000) >> 12);
 	len += sprintf(out_buf + len, "%-24s%011lu:%06lu\n",
-		       label, xtime.tv_sec, xtime.tv_nsec);
+		       label, dbftime.tv_sec, dbftime.tv_nsec);
 
 	return len;
 }
Index: quilt-2.6/drivers/s390/scsi/zfcp_erp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_erp.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_erp.c
@@ -54,7 +54,7 @@ static int zfcp_erp_strategy_check_adapt
 static int zfcp_erp_strategy_statechange(int, u32, struct zfcp_adapter *,
 					 struct zfcp_port *,
 					 struct zfcp_unit *, int);
-static inline int zfcp_erp_strategy_statechange_detected(atomic_t *, u32);
+static int zfcp_erp_strategy_statechange_detected(atomic_t *, u32);
 static int zfcp_erp_strategy_followup_actions(int, struct zfcp_adapter *,
 					      struct zfcp_port *,
 					      struct zfcp_unit *, int);
@@ -106,8 +106,8 @@ static void zfcp_erp_action_cleanup(int,
 static void zfcp_erp_action_ready(struct zfcp_erp_action *);
 static int  zfcp_erp_action_exists(struct zfcp_erp_action *);
 
-static inline void zfcp_erp_action_to_ready(struct zfcp_erp_action *);
-static inline void zfcp_erp_action_to_running(struct zfcp_erp_action *);
+static void zfcp_erp_action_to_ready(struct zfcp_erp_action *);
+static void zfcp_erp_action_to_running(struct zfcp_erp_action *);
 
 static void zfcp_erp_memwait_handler(unsigned long);
 
@@ -952,7 +952,7 @@ zfcp_erp_memwait_handler(unsigned long d
  *		action gets an appropriate flag and will be processed
  *		accordingly
  */
-void zfcp_erp_timeout_handler(unsigned long data)
+static void zfcp_erp_timeout_handler(unsigned long data)
 {
 	struct zfcp_erp_action *erp_action = (struct zfcp_erp_action *) data;
 	struct zfcp_adapter *adapter = erp_action->adapter;
@@ -1491,7 +1491,7 @@ zfcp_erp_strategy_statechange(int action
 	return retval;
 }
 
-static inline int
+static int
 zfcp_erp_strategy_statechange_detected(atomic_t * target_status, u32 erp_status)
 {
 	return
@@ -2001,7 +2001,7 @@ zfcp_erp_adapter_strategy_generic(struct
  * returns:	0 - successful setup
  *		!0 - failed setup
  */
-int
+static int
 zfcp_erp_adapter_strategy_open_qdio(struct zfcp_erp_action *erp_action)
 {
 	int retval;
@@ -3248,8 +3248,7 @@ static void zfcp_erp_action_dismiss_unit
 		zfcp_erp_action_dismiss(&unit->erp_action);
 }
 
-static inline void
-zfcp_erp_action_to_running(struct zfcp_erp_action *erp_action)
+static void zfcp_erp_action_to_running(struct zfcp_erp_action *erp_action)
 {
 	struct zfcp_adapter *adapter = erp_action->adapter;
 
@@ -3258,8 +3257,7 @@ zfcp_erp_action_to_running(struct zfcp_e
 	list_move(&erp_action->list, &erp_action->adapter->erp_running_head);
 }
 
-static inline void
-zfcp_erp_action_to_ready(struct zfcp_erp_action *erp_action)
+static void zfcp_erp_action_to_ready(struct zfcp_erp_action *erp_action)
 {
 	struct zfcp_adapter *adapter = erp_action->adapter;
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
