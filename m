Return-Path: <linux-kernel-owner+w=401wt.eu-S1755978AbZHNL2E@vger.kernel.org>
Message-Id: <20090814112618.205116349@de.ibm.com>
References: <20090814112517.982007860@de.ibm.com>
Date: Fri, 14 Aug 2009 13:25:41 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 24/34] move (io|sysc)_restore_trace_psw into .data section
Content-Disposition: inline; filename=123-nss-fix.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>

The sysc_restore_trace_psw and io_restore_trace_psw storage locations
are created in the .text section. When creating and IPLing from a named
saved system (NSS), writing to these locations causes a protection exception
(because the .text section is mapped as shared read-only in the NSS).

To permit write access, move the storage locations into the .data section.

The problem occurs only when CONFIG_TRACE_IRQFLAGS is set.
The git commmit that has introduced these variables is:
411788ea7fca01ee803af8225ac35807b4d02050

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/entry.S   |   16 ++++++++++++++--
 arch/s390/kernel/entry64.S |    4 ++++
 2 files changed, 18 insertions(+), 2 deletions(-)

Index: quilt-2.6/arch/s390/kernel/entry64.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/entry64.S
+++ quilt-2.6/arch/s390/kernel/entry64.S
@@ -284,10 +284,12 @@ sysc_leave:
 sysc_done:
 
 #ifdef CONFIG_TRACE_IRQFLAGS
+	.section .data,"aw",@progbits
 	.align	8
 	.globl sysc_restore_trace_psw
 sysc_restore_trace_psw:
 	.quad	0, sysc_restore_trace
+	.previous
 #endif
 
 #
@@ -595,10 +597,12 @@ io_leave:
 io_done:
 
 #ifdef CONFIG_TRACE_IRQFLAGS
+	.section .data,"aw",@progbits
 	.align	8
 	.globl io_restore_trace_psw
 io_restore_trace_psw:
 	.quad	0, io_restore_trace
+	.previous
 #endif
 
 #
Index: quilt-2.6/arch/s390/kernel/entry.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/entry.S
+++ quilt-2.6/arch/s390/kernel/entry.S
@@ -278,7 +278,8 @@ sysc_return:
 	bnz	BASED(sysc_work)  # there is work to do (signals etc.)
 sysc_restore:
 #ifdef CONFIG_TRACE_IRQFLAGS
-	la	%r1,BASED(sysc_restore_trace_psw)
+	la	%r1,BASED(sysc_restore_trace_psw_addr)
+	l	%r1,0(%r1)
 	lpsw	0(%r1)
 sysc_restore_trace:
 	TRACE_IRQS_CHECK
@@ -289,10 +290,15 @@ sysc_leave:
 sysc_done:
 
 #ifdef CONFIG_TRACE_IRQFLAGS
+sysc_restore_trace_psw_addr:
+	.long sysc_restore_trace_psw
+
+	.section .data,"aw",@progbits
 	.align	8
 	.globl	sysc_restore_trace_psw
 sysc_restore_trace_psw:
 	.long	0, sysc_restore_trace + 0x80000000
+	.previous
 #endif
 
 #
@@ -606,7 +612,8 @@ io_return:
 	bnz	BASED(io_work)		# there is work to do (signals etc.)
 io_restore:
 #ifdef CONFIG_TRACE_IRQFLAGS
-	la	%r1,BASED(io_restore_trace_psw)
+	la	%r1,BASED(io_restore_trace_psw_addr)
+	l	%r1,0(%r1)
 	lpsw	0(%r1)
 io_restore_trace:
 	TRACE_IRQS_CHECK
@@ -617,10 +624,15 @@ io_leave:
 io_done:
 
 #ifdef CONFIG_TRACE_IRQFLAGS
+io_restore_trace_psw_addr:
+	.long io_restore_trace_psw
+
+	.section .data,"aw",@progbits
 	.align	8
 	.globl	io_restore_trace_psw
 io_restore_trace_psw:
 	.long	0, io_restore_trace + 0x80000000
+	.previous
 #endif
 
 #

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
