Return-Path: <linux-kernel-owner+w=401wt.eu-S932479AbXGWI40@vger.kernel.org>
Message-Id: <20070723085702.372776086@de.ibm.com>
References: <20070723084548.394178614@de.ibm.com>
Date: Mon, 23 Jul 2007 10:45:54 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 6/9] Get rid of new section mismatch warnings.
Content-Disposition: inline; filename=006-section-warning.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/head.S        |    1 +
 arch/s390/kernel/vmlinux.lds.S |    1 +
 arch/s390/mm/vmem.c            |    6 +++---
 drivers/s390/char/raw3270.c    |    6 ++----
 drivers/s390/char/sclp_vt220.c |    3 +--
 5 files changed, 8 insertions(+), 9 deletions(-)

Index: quilt-2.6/arch/s390/kernel/head.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/head.S
+++ quilt-2.6/arch/s390/kernel/head.S
@@ -35,6 +35,7 @@
 #define ARCH_OFFSET	0
 #endif
 
+.section ".text.head","ax"
 #ifndef CONFIG_IPL
 	.org   0
 	.long  0x00080000,0x80000000+startup	# Just a restart PSW
Index: quilt-2.6/arch/s390/kernel/vmlinux.lds.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/vmlinux.lds.S
+++ quilt-2.6/arch/s390/kernel/vmlinux.lds.S
@@ -21,6 +21,7 @@ SECTIONS
   . = 0x00000000;
   _text = .;			/* Text and read-only data */
   .text : {
+	*(.text.head)
 	TEXT_TEXT
 	SCHED_TEXT
 	LOCK_TEXT
Index: quilt-2.6/arch/s390/mm/vmem.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/vmem.c
+++ quilt-2.6/arch/s390/mm/vmem.c
@@ -29,8 +29,8 @@ struct memory_segment {
 
 static LIST_HEAD(mem_segs);
 
-void memmap_init(unsigned long size, int nid, unsigned long zone,
-		 unsigned long start_pfn)
+void __meminit memmap_init(unsigned long size, int nid, unsigned long zone,
+			   unsigned long start_pfn)
 {
 	struct page *start, *end;
 	struct page *map_start, *map_end;
@@ -66,7 +66,7 @@ void memmap_init(unsigned long size, int
 	}
 }
 
-static inline void *vmem_alloc_pages(unsigned int order)
+static void __init_refok *vmem_alloc_pages(unsigned int order)
 {
 	if (slab_is_available())
 		return (void *)__get_free_pages(GFP_KERNEL, order);
Index: quilt-2.6/drivers/s390/char/raw3270.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/raw3270.c
+++ quilt-2.6/drivers/s390/char/raw3270.c
@@ -147,8 +147,7 @@ raw3270_request_alloc(size_t size)
  * Allocate a new 3270 ccw request from bootmem. Only works very
  * early in the boot process. Only con3270.c should be using this.
  */
-struct raw3270_request *
-raw3270_request_alloc_bootmem(size_t size)
+struct raw3270_request __init *raw3270_request_alloc_bootmem(size_t size)
 {
 	struct raw3270_request *rq;
 
@@ -848,8 +847,7 @@ raw3270_setup_device(struct ccw_device *
 /*
  * Setup 3270 device configured as console.
  */
-struct raw3270 *
-raw3270_setup_console(struct ccw_device *cdev)
+struct raw3270 __init *raw3270_setup_console(struct ccw_device *cdev)
 {
 	struct raw3270 *rp;
 	char *ascebc;
Index: quilt-2.6/drivers/s390/char/sclp_vt220.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_vt220.c
+++ quilt-2.6/drivers/s390/char/sclp_vt220.c
@@ -621,8 +621,7 @@ sclp_vt220_flush_buffer(struct tty_struc
 /*
  * Initialize all relevant components and register driver with system.
  */
-static int
-__sclp_vt220_init(int early)
+static int __init_refok __sclp_vt220_init(int early)
 {
 	void *page;
 	int i;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
