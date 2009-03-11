Return-Path: <linux-kernel-owner+w=401wt.eu-S1754571AbZCKJAm@vger.kernel.org>
From: Frans Pop <elendil@planet.nl>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator
Date: Wed, 11 Mar 2009 10:00:27 +0100
References: <200903080230.10099.elendil@planet.nl> <200903091604.56455.elendil@planet.nl> <1236733226.6080.28.camel@localhost>
In-Reply-To: <1236733226.6080.28.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903111000.29269.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wednesday 11 March 2009, john stultz wrote:
> On Mon, 2009-03-09 at 16:04 +0100, Frans Pop wrote:
> > And that resulted in:
> >      0.004175! Negative result: 166039808000 - 166039808256
>
> Hrm. That doesn't make sense.

It may not make sense, but that's still what I get ;-)

I've tried again with a bit more elaborate patch:
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -546,9 +546,26 @@ void update_wall_time(void)
 	/* store full nanoseconds into xtime after rounding it up and
 	 * add the remainder to the error difference.
 	 */
-	xtime.tv_nsec = ((s64)clock->xtime_nsec >> clock->shift) + 1;
-	clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
-	clock->error += clock->xtime_nsec << (NTP_SCALE_SHIFT - clock->shift);
+	u64 xtns1, xtns2, xtns3;
+
+	xtns1 = clock->xtime_nsec;
+	xtns2 = xtns1;
+	xtime.tv_nsec = ((s64)xtns1 >> clock->shift) + 1;
+	xtns2 -= (s64)xtime.tv_nsec << clock->shift;
+	clock->xtime_nsec = xtns2;
+	xtns3 = clock->xtime_nsec;
+	clock->error += (s64)xtns3 << (NTP_SCALE_SHIFT - clock->shift);
+
+	if (unlikely(xtns1 < ((s64)xtime.tv_nsec << clock->shift)))
+		printk("Wall time error. "
+			"xtns1: %llu, tv_nsec %lu, shifted tv_nsec %lld, "
+			"xtns2: %llu, xtns3: %llu, error: %lld\n",
+			(unsigned long long)xtns1,
+			xtime.tv_nsec,
+			(long long)((s64)xtime.tv_nsec << clock->shift),
+			(unsigned long long)xtns2,
+			(unsigned long long)xtns3,
+			(long long)clock->error);
 
 	update_xtime_cache(cyc2ns(clock, offset));
 

This results in tons of messages passing by and the boot going nowhere.
Sample:
Wall time error. xtns1: 15206684608, tv_nsec 59401112, shifted tv_nsec 15206684672,
   xtns2: 18446744063709451552, xtns3: 18446744063709451552, error: -13053227561031008
Wall time error. xtns1: 15206684737, tv_nsec 59401113, shifted tv_nsec 15206684928,
   xtns2: 18446744073709551425, xtns3: 18446744073709551425, error: -13053229775623520
Wall time error. xtns1: 15206684862, tv_nsec 59401113, shifted tv_nsec 15206684928,
   xtns2: 18446744063709451550, xtns3: 18446744063709451550, error: -13053241856098304
Wall time error. xtns1: 15206684995, tv_nsec 59401114, shifted tv_nsec 15206685184,
   xtns2: 18446744073709551427, xtns3: 18446744073709551427, error: -13053244070690816
Wall time error. xtns1: 15206685116, tv_nsec 59401114, shifted tv_nsec 15206685184,
   xtns2: 18446744063709451548, xtns3: 18446744063709451548, error: -13053246151065600


So it looks to me as if we're rounding up instead of down (and my
'unlikely' was probably too optimistic).
Code error? Compiler error? Hercules bug possibly?

I've got Hercules set to update the clock every 500 microseconds using
'TIMERINT 500' in the configuration file. From the documentation:
   "Specifies the internal timers update interval, in microseconds. This
    parameter specifies how frequently Hercules's internal timers-update
    thread updates the TOD Clock, CPU Timer, and other architectural
    related clock/timer values. The default interval is 50 microseconds,
    which strikes a reasonable balance between clock accuracy and overall
    host performance. The minimum allowed value is 1 microsecond and the
    maximum is 1000000 microseconds (i.e. one second)."

> Hmm.. Does the following explicit casting help?

I included that in the patch, but due to the large number of "errors" I
got I couldn't tell. Can test with just that cast, but it still seems to
me the problem is in the above.

Cheers,
FJP
