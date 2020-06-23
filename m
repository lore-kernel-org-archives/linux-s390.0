Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391521AbgFWUeV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 Jun 2020 16:34:21 -0400
Date: Tue, 23 Jun 2020 22:33:17 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200623203317.GG4496@worktop.programming.kicks-ass.net>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.512673481@infradead.org>
 <20200623150031.GA2986783@debian-buster-darwi.lab.linutronix.de>
 <20200623152450.GM4817@hirez.programming.kicks-ass.net>
 <20200623161320.GA2996373@debian-buster-darwi.lab.linutronix.de>
 <20200623163730.GA4800@hirez.programming.kicks-ass.net>
 <20200623175957.GA106514@elver.google.com>
 <20200623181232.GB4800@hirez.programming.kicks-ass.net>
 <20200623202404.GE2483@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623202404.GE2483@worktop.programming.kicks-ass.net>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Marco Elver <elver@google.com>
Cc: "Ahmed S. Darwish" <a.darwish@linutronix.de>, mingo@kernel.org, will@kernel.org, tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, bigeasy@linutronix.de, davem@davemloft.net, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk

On Tue, Jun 23, 2020 at 10:24:04PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 23, 2020 at 08:12:32PM +0200, Peter Zijlstra wrote:
> > Fair enough; I'll rip it all up and boot a KCSAN kernel, see what if
> > anything happens.
> 
> OK, so the below patch doesn't seem to have any nasty recursion issues
> here. The only 'problem' is that lockdep now sees report_lock can cause
> deadlocks.
> 
> It is completely right about it too, but I don't suspect there's much we
> can do about it, it's pretty much the standard printk() with scheduler
> locks held report.

Just for giggles I added the below and that works fine too. Right until
the report_lock deadlock splat of course, thereafter lockdep is
disabled.

diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index ac5f8345bae9..a011cf0a1611 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -459,6 +459,8 @@ static void set_other_info_task_blocking(unsigned long *flags,
 	 */
 	int timeout = max(kcsan_udelay_task, kcsan_udelay_interrupt);

+	lockdep_assert_held(&report_lock);
+
 	other_info->task = current;
 	do {
 		if (is_running) {
@@ -495,6 +497,8 @@ static void set_other_info_task_blocking(unsigned long *flags,
 		 other_info->task == current);
 	if (is_running)
 		set_current_state(TASK_RUNNING);
+
+	lockdep_assert_held(&report_lock);
 }

 /* Populate @other_info; requires that the provided @other_info not in use. */
