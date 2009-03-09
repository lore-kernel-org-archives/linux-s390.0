Return-Path: <linux-kernel-owner+w=401wt.eu-S1753380AbZCIPFQ@vger.kernel.org>
From: Frans Pop <elendil@planet.nl>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator
Date: Mon, 9 Mar 2009 16:04:53 +0100
References: <200903080230.10099.elendil@planet.nl>
In-Reply-To: <200903080230.10099.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903091604.56455.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org
Cc: Roman Zippel <zippel@linux-m68k.org>, John Stultz <johnstul@us.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sunday 08 March 2009, Frans Pop wrote:
> Kernels after 2.6.27 fail to boot in the Hercules S/390 emulator, quite
> early in the boot process:
[...]
>      0.141419! Initializing cgroup subsys ns
>      0.141605! Initializing cgroup subsys cpuacct
>      0.142009! Initializing cgroup subsys devices
>      0.180403! cpu: 2 configured CPUs, 0 standby CPUs
>
> I've bisected this to the following commit:
> commit 5cd1c9c5cf30d4b33df3d3f74d8142f278d536b7
> Author: Roman Zippel <zippel@linux-m68k.org>
> Date:   Mon Sep 22 14:42:43 2008 -0700
>     timekeeping: fix rounding problem during clock update

After staring at this commit for a while I decided to try the following
patch:
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -547,5 +547,11 @@ void update_wall_time(void)
 	* add the remainder to the error difference.
 	*/
 	xtime.tv_nsec = ((s64)clock->xtime_nsec >> clock->shift) + 1;
+	if (unlikely(clock->xtime_nsec < ((s64)xtime.tv_nsec << clock->shift))) {
+		printk("Negative result: %llu - %lld\n",
+			(unsigned long long)clock->xtime_nsec,
+			(long long)((s64)xtime.tv_nsec << clock->shift));
+		BUG_ON(1);
+	}
 	clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
 	clock->error += clock->xtime_nsec << (NTP_SCALE_SHIFT - clock->shift);

And that resulted in:
     0.004175! Negative result: 166039808000 - 166039808256

So we're trying to stuff a negative value into an unsigned field, and I
keep seeing on these lists that's a bad idea.

I'll leave it up to you how we get there, but could it possibly be the
same kind of thing as corrected earlier today in Heiko Carsten's patch:
http://lkml.org/lkml/2009/3/9/112 ?

Cheers,
FJP
