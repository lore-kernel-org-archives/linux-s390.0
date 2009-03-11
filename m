Return-Path: <linux-kernel-owner+w=401wt.eu-S1754411AbZCKBAl@vger.kernel.org>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator
From: john stultz <johnstul@us.ibm.com>
In-Reply-To: <200903091604.56455.elendil@planet.nl>
References: <200903080230.10099.elendil@planet.nl>
	 <200903091604.56455.elendil@planet.nl>
Content-Type: text/plain
Date: Tue, 10 Mar 2009 18:00:26 -0700
Message-Id: <1236733226.6080.28.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Frans Pop <elendil@planet.nl>
Cc: linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2009-03-09 at 16:04 +0100, Frans Pop wrote:
> On Sunday 08 March 2009, Frans Pop wrote:
> > Kernels after 2.6.27 fail to boot in the Hercules S/390 emulator, quite
> > early in the boot process:
> [...]
> >      0.141419! Initializing cgroup subsys ns
> >      0.141605! Initializing cgroup subsys cpuacct
> >      0.142009! Initializing cgroup subsys devices
> >      0.180403! cpu: 2 configured CPUs, 0 standby CPUs
> >
> > I've bisected this to the following commit:
> > commit 5cd1c9c5cf30d4b33df3d3f74d8142f278d536b7
> > Author: Roman Zippel <zippel@linux-m68k.org>
> > Date:   Mon Sep 22 14:42:43 2008 -0700
> >     timekeeping: fix rounding problem during clock update
> 
> After staring at this commit for a while I decided to try the following
> patch:
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -547,5 +547,11 @@ void update_wall_time(void)
>  	* add the remainder to the error difference.
>  	*/
>  	xtime.tv_nsec = ((s64)clock->xtime_nsec >> clock->shift) + 1;
> +	if (unlikely(clock->xtime_nsec < ((s64)xtime.tv_nsec << clock->shift))) {
> +		printk("Negative result: %llu - %lld\n",
> +			(unsigned long long)clock->xtime_nsec,
> +			(long long)((s64)xtime.tv_nsec << clock->shift));
> +		BUG_ON(1);
> +	}
>  	clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
>  	clock->error += clock->xtime_nsec << (NTP_SCALE_SHIFT - clock->shift);
> 
> And that resulted in:
>      0.004175! Negative result: 166039808000 - 166039808256

Hrm. That doesn't make sense.

xtime.tv_nsec = ((s64)clock->xtime_nsec >> clock->shift) + 1;

I'm assuming clock->shift == 12 (from the clocksource_tod definition).

If clock->xtime_nsec == 166039808000, then xtime.tv_nsec should be
40537063, so xtime_tv_nsec << clock->shift would be 166039810048.

So not sure whats going on with the output you got.

Also the negative conditional you add doesn't really make sense either,
as we expect the xtime.tv_nsec << clock->shift to be larger then
clock->xtime_nsec, as we've rounded it up by one. We then accumulate the
negative difference between them into clock->error. 

Hmm.. Does the following explicit casting help?

thanks
-john


diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 900f1b6..acd130b 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -548,7 +548,7 @@ void update_wall_time(void)
 	 */
 	xtime.tv_nsec = ((s64)clock->xtime_nsec >> clock->shift) + 1;
 	clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
-	clock->error += clock->xtime_nsec << (NTP_SCALE_SHIFT - clock->shift);
+	clock->error += (s64)clock->xtime_nsec << (NTP_SCALE_SHIFT - clock->shift);
 
 	update_xtime_cache(cyc2ns(clock, offset));
 
