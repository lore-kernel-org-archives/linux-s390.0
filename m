Return-Path: <linux-kernel-owner+w=401wt.eu-S1755134Ab0AUUvj@vger.kernel.org>
Date: Thu, 21 Jan 2010 21:51:13 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
	results on s390x)
Message-ID: <20100121205113.GB20050@redhat.com>
References: <20100105153633.GA9376@redhat.com> <20100105164610.388effd3@mschwide.boeblingen.de.ibm.com> <20100105155913.GA10652@redhat.com> <20100105170301.GA13641@redhat.com> <20100105195818.GA20358@redhat.com> <20100106201722.GB26204@redhat.com> <20100106211329.DB4F5134D@magilla.sf.frob.com> <20100107101855.13248dc2@mschwide.boeblingen.de.ibm.com> <20100107175446.GA13300@redhat.com> <20100107214821.94FF97300@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100107214821.94FF97300@magilla.sf.frob.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 01/07, Roland McGrath wrote:
>
> > I am confused as well. Yes, I thought about regs->psw.mask change too,
> > but I don't understand why it helps..
> [...]
> > But. Acoording to the testing I did (unless I did something wrong
> > again) this patch doesn't make any difference in this particular
> > case. 6580807da14c423f0d0a708108e6df6ebc8bc83d does.
>
> Those results are quite mysterious to me.
> I think we'll have to get Martin to sort it out definitively.

I did the testing again with 2.6.32-5.el6 + Martin's
	c3311c13adc1021e986fef12609ceb395ffc5014
	f8d5faf718c9ff2c04eb8484585d4963c4111cd7
patches.

the same test-case:

	#include <stdio.h>
	#include <unistd.h>
	#include <signal.h>
	#include <sys/ptrace.h>
	#include <sys/wait.h>
	#include <assert.h>

	int main(void)
	{
		int pid, status;

		if (!(pid = fork())) {
			assert(ptrace(PTRACE_TRACEME) == 0);
			kill(getpid(), SIGSTOP);

			if (!fork())
				return 43;

			wait(&status);
			return WEXITSTATUS(status);
		}


		for (;;) {
			assert(pid == wait(&status));
			if (WIFEXITED(status))
				break;
			assert(ptrace(PTRACE_SINGLESTEP, pid, 0,0) == 0);
		}

		assert(WEXITSTATUS(status) == 43);
		return 0;
	}

with the simple debugging patch below I did

	# perl -e 'syscall 172, 666, 0,0'; ./xxx
	# perl -e 'syscall 172, 666, 0,1'; ./xxx
	# perl -e 'syscall 172, 666, 1,0'; ./xxx
	# perl -e 'syscall 172, 666, 1,1'; ./xxx

and dmesg reports:

	XXX disable_step=0, clear_flag=0
	XXX: xxx/1868 0
	[... 799 times ...]
	XXX disable_step=0, clear_flag=1
	XXX: xxx/1905 0
	[... 799 times ...]
	XXX disable_step=1, clear_flag=0
	XXX disable_step=1, clear_flag=1

Just in case, I did the testing with and without CONFIG_UTRACE,
result is the same.

IOW, copy_thread()->clear_tsk_thread_flag(TIF_SINGLE_STEP) doesn't
make any difference, copy_process()->user_disable_single_step() does.

Although I need to re-read Martin's explanations about psw magic,
perhaps this was already explained...

Oleg.

--- K/kernel/sys.c~	2010-01-21 14:16:15.366639654 -0500
+++ K/kernel/sys.c	2010-01-21 14:30:35.131591879 -0500
@@ -1453,6 +1453,8 @@ SYSCALL_DEFINE1(umask, int, mask)
 	return mask;
 }
 
+int xxx_disable_step, xxx_clear_flag;
+
 SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2, unsigned long, arg3,
 		unsigned long, arg4, unsigned long, arg5)
 {
@@ -1466,6 +1468,13 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 
 	error = 0;
 	switch (option) {
+		case 666:
+			xxx_disable_step = arg2;
+			xxx_clear_flag = arg3;
+			printk(KERN_INFO "XXX disable_step=%d, clear_flag=%d\n",
+				xxx_disable_step, xxx_clear_flag);
+			break;
+
 		case PR_SET_PDEATHSIG:
 			if (!valid_signal(arg2)) {
 				error = -EINVAL;
--- K/kernel/fork.c~	2010-01-18 09:35:16.823811008 -0500
+++ K/kernel/fork.c	2010-01-21 14:29:39.131624971 -0500
@@ -964,6 +964,8 @@ static void posix_cpu_timers_init(struct
 	INIT_LIST_HEAD(&tsk->cpu_timers[2]);
 }
 
+extern int xxx_disable_step;
+
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.
@@ -1207,7 +1209,8 @@ static struct task_struct *copy_process(
 	 * Syscall tracing and stepping should be turned off in the
 	 * child regardless of CLONE_PTRACE.
 	 */
-	user_disable_single_step(p);
+	if (xxx_disable_step)
+		user_disable_single_step(p);
 	clear_tsk_thread_flag(p, TIF_SYSCALL_TRACE);
 #ifdef TIF_SYSCALL_EMU
 	clear_tsk_thread_flag(p, TIF_SYSCALL_EMU);
--- K/arch/s390/kernel/process.c~	2010-01-21 14:32:38.541609793 -0500
+++ K/arch/s390/kernel/process.c	2010-01-21 14:34:10.461584130 -0500
@@ -161,6 +161,8 @@ void release_thread(struct task_struct *
 {
 }
 
+extern int xxx_clear_flag;
+
 int copy_thread(unsigned long clone_flags, unsigned long new_stackp,
 		unsigned long unused,
 		struct task_struct *p, struct pt_regs *regs)
@@ -217,7 +219,8 @@ int copy_thread(unsigned long clone_flag
 	p->thread.mm_segment = get_fs();
 	/* Don't copy debug registers */
 	memset(&p->thread.per_info, 0, sizeof(p->thread.per_info));
-	clear_tsk_thread_flag(p, TIF_SINGLE_STEP);
+	if (xxx_clear_flag)
+		clear_tsk_thread_flag(p, TIF_SINGLE_STEP);
 	/* Initialize per thread user and system timer values */
 	ti = task_thread_info(p);
 	ti->user_timer = 0;
