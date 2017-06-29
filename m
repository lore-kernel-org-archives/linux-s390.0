From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 29 Jun 2017 09:38:11 +0000
Subject: [PATCH] s390/syscalls: Fix out of bounds arguments access
Message-Id: <20170629093811.6364-1-jolsa@kernel.org>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Zorro reported following crash while having enabled
syscall tracing (CONFIG_FTRACE_SYSCALLS):

  Unable to handle kernel pointer dereference at virtual ...
  Oops: 0011 [#1] SMP DEBUG_PAGEALLOC

  SNIP

  Call Trace:
  ([<000000000024d79c>] ftrace_syscall_enter+0xec/0x1d8)
   [<00000000001099c6>] do_syscall_trace_enter+0x236/0x2f8
   [<0000000000730f1c>] sysc_tracesys+0x1a/0x32
   [<000003fffcf946a2>] 0x3fffcf946a2
  INFO: lockdep is turned off.
  Last Breaking-Event-Address:
   [<000000000022dd44>] rb_event_data+0x34/0x40
  ---[ end trace 8c795f86b1b3f7b9 ]---

The crash happens in syscall_get_arguments function for
syscalls with zero arguments, that will try to access
first argument (args[0]) in event entry, but it's not
allocated.

Bail out of there are no arguments.

Reported-by: Zorro Lang <zlang@redhat.com>
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/s390/include/asm/syscall.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
index 6ba0bf928909..5f7c11c932fa 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -64,14 +64,22 @@ static inline void syscall_get_arguments(struct task_struct *task,
 {
 	unsigned long mask = -1UL;
 
+	/*
+	 * No arguments for this syscall, there's nothing to do.
+	 */
+	if (!n)
+		return;
+
 	BUG_ON(i + n > 6);
 #ifdef CONFIG_COMPAT
 	if (test_tsk_thread_flag(task, TIF_31BIT))
 		mask = 0xffffffff;
 #endif
-	while (n-- > 0)
+	while (n-- > 0) {
 		if (i + n > 0)
 			args[n] = regs->gprs[2 + i + n] & mask;
+	}
+
 	if (i == 0)
 		args[0] = regs->orig_gpr2 & mask;
 }
-- 
2.9.4
