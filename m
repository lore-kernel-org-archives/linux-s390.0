Return-Path: <linux-kernel-owner+w=401wt.eu-S1760211AbXK1Kww@vger.kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [s390] build failure
Date: Wed, 28 Nov 2007 11:51:58 +0100
References: <200711281127.30051.elendil@planet.nl>
In-Reply-To: <200711281127.30051.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200711281151.58236.borntraeger@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Frans Pop <elendil@planet.nl>, schwidefsky@de.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Am Mittwoch, 28. November 2007 schrieb Frans Pop:
> $ git describe
> v2.6.24-rc3-342-g8c27eba
> 
> arch/s390/kernel/built-in.o: In function `cleanup_io_leave_insn':
> diag.c:(.text+0xc29a): undefined reference to `preempt_schedule_irq'
> make[2]: *** [.tmp_vmlinux1] Error 1
> 
> 

We have a patch for that in our repository.
Martin will send that fix with the next bunch of fixes.


Subject: [PATCH] Fix compile error on 31bit without preemption

From: Christian Borntraeger <borntraeger@de.ibm.com>

Commit b8e7a54cd06b0b0174029ef3a7f5a1415a2c28f2 introduced a compile
error if CONFIG_PREEMPT is not set:

arch/s390/kernel/built-in.o: In function `cleanup_io_leave_insn':
/space/kvm/arch/s390/kernel/entry.S:(.text+0xbfce): undefined reference to `preempt_schedule_irq'

This patch hides preempt_schedule_irq if CONFIG_PREEMPT is not set.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/entry.S |    2 ++
 1 file changed, 2 insertions(+)

diff -urpN linux-2.6/arch/s390/kernel/entry.S linux-2.6-patched/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	2007-11-27 16:31:36.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/entry.S	2007-11-27 16:31:45.000000000 +0100
@@ -1079,8 +1079,10 @@ cleanup_io_leave_insn:
 .Lexecve_tail:	.long	execve_tail
 .Ljump_table:	.long	pgm_check_table
 .Lschedule:	.long	schedule
+#ifdef CONFIG_PREEMPT
 .Lpreempt_schedule_irq:
 		.long	preempt_schedule_irq
+#endif
 .Ltrace:	.long	syscall_trace
 .Lschedtail:	.long	schedule_tail
 .Lsysc_table:	.long	sys_call_table
