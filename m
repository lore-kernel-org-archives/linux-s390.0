Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728165AbgHSMuG (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 19 Aug 2020 08:50:06 -0400
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/3] stacktrace: Remove reliable argument from arch_stack_walk() callback
Date: Wed, 19 Aug 2020 13:49:11 +0100
Message-Id: <20200819124913.37261-2-broonie@kernel.org>
In-Reply-To: <20200819124913.37261-1-broonie@kernel.org>
References: <20200819124913.37261-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Jiri Slaby <jirislaby@kernel.org>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>, Mark Brown <broonie@kernel.org>

Currently the callback passed to arch_stack_walk() has an argument called
reliable passed to it to indicate if the stack entry is reliable, a comment
says that this is used by some printk() consumers. However in the current
kernel none of the arch_stack_walk() implementations ever set this flag to
true and the only callback implementation we have is in the generic
stacktrace code which ignores the flag. It therefore appears that this
flag is redundant so we can simplify and clarify things by removing it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/s390/kernel/stacktrace.c |  4 ++--
 arch/x86/kernel/stacktrace.c  | 10 +++++-----
 include/linux/stacktrace.h    |  5 +----
 kernel/stacktrace.c           |  8 +++-----
 4 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
index fc5419ac64c8..7f1266c24f6b 100644
--- a/arch/s390/kernel/stacktrace.c
+++ b/arch/s390/kernel/stacktrace.c
@@ -19,7 +19,7 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 
 	unwind_for_each_frame(&state, task, regs, 0) {
 		addr = unwind_get_return_address(&state);
-		if (!addr || !consume_entry(cookie, addr, false))
+		if (!addr || !consume_entry(cookie, addr))
 			break;
 	}
 }
@@ -56,7 +56,7 @@ int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
 			return -EINVAL;
 #endif
 
-		if (!consume_entry(cookie, addr, false))
+		if (!consume_entry(cookie, addr))
 			return -EINVAL;
 	}
 
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 2fd698e28e4d..8627fda8d993 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -18,13 +18,13 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 	struct unwind_state state;
 	unsigned long addr;
 
-	if (regs && !consume_entry(cookie, regs->ip, false))
+	if (regs && !consume_entry(cookie, regs->ip))
 		return;
 
 	for (unwind_start(&state, task, regs, NULL); !unwind_done(&state);
 	     unwind_next_frame(&state)) {
 		addr = unwind_get_return_address(&state);
-		if (!addr || !consume_entry(cookie, addr, false))
+		if (!addr || !consume_entry(cookie, addr))
 			break;
 	}
 }
@@ -72,7 +72,7 @@ int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
 		if (!addr)
 			return -EINVAL;
 
-		if (!consume_entry(cookie, addr, false))
+		if (!consume_entry(cookie, addr))
 			return -EINVAL;
 	}
 
@@ -114,7 +114,7 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 {
 	const void __user *fp = (const void __user *)regs->bp;
 
-	if (!consume_entry(cookie, regs->ip, false))
+	if (!consume_entry(cookie, regs->ip))
 		return;
 
 	while (1) {
@@ -128,7 +128,7 @@ void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 			break;
 		if (!frame.ret_addr)
 			break;
-		if (!consume_entry(cookie, frame.ret_addr, false))
+		if (!consume_entry(cookie, frame.ret_addr))
 			break;
 		fp = frame.next_fp;
 	}
diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index b7af8cc13eda..50e2df30b0aa 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -29,14 +29,11 @@ unsigned int stack_trace_save_user(unsigned long *store, unsigned int size);
  * stack_trace_consume_fn - Callback for arch_stack_walk()
  * @cookie:	Caller supplied pointer handed back by arch_stack_walk()
  * @addr:	The stack entry address to consume
- * @reliable:	True when the stack entry is reliable. Required by
- *		some printk based consumers.
  *
  * Return:	True, if the entry was consumed or skipped
  *		False, if there is no space left to store
  */
-typedef bool (*stack_trace_consume_fn)(void *cookie, unsigned long addr,
-				       bool reliable);
+typedef bool (*stack_trace_consume_fn)(void *cookie, unsigned long addr);
 /**
  * arch_stack_walk - Architecture specific function to walk the stack
  * @consume_entry:	Callback which is invoked by the architecture code for
diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index 946f44a9e86a..9f8117c7cfdd 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -78,8 +78,7 @@ struct stacktrace_cookie {
 	unsigned int	len;
 };
 
-static bool stack_trace_consume_entry(void *cookie, unsigned long addr,
-				      bool reliable)
+static bool stack_trace_consume_entry(void *cookie, unsigned long addr)
 {
 	struct stacktrace_cookie *c = cookie;
 
@@ -94,12 +93,11 @@ static bool stack_trace_consume_entry(void *cookie, unsigned long addr,
 	return c->len < c->size;
 }
 
-static bool stack_trace_consume_entry_nosched(void *cookie, unsigned long addr,
-					      bool reliable)
+static bool stack_trace_consume_entry_nosched(void *cookie, unsigned long addr)
 {
 	if (in_sched_functions(addr))
 		return true;
-	return stack_trace_consume_entry(cookie, addr, reliable);
+	return stack_trace_consume_entry(cookie, addr);
 }
 
 /**
-- 
2.20.1
