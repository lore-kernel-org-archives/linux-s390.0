Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alex Dowad <alexinbeijing@gmail.com>
Subject: [PATCH 24/32] s390: copy_thread(): rename 'arg' argument to 'kthread_arg'
Date: Fri, 13 Mar 2015 20:14:47 +0200
Message-Id: <1426270496-26362-14-git-send-email-alexinbeijing@gmail.com>
In-Reply-To: <1426270496-26362-1-git-send-email-alexinbeijing@gmail.com>
References: <1426270496-26362-1-git-send-email-alexinbeijing@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "supporter:S390" <linux390@de.ibm.com>, Hendrik Brueckner <brueckner@linux.vnet.ibm.com>, "open list:S390" <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

The 'arg' argument to copy_thread() is only ever used when forking a new
kernel thread. Hence, rename it to 'kthread_arg' for clarity (and consistency
with do_fork() and other arch-specific implementations of copy_thread()).

Signed-off-by: Alex Dowad <alexinbeijing@gmail.com>
---
 arch/s390/kernel/process.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 13fc097..a1ca7cf 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -87,8 +87,11 @@ void arch_release_task_struct(struct task_struct *tsk)
 }
 #endif
 
+/*
+ * Copy architecture-specific thread state
+ */
 int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
-		unsigned long arg, struct task_struct *p)
+		unsigned long kthread_arg, struct task_struct *p)
 {
 	struct thread_info *ti;
 	struct fake_frame
@@ -127,12 +130,14 @@ int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
 		frame->childregs.psw.addr = PSW_ADDR_AMODE |
 				(unsigned long) kernel_thread_starter;
 		frame->childregs.gprs[9] = new_stackp; /* function */
-		frame->childregs.gprs[10] = arg;
+		frame->childregs.gprs[10] = kthread_arg;
 		frame->childregs.gprs[11] = (unsigned long) do_exit;
 		frame->childregs.orig_gpr2 = -1;
 
 		return 0;
 	}
+
+	/* user thread */
 	frame->childregs = *current_pt_regs();
 	frame->childregs.gprs[2] = 0;	/* child returns 0 on fork. */
 	frame->childregs.flags = 0;
-- 
2.0.0.GIT
