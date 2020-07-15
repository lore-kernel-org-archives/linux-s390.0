Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727795AbgGOUpE (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 15 Jul 2020 16:45:04 -0400
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 3/3] arm64: stacktrace: Convert to ARCH_STACKWALK
Date: Wed, 15 Jul 2020 21:28:21 +0100
Message-Id: <20200715202821.12220-4-broonie@kernel.org>
In-Reply-To: <20200715202821.12220-1-broonie@kernel.org>
References: <20200715202821.12220-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>

Historically architectures have had duplicated code in their stack trace
implementations for filtering what gets traced. In order to avoid this
duplication some generic code has been provided using a new interface
arch_stack_walk(), enabled by selecting ARCH_STACKWALK in Kconfig, which
factors all this out into the generic stack trace code. Convert arm64
to use this common infrastructure.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/Kconfig             |  1 +
 arch/arm64/kernel/stacktrace.c | 79 ++++------------------------------
 2 files changed, 9 insertions(+), 71 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5d4f02b3dfe9..6ed4b6c6df95 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -29,6 +29,7 @@ config ARM64
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_SET_MEMORY
+	select ARCH_STACKWALK
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 743cf11fbfca..a33fba048954 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -133,82 +133,19 @@ void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
 NOKPROBE_SYMBOL(walk_stackframe);
 
 #ifdef CONFIG_STACKTRACE
-struct stack_trace_data {
-	struct stack_trace *trace;
-	unsigned int no_sched_functions;
-	unsigned int skip;
-};
 
-static bool save_trace(void *d, unsigned long addr)
+void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
+		     struct task_struct *task, struct pt_regs *regs)
 {
-	struct stack_trace_data *data = d;
-	struct stack_trace *trace = data->trace;
-
-	if (data->no_sched_functions && in_sched_functions(addr))
-		return false;
-	if (data->skip) {
-		data->skip--;
-		return false;
-	}
-
-	trace->entries[trace->nr_entries++] = addr;
-
-	return trace->nr_entries >= trace->max_entries;
-}
-
-void save_stack_trace_regs(struct pt_regs *regs, struct stack_trace *trace)
-{
-	struct stack_trace_data data;
-	struct stackframe frame;
-
-	data.trace = trace;
-	data.skip = trace->skip;
-	data.no_sched_functions = 0;
-
-	start_backtrace(&frame, regs->regs[29], regs->pc);
-	walk_stackframe(current, &frame, save_trace, &data);
-}
-EXPORT_SYMBOL_GPL(save_stack_trace_regs);
-
-static noinline void __save_stack_trace(struct task_struct *tsk,
-	struct stack_trace *trace, unsigned int nosched)
-{
-	struct stack_trace_data data;
 	struct stackframe frame;
 
-	if (!try_get_task_stack(tsk))
-		return;
+	if (regs)
+		start_backtrace(&frame, regs->regs[29], regs->pc);
+	else
+		start_backtrace(&frame, thread_saved_fp(task),
+				thread_saved_pc(task));
 
-	data.trace = trace;
-	data.skip = trace->skip;
-	data.no_sched_functions = nosched;
-
-	if (tsk != current) {
-		start_backtrace(&frame, thread_saved_fp(tsk),
-				thread_saved_pc(tsk));
-	} else {
-		/* We don't want this function nor the caller */
-		data.skip += 2;
-		start_backtrace(&frame,
-				(unsigned long)__builtin_frame_address(0),
-				(unsigned long)__save_stack_trace);
-	}
-
-	walk_stackframe(tsk, &frame, save_trace, &data);
-
-	put_task_stack(tsk);
-}
-
-void save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace)
-{
-	__save_stack_trace(tsk, trace, 1);
-}
-EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
-
-void save_stack_trace(struct stack_trace *trace)
-{
-	__save_stack_trace(current, trace, 0);
+	walk_stackframe(task, &frame, consume_entry, cookie);
 }
 
-EXPORT_SYMBOL_GPL(save_stack_trace);
 #endif
-- 
2.20.1
