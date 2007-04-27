Return-Path: <linux-kernel-owner+w=401wt.eu-S1755898AbXD0OFq@vger.kernel.org>
Message-Id: <20070427140512.162418645@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/38] cio/ipl: Clean interface between cio and ipl code.
Content-Disposition: inline; filename=100-cio-ipl.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Clean interface between cio and ipl code, so Peter stops complaining.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/ipl.c |   23 ++++++++++++++++++++++-
 drivers/s390/cio/cio.c |   38 ++++++++++----------------------------
 include/asm-s390/cio.h |    7 +++++++
 include/asm-s390/ipl.h |    3 +--
 4 files changed, 40 insertions(+), 31 deletions(-)

Index: quilt-2.6/arch/s390/kernel/ipl.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ipl.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/ipl.c	2007-04-27 16:04:52.000000000 +0200
@@ -47,7 +47,7 @@
  * Must be in data section since the bss section
  * is not cleared when these are accessed.
  */
-u16 ipl_devno __attribute__((__section__(".data"))) = 0;
+static u16 ipl_devno __attribute__((__section__(".data"))) = 0;
 u32 ipl_flags __attribute__((__section__(".data"))) = 0;
 
 static char *ipl_type_str(enum ipl_type type)
@@ -1038,6 +1038,27 @@
 
 __initcall(s390_ipl_init);
 
+void __init ipl_save_parameters(void)
+{
+	struct cio_iplinfo iplinfo;
+	unsigned int *ipl_ptr;
+	void *src, *dst;
+
+	if (cio_get_iplinfo(&iplinfo))
+		return;
+
+	ipl_devno = iplinfo.devno;
+	ipl_flags |= IPL_DEVNO_VALID;
+	if (!iplinfo.is_qdio)
+		return;
+	ipl_flags |= IPL_PARMBLOCK_VALID;
+	ipl_ptr = (unsigned int *)__LC_IPL_PARMBLOCK_PTR;
+	src = (void *)(unsigned long)*ipl_ptr;
+	dst = (void *)IPL_PARMBLOCK_ORIGIN;
+	memmove(dst, src, PAGE_SIZE);
+	*ipl_ptr = IPL_PARMBLOCK_ORIGIN;
+}
+
 static LIST_HEAD(rcall);
 static DEFINE_MUTEX(rcall_mutex);
 
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/drivers/s390/cio/cio.c	2007-04-27 16:04:52.000000000 +0200
@@ -1048,37 +1048,19 @@
 	do_reipl_asm(*((__u32*)&schid));
 }
 
-static struct schib __initdata ipl_schib;
-
-/*
- * ipl_save_parameters gets called very early. It is not allowed to access
- * anything in the bss section at all. The bss section is not cleared yet,
- * but may contain some ipl parameters written by the firmware.
- * These parameters (if present) are copied to 0x2000.
- * To avoid corruption of the ipl parameters, all variables used by this
- * function must reside on the stack or in the data section.
- */
-void ipl_save_parameters(void)
+int __init cio_get_iplinfo(struct cio_iplinfo *iplinfo)
 {
 	struct subchannel_id schid;
-	unsigned int *ipl_ptr;
-	void *src, *dst;
+	struct schib schib;
 
 	schid = *(struct subchannel_id *)__LC_SUBCHANNEL_ID;
 	if (!schid.one)
-		return;
-	if (stsch(schid, &ipl_schib))
-		return;
-	if (!ipl_schib.pmcw.dnv)
-		return;
-	ipl_devno = ipl_schib.pmcw.dev;
-	ipl_flags |= IPL_DEVNO_VALID;
-	if (!ipl_schib.pmcw.qf)
-		return;
-	ipl_flags |= IPL_PARMBLOCK_VALID;
-	ipl_ptr = (unsigned int *)__LC_IPL_PARMBLOCK_PTR;
-	src = (void *)(unsigned long)*ipl_ptr;
-	dst = (void *)IPL_PARMBLOCK_ORIGIN;
-	memmove(dst, src, PAGE_SIZE);
-	*ipl_ptr = IPL_PARMBLOCK_ORIGIN;
+		return -ENODEV;
+	if (stsch(schid, &schib))
+		return -ENODEV;
+	if (!schib.pmcw.dnv)
+		return -ENODEV;
+	iplinfo->devno = schib.pmcw.dev;
+	iplinfo->is_qdio = schib.pmcw.qf;
+	return 0;
 }
Index: quilt-2.6/include/asm-s390/cio.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/cio.h	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/include/asm-s390/cio.h	2007-04-27 16:04:52.000000000 +0200
@@ -292,6 +292,13 @@
 
 extern void reipl_ccw_dev(struct ccw_dev_id *id);
 
+struct cio_iplinfo {
+	u16 devno;
+	int is_qdio;
+};
+
+extern int cio_get_iplinfo(struct cio_iplinfo *iplinfo);
+
 #endif
 
 #endif
Index: quilt-2.6/include/asm-s390/ipl.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/ipl.h	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/include/asm-s390/ipl.h	2007-04-27 16:04:52.000000000 +0200
@@ -74,10 +74,9 @@
 } __attribute__((packed));
 
 /*
- * IPL validity flags and parameters as detected in head.S
+ * IPL validity flags
  */
 extern u32 ipl_flags;
-extern u16 ipl_devno;
 
 extern u32 dump_prefix_page;
 extern void do_reipl(void);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
