Return-Path: <linux-kernel-owner+w=401wt.eu-S1754612AbZCKTFw@vger.kernel.org>
From: Frans Pop <elendil@planet.nl>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator
Date: Wed, 11 Mar 2009 20:05:36 +0100
References: <200903080230.10099.elendil@planet.nl> <1236733226.6080.28.camel@localhost> <200903111703.41663.elendil@planet.nl>
In-Reply-To: <200903111703.41663.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200903112005.38181.elendil@planet.nl>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Sorry for the mail flood. This is the last one and then I'm going to wait for some reactions.

On Wednesday 11 March 2009, Frans Pop wrote:
> So, lets look next what happens if I allow clock->error to be changed
> here. This makes the boot fail and I believe that this is the critical
> change in 5cd1c9c5cf30.
[...]
> Note that clock->xtime_nsec is now running backwards and the crazy
> values for clock->error.
>
> From this I conclude that clock->error is getting buggered somewhere
> else: we get a completely different value back from what is calculated
> here. The calculation here is still correct:
> $ echo $(( -4292487689804800 + (-256 << 24) ))
> -4292491984772096
>
> I suspect that clock->error running back is what causes my hang.

s/clock->error/clock->xtime_nsec/ of course.

Looking a bit closer at what Roman's patch 5cd1c9c5cf30 does, I see this:

-       clock->xtime_nsec += (s64)xtime.tv_nsec << clock->shift;
+       clock->xtime_nsec = (s64)xtime.tv_nsec << clock->shift;
[...]
        clocksource_adjust(offset);
-       xtime.tv_nsec = (s64)clock->xtime_nsec >> clock->shift;
+       xtime.tv_nsec = ((s64)clock->xtime_nsec >> clock->shift) + 1;
        clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
+       clock->error += clock->xtime_nsec << (NTP_SCALE_SHIFT - clock->shift);

So, in the old situation the code first added xtime.tv_nsec to
clock->xtime_nsec and later subtracted it again, so there's symmetry.

In the new code we no longer do the first, but still do the second. That
seems strange and probably upsets assumptions in the code in between, which
includes the call to clocksource_adjust(). AFAICT this is the root cause of
the overflow visible in my earliest traces.
I've done some tries to correct that, but did not find anything that really
worked.

I also do now know with near certainty where the system hangs with the
vanilla 2.6.28.7: in the 'while (offset >= clock->cycle_interval)' loop in
update_wall_time. That loop should probably have some mechanism to warn if
it's running wild...

This whole code is pretty tricky, but I'm convinced Roman's patch is
structurally broken.

Cheers,
FJP
