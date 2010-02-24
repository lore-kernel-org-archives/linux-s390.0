Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084452.816283483@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:57 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 27/32] [PATCH] Define new s390 ELF note sections in elf.h
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=126-elf-notes-sections.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Holzheu <holzheu@linux.vnet.ibm.com>

S390 ELF core dump currently only contains the PSW, the general purpose
registers, the floating point registers and the access registers stored
in PRSTATUS/PRFPREG note sections.
For analyzing s390 kernel problems additional registers are important.
In order to be able to include these registers to a kernel ELF core dump,
this patch adds the following five new note sections to elf.h:

* NT_S390_TIMER:   S390 timer register
* NT_S390_TODCMP:  S390 TOD comparator register
* NT_S390_TODPREG: S390 TOD programmable register
* NT_S390_CTRS:    S390 control registers
* NT_S390_PREFIX:  S390 prefix register

The new note sections have been already defined and accepted in the upstream
binutils package.

Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/linux/elf.h |    5 +++++
 1 file changed, 5 insertions(+)

Index: quilt-2.6/include/linux/elf.h
===================================================================
--- quilt-2.6.orig/include/linux/elf.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/include/linux/elf.h	2010-02-24 09:44:28.000000000 +0100
@@ -362,6 +362,11 @@
 #define NT_386_TLS	0x200		/* i386 TLS slots (struct user_desc) */
 #define NT_386_IOPERM	0x201		/* x86 io permission bitmap (1=deny) */
 #define NT_S390_HIGH_GPRS	0x300	/* s390 upper register halves */
+#define NT_S390_TIMER	0x301		/* s390 timer register */
+#define NT_S390_TODCMP	0x302		/* s390 TOD clock comparator register */
+#define NT_S390_TODPREG	0x303		/* s390 TOD programmable register */
+#define NT_S390_CTRS	0x304		/* s390 control registers */
+#define NT_S390_PREFIX	0x305		/* s390 prefix register */
 
 
 /* Note header in a PT_NOTE section */
