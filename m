Return-Path: <linux-kernel-owner+w=401wt.eu-S1754398AbZCLAr5@vger.kernel.org>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator
From: john stultz <johnstul@us.ibm.com>
In-Reply-To: <1236817822.7680.148.camel@localhost.localdomain>
References: <200903080230.10099.elendil@planet.nl>
	 <200903091604.56455.elendil@planet.nl> <1236733226.6080.28.camel@localhost>
	 <200903111703.41663.elendil@planet.nl>
	 <1236817822.7680.148.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 11 Mar 2009 17:47:43 -0700
Message-Id: <1236818863.7680.156.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Frans Pop <elendil@planet.nl>
Cc: linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2009-03-11 at 17:30 -0700, john stultz wrote:
> On Wed, 2009-03-11 at 17:03 +0100, Frans Pop wrote:
> > OK, I think I've gotten a lot further now.
> > 
> > On Wednesday 11 March 2009, john stultz wrote:
> > > Also the negative conditional you add doesn't really make sense either,
> > > as we expect the xtime.tv_nsec << clock->shift to be larger then
> > > clock->xtime_nsec, as we've rounded it up by one. We then accumulate
> > > the negative difference between them into clock->error.
> > 
> > I'm not at all fluent in casts, bit shifting and stuff, so it took a
> > while for the quarter to drop. But AFAICT what you're saying here is
> > exactly the problem.
> > 
> > Indeed you do round xtime.tv_nsec up, so when you do
> >    clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
> > or
> >    clock->xtime_nsec = clock->xtime_nsec - ((s64)xtime.tv_nsec << clock->shift);
> > the second argument is always going to be bigger than the first, so you
> > always end up with a negative value.
> > 
> > > Hmm.. Does the following explicit casting help?
> > 
> > Even with the cast you're just papering over the issue that we're moving a
> > negative value into a field that is defined as unsigned:
> > include/linux/clocksource.h:    u64 xtime_nsec;
> 
> Probably agreed here, xtime_nsec probably should be converted to a s64
> as negative values are possible.
> 
> 
> However, Its unclear to me if my patch worked or not? 
> Did you try it alone?

For a cleaner version, could you try the following, against 2.6.29-git
with no other modification?

thanks
-john



xtime_nsec is expected at times to be negative. Instead of trying to
handle all the shifting properly via casts, define it as a s64 instead
of a u64.

NOT FOR INCLUSION
Signed-off-by: John Stultz <johnstul@us.ibm.com>

diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
index f88d32f..e217000 100644
--- a/include/linux/clocksource.h
+++ b/include/linux/clocksource.h
@@ -86,7 +86,7 @@ struct clocksource {
 	 * more than one cache line.
 	 */
 	cycle_t cycle_last ____cacheline_aligned_in_smp;
-	u64 xtime_nsec;
+	s64 xtime_nsec;
 	s64 error;
 	struct timespec raw_time;
 
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 900f1b6..387be3c 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -546,7 +546,7 @@ void update_wall_time(void)
 	/* store full nanoseconds into xtime after rounding it up and
 	 * add the remainder to the error difference.
 	 */
-	xtime.tv_nsec = ((s64)clock->xtime_nsec >> clock->shift) + 1;
+	xtime.tv_nsec = (clock->xtime_nsec >> clock->shift) + 1;
 	clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
 	clock->error += clock->xtime_nsec << (NTP_SCALE_SHIFT - clock->shift);
 
