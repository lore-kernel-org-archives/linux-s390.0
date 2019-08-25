Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37602 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfHYNZA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 25 Aug 2019 09:25:00 -0400
From: Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 09/11] x86_64: add function prototype recording support
Date: Sun, 25 Aug 2019 21:23:28 +0800
Message-Id: <20190825132330.5015-10-changbin.du@gmail.com>
In-Reply-To: <20190825132330.5015-1-changbin.du@gmail.com>
References: <20190825132330.5015-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Jessica Yu <jeyu@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org, linux-kbuild@vger.kernel.org, Changbin Du <changbin.du@gmail.com>

This patch implements the arch_fgraph_record_params() function for x86_64
platform and deliver the return value of function to ftrace core part.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 arch/x86/Kconfig            |  1 +
 arch/x86/kernel/ftrace.c    | 84 +++++++++++++++++++++++++++++++++++--
 arch/x86/kernel/ftrace_64.S |  4 +-
 3 files changed, 85 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 222855cc0158..34e583bfdab8 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -31,6 +31,7 @@ config X86_64
 	select NEED_DMA_MAP_STATE
 	select SWIOTLB
 	select ARCH_HAS_SYSCALL_WRAPPER
+	select HAVE_FTRACE_FUNC_PROTOTYPE
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index a044734167af..fc0a062ce762 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -31,6 +31,7 @@
 #include <asm/ftrace.h>
 #include <asm/nops.h>
 #include <asm/text-patching.h>
+#include <asm-generic/dwarf.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
@@ -918,7 +919,8 @@ static void *addr_from_call(void *ptr)
 }
 
 void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
-			   unsigned long frame_pointer);
+			   unsigned long frame_pointer,
+			   struct pt_regs *pt_regs);
 
 /*
  * If the ops->trampoline was not allocated, then it probably
@@ -973,6 +975,82 @@ void arch_ftrace_trampoline_free(struct ftrace_ops *ops)
 	ops->trampoline = 0;
 }
 
+#ifdef CONFIG_FTRACE_FUNC_PROTOTYPE
+void arch_fgraph_record_params(struct ftrace_graph_ent *trace,
+			       struct func_prototype *proto,
+			       struct pt_regs *pt_regs)
+{
+	int i;
+
+	trace->nr_param = min(proto->nr_param, (uint8_t)FTRACE_MAX_FUNC_PARAMS);
+
+	for (i = 0; i < trace->nr_param; i++) {
+		struct func_param *param = &proto->params[i];
+		unsigned int sz = FTRACE_PROTOTYPE_SIZE(param->type);
+		long off = (char)param->loc[1];
+		unsigned long value = 0;
+		bool good = true;
+
+		if (sz > sizeof(value)) {
+			/* Don't record value of complex type. */
+			trace->param_types[i] = param->type;
+			trace->param_values[i] = 0;
+			continue;
+		}
+
+		switch (param->loc[0]) {
+		case DW_OP_reg1:
+			value = pt_regs->dx;
+			break;
+		case DW_OP_reg2:
+			value = pt_regs->cx;
+			break;
+		case DW_OP_reg3:
+			value = pt_regs->bx;
+			break;
+		case DW_OP_reg4:
+			value = pt_regs->si;
+			break;
+		case DW_OP_reg5:
+			value = pt_regs->di;
+			break;
+		case DW_OP_reg6:
+			value = pt_regs->bp;
+			break;
+		case DW_OP_reg8:
+			value = pt_regs->r8;
+			break;
+		case DW_OP_reg9:
+			value = pt_regs->r9;
+			break;
+		case DW_OP_fbreg:
+			if (probe_kernel_read(&value,
+					(void *)pt_regs->bp + off,
+					sz))
+				good = false;
+			break;
+		case DW_OP_breg7:
+			if (probe_kernel_read(&value,
+					(void *)pt_regs->sp + off,
+					sz))
+				good = false;
+			break;
+		default:
+			/* unexpected loc expression */
+			good = false;
+		}
+
+		trace->param_names[i] = param->name;
+		if (good) {
+			trace->param_types[i] = param->type;
+			trace->param_values[i] = value;
+		} else {
+			/* set the type to 0 so we skip it when printing. */
+			trace->param_types[i] = 0;
+		}
+	}
+}
+#endif /* CONFIG_FTRACE_FUNC_PROTOTYPE */
 #endif /* CONFIG_X86_64 */
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
@@ -1017,7 +1095,7 @@ int ftrace_disable_ftrace_graph_caller(void)
  * in current thread info.
  */
 void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
-			   unsigned long frame_pointer)
+			   unsigned long frame_pointer, struct pt_regs *pt_regs)
 {
 	unsigned long old;
 	int faulted;
@@ -1072,7 +1150,7 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent,
 		return;
 	}
 
-	if (function_graph_enter(old, self_addr, frame_pointer, parent, NULL))
+	if (function_graph_enter(old, self_addr, frame_pointer, parent, pt_regs))
 		*parent = old;
 }
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 809d54397dba..e01d6358e859 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -289,7 +289,8 @@ ENTRY(ftrace_graph_caller)
 
 	leaq MCOUNT_REG_SIZE+8(%rsp), %rsi
 	movq $0, %rdx	/* No framepointers needed */
-	call	prepare_ftrace_return
+	movq %rsp, %rcx /* the fourth parameter */
+	call prepare_ftrace_return
 
 	restore_mcount_regs
 
@@ -304,6 +305,7 @@ ENTRY(return_to_handler)
 	movq %rax, (%rsp)
 	movq %rdx, 8(%rsp)
 	movq %rbp, %rdi
+	movq %rax, %rsi
 
 	call ftrace_return_to_handler
 
-- 
2.20.1
