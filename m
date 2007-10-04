Return-Path: <linux-kernel-owner+w=401wt.eu-S1759468AbXJDTN4@vger.kernel.org>
Date: Thu, 4 Oct 2007 21:15:10 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: [PATCH 1/2] s390: beautify vmlinux.lds
Message-ID: <20071004191510.GB23211@uranus.ravnborg.org>
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

Introduce a consistent style in vmlinux.lds.
This style is gradually being introduced for all archs.

A few lables were moved inside the section definition so
they are assigned the correct value of gcc decide to align
the content to another address than the one . has.
In the past this has fixed several bugs but for s390 it
will not impact due to all the alignmnet already introduced.

Stabs definitions are consolidated in asm-generic/vmlinux.lds.h
This patch also introduce support for DWARF - without knowing
if this makes sense for s390.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
build tested only

 vmlinux.lds.S |  233 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 127 insertions(+), 106 deletions(-)

diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index b4622a3..3a364d1 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -18,121 +18,142 @@ jiffies = jiffies_64;
 
 SECTIONS
 {
-  . = 0x00000000;
-  _text = .;			/* Text and read-only data */
-  .text : {
-	*(.text.head)
+	. = 0x00000000;
+	.text : {
+	_text = .;		/* Text and read-only data */
+		*(.text.head)
 	TEXT_TEXT
-	SCHED_TEXT
-	LOCK_TEXT
-	KPROBES_TEXT
-	*(.fixup)
-	*(.gnu.warning)
+		SCHED_TEXT
+		LOCK_TEXT
+		KPROBES_TEXT
+		*(.fixup)
+		*(.gnu.warning)
 	} = 0x0700
 
-  _etext = .;			/* End of text section */
+	_etext = .;		/* End of text section */
 
-  RODATA
+	RODATA
 
 #ifdef CONFIG_SHARED_KERNEL
-  . = ALIGN(1048576);		/* VM shared segments are 1MB aligned */
+	. = ALIGN(1048576);	/* VM shared segments are 1MB aligned */
 #endif
 
-  . = ALIGN(4096);
-  _eshared = .;			/* End of shareable data */
-
-  . = ALIGN(16);		/* Exception table */
-  __start___ex_table = .;
-  __ex_table : { *(__ex_table) }
-  __stop___ex_table = .;
-
-  NOTES
-
-  BUG_TABLE
-
-  .data : {			/* Data */
-	DATA_DATA
-	CONSTRUCTORS
-	}
-
-  . = ALIGN(4096);
-  __nosave_begin = .;
-  .data_nosave : { *(.data.nosave) }
-  . = ALIGN(4096);
-  __nosave_end = .;
-
-  . = ALIGN(4096);
-  .data.page_aligned : { *(.data.idt) }
-
-  . = ALIGN(256);
-  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
-
-  . = ALIGN(256);
-  .data.read_mostly : { *(.data.read_mostly) }
-  _edata = .;			/* End of data section */
-
-  . = ALIGN(8192);		/* init_task */
-  .data.init_task : { *(.data.init_task) }
-
-  /* will be freed after init */
-  . = ALIGN(4096);		/* Init code and data */
-  __init_begin = .;
-  .init.text : { 
-	_sinittext = .;
-	*(.init.text)
-	_einittext = .;
-  }
-  /*
-   * .exit.text is discarded at runtime, not link time,
-   * to deal with references from __bug_table
-   */
-  .exit.text :	 { *(.exit.text) }
-
-  .init.data : { *(.init.data) }
-  . = ALIGN(256);
-  __setup_start = .;
-  .init.setup : { *(.init.setup) }
-  __setup_end = .;
-  __initcall_start = .;
-  .initcall.init : {
-	INITCALLS
-  }
-  __initcall_end = .;
-  __con_initcall_start = .;
-  .con_initcall.init : { *(.con_initcall.init) }
-  __con_initcall_end = .;
-  SECURITY_INIT
+	. = ALIGN(4096);
+	_eshared = .;		/* End of shareable data */
+
+	. = ALIGN(16);		/* Exception table */
+	__ex_table : {
+		__start___ex_table = .;
+		*(__ex_table)
+		__stop___ex_table = .;
+	}
+
+	NOTES
+	BUG_TABLE
+
+	.data : {		/* Data */
+		DATA_DATA
+		CONSTRUCTORS
+	}
+
+	. = ALIGN(4096);
+	.data_nosave : {
+	__nosave_begin = .;
+		*(.data.nosave)
+	}
+	. = ALIGN(4096);
+	__nosave_end = .;
+
+	. = ALIGN(4096);
+	.data.page_aligned : {
+		*(.data.idt)
+	}
+
+	. = ALIGN(256);
+	.data.cacheline_aligned : {
+		*(.data.cacheline_aligned)
+	}
+
+	. = ALIGN(256);
+	.data.read_mostly : {
+		*(.data.read_mostly)
+	}
+	_edata = .;		/* End of data section */
+
+	. = ALIGN(8192);	/* init_task */
+	.data.init_task : {
+		*(.data.init_task)
+	}
+
+	/* will be freed after init */
+	. = ALIGN(4096);	/* Init code and data */
+	__init_begin = .;
+	.init.text : { 
+		_sinittext = .;
+		*(.init.text)
+		_einittext = .;
+	}
+	/*
+	 * .exit.text is discarded at runtime, not link time,
+	 * to deal with references from __bug_table
+	*/
+	.exit.text : {
+		*(.exit.text)
+	}
+
+	.init.data : {
+		*(.init.data)
+	}
+	. = ALIGN(256);
+	.init.setup : {
+		__setup_start = .;
+		*(.init.setup)
+		__setup_end = .;
+	}
+	.initcall.init : {
+		__initcall_start = .;
+		INITCALLS
+		__initcall_end = .;
+	}
+
+	.con_initcall.init : {
+		__con_initcall_start = .;
+		*(.con_initcall.init)
+		__con_initcall_end = .;
+	}
+	SECURITY_INIT
 
 #ifdef CONFIG_BLK_DEV_INITRD
-  . = ALIGN(256);
-  __initramfs_start = .;
-  .init.ramfs : { *(.init.initramfs) }
-  . = ALIGN(2);
-  __initramfs_end = .;
+	. = ALIGN(256);
+	.init.ramfs : {
+		__initramfs_start = .;
+		*(.init.initramfs)
+		. = ALIGN(2);
+  		__initramfs_end = .;
+	}
 #endif
-  PERCPU(4096)
-  . = ALIGN(4096);
-  __init_end = .;
-  /* freed after init ends here */
-
-  __bss_start = .;		/* BSS */
-  .bss : { *(.bss) }
-  . = ALIGN(2);
-  __bss_stop = .;
-
-  _end = . ;
-
-  /* Sections to be discarded */
-  /DISCARD/ : {
-	*(.exit.data) *(.exitcall.exit)
-	}
-
-  /* Stabs debugging sections.  */
-  .stab 0 : { *(.stab) }
-  .stabstr 0 : { *(.stabstr) }
-  .stab.excl 0 : { *(.stab.excl) }
-  .stab.exclstr 0 : { *(.stab.exclstr) }
-  .stab.index 0 : { *(.stab.index) }
-  .stab.indexstr 0 : { *(.stab.indexstr) }
-  .comment 0 : { *(.comment) }
+
+	PERCPU(4096)
+	. = ALIGN(4096);
+	__init_end = .;		/* freed after init ends here */
+
+	/* BSS */
+	.bss : {
+		__bss_start = .;
+		*(.bss)
+		. = ALIGN(2);
+		__bss_stop = .;
+	}
+
+	_end = . ;
+
+	/* Sections to be discarded */
+	/DISCARD/ : {
+		*(.exit.data)
+		*(.exitcall.exit)
+	}
+
+	/* Debugging sections.  */
+	STABS_DEBUG
+	DWARF_DEBUG
 }
