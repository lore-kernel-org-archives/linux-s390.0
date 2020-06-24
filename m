Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388470AbgFXLcz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 24 Jun 2020 07:32:55 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53185C061573
        for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2020 04:32:55 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id r12so1886010wrj.13
        for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2020 04:32:55 -0700 (PDT)
Date: Wed, 24 Jun 2020 13:32:46 +0200
From: Marco Elver <elver@google.com>
Subject: Re: [PATCH v4 7/8] lockdep: Change hardirq{s_enabled,_context} to
 per-cpu variables
Message-ID: <20200624113246.GA170324@elver.google.com>
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
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200623202404.GE2483@worktop.programming.kicks-ass.net>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Ahmed S. Darwish" <a.darwish@linutronix.de>, mingo@kernel.org, will@kernel.org, tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, bigeasy@linutronix.de, davem@davemloft.net, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk, paulmck@kernel.org

On Tue, Jun 23, 2020 at 10:24PM +0200, Peter Zijlstra wrote:
> On Tue, Jun 23, 2020 at 08:12:32PM +0200, Peter Zijlstra wrote:
> > Fair enough; I'll rip it all up and boot a KCSAN kernel, see what if
> > anything happens.
>=20
> OK, so the below patch doesn't seem to have any nasty recursion issues
> here. The only 'problem' is that lockdep now sees report_lock can cause
> deadlocks.

Thanks, using non-raw now makes sense.

> It is completely right about it too, but I don't suspect there's much we
> can do about it, it's pretty much the standard printk() with scheduler
> locks held report.

Right, I think we just have to tolerate the potential risk of deadlock
until there is a way to make all the code that prints in print_report()
scheduler-safe (that includes stack_trace_print()).

Based on your suggested change to core.c, how about the below patch?
Anything we've missed? If you think it's reasonable, please carry it
with the IRQ state tracking changes.

As far as I can tell there are no more warnings together with the other
patch you sent to add '& LOCKDEP_RECURSION_MASK'.

Thanks,
-- Marco

------ >8 ------

=46rom: Marco Elver <elver@google.com>
Date: Wed, 24 Jun 2020 11:23:22 +0200
Subject: [PATCH] kcsan: Make KCSAN compatible with new IRQ state tracking

The new IRQ state tracking code does not honor lockdep_off(), and as
such we should again permit tracing by using non-raw functions in
core.c. Update the lockdep_off() comment in report.c, to reflect the
fact there is still a potential risk of deadlock due to using printk()
=66rom scheduler code.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/core.c   | 5 ++---
 kernel/kcsan/report.c | 9 +++++----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 15f67949d11e..732623c30359 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -397,8 +397,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t=
 size, int type)
 	}
=20
 	if (!kcsan_interrupt_watcher)
-		/* Use raw to avoid lockdep recursion via IRQ flags tracing. */
-		raw_local_irq_save(irq_flags);
+		local_irq_save(irq_flags);
=20
 	watchpoint =3D insert_watchpoint((unsigned long)ptr, size, is_write);
 	if (watchpoint =3D=3D NULL) {
@@ -539,7 +538,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t=
 size, int type)
 	kcsan_counter_dec(KCSAN_COUNTER_USED_WATCHPOINTS);
 out_unlock:
 	if (!kcsan_interrupt_watcher)
-		raw_local_irq_restore(irq_flags);
+		local_irq_restore(irq_flags);
 out:
 	user_access_restore(ua_flags);
 }
diff --git a/kernel/kcsan/report.c b/kernel/kcsan/report.c
index ac5f8345bae9..6b2fb1a6d8cd 100644
--- a/kernel/kcsan/report.c
+++ b/kernel/kcsan/report.c
@@ -606,10 +606,11 @@ void kcsan_report(const volatile void *ptr, size_t si=
ze, int access_type,
 		goto out;
=20
 	/*
-	 * With TRACE_IRQFLAGS, lockdep's IRQ trace state becomes corrupted if
-	 * we do not turn off lockdep here; this could happen due to recursion
-	 * into lockdep via KCSAN if we detect a race in utilities used by
-	 * lockdep.
+	 * Because we may generate reports when we're in scheduler code, the use
+	 * of printk() could deadlock. Until such time that all printing code
+	 * called in print_report() is scheduler-safe, accept the risk, and just
+	 * get our message out. As such, also disable lockdep to hide the
+	 * warning, and avoid disabling lockdep for the rest of the kernel.
 	 */
 	lockdep_off();
=20
--=20
2.27.0.111.gc72c7da667-goog
=20
