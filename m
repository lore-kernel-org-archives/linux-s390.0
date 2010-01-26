Return-Path: <linux-kernel-owner+w=401wt.eu-S1753789Ab0AZNNO@vger.kernel.org>
Date: Tue, 26 Jan 2010 14:13:06 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
 results on s390x)
Message-ID: <20100126141306.3cb60b14@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <20100121205113.GB20050@redhat.com>
References: <20100105153633.GA9376@redhat.com>
	<20100105164610.388effd3@mschwide.boeblingen.de.ibm.com>
	<20100105155913.GA10652@redhat.com>
	<20100105170301.GA13641@redhat.com>
	<20100105195818.GA20358@redhat.com>
	<20100106201722.GB26204@redhat.com>
	<20100106211329.DB4F5134D@magilla.sf.frob.com>
	<20100107101855.13248dc2@mschwide.boeblingen.de.ibm.com>
	<20100107175446.GA13300@redhat.com>
	<20100107214821.94FF97300@magilla.sf.frob.com>
	<20100121205113.GB20050@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Roland McGrath <roland@redhat.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com, stable@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 21 Jan 2010 21:51:13 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> On 01/07, Roland McGrath wrote:
> >
> > > I am confused as well. Yes, I thought about regs->psw.mask change too,
> > > but I don't understand why it helps..
> > [...]
> > > But. Acoording to the testing I did (unless I did something wrong
> > > again) this patch doesn't make any difference in this particular
> > > case. 6580807da14c423f0d0a708108e6df6ebc8bc83d does.
> >
> > Those results are quite mysterious to me.
> > I think we'll have to get Martin to sort it out definitively.

Finally nailed that one. Grrmpf.. the special case in the program check
handler for single stepped svcs clobbers the argument registers. With our
test case this affects the clone() system call. Funny things happen when
the clone_flags argument is more or less random ..
The following patch fixes the problem for me.

--
Subject: [PATCH] fix single stepped svcs with TRACE_IRQFLAGS=y

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

If irq flags tracing is enabled the TRACE_IRQS_ON macros expands to
a function call which clobbers registers %r0-%r5. The macro is used
in the code path for single stepped system calls. The argument
registers %r2-%r6 need to be restored from the stack before the system
call function is called.

Cc: stable@kernel.org
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/entry.S   |    1 +
 arch/s390/kernel/entry64.S |    1 +
 2 files changed, 2 insertions(+)

diff -urpN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-patched/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	2009-12-03 04:51:21.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/entry64.S	2010-01-26 14:04:58.000000000 +0100
@@ -549,6 +549,7 @@ pgm_svcper:
 	mvc	__THREAD_per+__PER_access_id(1,%r8),__LC_PER_ACCESS_ID
 	oi	__TI_flags+7(%r9),_TIF_SINGLE_STEP # set TIF_SINGLE_STEP
 	TRACE_IRQS_ON
+	lmg	%r2,%r6,SP_R2(%r15)	# load svc arguments
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	j	sysc_do_svc
 
diff -urpN linux-2.6/arch/s390/kernel/entry.S linux-2.6-patched/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	2009-12-03 04:51:21.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/entry.S	2010-01-26 14:04:58.000000000 +0100
@@ -571,6 +571,7 @@ pgm_svcper:
 	mvc	__THREAD_per+__PER_access_id(1,%r8),__LC_PER_ACCESS_ID
 	oi	__TI_flags+3(%r9),_TIF_SINGLE_STEP # set TIF_SINGLE_STEP
 	TRACE_IRQS_ON
+	lm	%r2,%r6,SP_R2(%r15)	# load svc arguments
 	stosm	__SF_EMPTY(%r15),0x03	# reenable interrupts
 	b	BASED(sysc_do_svc)
 
-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
