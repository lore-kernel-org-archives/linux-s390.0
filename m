Return-Path: <linux-kernel-owner+w=401wt.eu-S1761925AbXHVMes@vger.kernel.org>
Message-Id: <20070822123642.997474076@de.ibm.com>
References: <20070822123603.501231302@de.ibm.com>
Date: Wed, 22 Aug 2007 14:36:08 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/10] vmur: fix diag14 exceptions with addresses > 2GB.
Content-Disposition: inline; filename=005-vmur-diags.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Michael Holzheu <holzheu@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@de.ibm.com>

There are several s390 diagnose calls, which must be executed below the
2GB memory boundary. In order to enforce this, those diagnoses must be
compiled into the kernel. Currently diag 14 can be called within the
vmur kernel module from addresses above 2GB. This leads to specification
exceptions. This patch moves diag10, diag14 and diag210 into the new
diag.c file.

Signed-off-by: Michael Holzheu <holzheu@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/Makefile      |    2 
 arch/s390/kernel/diag.c        |  102 +++++++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/s390_ksyms.c  |    1 
 arch/s390/mm/cmm.c             |    1 
 arch/s390/mm/init.c            |   17 ------
 drivers/s390/block/dasd_diag.c |    1 
 drivers/s390/char/raw3270.c    |    1 
 drivers/s390/char/vmur.c       |   32 +-----------
 drivers/s390/cio/device_id.c   |   48 -------------------
 include/asm-s390/cio.h         |   15 ------
 include/asm-s390/diag.h        |   39 +++++++++++++++
 include/asm-s390/pgalloc.h     |    2 
 12 files changed, 150 insertions(+), 111 deletions(-)

Index: quilt-2.6/arch/s390/kernel/diag.c
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/diag.c
@@ -0,0 +1,102 @@
+/*
+ * Implementation of s390 diagnose codes
+ *
+ * Copyright IBM Corp. 2007
+ * Author(s): Michael Holzheu <holzheu@de.ibm.com>
+ */
+
+#include <linux/module.h>
+#include <asm/diag.h>
+
+/*
+ * Diagnose 10: Release pages
+ */
+void diag10(unsigned long addr)
+{
+	if (addr >= 0x7ff00000)
+		return;
+	asm volatile(
+#ifdef CONFIG_64BIT
+		"	sam31\n"
+		"	diag	%0,%0,0x10\n"
+		"0:	sam64\n"
+#else
+		"	diag	%0,%0,0x10\n"
+		"0:\n"
+#endif
+		EX_TABLE(0b, 0b)
+		: : "a" (addr));
+}
+EXPORT_SYMBOL(diag10);
+
+/*
+ * Diagnose 14: Input spool file manipulation
+ */
+int diag14(unsigned long rx, unsigned long ry1, unsigned long subcode)
+{
+	register unsigned long _ry1 asm("2") = ry1;
+	register unsigned long _ry2 asm("3") = subcode;
+	int rc = 0;
+
+	asm volatile(
+#ifdef CONFIG_64BIT
+		"   sam31\n"
+		"   diag    %2,2,0x14\n"
+		"   sam64\n"
+#else
+		"   diag    %2,2,0x14\n"
+#endif
+		"   ipm     %0\n"
+		"   srl     %0,28\n"
+		: "=d" (rc), "+d" (_ry2)
+		: "d" (rx), "d" (_ry1)
+		: "cc");
+
+	return rc;
+}
+EXPORT_SYMBOL(diag14);
+
+/*
+ * Diagnose 210: Get information about a virtual device
+ */
+int diag210(struct diag210 *addr)
+{
+	/*
+	 * diag 210 needs its data below the 2GB border, so we
+	 * use a static data area to be sure
+	 */
+	static struct diag210 diag210_tmp;
+	static DEFINE_SPINLOCK(diag210_lock);
+	unsigned long flags;
+	int ccode;
+
+	spin_lock_irqsave(&diag210_lock, flags);
+	diag210_tmp = *addr;
+
+#ifdef CONFIG_64BIT
+	asm volatile(
+		"	lhi	%0,-1\n"
+		"	sam31\n"
+		"	diag	%1,0,0x210\n"
+		"0:	ipm	%0\n"
+		"	srl	%0,28\n"
+		"1:	sam64\n"
+		EX_TABLE(0b, 1b)
+		: "=&d" (ccode) : "a" (&diag210_tmp) : "cc", "memory");
+#else
+	asm volatile(
+		"	lhi	%0,-1\n"
+		"	diag	%1,0,0x210\n"
+		"0:	ipm	%0\n"
+		"	srl	%0,28\n"
+		"1:\n"
+		EX_TABLE(0b, 1b)
+		: "=&d" (ccode) : "a" (&diag210_tmp) : "cc", "memory");
+#endif
+
+	*addr = diag210_tmp;
+	spin_unlock_irqrestore(&diag210_lock, flags);
+
+	return ccode;
+}
+EXPORT_SYMBOL(diag210);
Index: quilt-2.6/arch/s390/kernel/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/Makefile
+++ quilt-2.6/arch/s390/kernel/Makefile
@@ -6,7 +6,7 @@ EXTRA_AFLAGS	:= -traditional
 
 obj-y	:=  bitmap.o traps.o time.o process.o base.o early.o \
             setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
-	    semaphore.o s390_ext.o debug.o irq.o ipl.o dis.o
+	    semaphore.o s390_ext.o debug.o irq.o ipl.o dis.o diag.o
 
 obj-y	+= $(if $(CONFIG_64BIT),entry64.o,entry.o)
 obj-y	+= $(if $(CONFIG_64BIT),reipl64.o,reipl.o)
Index: quilt-2.6/arch/s390/kernel/s390_ksyms.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/s390_ksyms.c
+++ quilt-2.6/arch/s390/kernel/s390_ksyms.c
@@ -25,7 +25,6 @@ EXPORT_SYMBOL(_oi_bitmap);
 EXPORT_SYMBOL(_ni_bitmap);
 EXPORT_SYMBOL(_zb_findmap);
 EXPORT_SYMBOL(_sb_findmap);
-EXPORT_SYMBOL(diag10);
 
 /*
  * semaphore ops
Index: quilt-2.6/arch/s390/mm/cmm.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/cmm.c
+++ quilt-2.6/arch/s390/mm/cmm.c
@@ -20,6 +20,7 @@
 
 #include <asm/pgalloc.h>
 #include <asm/uaccess.h>
+#include <asm/diag.h>
 
 static char *sender = "VMRMSVM";
 module_param(sender, charp, 0400);
Index: quilt-2.6/arch/s390/mm/init.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/init.c
+++ quilt-2.6/arch/s390/mm/init.c
@@ -42,23 +42,6 @@ DEFINE_PER_CPU(struct mmu_gather, mmu_ga
 pgd_t swapper_pg_dir[PTRS_PER_PGD] __attribute__((__aligned__(PAGE_SIZE)));
 char  empty_zero_page[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
 
-void diag10(unsigned long addr)
-{
-        if (addr >= 0x7ff00000)
-                return;
-	asm volatile(
-#ifdef CONFIG_64BIT
-		"	sam31\n"
-		"	diag	%0,%0,0x10\n"
-		"0:	sam64\n"
-#else
-		"	diag	%0,%0,0x10\n"
-		"0:\n"
-#endif
-		EX_TABLE(0b,0b)
-		: : "a" (addr));
-}
-
 void show_mem(void)
 {
 	int i, total = 0, reserved = 0;
Index: quilt-2.6/drivers/s390/block/dasd_diag.c
===================================================================
--- quilt-2.6.orig/drivers/s390/block/dasd_diag.c
+++ quilt-2.6/drivers/s390/block/dasd_diag.c
@@ -24,6 +24,7 @@
 #include <asm/s390_ext.h>
 #include <asm/todclk.h>
 #include <asm/vtoc.h>
+#include <asm/diag.h>
 
 #include "dasd_int.h"
 #include "dasd_diag.h"
Index: quilt-2.6/drivers/s390/char/raw3270.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/raw3270.c
+++ quilt-2.6/drivers/s390/char/raw3270.c
@@ -21,6 +21,7 @@
 #include <asm/ccwdev.h>
 #include <asm/cio.h>
 #include <asm/ebcdic.h>
+#include <asm/diag.h>
 
 #include "raw3270.h"
 
Index: quilt-2.6/drivers/s390/char/vmur.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmur.c
+++ quilt-2.6/drivers/s390/char/vmur.c
@@ -14,6 +14,7 @@
 #include <asm/cio.h>
 #include <asm/ccwdev.h>
 #include <asm/debug.h>
+#include <asm/diag.h>
 
 #include "vmur.h"
 
@@ -379,31 +380,6 @@ static ssize_t ur_write(struct file *fil
 	return do_write(urf->urd, udata, count, urf->dev_reclen, ppos);
 }
 
-static int do_diag_14(unsigned long rx, unsigned long ry1,
-		      unsigned long subcode)
-{
-	register unsigned long _ry1 asm("2") = ry1;
-	register unsigned long _ry2 asm("3") = subcode;
-	int rc = 0;
-
-	asm volatile(
-#ifdef CONFIG_64BIT
-		"   sam31\n"
-		"   diag    %2,2,0x14\n"
-		"   sam64\n"
-#else
-		"   diag    %2,2,0x14\n"
-#endif
-		"   ipm     %0\n"
-		"   srl     %0,28\n"
-		: "=d" (rc), "+d" (_ry2)
-		: "d" (rx), "d" (_ry1)
-		: "cc");
-
-	TRACE("diag 14: subcode=0x%lx, cc=%i\n", subcode, rc);
-	return rc;
-}
-
 /*
  * diagnose code 0x14 subcode 0x0028 - position spool file to designated
  *				       record
@@ -415,7 +391,7 @@ static int diag_position_to_record(int d
 {
 	int cc;
 
-	cc = do_diag_14(record, devno, 0x28);
+	cc = diag14(record, devno, 0x28);
 	switch (cc) {
 	case 0:
 		return 0;
@@ -440,7 +416,7 @@ static int diag_read_file(int devno, cha
 {
 	int cc;
 
-	cc = do_diag_14((unsigned long) buf, devno, 0x00);
+	cc = diag14((unsigned long) buf, devno, 0x00);
 	switch (cc) {
 	case 0:
 		return 0;
@@ -533,7 +509,7 @@ static int diag_read_next_file_info(stru
 {
 	int cc;
 
-	cc = do_diag_14((unsigned long) buf, spid, 0xfff);
+	cc = diag14((unsigned long) buf, spid, 0xfff);
 	switch (cc) {
 	case 0:
 		return 0;
Index: quilt-2.6/drivers/s390/cio/device_id.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_id.c
+++ quilt-2.6/drivers/s390/cio/device_id.c
@@ -17,6 +17,7 @@
 #include <asm/delay.h>
 #include <asm/cio.h>
 #include <asm/lowcore.h>
+#include <asm/diag.h>
 
 #include "cio.h"
 #include "cio_debug.h"
@@ -25,51 +26,6 @@
 #include "ioasm.h"
 
 /*
- * diag210 is used under VM to get information about a virtual device
- */
-int
-diag210(struct diag210 * addr)
-{
-	/*
-	 * diag 210 needs its data below the 2GB border, so we
-	 * use a static data area to be sure
-	 */
-	static struct diag210 diag210_tmp;
-	static DEFINE_SPINLOCK(diag210_lock);
-	unsigned long flags;
-	int ccode;
-
-	spin_lock_irqsave(&diag210_lock, flags);
-	diag210_tmp = *addr;
-
-#ifdef CONFIG_64BIT
-	asm volatile(
-		"	lhi	%0,-1\n"
-		"	sam31\n"
-		"	diag	%1,0,0x210\n"
-		"0:	ipm	%0\n"
-		"	srl	%0,28\n"
-		"1:	sam64\n"
-		EX_TABLE(0b,1b)
-		: "=&d" (ccode) : "a" (&diag210_tmp) : "cc", "memory");
-#else
-	asm volatile(
-		"	lhi	%0,-1\n"
-		"	diag	%1,0,0x210\n"
-		"0:	ipm	%0\n"
-		"	srl	%0,28\n"
-		"1:\n"
-		EX_TABLE(0b,1b)
-		: "=&d" (ccode) : "a" (&diag210_tmp) : "cc", "memory");
-#endif
-
-	*addr = diag210_tmp;
-	spin_unlock_irqrestore(&diag210_lock, flags);
-
-	return ccode;
-}
-
-/*
  * Input :
  *   devno - device number
  *   ps	   - pointer to sense ID data area
@@ -349,5 +305,3 @@ ccw_device_sense_id_irq(struct ccw_devic
 		break;
 	}
 }
-
-EXPORT_SYMBOL(diag210);
Index: quilt-2.6/include/asm-s390/cio.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/cio.h
+++ quilt-2.6/include/asm-s390/cio.h
@@ -258,19 +258,6 @@ struct ciw {
 /* Sick revalidation of device. */
 #define CIO_REVALIDATE 0x0008
 
-struct diag210 {
-	__u16 vrdcdvno : 16;   /* device number (input) */
-	__u16 vrdclen  : 16;   /* data block length (input) */
-	__u32 vrdcvcla : 8;    /* virtual device class (output) */
-	__u32 vrdcvtyp : 8;    /* virtual device type (output) */
-	__u32 vrdcvsta : 8;    /* virtual device status (output) */
-	__u32 vrdcvfla : 8;    /* virtual device flags (output) */
-	__u32 vrdcrccl : 8;    /* real device class (output) */
-	__u32 vrdccrty : 8;    /* real device type (output) */
-	__u32 vrdccrmd : 8;    /* real device model (output) */
-	__u32 vrdccrft : 8;    /* real device feature (output) */
-} __attribute__ ((packed,aligned(4)));
-
 struct ccw_dev_id {
 	u8 ssid;
 	u16 devno;
@@ -285,8 +272,6 @@ static inline int ccw_dev_id_is_equal(st
 	return 0;
 }
 
-extern int diag210(struct diag210 *addr);
-
 extern void wait_cons_dev(void);
 
 extern void css_schedule_reprobe(void);
Index: quilt-2.6/include/asm-s390/diag.h
===================================================================
--- /dev/null
+++ quilt-2.6/include/asm-s390/diag.h
@@ -0,0 +1,39 @@
+/*
+ * s390 diagnose functions
+ *
+ * Copyright IBM Corp. 2007
+ * Author(s): Michael Holzheu <holzheu@de.ibm.com>
+ */
+
+#ifndef _ASM_S390_DIAG_H
+#define _ASM_S390_DIAG_H
+
+/*
+ * Diagnose 10: Release pages
+ */
+extern void diag10(unsigned long addr);
+
+/*
+ * Diagnose 14: Input spool file manipulation
+ */
+extern int diag14(unsigned long rx, unsigned long ry1, unsigned long subcode);
+
+/*
+ * Diagnose 210: Get information about a virtual device
+ */
+struct diag210 {
+	u16 vrdcdvno;	/* device number (input) */
+	u16 vrdclen;	/* data block length (input) */
+	u8 vrdcvcla;	/* virtual device class (output) */
+	u8 vrdcvtyp;	/* virtual device type (output) */
+	u8 vrdcvsta;	/* virtual device status (output) */
+	u8 vrdcvfla;	/* virtual device flags (output) */
+	u8 vrdcrccl;	/* real device class (output) */
+	u8 vrdccrty;	/* real device type (output) */
+	u8 vrdccrmd;	/* real device model (output) */
+	u8 vrdccrft;	/* real device feature (output) */
+} __attribute__((packed, aligned(4)));
+
+extern int diag210(struct diag210 *addr);
+
+#endif /* _ASM_S390_DIAG_H */
Index: quilt-2.6/include/asm-s390/pgalloc.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/pgalloc.h
+++ quilt-2.6/include/asm-s390/pgalloc.h
@@ -19,8 +19,6 @@
 
 #define check_pgt_cache()	do {} while (0)
 
-extern void diag10(unsigned long addr);
-
 /*
  * Page allocation orders.
  */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
