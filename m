Return-Path: <linux-kernel-owner+w=401wt.eu-S1759240AbZCQFJb@vger.kernel.org>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator -
 hang traced
From: john stultz <johnstul@us.ibm.com>
In-Reply-To: <200903131248.03622.elendil@planet.nl>
References: <200903080230.10099.elendil@planet.nl>
	 <1236818863.7680.156.camel@localhost.localdomain>
	 <200903121805.48041.elendil@planet.nl>
	 <200903131248.03622.elendil@planet.nl>
Content-Type: text/plain
Date: Mon, 16 Mar 2009 22:09:16 -0700
Message-Id: <1237266556.7306.80.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Frans Pop <elendil@planet.nl>
Cc: linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2009-03-13 at 12:48 +0100, Frans Pop wrote:
> One more.
> 
> On Thursday 12 March 2009, Frans Pop wrote:
> > I have now been able to trace the hang (full log attached). Where I
> > added tracing printks should be fairly obvious, and see attachment.
> > No idea what to make of the result.
> 
> I added printks that show changes in clock data. I print info for
> 3 consecutive calls of update_wall_time every 1000 times the function
> is called and also after a change of clock source.

[snip]

> The values are: "from the very beginning of the function" -> "just after
> the calculations". Values are from nsecs fields.
> The xtime.tv_nsec which enters the function increases nicely and follows
> the timestamps from Hercules, but look rather bogus after the calculations.
> 
> With Roman's patch and the later patch this changes to:
> 
>      0.004593! timekeeping: clock source changed from none to jiffies (shift: 8)
>      0.005051! timekeeping (jiffies, 8): xtime.tv: 594977000 -> 594977001
>      0.005097!    clock->xtime: 0 -> -256, error: 0 -> -4294867296
>      0.009608! timekeeping (jiffies, 8): xtime.tv: 594977001 -> 594960618
>      0.009712!    clock->xtime: -256 -> -256, error: -4294867296 -> -4292501984672096
>      0.014463! Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
> [... Clock has gone back? ...]


xtime going backwards is actually allowable, as xtime does not store the
entire state of time.

Time is represented by the equation:
	xtime + (offset * mult) >> shift

Since we steer the clock by changing the mult value, imagine if we were
slowing down time, we'd decrese mult by one. However, since  offset may
be non-zero, we have to keep the equation balanced, or time might
actually go backwards.

Given:
	mult2 == mult1 - 1

	xtime1 + (offset * mult1) >> shift == xtime2 + (offset * mult2) >> shift
	xtime1 + (offset * mult1) >> shift == xtime2 + (offset * (mult1 - 1)) >> shift
	xtime1 + (offset * mult1) >> shift - (offset * (mult1 - 1)) >> shift == xtime2
	xtime1 + (offset * mult1 - offset * (mult1 - 1)) >> shift == xtime2
	xtime1 + (offset * mult1 - (offset * mult1 - offset*1)) >> shift == xtime2
	xtime1 + offset>> shift == xtime2

Now, if we are increasing mult, xtime will be decreased in the same
fashion. So the xtime value going backwards isn't wrong by itself, as
the corresponding offset * newmult will compensate.

xtime_cache actually stores a snapshot of the full state each call to
update_wall_time(), so you might want to use that in your printing
instead.


From what I've seen so far debugging today it seems something goes off
in clocksource_bigadjust(), and the error continues to grow instead of
being corrected, and we end up constantly increasing mult.

I'm still not quite sure how this links to the hang, but I'm still digging.

thanks
-john
