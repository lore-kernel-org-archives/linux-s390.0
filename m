Return-Path: <linux-kernel-owner+w=401wt.eu-S1753504Ab0ADPwe@vger.kernel.org>
Date: Mon, 4 Jan 2010 16:52:25 +0100
From: Oleg Nesterov <oleg@redhat.com>
Subject: s390 && user_enable_single_step() (Was: odd utrace testing results
	on s390x)
Message-ID: <20100104155225.GA16650@redhat.com>
References: <1503844142.2061111261478093776.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com> <1257887498.2061171261478252049.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1257887498.2061171261478252049.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Jan Kratochvil <jkratoch@redhat.com>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

Hi!

We have some strange problems with utrace on s390, and so far this _looks_
like a s390 problem.

Looks like, on any CPU user_enable_single_step() does not "work" until at
least one thread with per_info.single_step = 1 does the context switch.

This doesn't matter with the old ptrace implementation, but with utrace
the tracee itself does user_enable_single_step(current) and returns to
user-mode. Until it does at least one context switch the single-stepping
doesn't work, after that everything works fine till the next reboot.

To rule out the possible problems with ptrace or utrace, I did the trivial
patch:

--- K/kernel/sys.c~	2009-12-29 10:45:25.787198223 -0500
+++ K/kernel/sys.c	2010-01-03 13:04:00.485591316 -0500
@@ -1444,6 +1444,17 @@ SYSCALL_DEFINE5(prctl, int, option, unsi
 
 	error = 0;
 	switch (option) {
+		case 666:
+			user_enable_single_step(current);
+			break;
+
+		case 777:
+			/* same as 666, but force the context switch
+			 * after user_enable_single_step() */
+			user_enable_single_step(current);
+			schedule_timeout_interruptible(HZ/10);
+			break;
+
 		case PR_SET_PDEATHSIG:
 			if (!valid_signal(arg2)) {
 				error = -EINVAL;
--- K/arch/s390/kernel/traps.c~	2009-12-22 10:41:52.909174198 -0500
+++ K/arch/s390/kernel/traps.c	2009-12-30 10:31:12.985266686 -0500
@@ -378,11 +378,14 @@ static inline void __user *get_check_add
 
 void __kprobes do_single_step(struct pt_regs *regs)
 {
+	printk("SS enter\n");
+
 	if (notify_die(DIE_SSTEP, "sstep", regs, 0, 0,
 					SIGTRAP) == NOTIFY_STOP){
+		printk(KERN_INFO "SS cancelled ???\n");
 		return;
 	}
-	if (tracehook_consider_fatal_signal(current, SIGTRAP))
+//	if (tracehook_consider_fatal_signal(current, SIGTRAP))
 		force_sig(SIGTRAP, current);
 }
 
-------------------------------------------------------------------------------

The change in do_single_step() just removes "is it traced" check
and adds a couple of printk's.


With this patch I assume that the task which does prctl(666) should
be killed by SIGTRAP, but this doesn't happen:

	# taskset -c 0 perl -le 'syscall 172,666 and die $!'
	# taskset -c 0 perl -le 'syscall 172,666 and die $!'
	# taskset -c 0 perl -le 'syscall 172,666 and die $!'

	(syscall 172,666 == prctl(666))

the task exits normally, there is nothing in dmesg.

However,

	# taskset -c 0 perl -le 'syscall 172,777 and die $!'
	Trace/breakpoint trap

Now prctl(777)->user_enable_single_step() does work, the task is
killed by do_single_step()->force_sig(SIGTRAP).

Now prctl(666) works too on CPU 0

	# taskset -c 0 perl -le 'syscall 172,666 and die $!'
	Trace/breakpoint trap
	# taskset -c 0 perl -le 'syscall 172,666 and die $!'
	Trace/breakpoint trap
	# taskset -c 0 perl -le 'syscall 172,666 and die $!'
	Trace/breakpoint trap



And please note "# taskset -c 0", we can repeat the same on another
CPU:

	# taskset -c 1 perl -le 'syscall 172,666 and die $!'
	# taskset -c 1 perl -le 'syscall 172,666 and die $!'

doesn't work, but

	# taskset -c 1 perl -le 'syscall 172,777 and die $!'
	Trace/breakpoint trap

magically "fixes" user_enable_single_step(), now we can use prctl(666)
on CPU 1.


The kernel is 2.6.32.2 plus ca633fd006486ed2c2d3b542283067aab61e6dc8,
could you help?

Oleg.
