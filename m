Return-Path: <linux-kernel-owner+w=401wt.eu-S1752995AbZGaU7s@vger.kernel.org>
From: Tim Abbott <tabbott@ksplice.com>
Subject: [PATCH 2/2] s390: clean up linker script using new linker script macros.
Date: Fri, 31 Jul 2009 16:58:31 -0400
Message-Id: <1249073911-30208-2-git-send-email-tabbott@ksplice.com>
In-Reply-To: <1249073911-30208-1-git-send-email-tabbott@ksplice.com>
References: <1249073911-30208-1-git-send-email-tabbott@ksplice.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Anders Kaseorg <andersk@ksplice.com>, Nelson Elhage <nelhage@ksplice.com>, Tim Abbott <tabbott@ksplice.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Nelson Elhage <nelhage@ksplice.com>

Note that this patch moves .data.init_task inside _edata.  In
addition, the alignment of .init.ramfs changes: It is now PAGE_ALIGNED
and __initramfs_end is arbitrarily aligned; Previously it was
only aligned to a 0x100-byte boundary, and always ended on an even
byte.

This change results in fewer output sections and in some data being
reordered, but should have no functional effect.

Signed-off-by: Nelson Elhage <nelhage@ksplice.com>
Signed-off-by: Tim Abbott <tabbott@ksplice.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/kernel/vmlinux.lds.S |   83 +++------------------------------------
 1 files changed, 7 insertions(+), 76 deletions(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 8e023c8..7315f9e 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -52,51 +52,18 @@ SECTIONS
 	. = ALIGN(PAGE_SIZE);
 	_eshared = .;		/* End of shareable data */
 
-	. = ALIGN(16);		/* Exception table */
-	__ex_table : {
-		__start___ex_table = .;
-		*(__ex_table)
-		__stop___ex_table = .;
-	} :data
-
-	.data : {		/* Data */
-		PAGE_ALIGNED_DATA(PAGE_SIZE)
-		DATA_DATA
-		CONSTRUCTORS
-	}
-
-	. = ALIGN(PAGE_SIZE);
-	.data_nosave : {
-	__nosave_begin = .;
-		*(.data.nosave)
-	}
-	. = ALIGN(PAGE_SIZE);
-	__nosave_end = .;
+	EXCEPTION_TABLE(16) :data
 
-	. = ALIGN(0x100);
-	.data.cacheline_aligned : {
-		*(.data.cacheline_aligned)
-	}
+	RW_DATA_SECTION(0x100, PAGE_SIZE, THREAD_SIZE)
 
-	. = ALIGN(0x100);
-	.data.read_mostly : {
-		*(.data.read_mostly)
-	}
 	_edata = .;		/* End of data section */
 
-	. = ALIGN(THREAD_SIZE);	/* init_task */
-	.data.init_task : {
-		*(.data.init_task)
-	}
-
 	/* will be freed after init */
 	. = ALIGN(PAGE_SIZE);	/* Init code and data */
 	__init_begin = .;
-	.init.text : {
-		_sinittext = .;
-		INIT_TEXT
-		_einittext = .;
-	}
+
+	INIT_TEXT_SECTION(PAGE_SIZE)
+
 	/*
 	 * .exit.text is discarded at runtime, not link time,
 	 * to deal with references from __bug_table
@@ -107,49 +74,13 @@ SECTIONS
 
 	/* early.c uses stsi, which requires page aligned data. */
 	. = ALIGN(PAGE_SIZE);
-	.init.data : {
-		INIT_DATA
-	}
-	. = ALIGN(0x100);
-	.init.setup : {
-		__setup_start = .;
-		*(.init.setup)
-		__setup_end = .;
-	}
-	.initcall.init : {
-		__initcall_start = .;
-		INITCALLS
-		__initcall_end = .;
-	}
-
-	.con_initcall.init : {
-		__con_initcall_start = .;
-		*(.con_initcall.init)
-		__con_initcall_end = .;
-	}
-	SECURITY_INIT
-
-#ifdef CONFIG_BLK_DEV_INITRD
-	. = ALIGN(0x100);
-	.init.ramfs : {
-		__initramfs_start = .;
-		*(.init.ramfs)
-		. = ALIGN(2);
-		__initramfs_end = .;
-	}
-#endif
+	INIT_DATA_SECTION(0x100)
 
 	PERCPU(PAGE_SIZE)
 	. = ALIGN(PAGE_SIZE);
 	__init_end = .;		/* freed after init ends here */
 
-	/* BSS */
-	.bss : {
-		__bss_start = .;
-		*(.bss)
-		. = ALIGN(2);
-		__bss_stop = .;
-	}
+	BSS_SECTION(0, 2, 0)
 
 	_end = . ;
 
-- 
1.6.3.3
