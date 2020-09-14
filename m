Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbgINPjx (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Sep 2020 11:39:53 -0400
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v3 2/3] arm64: stacktrace: Make stack walk callback consistent with generic code
Date: Mon, 14 Sep 2020 16:34:08 +0100
Message-Id: <20200914153409.25097-3-broonie@kernel.org>
In-Reply-To: <20200914153409.25097-1-broonie@kernel.org>
References: <20200914153409.25097-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "H . Peter Anvin" <hpa@zytor.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, Miroslav Benes <mbenes@suse.cz>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>

As with the generic arch_stack_walk() code the arm64 stack walk code takes
a callback that is called per stack frame. Currently the arm64 code always
passes a struct stackframe to the callback and the generic code just passes
the pc, however none of the users ever reference anything in the struct
other than the pc value. The arm64 code also uses a return type of int
while the generic code uses a return type of bool though in both cases the
return value is a boolean value and the sense is inverted between the two.

In order to reduce code duplication when arm64 is converted to use
arch_stack_walk() change the signature and return sense of the arm64
specific callback to match that of the generic code.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/stacktrace.h |  2 +-
 arch/arm64/kernel/perf_callchain.c  |  6 +++---
 arch/arm64/kernel/return_address.c  |  8 ++++----
 arch/arm64/kernel/stacktrace.c      | 11 +++++------
 4 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
index fc7613023c19..eb29b1fe8255 100644
--- a/arch/arm64/include/asm/stacktrace.h
+++ b/arch/arm64/include/asm/stacktrace.h
@@ -63,7 +63,7 @@ struct stackframe {
 
 extern int unwind_frame(struct task_struct *tsk, struct stackframe *frame);
 extern void walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
-			    int (*fn)(struct stackframe *, void *), void *data);
+			    bool (*fn)(void *, unsigned long), void *data);
 extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
 			   const char *loglvl);
 
diff --git a/arch/arm64/kernel/perf_callchain.c b/arch/arm64/kernel/perf_callchain.c
index b0e03e052dd1..88ff471b0bce 100644
--- a/arch/arm64/kernel/perf_callchain.c
+++ b/arch/arm64/kernel/perf_callchain.c
@@ -137,11 +137,11 @@ void perf_callchain_user(struct perf_callchain_entry_ctx *entry,
  * whist unwinding the stackframe and is like a subroutine return so we use
  * the PC.
  */
-static int callchain_trace(struct stackframe *frame, void *data)
+static bool callchain_trace(void *data, unsigned long pc)
 {
 	struct perf_callchain_entry_ctx *entry = data;
-	perf_callchain_store(entry, frame->pc);
-	return 0;
+	perf_callchain_store(entry, pc);
+	return true;
 }
 
 void perf_callchain_kernel(struct perf_callchain_entry_ctx *entry,
diff --git a/arch/arm64/kernel/return_address.c b/arch/arm64/kernel/return_address.c
index a5e8b3b9d798..a6d18755652f 100644
--- a/arch/arm64/kernel/return_address.c
+++ b/arch/arm64/kernel/return_address.c
@@ -18,16 +18,16 @@ struct return_address_data {
 	void *addr;
 };
 
-static int save_return_addr(struct stackframe *frame, void *d)
+static bool save_return_addr(void *d, unsigned long pc)
 {
 	struct return_address_data *data = d;
 
 	if (!data->level) {
-		data->addr = (void *)frame->pc;
-		return 1;
+		data->addr = (void *)pc;
+		return false;
 	} else {
 		--data->level;
-		return 0;
+		return true;
 	}
 }
 NOKPROBE_SYMBOL(save_return_addr);
diff --git a/arch/arm64/kernel/stacktrace.c b/arch/arm64/kernel/stacktrace.c
index 2dd8e3b8b94b..05eaba21fd46 100644
--- a/arch/arm64/kernel/stacktrace.c
+++ b/arch/arm64/kernel/stacktrace.c
@@ -118,12 +118,12 @@ int notrace unwind_frame(struct task_struct *tsk, struct stackframe *frame)
 NOKPROBE_SYMBOL(unwind_frame);
 
 void notrace walk_stackframe(struct task_struct *tsk, struct stackframe *frame,
-		     int (*fn)(struct stackframe *, void *), void *data)
+			     bool (*fn)(void *, unsigned long), void *data)
 {
 	while (1) {
 		int ret;
 
-		if (fn(frame, data))
+		if (!fn(data, frame->pc))
 			break;
 		ret = unwind_frame(tsk, frame);
 		if (ret < 0)
@@ -139,17 +139,16 @@ struct stack_trace_data {
 	unsigned int skip;
 };
 
-static int save_trace(struct stackframe *frame, void *d)
+static bool save_trace(void *d, unsigned long addr)
 {
 	struct stack_trace_data *data = d;
 	struct stack_trace *trace = data->trace;
-	unsigned long addr = frame->pc;
 
 	if (data->no_sched_functions && in_sched_functions(addr))
-		return 0;
+		return false;
 	if (data->skip) {
 		data->skip--;
-		return 0;
+		return false;
 	}
 
 	trace->entries[trace->nr_entries++] = addr;
-- 
2.20.1
