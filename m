Return-Path: <linux-kbuild-owner@vger.kernel.org>
Date: Mon, 6 Aug 2018 15:17:47 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 4/4] s390/ftrace: add -mfentry and -mnop-mcount support
References: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.thread-aa7b8d.your-ad-here.call-01533557518-ext-9465@work.hours>
Message-Id: <patch-4.thread-aa7b8d.git-aa7b8dbf236f.your-ad-here.call-01533557518-ext-9465@work.hours>
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
List-ID: <linux-s390.vger.kernel.org>

Utilize -mfentry and -mnop-mcount gcc options together with
-mrecord-mcount to get compiler generated calls to the profiling functions
as nops which are compatible with current -mhotpatch=0,3 approach.  At the
same time -mrecord-mcount enables __mcount_loc section generation by
the compiler which allows to avoid using scripts/recordmcount.pl script.

Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/Kconfig              |  2 ++
 arch/s390/Makefile             | 16 +++++++++-------
 arch/s390/include/asm/ftrace.h |  6 +++---
 arch/s390/kernel/ftrace.c      |  2 +-
 arch/s390/kernel/mcount.S      |  2 +-
 5 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 8a1863d9ed53..71c2d9de379f 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -136,6 +136,7 @@ config S390
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select HAVE_FENTRY
 	select HAVE_FTRACE_MCOUNT_RECORD
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_TRACER
@@ -157,6 +158,7 @@ config S390
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MEMBLOCK_PHYS_MAP
 	select HAVE_MOD_ARCH_SPECIFIC
+	select HAVE_NOP_MCOUNT
 	select HAVE_OPROFILE
 	select HAVE_PERF_EVENTS
 	select HAVE_REGS_AND_STACK_ACCESS_API
diff --git a/arch/s390/Makefile b/arch/s390/Makefile
index 68a690442be0..8498babb5dad 100644
--- a/arch/s390/Makefile
+++ b/arch/s390/Makefile
@@ -86,13 +86,15 @@ ifdef CONFIG_EXPOLINE
 endif
 
 ifdef CONFIG_FUNCTION_TRACER
-# make use of hotpatch feature if the compiler supports it
-cc_hotpatch	:= -mhotpatch=0,3
-ifeq ($(call cc-option-yn,$(cc_hotpatch)),y)
-CC_FLAGS_FTRACE := $(cc_hotpatch)
-KBUILD_AFLAGS	+= -DCC_USING_HOTPATCH
-KBUILD_CFLAGS	+= -DCC_USING_HOTPATCH
-endif
+  ifeq ($(call cc-option-yn,-mfentry -mnop-mcount),n)
+    # make use of hotpatch feature if the compiler supports it
+    cc_hotpatch	:= -mhotpatch=0,3
+    ifeq ($(call cc-option-yn,$(cc_hotpatch)),y)
+      CC_FLAGS_FTRACE := $(cc_hotpatch)
+      KBUILD_AFLAGS	+= -DCC_USING_HOTPATCH
+      KBUILD_CFLAGS	+= -DCC_USING_HOTPATCH
+    endif
+  endif
 endif
 
 # Test CFI features of binutils
diff --git a/arch/s390/include/asm/ftrace.h b/arch/s390/include/asm/ftrace.h
index cfccc0edd00d..8ea270fdc7fb 100644
--- a/arch/s390/include/asm/ftrace.h
+++ b/arch/s390/include/asm/ftrace.h
@@ -4,7 +4,7 @@
 
 #define ARCH_SUPPORTS_FTRACE_OPS 1
 
-#ifdef CC_USING_HOTPATCH
+#if defined(CC_USING_HOTPATCH) || defined(CC_USING_NOP_MCOUNT)
 #define MCOUNT_INSN_SIZE	6
 #else
 #define MCOUNT_INSN_SIZE	24
@@ -42,7 +42,7 @@ struct ftrace_insn {
 static inline void ftrace_generate_nop_insn(struct ftrace_insn *insn)
 {
 #ifdef CONFIG_FUNCTION_TRACER
-#ifdef CC_USING_HOTPATCH
+#if defined(CC_USING_HOTPATCH) || defined(CC_USING_NOP_MCOUNT)
 	/* brcl 0,0 */
 	insn->opc = 0xc004;
 	insn->disp = 0;
@@ -57,7 +57,7 @@ static inline void ftrace_generate_nop_insn(struct ftrace_insn *insn)
 static inline int is_ftrace_nop(struct ftrace_insn *insn)
 {
 #ifdef CONFIG_FUNCTION_TRACER
-#ifdef CC_USING_HOTPATCH
+#if defined(CC_USING_HOTPATCH) || defined(CC_USING_NOP_MCOUNT)
 	if (insn->disp == 0)
 		return 1;
 #else
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index dc76d813e420..84be7f02d0c2 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -61,7 +61,7 @@ unsigned long ftrace_plt;
 
 static inline void ftrace_generate_orig_insn(struct ftrace_insn *insn)
 {
-#ifdef CC_USING_HOTPATCH
+#if defined(CC_USING_HOTPATCH) || defined(CC_USING_NOP_MCOUNT)
 	/* brcl 0,0 */
 	insn->opc = 0xc004;
 	insn->disp = 0;
diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index 27110f3294ed..e93fbf02490c 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -35,7 +35,7 @@ ENTRY(ftrace_caller)
 	.globl	ftrace_regs_caller
 	.set	ftrace_regs_caller,ftrace_caller
 	lgr	%r1,%r15
-#ifndef CC_USING_HOTPATCH
+#if !(defined(CC_USING_HOTPATCH) || defined(CC_USING_NOP_MCOUNT))
 	aghi	%r0,MCOUNT_RETURN_FIXUP
 #endif
 	aghi	%r15,-STACK_FRAME_SIZE
-- 
2.18.0.13.gd42ae10
