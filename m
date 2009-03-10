Return-Path: <linux-kernel-owner+w=401wt.eu-S1753620AbZCJDkL@vger.kernel.org>
From: Frans Pop <elendil@planet.nl>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator
Date: Tue, 10 Mar 2009 04:37:27 +0100
References: <200903080230.10099.elendil@planet.nl> <1236654582.3792.7.camel@jstultz-laptop>
In-Reply-To: <1236654582.3792.7.camel@jstultz-laptop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903100437.29280.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: John Stultz <johnstul@us.ibm.com>
Cc: linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tuesday 10 March 2009, John Stultz wrote:
> > After reverting 5cd1c9c5cf30 and the somewhat related 6c9bacb41c10 on
> > top of 2.6.28.7, the system boots OK again [1].
>
> Huh. No clue right off. What clocksource is in use on this system?

$ cat /sys/devices/system/clocksource/clocksource0/current_clocksource
tod
(That's from 2.6.26.)

> Also can you provide the output with the following patch?

I already did something similar. Did you see my follow-up mail?

I added:
+       if (unlikely(clock->xtime_nsec < ((s64)xtime.tv_nsec << clock->shift)))
+               printk("Negative result: %llu - %lld\n",
+                       (unsigned long long)clock->xtime_nsec,
+                       (long long)((s64)xtime.tv_nsec << clock->shift));

Which resulted in:
   Negative result: 166039808000 - 166039808256

Would you still like me to try your patch?

Cheers,
FJP
