Return-Path: <linux-kernel-owner+w=401wt.eu-S1759134AbYBIMGe@vger.kernel.org>
Message-Id: <20080209120312.275984135@de.ibm.com>
References: <20080209120157.885371603@de.ibm.com>
Date: Sat, 09 Feb 2008 13:02:05 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/11] Remove a.out header file.
Content-Disposition: inline; filename=008-aout.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/process.c |    1 -
 arch/s390/kernel/setup.c   |    1 -
 include/asm-s390/a.out.h   |   32 --------------------------------
 3 files changed, 34 deletions(-)

Index: quilt-2.6/arch/s390/kernel/process.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/process.c
+++ quilt-2.6/arch/s390/kernel/process.c
@@ -29,7 +29,6 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/user.h>
-#include <linux/a.out.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 #include <linux/reboot.h>
Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -24,7 +24,6 @@
 #include <linux/ptrace.h>
 #include <linux/slab.h>
 #include <linux/user.h>
-#include <linux/a.out.h>
 #include <linux/tty.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
Index: quilt-2.6/include/asm-s390/a.out.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/a.out.h
+++ /dev/null
@@ -1,32 +0,0 @@
-/*
- *  include/asm-s390/a.out.h
- *
- *  S390 version
- *    Copyright (C) 1999 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *
- *  Derived from "include/asm-i386/a.out.h"
- *    Copyright (C) 1992, Linus Torvalds
- *
- * I don't think we'll ever need a.out ...
- */
-
-#ifndef __S390_A_OUT_H__
-#define __S390_A_OUT_H__
-
-struct exec
-{
-  unsigned long a_info;		/* Use macros N_MAGIC, etc for access */
-  unsigned a_text;		/* length of text, in bytes */
-  unsigned a_data;		/* length of data, in bytes */
-  unsigned a_bss;		/* length of uninitialized data area for file, in bytes */
-  unsigned a_syms;		/* length of symbol table data in file, in bytes */
-  unsigned a_entry;		/* start address */
-  unsigned a_trsize;		/* length of relocation info for text, in bytes */
-  unsigned a_drsize;		/* length of relocation info for data, in bytes */
-};
-
-#define N_TRSIZE(a)	((a).a_trsize)
-#define N_DRSIZE(a)	((a).a_drsize)
-#define N_SYMSIZE(a)	((a).a_syms)
-
-#endif /* __A_OUT_GNU_H__ */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
