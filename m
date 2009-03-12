Return-Path: <linux-kernel-owner+w=401wt.eu-S1755329AbZCLB6B@vger.kernel.org>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator
From: john stultz <johnstul@us.ibm.com>
In-Reply-To: <alpine.LFD.2.00.0903120201040.29264@localhost.localdomain>
References: <200903080230.10099.elendil@planet.nl>
	 <200903091604.56455.elendil@planet.nl> <1236733226.6080.28.camel@localhost>
	 <200903111703.41663.elendil@planet.nl>
	 <1236817822.7680.148.camel@localhost.localdomain>
	 <1236818863.7680.156.camel@localhost.localdomain>
	 <alpine.LFD.2.00.0903120201040.29264@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 11 Mar 2009 18:57:46 -0700
Message-Id: <1236823066.7680.178.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Frans Pop <elendil@planet.nl>, linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2009-03-12 at 02:30 +0100, Thomas Gleixner wrote:
> On Wed, 11 Mar 2009, john stultz wrote:
> > For a cleaner version, could you try the following, against 2.6.29-git
> > with no other modification?
> 
> cleaner ?
> 
> > xtime_nsec is expected at times to be negative. Instead of trying to
> > handle all the shifting properly via casts, define it as a s64 instead
> > of a u64.
> > 
> > NOT FOR INCLUSION
> > Signed-off-by: John Stultz <johnstul@us.ibm.com>
> > 
> > diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> > index f88d32f..e217000 100644
> > --- a/include/linux/clocksource.h
> > +++ b/include/linux/clocksource.h
> > @@ -86,7 +86,7 @@ struct clocksource {
> >  	 * more than one cache line.
> >  	 */
> >  	cycle_t cycle_last ____cacheline_aligned_in_smp;
> > -	u64 xtime_nsec;
> > +	s64 xtime_nsec;
> >  	s64 error;
> >  	struct timespec raw_time;
> >  
> > diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> > index 900f1b6..387be3c 100644
> > --- a/kernel/time/timekeeping.c
> > +++ b/kernel/time/timekeeping.c
> > @@ -546,7 +546,7 @@ void update_wall_time(void)
> >  	/* store full nanoseconds into xtime after rounding it up and
> >  	 * add the remainder to the error difference.
> >  	 */
> > -	xtime.tv_nsec = ((s64)clock->xtime_nsec >> clock->shift) + 1;
> > +	xtime.tv_nsec = (clock->xtime_nsec >> clock->shift) + 1;
> >  	clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
> >  	clock->error += clock->xtime_nsec << (NTP_SCALE_SHIFT - clock->shift);
> 
> This code sequence does:
> 
>    xtime.tv_nsec = (clock->xtime_nsec >> clock->shift) + 1;
>    clock->xtime_nsec -= xtime.tv_nsec << clock->shift;
> 
> Lets substitute a bit:
> 
>    a = xtime.tv_nsec
>    b = clock->xtime_nsec
>    c = clock->shift
>    r = result (which ends up in b aka clock->xtime_nsec again for the next round)
> 
> => a = (b >> c) + 1
>    r = b - (a << c)
> 
>    b >> c = b / 2^c
>    a << c = a * 2^c
> 
> => a = (b / 2^c) + 1
>    r = b - (a * 2^c)
> 
> => r = b - ((b / 2^c) + 1) * 2^c
>    r = b - ((2^c * b / 2^c) + 2^c)
>    r = b - (2^c * b / 2^c) - 2^c
>    r = b - b - 2^c
>    r = -2^c
>    
> => r = -(1 << c)
> 
> So the whole business boils down to:
> 
>    clock->xtime_nsec = -(1 << clock->shift);

Err, not quite. See, we truncate clock->xtime_nsec when we shift it down
and store it into xtime.tv_nsec. Since we don't want to lose truncated
remainder, we simply add one to xtime.tv_nsec, taking the ceiling in
effect.

However, we have to balance this out in order to not rush forward in
time each tick. So we accumulate amount we ended up adding into the
error.

Lets walk through a simple example with actual values.
b = 99
c = 4

=> a = (b >> c) + 1
   r = b - (a << c)

=> a = (99 >> 4) + 1
   a = 6 + 1
   a = 7

   r = 99 - (7 << 4)
   r = 99 - 112
   r = -13

(Your reduction would give -16, since it ignores that shift down
truncates)

In effect, adding 1 to xtime.tv_nsec, is the same as adding 13 to
clock->xtime_nsec.


Maybe a different way of expressing what we're calculating is the
following:

xtime.tv_nsec = (clock->xtime_nsec + (1<<clock->shift)) >> clock->shift
clock->xtime_nsec = (1<<clock->shift) 
			- (clock->xtime_nsec &((1<<clock->shift)-1)

In other words: The rounded up portion - the masked remainder in
xtime_nsec.

Does that make sense?
thanks
-john
