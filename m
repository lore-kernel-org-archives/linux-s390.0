Return-Path: <linux-kernel-owner+w=401wt.eu-S933036Ab0AGJTQ@vger.kernel.org>
Date: Thu, 7 Jan 2010 10:18:55 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
 results on s390x)
Message-ID: <20100107101855.13248dc2@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <20100106211329.DB4F5134D@magilla.sf.frob.com>
References: <20100104155225.GA16650@redhat.com>
	<20100104171626.22ea2d9c@mschwide.boeblingen.de.ibm.com>
	<20100104181412.GA21146@redhat.com>
	<20100104211147.4CC94D532@magilla.sf.frob.com>
	<20100105105030.66bb8a0a@mschwide.boeblingen.de.ibm.com>
	<20100105153633.GA9376@redhat.com>
	<20100105164610.388effd3@mschwide.boeblingen.de.ibm.com>
	<20100105155913.GA10652@redhat.com>
	<20100105170301.GA13641@redhat.com>
	<20100105195818.GA20358@redhat.com>
	<20100106201722.GB26204@redhat.com>
	<20100106211329.DB4F5134D@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Roland McGrath <roland@redhat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Wed,  6 Jan 2010 13:13:29 -0800 (PST)
Roland McGrath <roland@redhat.com> wrote:

> > However, with or without CONFIG_UTRACE, 6580807da14c423f0d0a708108e6df6ebc8bc83d
> > is needed on s390 too, otherwise the child gets unnecessary traps.
> 
> This confuses me.  user_disable_single_step on non-current doesn't do
> anything not already done by the memset in copy_thread.  Ooh, except
> perhaps it does not clear PSW_MASK_PER.  Maybe that matters.  That's
> the only thing I can think of.  Maybe Martin can make sense of it.

The additional traps should not happen anymore with this patch:
--
Subject: [PATCH] clear TIF_SINGLE_STEP for new process.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Clear the TIF_SINGLE_STEP bit in copy_thread. If the new process is
not auto-attached by the tracer it is wrong to delivere SIGTRAP to
the new process.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/process.c |    1 +
 1 file changed, 1 insertion(+)

diff -urpN linux-2.6/arch/s390/kernel/process.c linux-2.6-patched/arch/s390/kernel/process.c
--- linux-2.6/arch/s390/kernel/process.c	2009-12-03 04:51:21.000000000 +0100
+++ linux-2.6-patched/arch/s390/kernel/process.c	2010-01-07 09:25:53.000000000 +0100
@@ -217,6 +217,7 @@ int copy_thread(unsigned long clone_flag
 	p->thread.mm_segment = get_fs();
 	/* Don't copy debug registers */
 	memset(&p->thread.per_info, 0, sizeof(p->thread.per_info));
+	clear_tsk_thread_flag(p, TIF_SINGLE_STEP);
 	/* Initialize per thread user and system timer values */
 	ti = task_thread_info(p);
 	ti->user_timer = 0;
-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
