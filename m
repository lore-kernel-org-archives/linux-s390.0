Return-Path: <linux-kernel-owner+w=401wt.eu-S1754485AbZCLBbV@vger.kernel.org>
Date: Thu, 12 Mar 2009 02:30:50 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator
In-Reply-To: <1236818863.7680.156.camel@localhost.localdomain>
Message-ID: <alpine.LFD.2.00.0903120201040.29264@localhost.localdomain>
References: <200903080230.10099.elendil@planet.nl>  <200903091604.56455.elendil@planet.nl> <1236733226.6080.28.camel@localhost>  <200903111703.41663.elendil@planet.nl>  <1236817822.7680.148.camel@localhost.localdomain>
 <1236818863.7680.156.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: john stultz <johnstul@us.ibm.com>
Cc: Frans Pop <elendil@planet.nl>, linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 11 Mar 2009, john stultz wrote:
> For a cleaner version, could you try the following, against 2.6.29-git
> with no other modification?

cleaner ?

> xtime_nsec is expected at times to be negative. Instead of trying to
> handle all the shifting properly via casts, define it as a s64 instead
> of a u64.
> 
> NOT FOR INCLUSION
> Signed-off-by: John Stultz <johnstul@us.ibm.com>
> 
> diff --git a/include/linux/clocksource.h b/include/linux/clocksource.h
> index f88d32f..e217000 100644
> --- a/include/linux/clocksource.h
> +++ b/include/linux/clocksource.h
> @@ -86,7 +86,7 @@ struct clocksource {
>  	 * more than one cache line.
>  	 */
>  	cycle_t cycle_last ____cacheline_aligned_in_smp;
> -	u64 xtime_nsec;
> +	s64 xtime_nsec;
>  	s64 error;
>  	struct timespec raw_time;
>  
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index 900f1b6..387be3c 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -546,7 +546,7 @@ void update_wall_time(void)
>  	/* store full nanoseconds into xtime after rounding it up and
>  	 * add the remainder to the error difference.
>  	 */
> -	xtime.tv_nsec = ((s64)clock->xtime_nsec >> clock->shift) + 1;
> +	xtime.tv_nsec = (clock->xtime_nsec >> clock->shift) + 1;
>  	clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
>  	clock->error += clock->xtime_nsec << (NTP_SCALE_SHIFT - clock->shift);

This code sequence does:

   xtime.tv_nsec = (clock->xtime_nsec >> clock->shift) + 1;
   clock->xtime_nsec -= xtime.tv_nsec << clock->shift;

Lets substitute a bit:

   a = xtime.tv_nsec
   b = clock->xtime_nsec
   c = clock->shift
   r = result (which ends up in b aka clock->xtime_nsec again for the next round)

=> a = (b >> c) + 1
   r = b - (a << c)

   b >> c = b / 2^c
   a << c = a * 2^c

=> a = (b / 2^c) + 1
   r = b - (a * 2^c)

=> r = b - ((b / 2^c) + 1) * 2^c
   r = b - ((2^c * b / 2^c) + 2^c)
   r = b - (2^c * b / 2^c) - 2^c
   r = b - b - 2^c
   r = -2^c
   
=> r = -(1 << c)

So the whole business boils down to:

   clock->xtime_nsec = -(1 << clock->shift);

Famous last words (see also arch/x86/kernel/tsc.c and
arch/x86/include/asm/timer.h):

  -johnstul@us.ibm.com "math is hard, lets go shopping!"

Thanks,

	tglx
