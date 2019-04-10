Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
Message-Id: <20190410103644.396788431@linutronix.de>
Date: Wed, 10 Apr 2019 12:28:03 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC patch 09/41] s390/stacktrace: Remove the pointless ULONG_MAX
 marker
References: <20190410102754.387743324@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Alexander Potapenko <glider@google.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Terminating the last trace entry with ULONG_MAX is a completely pointless
exercise and none of the consumers can rely on it because it's
inconsistently implemented across architectures. In fact quite some of the
callers remove the entry and adjust stack_trace.nr_entries afterwards.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/kernel/stacktrace.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/arch/s390/kernel/stacktrace.c
+++ b/arch/s390/kernel/stacktrace.c
@@ -45,8 +45,6 @@ void save_stack_trace(struct stack_trace
 
 	sp = current_stack_pointer();
 	dump_trace(save_address, trace, NULL, sp);
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 EXPORT_SYMBOL_GPL(save_stack_trace);
 
@@ -58,8 +56,6 @@ void save_stack_trace_tsk(struct task_st
 	if (tsk == current)
 		sp = current_stack_pointer();
 	dump_trace(save_address_nosched, trace, tsk, sp);
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_tsk);
 
@@ -69,7 +65,5 @@ void save_stack_trace_regs(struct pt_reg
 
 	sp = kernel_stack_pointer(regs);
 	dump_trace(save_address, trace, NULL, sp);
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 EXPORT_SYMBOL_GPL(save_stack_trace_regs);
