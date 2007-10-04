Return-Path: <linux-kernel-owner+w=401wt.eu-S1759432AbXJDTSM@vger.kernel.org>
Date: Thu, 4 Oct 2007 21:18:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 2/2] s390: use PAGE_SIZE in vmlinux.lds
Message-ID: <20071004191835.GC23211@uranus.ravnborg.org>
References: <20071004112706.574737175@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071004112706.574737175@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Repalce the hardcoded 4096 value with the PAGE_SIZE macro.
Converted a few decimal numbers to readable hex numbers.

Use of PAGE_SIZE required a small change to page.h
to allow PAGE_SIZE to be used from assembler/linker scripts.


Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
build tested only

 arch/s390/kernel/vmlinux.lds.S |   27 ++++++++++++++-------------
 include/asm-s390/page.h        |    3 ++-
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 3a364d1..dd3b310 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -2,6 +2,7 @@
  * Written by Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
 
+#include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
 
 #ifndef CONFIG_64BIT
@@ -35,10 +36,10 @@ SECTIONS
 	RODATA
 
 #ifdef CONFIG_SHARED_KERNEL
-	. = ALIGN(1048576);	/* VM shared segments are 1MB aligned */
+	. = ALIGN(0x100000);	/* VM shared segments are 1MB aligned */
 #endif
 
-	. = ALIGN(4096);
+	. = ALIGN(PAGE_SIZE);
 	_eshared = .;		/* End of shareable data */
 
 	. = ALIGN(16);		/* Exception table */
@@ -56,37 +57,37 @@ SECTIONS
 		CONSTRUCTORS
 	}
 
-	. = ALIGN(4096);
+	. = ALIGN(PAGE_SIZE);
 	.data_nosave : {
 	__nosave_begin = .;
 		*(.data.nosave)
 	}
-	. = ALIGN(4096);
+	. = ALIGN(PAGE_SIZE);
 	__nosave_end = .;
 
-	. = ALIGN(4096);
+	. = ALIGN(PAGE_SIZE);
 	.data.page_aligned : {
 		*(.data.idt)
 	}
 
-	. = ALIGN(256);
+	. = ALIGN(0x100);
 	.data.cacheline_aligned : {
 		*(.data.cacheline_aligned)
 	}
 
-	. = ALIGN(256);
+	. = ALIGN(0x100);
 	.data.read_mostly : {
 		*(.data.read_mostly)
 	}
 	_edata = .;		/* End of data section */
 
-	. = ALIGN(8192);	/* init_task */
+	. = ALIGN(2 * PAGE_SIZE);	/* init_task */
 	.data.init_task : {
 		*(.data.init_task)
 	}
 
 	/* will be freed after init */
-	. = ALIGN(4096);	/* Init code and data */
+	. = ALIGN(PAGE_SIZE);	/* Init code and data */
 	__init_begin = .;
 	.init.text : { 
 		_sinittext = .;
@@ -104,7 +105,7 @@ SECTIONS
 	.init.data : {
 		*(.init.data)
 	}
-	. = ALIGN(256);
+	. = ALIGN(0x100);
 	.init.setup : {
 		__setup_start = .;
 		*(.init.setup)
@@ -124,7 +125,7 @@ SECTIONS
 	SECURITY_INIT
 
 #ifdef CONFIG_BLK_DEV_INITRD
-	. = ALIGN(256);
+	. = ALIGN(0x100);
 	.init.ramfs : {
 		__initramfs_start = .;
 		*(.init.initramfs)
@@ -133,8 +134,8 @@ SECTIONS
 	}
 #endif
 
-	PERCPU(4096)
-	. = ALIGN(4096);
+	PERCPU(PAGE_SIZE)
+	. = ALIGN(PAGE_SIZE);
 	__init_end = .;		/* freed after init ends here */
 
 	/* BSS */
diff --git a/include/asm-s390/page.h b/include/asm-s390/page.h
index f326451..e3ce489 100644
--- a/include/asm-s390/page.h
+++ b/include/asm-s390/page.h
@@ -9,11 +9,12 @@
 #ifndef _S390_PAGE_H
 #define _S390_PAGE_H
 
+#include <linux/const.h>
 #include <asm/types.h>
 
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT      12
-#define PAGE_SIZE       (1UL << PAGE_SHIFT)
+#define PAGE_SIZE       (_AC(1,UL) << PAGE_SHIFT)
 #define PAGE_MASK       (~(PAGE_SIZE-1))
 #define PAGE_DEFAULT_ACC	0
 #define PAGE_DEFAULT_KEY	(PAGE_DEFAULT_ACC << 4)
