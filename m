Return-Path: <linux-kernel-owner+w=401wt.eu-S1757941AbZCWWWR@vger.kernel.org>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator -
 hang traced
From: John Stultz <johnstul@us.ibm.com>
In-Reply-To: <200903230111.08814.elendil@planet.nl>
References: <200903080230.10099.elendil@planet.nl>
	 <200903181307.44867.elendil@planet.nl>
	 <1237391338.32698.9.camel@jstultz-laptop>
	 <200903230111.08814.elendil@planet.nl>
Content-Type: text/plain
Date: Mon, 23 Mar 2009 15:19:00 -0700
Message-Id: <1237846740.7068.15.camel@jstultz-laptop>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Frans Pop <elendil@planet.nl>, Thomas Gleixner <tglx@linutronix.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2009-03-23 at 01:11 +0100, Frans Pop wrote:
> On Wednesday 18 March 2009, John Stultz wrote:
> > > Ever increasing error with tod on 2.6.28.8 (with Martin's patch
> > > applied):
> > > 0.672655! timekeeping: clock source changed from jiffies to tod (shift: 12)
> > > 0.676889! tod/12 (150): xtime.tv: 1237377507/55524946 -> 1237377507/55524947
> > > 0.677020!    clock->xtime: 0 -> -4096, error: 0 -> -4294967296
> > > 0.680788! tod/12 (151): xtime.tv: 1237377507/55524947 -> 1237377507/55524948
> [...]
> > > 491.860765! tod/12 (37189): xtime.tv: 1237377998/55561985 -> 1237377998/55561986
> > > 491.860886!  clock->xtime: -4096 -> -4096, error: -159081293676544 -> -159085588643840
> >
> > Hrm. Is the box otherwise working ok? The TOD clock should not be
> > affected by the second issue (one shot mode) discussed.
> 
> Yes, the box^Wsystem works fine. I've now also seen the eventual correction
> of the error in action: after 35 mins of uptime clock->multi changed from
> 1000 to 999 (with tod).
> 
> So the only issue left, though only indirectly related to the hang, is
> the initial behavior with clocksource jiffies where clocksource_bigadjust
> gets called every time update_wall_time is called (I've confirmed that).
> 
> And possibly the cleanup change of clock->xtime_nsec to S64.
> 
> I'll happily leave those to you as I readily admit my understanding of the
> whole timekeeping thing is still very limited. But if you'd like patches
> tested, feel free to CC me.

Here's the fix to the tick_handle_periodic() tripping into an infinite
loop. Again, this was only triggered because the divide error that
caused jiffies to be skewed enough that the clock-steering code
increased the ns per jiffy conversion value enough that any slack we had
in the loop before was lost.

Fixing the divide issue avoids the problem (and is pretty important to
get upstream), but the underlying issue that we allow ONESHOT clockevent
mode to be used while the jiffies clocksource is in use is a concern.

Thomas had pointed out that ppc and other arches that do not have
PERIODIC mode clockevents don't trip over this, but I believe this has
been just luck so far, as we do not enable clocksource switching till
bootup is almost finished (to avoid clocksource churn), so after
interrupts are enabled, but before clocksource switching is allowed,
there is a chance (albeit very very small) that clock steering could
cause a similar problem on other arches.

Thomas, what do you think about this? With it s390 runs fine even
without the do_div() fix.

thanks
-john



The following patch avoids and endless loop issue by requiring that a
highres valid clocksource be installed before we call tick_periodic() in
a loop when using ONESHOT mode. The result is we will only increment
jiffies once per interrupt until a continuous hardware clocksource is
available.

Without this, we can run into a endless loop, where each cycle through
the loop, jiffies is updated which increments time by tick_period or
more (due to clock steering), which can cause the event programming to
think the next event was before the newly incremented time and fail
causing tick_periodic() to be called again and the whole process loops
forever.

Signed-off-by: John Stultz <johnstul@us.ibm.com>

diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 21a5ca8..83c4417 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -93,7 +93,17 @@ void tick_handle_periodic(struct clock_event_device *dev)
 	for (;;) {
 		if (!clockevents_program_event(dev, next, ktime_get()))
 			return;
-		tick_periodic(cpu);
+		/*
+		 * Have to be careful here. If we're in oneshot mode,
+		 * before we call tick_periodic() in a loop, we need
+		 * to be sure we're using a real hardware clocksource.
+		 * Otherwise we could get trapped in an infinite
+		 * loop, as the tick_periodic() increments jiffies,
+		 * when then will increment time, posibly causing
+		 * the loop to trigger again and again.
+		 */
+		if (timekeeping_valid_for_hres())
+			tick_periodic(cpu);
 		next = ktime_add(next, tick_period);
 	}
 }
