Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC PATCH v2 05/18] sched: add task flag for preempt IRQ tracking
Date: Thu, 28 Apr 2016 15:44:36 -0500
Message-Id: <f8816223098569a9b2f478caa5b4a7a0c27dda00.1461875890.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1461875890.git.jpoimboe@redhat.com>
References: <cover.1461875890.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Petr Mladek <pmladek@suse.com>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

A preempted function might not have had a chance to save the frame
pointer to the stack yet, which can result in its caller getting skipped
on a stack trace.

Add a flag to indicate when the task has been preempted so that stack
dump code can determine whether the stack trace is reliable.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 include/linux/sched.h | 1 +
 kernel/fork.c         | 2 +-
 kernel/sched/core.c   | 4 ++++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 3d31572..fb364a0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2137,6 +2137,7 @@ extern void thread_group_cputime_adjusted(struct task_struct *p, cputime_t *ut,
 #define PF_SWAPWRITE	0x00800000	/* Allowed to write to swap */
 #define PF_NO_SETAFFINITY 0x04000000	/* Userland is not allowed to meddle with cpus_allowed */
 #define PF_MCE_EARLY    0x08000000      /* Early kill for mce process policy */
+#define PF_PREEMPT_IRQ	0x10000000	/* Thread is preempted by an irq */
 #define PF_MUTEX_TESTER	0x20000000	/* Thread belongs to the rt mutex tester */
 #define PF_FREEZER_SKIP	0x40000000	/* Freezer should not count it as freezable */
 #define PF_SUSPEND_TASK 0x80000000      /* this thread called freeze_processes and should not be frozen */
diff --git a/kernel/fork.c b/kernel/fork.c
index b73a539..d2fe04a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1373,7 +1373,7 @@ static struct task_struct *copy_process(unsigned long clone_flags,
 		goto bad_fork_cleanup_count;
 
 	delayacct_tsk_init(p);	/* Must remain after dup_task_struct() */
-	p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER);
+	p->flags &= ~(PF_SUPERPRIV | PF_WQ_WORKER | PF_PREEMPT_IRQ);
 	p->flags |= PF_FORKNOEXEC;
 	INIT_LIST_HEAD(&p->children);
 	INIT_LIST_HEAD(&p->sibling);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9d84d60..7594267 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3422,6 +3422,8 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 
 	prev_state = exception_enter();
 
+	current->flags |= PF_PREEMPT_IRQ;
+
 	do {
 		preempt_disable();
 		local_irq_enable();
@@ -3430,6 +3432,8 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
 
+	current->flags &= ~PF_PREEMPT_IRQ;
+
 	exception_exit(prev_state);
 }
 
-- 
2.4.11
