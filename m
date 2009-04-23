Return-Path: <linux-kernel-owner+w=401wt.eu-S1750952AbZDWLtf@vger.kernel.org>
Message-Id: <20090423114726.180651295@de.ibm.com>
References: <20090423114638.865214111@de.ibm.com>
Date: Thu, 23 Apr 2009 13:46:43 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 5/6] omit frame pointers on s390 when possible
Content-Disposition: inline; filename=005-omit-frame-pointer.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Always omit frame pointers on s390. They aren't too useful for the
kernel since we have already the kernel stack backchain which allows
us to walk the kernel stack.
So eleminate the extra code for frame pointers. Only allow the extra
code for the function tracer since the gcc compile options -pg and
-fomit-frame-pointer are incompatible.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 lib/Kconfig.debug |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: quilt-2.6/lib/Kconfig.debug
===================================================================
--- quilt-2.6.orig/lib/Kconfig.debug
+++ quilt-2.6/lib/Kconfig.debug
@@ -440,7 +440,7 @@ config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
 	select STACKTRACE
-	select FRAME_POINTER if !X86 && !MIPS && !PPC && !ARM_UNWIND
+	select FRAME_POINTER if !X86 && !MIPS && !PPC && !ARM_UNWIND && !S390
 	select KALLSYMS
 	select KALLSYMS_ALL
 
@@ -620,7 +620,7 @@ config ARCH_WANT_FRAME_POINTERS
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
 	depends on DEBUG_KERNEL && \
-		(CRIS || M68K || M68KNOMMU || FRV || UML || S390 || \
+		(CRIS || M68K || M68KNOMMU || FRV || UML || \
 		 AVR32 || SUPERH || BLACKFIN || MN10300) || \
 		ARCH_WANT_FRAME_POINTERS
 	default y if (DEBUG_INFO && UML) || ARCH_WANT_FRAME_POINTERS
@@ -809,13 +809,13 @@ config FAULT_INJECTION_STACKTRACE_FILTER
 	depends on FAULT_INJECTION_DEBUG_FS && STACKTRACE_SUPPORT
 	depends on !X86_64
 	select STACKTRACE
-	select FRAME_POINTER if !PPC
+	select FRAME_POINTER if !PPC && !S390
 	help
 	  Provide stacktrace filter for fault-injection capabilities
 
 config LATENCYTOP
 	bool "Latency measuring infrastructure"
-	select FRAME_POINTER if !MIPS && !PPC
+	select FRAME_POINTER if !MIPS && !PPC && !S390
 	select KALLSYMS
 	select KALLSYMS_ALL
 	select STACKTRACE

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
