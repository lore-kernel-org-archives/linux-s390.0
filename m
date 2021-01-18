Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438039AbhARVRn (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Jan 2021 16:17:43 -0500
From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] stacktrace: Move documentation for arch_stack_walk_reliable() to header
Date: Mon, 18 Jan 2021 21:10:21 +0000
Message-Id: <20210118211021.42308-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Mark Brown <broonie@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>, x86@kernel.org, linux-s390@vger.kernel.org, live-patching@vger.kernel.org

Currently arch_stack_wallk_reliable() is documented with an identical
comment in both x86 and S/390 implementations which is a bit redundant.
Move this to the header and convert to kerneldoc while we're at it.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Petr Mladek <pmladek@suse.com>
Cc: Joe Lawrence <joe.lawrence@redhat.com>
Cc: x86@kernel.org
Cc: linux-s390@vger.kernel.org
Cc: live-patching@vger.kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/s390/kernel/stacktrace.c |  6 ------
 arch/x86/kernel/stacktrace.c  |  6 ------
 include/linux/stacktrace.h    | 19 +++++++++++++++++++
 3 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kernel/stacktrace.c b/arch/s390/kernel/stacktrace.c
index 7f1266c24f6b..101477b3e263 100644
--- a/arch/s390/kernel/stacktrace.c
+++ b/arch/s390/kernel/stacktrace.c
@@ -24,12 +24,6 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 	}
 }
 
-/*
- * This function returns an error if it detects any unreliable features of the
- * stack.  Otherwise it guarantees that the stack trace is reliable.
- *
- * If the task is not 'current', the caller *must* ensure the task is inactive.
- */
 int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
 			     void *cookie, struct task_struct *task)
 {
diff --git a/arch/x86/kernel/stacktrace.c b/arch/x86/kernel/stacktrace.c
index 8627fda8d993..15b058eefc4e 100644
--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -29,12 +29,6 @@ void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 	}
 }
 
-/*
- * This function returns an error if it detects any unreliable features of the
- * stack.  Otherwise it guarantees that the stack trace is reliable.
- *
- * If the task is not 'current', the caller *must* ensure the task is inactive.
- */
 int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry,
 			     void *cookie, struct task_struct *task)
 {
diff --git a/include/linux/stacktrace.h b/include/linux/stacktrace.h
index 50e2df30b0aa..9edecb494e9e 100644
--- a/include/linux/stacktrace.h
+++ b/include/linux/stacktrace.h
@@ -52,8 +52,27 @@ typedef bool (*stack_trace_consume_fn)(void *cookie, unsigned long addr);
  */
 void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
 		     struct task_struct *task, struct pt_regs *regs);
+
+/**
+ * arch_stack_walk_reliable - Architecture specific function to walk the
+ *			      stack reliably
+ *
+ * @consume_entry:	Callback which is invoked by the architecture code for
+ *			each entry.
+ * @cookie:		Caller supplied pointer which is handed back to
+ *			@consume_entry
+ * @task:		Pointer to a task struct, can be NULL
+ *
+ * This function returns an error if it detects any unreliable
+ * features of the stack. Otherwise it guarantees that the stack
+ * trace is reliable.
+ *
+ * If the task is not 'current', the caller *must* ensure the task is
+ * inactive and its stack is pinned.
+ */
 int arch_stack_walk_reliable(stack_trace_consume_fn consume_entry, void *cookie,
 			     struct task_struct *task);
+
 void arch_stack_walk_user(stack_trace_consume_fn consume_entry, void *cookie,
 			  const struct pt_regs *regs);
 
-- 
2.20.1
