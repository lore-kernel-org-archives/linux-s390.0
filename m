Return-Path: <linux-kernel-owner+w=401wt.eu-S1752638AbZCKQDz@vger.kernel.org>
From: Frans Pop <elendil@planet.nl>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator
Date: Wed, 11 Mar 2009 17:03:39 +0100
References: <200903080230.10099.elendil@planet.nl> <200903091604.56455.elendil@planet.nl> <1236733226.6080.28.camel@localhost>
In-Reply-To: <1236733226.6080.28.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200903111703.41663.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

OK, I think I've gotten a lot further now.

On Wednesday 11 March 2009, john stultz wrote:
> Also the negative conditional you add doesn't really make sense either,
> as we expect the xtime.tv_nsec << clock->shift to be larger then
> clock->xtime_nsec, as we've rounded it up by one. We then accumulate
> the negative difference between them into clock->error.

I'm not at all fluent in casts, bit shifting and stuff, so it took a
while for the quarter to drop. But AFAICT what you're saying here is
exactly the problem.

Indeed you do round xtime.tv_nsec up, so when you do
   clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
or
   clock->xtime_nsec = clock->xtime_nsec - ((s64)xtime.tv_nsec << clock->shift);
the second argument is always going to be bigger than the first, so you
always end up with a negative value.

> Hmm.. Does the following explicit casting help?

Even with the cast you're just papering over the issue that we're moving a
negative value into a field that is defined as unsigned:
include/linux/clocksource.h:    u64 xtime_nsec;

Why does clock->xtime_nsec get set to the _difference_ (-=) at all? It
almost seems to me as if that field is getting abused as a temporary
variable. We're also not doing as the comment says:
        /* store full nanoseconds into xtime after rounding it up and
         * add the remainder to the error difference.
What we are actually doing is storing the _remainder_ in xtime.

The patch included below gives me saner values, but still leaves a
problem with the calculation of clock->error. Here are the first
wall_update calls after a reboot. This is with the patch and some
debugging code, but *without* actually changing clock->error.

With that the system boots correctly!

0: scale/shift: 32/8, xtime_ns old: 155790080000, new: 155790080256
    tv_ns: 608555001, rem: -256, old_err: 0, error: -4294867296
1: scale/shift: 32/8, xtime_ns old: 155790080256, new: 155790080512
    tv_ns: 608555002, rem: -256, old_err: 0, error: -4294867296
2: scale/shift: 32/8, xtime_ns old: 155790080512, new: 155790080768
    tv_ns: 608555003, rem: -256, old_err: 0, error: -4294867296
3: scale/shift: 32/8, xtime_ns old: 155790080768, new: 155790081024
    tv_ns: 608555004, rem: -256, old_err: 0, error: -4294867296
4: scale/shift: 32/8, xtime_ns old: 155790081024, new: 155790081280
    tv_ns: 608555005, rem: -256, old_err: 0, error: -4294867296
5: scale/shift: 32/8, xtime_ns old: 155790081280, new: 155790081536
    tv_ns: 608555006, rem: -256, old_err: 0, error: -4294867296

First observation is that clock->shift is not 12, but 8! This explains
the "strange" values we got for xtime.tv_nsec. But I agree with you that
from the code in arch/s390/time.c it looks like the value should be 12
for the tod clocksource. No idea what mangles it. It also means that
clock->error gets shifted by 24 (!) as NTP_SCALE_SHIFT is 32.

Second observation is that clock->error (old_err) remains at 0. So
apparently it's not getting set anywhere else if we don't set it here
first. The calculated new error is correct given the shift.

So, lets look next what happens if I allow clock->error to be changed
here. This makes the boot fail and I believe that this is the critical
change in 5cd1c9c5cf30.

0: scale/shift: 32/8, xtime_ns old: 496319488000, new: 496319488256
    tv_ns: 1938748001, rem: -256, old_err: 0, error: -4294867296
1: scale/shift: 32/8, xtime_ns old: 496315293952, new: 496315294208
    tv_ns: 1938731618, rem: -256, old_err: -4292487689804800, error: -4292501984672096
2: scale/shift: 32/8, xtime_ns old: 496302611296, new: 496302611552
    tv_ns: 1938682467, rem: -256, old_err: -12807120030269440, error: -12807124325236736
3: scale/shift: 32/8, xtime_ns old: 496298417248, new: 496298417504
    tv_ns: 1938666084, rem: -256, old_err: -14918186650466656, error: -14918180945433952
4: scale/shift: 32/8, xtime_ns old: 496295896064, new: 496295896320
    tv_ns: 1938655845, rem: -256, old_err: -15964926015076704, error: -15964920310044000
5: scale/shift: 32/8, xtime_ns old: 496294223456, new: 496294223712
    tv_ns: 1938649702, rem: -256, old_err: -16483889798454272, error: -16483904093421568

Note that clock->xtime_nsec is now running backwards and the crazy values
for clock->error.

From this I conclude that clock->error is getting buggered somewhere
else: we get a completely different value back from what is calculated
here. The calculation here is still correct:
$ echo $(( -4292487689804800 + (-256 << 24) ))
-4292491984772096

I suspect that clock->error running back is what causes my hang.

I hope that I'm at least somewhat on the right track here?
I keep wondering why I'm the only one seeing problems...

Cheers,
FJP

---
Partial fix. This makes clock->xtime_nsec have sane values and gives
correct remainders.

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 900f1b6..fb048cc 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -480,6 +480,7 @@ static void clocksource_adjust(s64 offset)
 void update_wall_time(void)
 {
 	cycle_t offset;
+	s64 remainder;
 
 	/* Make sure we're fully resumed: */
 	if (unlikely(timekeeping_suspended))
@@ -547,8 +548,9 @@ void update_wall_time(void)
 	 * add the remainder to the error difference.
 	 */
 	xtime.tv_nsec = ((s64)clock->xtime_nsec >> clock->shift) + 1;
-	clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
-	clock->error += clock->xtime_nsec << (NTP_SCALE_SHIFT - clock->shift);
+	remainder = clock->xtime_nsec - ((s64)xtime.tv_nsec << clock->shift);
+	clock->xtime_nsec = (s64)xtime.tv_nsec << clock->shift;
+	clock->error += remainder << (NTP_SCALE_SHIFT - clock->shift);
 
 	update_xtime_cache(cyc2ns(clock, offset));
 
