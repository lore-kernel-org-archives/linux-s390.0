Return-Path: <linux-kernel-owner+w=401wt.eu-S1762693AbYD3Liw@vger.kernel.org>
Subject: Re: [patch] s390: Remove self ptrace IEEE_IP hack.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
In-Reply-To: <20080430091900.GA13743@infradead.org>
References: <1209546896.10954.28.camel@localhost>
	 <20080430091900.GA13743@infradead.org>
Content-Type: text/plain
Date: Wed, 30 Apr 2008 13:36:33 +0200
Message-Id: <1209555393.10954.32.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2008-04-30 at 05:19 -0400, Christoph Hellwig wrote:
> After this the switch to the generic sys_ptrace is trivial.  Care to
> submit a patch for that aswell?
> 

Here we go..

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.

---
Subject: [PATCH] s390: use generic sys_ptrace

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

After the PT_IEEE_IP hack has been removed s390 can now use
the common code sys_ptrace function.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/ptrace.c |   37 +------------------------------------
 include/asm-s390/ptrace.h |    2 --
 2 files changed, 1 insertion(+), 38 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/ptrace.c linux-2.6-patched/arch/s390/kernel/ptrace.c
--- linux-2.6/arch/s390/kernel/ptrace.c	2008-04-30 13:33:14.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/ptrace.c	2008-04-30 13:33:14.000000000 +0200
@@ -607,18 +607,8 @@ do_ptrace_emu31(struct task_struct *chil
 }
 #endif
 
-static int
-do_ptrace(struct task_struct *child, long request, long addr, long data)
+long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 {
-	int ret;
-
-	if (request == PTRACE_ATTACH)
-		return ptrace_attach(child);
-
-	ret = ptrace_check_attach(child, request == PTRACE_KILL);
-	if (ret < 0)
-		return ret;
-
 	switch (request) {
 	case PTRACE_SYSCALL:
 		/* continue and stop at next (return from) syscall */
@@ -673,31 +663,6 @@ do_ptrace(struct task_struct *child, lon
 	return -EIO;
 }
 
-asmlinkage long
-sys_ptrace(long request, long pid, long addr, long data)
-{
-	struct task_struct *child;
-	int ret;
-
-	lock_kernel();
-	if (request == PTRACE_TRACEME) {
-		 ret = ptrace_traceme();
-		 goto out;
-	}
-
-	child = ptrace_get_task_struct(pid);
-	if (IS_ERR(child)) {
-		ret = PTR_ERR(child);
-		goto out;
-	}
-
-	ret = do_ptrace(child, request, addr, data);
-	put_task_struct(child);
-out:
-	unlock_kernel();
-	return ret;
-}
-
 asmlinkage void
 syscall_trace(struct pt_regs *regs, int entryexit)
 {
diff -urpN linux-2.6/include/asm-s390/ptrace.h linux-2.6-patched/include/asm-s390/ptrace.h
--- linux-2.6/include/asm-s390/ptrace.h	2008-04-17 04:49:44.000000000 +0200
+++ linux-2.6-patched/include/asm-s390/ptrace.h	2008-04-30 13:33:14.000000000 +0200
@@ -463,8 +463,6 @@ struct user_regs_struct
 };
 
 #ifdef __KERNEL__
-#define __ARCH_SYS_PTRACE	1
-
 /*
  * These are defined as per linux/ptrace.h, which see.
  */
