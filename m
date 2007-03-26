Return-Path: <linux-kernel-owner+w=401wt.eu-S932469AbXCZV0l@vger.kernel.org>
Message-Id: <20070326212634.931820139@de.ibm.com>
References: <20070326212459.711271424@de.ibm.com>
Date: Mon, 26 Mar 2007 23:25:00 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [patch 1/8] Processor degredation support.
Content-Disposition: inline; filename=109-cpu-degradation.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Emit a warning if cpu capability changes e.g. because the cpus are
overheating. The new cpu capability can be read via /proc/sysinfo.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 drivers/s390/char/Makefile       |    2 -
 drivers/s390/char/sclp.h         |    2 +
 drivers/s390/char/sclp_confmgm.c |   57 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/s390/char/Makefile
===================================================================
--- linux-2.6.orig/drivers/s390/char/Makefile
+++ linux-2.6/drivers/s390/char/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-y += ctrlchar.o keyboard.o defkeymap.o sclp.o sclp_rw.o sclp_quiesce.o \
-	 sclp_info.o
+	 sclp_info.o sclp_confmgm.o
 
 obj-$(CONFIG_TN3270) += raw3270.o
 obj-$(CONFIG_TN3270_CONSOLE) += con3270.o
Index: linux-2.6/drivers/s390/char/sclp_confmgm.c
===================================================================
--- /dev/null
+++ linux-2.6/drivers/s390/char/sclp_confmgm.c
@@ -0,0 +1,57 @@
+/*
+ *  drivers/s390/char/sclp_confmgm.c
+ *
+ *    Copyright IBM Corp. 2007
+ *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>
+ */
+
+#include <linux/init.h>
+#include <linux/errno.h>
+#include "sclp.h"
+
+#define SCLP_CONFMGM_PRINT_HEADER	"sclp_confmgm: "
+
+struct conf_mgm_data {
+	u8 reserved;
+	u8 ev_qualifier;
+} __attribute__((packed));
+
+#define EV_QUAL_CAP_CHANGE	3
+
+static void sclp_conf_receiver_fn(struct evbuf_header *evbuf)
+{
+	struct conf_mgm_data *cdata;
+
+	cdata = (struct conf_mgm_data *)(evbuf + 1);
+	if (cdata->ev_qualifier == EV_QUAL_CAP_CHANGE)
+		/* Will be parsed. Don't change. */
+		printk(KERN_WARNING "sclp: CPU capability changed.\n");
+}
+
+static struct sclp_register sclp_conf_register =
+{
+	.receive_mask = EvTyp_ConfMgmData_Mask,
+	.receiver_fn  = sclp_conf_receiver_fn,
+};
+
+static int __init sclp_conf_init(void)
+{
+	int rc;
+
+	rc = sclp_register(&sclp_conf_register);
+	if (rc) {
+		printk(KERN_ERR SCLP_CONFMGM_PRINT_HEADER
+		       "failed to register (%d).\n", rc);
+		return rc;
+	}
+
+	if (!(sclp_conf_register.sclp_receive_mask & EvTyp_ConfMgmData_Mask)) {
+		printk(KERN_WARNING SCLP_CONFMGM_PRINT_HEADER
+		       "no configuration management.\n");
+		sclp_unregister(&sclp_conf_register);
+		rc = -ENOSYS;
+	}
+	return rc;
+}
+
+__initcall(sclp_conf_init);
Index: linux-2.6/drivers/s390/char/sclp.h
===================================================================
--- linux-2.6.orig/drivers/s390/char/sclp.h
+++ linux-2.6/drivers/s390/char/sclp.h
@@ -27,6 +27,7 @@
 #define EvTyp_CntlProgIdent	0x0B
 #define EvTyp_SigQuiesce	0x1D
 #define EvTyp_VT220Msg		0x1A
+#define EvTyp_ConfMgmData	0x04
 
 #define EvTyp_OpCmd_Mask	0x80000000
 #define EvTyp_Msg_Mask		0x40000000
@@ -36,6 +37,7 @@
 #define EvTyp_CtlProgIdent_Mask	0x00200000
 #define EvTyp_SigQuiesce_Mask	0x00000008
 #define EvTyp_VT220Msg_Mask	0x00000040
+#define EvTyp_ConfMgmData_Mask	0x10000000
 
 #define GnrlMsgFlgs_DOM		0x8000
 #define GnrlMsgFlgs_SndAlrm	0x4000

-- 
