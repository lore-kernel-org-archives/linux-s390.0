Return-Path: <linux-kernel-owner+w=401wt.eu-S1758817AbYGAMxt@vger.kernel.org>
Message-Id: <20080701124958.332464747@de.ibm.com>
References: <20080701124809.319736054@de.ibm.com>
Date: Tue, 01 Jul 2008 14:48:13 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/14] cio: introduce isc_(un)register functions.
Content-Disposition: inline; filename=123-cio-isc-reg.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Sebastian Ott <sebott@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

This interface makes it easy for drivers to register usage of different
I/O interruption subclasses without needing to worry about possible
other users of the same isc.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/cio/Makefile |    4 +-
 drivers/s390/cio/isc.c    |   68 ++++++++++++++++++++++++++++++++++++++++++++++
 include/asm-s390/isc.h    |    6 ++++
 3 files changed, 76 insertions(+), 2 deletions(-)

Index: quilt-2.6/drivers/s390/cio/isc.c
===================================================================
--- /dev/null
+++ quilt-2.6/drivers/s390/cio/isc.c
@@ -0,0 +1,68 @@
+/*
+ * Functions for registration of I/O interruption subclasses on s390.
+ *
+ * Copyright IBM Corp. 2008
+ * Authors: Sebastian Ott <sebott@linux.vnet.ibm.com>
+ */
+
+#include <linux/spinlock.h>
+#include <linux/module.h>
+#include <asm/isc.h>
+
+static unsigned int isc_refs[MAX_ISC + 1];
+static DEFINE_SPINLOCK(isc_ref_lock);
+
+
+/**
+ * isc_register - register an I/O interruption subclass.
+ * @isc: I/O interruption subclass to register
+ *
+ * The number of users for @isc is increased. If this is the first user to
+ * register @isc, the corresponding I/O interruption subclass mask is enabled.
+ *
+ * Context:
+ *   This function must not be called in interrupt context.
+ */
+void isc_register(unsigned int isc)
+{
+	if (isc > MAX_ISC) {
+		WARN_ON(1);
+		return;
+	}
+
+	spin_lock(&isc_ref_lock);
+	if (isc_refs[isc] == 0)
+		ctl_set_bit(6, 31 - isc);
+	isc_refs[isc]++;
+	spin_unlock(&isc_ref_lock);
+}
+EXPORT_SYMBOL_GPL(isc_register);
+
+/**
+ * isc_unregister - unregister an I/O interruption subclass.
+ * @isc: I/O interruption subclass to unregister
+ *
+ * The number of users for @isc is decreased. If this is the last user to
+ * unregister @isc, the corresponding I/O interruption subclass mask is
+ * disabled.
+ * Note: This function must not be called if isc_register() hasn't been called
+ * before by the driver for @isc.
+ *
+ * Context:
+ *   This function must not be called in interrupt context.
+ */
+void isc_unregister(unsigned int isc)
+{
+	spin_lock(&isc_ref_lock);
+	/* check for misuse */
+	if (isc > MAX_ISC || isc_refs[isc] == 0) {
+		WARN_ON(1);
+		goto out_unlock;
+	}
+	if (isc_refs[isc] == 1)
+		ctl_clear_bit(6, 31 - isc);
+	isc_refs[isc]--;
+out_unlock:
+	spin_unlock(&isc_ref_lock);
+}
+EXPORT_SYMBOL_GPL(isc_unregister);
Index: quilt-2.6/drivers/s390/cio/Makefile
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/Makefile
+++ quilt-2.6/drivers/s390/cio/Makefile
@@ -2,8 +2,8 @@
 # Makefile for the S/390 common i/o drivers
 #
 
-obj-y += airq.o blacklist.o chsc.o cio.o css.o chp.o idset.o scsw.o fcx.o \
-	 itcw.o
+obj-y += airq.o blacklist.o chsc.o cio.o css.o chp.o idset.o isc.o scsw.o \
+	fcx.o itcw.o
 ccw_device-objs += device.o device_fsm.o device_ops.o
 ccw_device-objs += device_id.o device_pgid.o device_status.o
 obj-y += ccw_device.o cmf.o
Index: quilt-2.6/include/asm-s390/isc.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/isc.h
+++ quilt-2.6/include/asm-s390/isc.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_S390_ISC_H
 #define _ASM_S390_ISC_H
 
+#include <linux/types.h>
+
 /*
  * I/O interruption subclasses used by drivers.
  * Please add all used iscs here so that it is possible to distribute
@@ -15,4 +17,8 @@
 /* Adapter interrupts. */
 #define QDIO_AIRQ_ISC IO_SCH_ISC	/* I/O subchannel in qdio mode */
 
+/* Functions for registration of I/O interruption subclasses */
+void isc_register(unsigned int isc);
+void isc_unregister(unsigned int isc);
+
 #endif /* _ASM_S390_ISC_H */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
