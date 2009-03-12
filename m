Return-Path: <linux-kernel-owner+w=401wt.eu-S1754773AbZCLAeW@vger.kernel.org>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator
From: john stultz <johnstul@us.ibm.com>
In-Reply-To: <200903112005.38181.elendil@planet.nl>
References: <200903080230.10099.elendil@planet.nl>
	 <1236733226.6080.28.camel@localhost> <200903111703.41663.elendil@planet.nl>
	 <200903112005.38181.elendil@planet.nl>
Content-Type: text/plain
Date: Wed, 11 Mar 2009 17:34:04 -0700
Message-Id: <1236818044.7680.153.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Frans Pop <elendil@planet.nl>
Cc: linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2009-03-11 at 20:05 +0100, Frans Pop wrote:
> Sorry for the mail flood. This is the last one and then I'm going to wait for some reactions.
> 
> On Wednesday 11 March 2009, Frans Pop wrote:
> > So, lets look next what happens if I allow clock->error to be changed
> > here. This makes the boot fail and I believe that this is the critical
> > change in 5cd1c9c5cf30.
> [...]
> > Note that clock->xtime_nsec is now running backwards and the crazy
> > values for clock->error.
> >
> > From this I conclude that clock->error is getting buggered somewhere
> > else: we get a completely different value back from what is calculated
> > here. The calculation here is still correct:
> > $ echo $(( -4292487689804800 + (-256 << 24) ))
> > -4292491984772096
> >
> > I suspect that clock->error running back is what causes my hang.
> 
> s/clock->error/clock->xtime_nsec/ of course.
> 
> Looking a bit closer at what Roman's patch 5cd1c9c5cf30 does, I see this:
> 
> -       clock->xtime_nsec += (s64)xtime.tv_nsec << clock->shift;
> +       clock->xtime_nsec = (s64)xtime.tv_nsec << clock->shift;
> [...]
>         clocksource_adjust(offset);
> -       xtime.tv_nsec = (s64)clock->xtime_nsec >> clock->shift;
> +       xtime.tv_nsec = ((s64)clock->xtime_nsec >> clock->shift) + 1;
>         clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
> +       clock->error += clock->xtime_nsec << (NTP_SCALE_SHIFT - clock->shift);
> 
> So, in the old situation the code first added xtime.tv_nsec to
> clock->xtime_nsec and later subtracted it again, so there's symmetry.
> 
> In the new code we no longer do the first, but still do the second. That
> seems strange and probably upsets assumptions in the code in between, which
> includes the call to clocksource_adjust(). AFAICT this is the root cause of
> the overflow visible in my earliest traces.
> I've done some tries to correct that, but did not find anything that really
> worked.

No not quite. We use clock->xtime_nsec to store the high precision
xtime.tv_nsec. Its use is as follows:

1) We initialize it to xtime.tv_nsec << clock->shift
2) We accumulate into it
3) We tweak it as needed from clocksource_adjust()
4) We then store its value shifted back down and rounded up into
xtiem.tv_nsec.
5) We calculate the the difference between the rounded up value and
xtime_nsec, and add it to the error.

I'm still a little baffled, but I figure I can try to reproduce this
myself. So I'm working setting up hercules environment here to see if I
can't trigger it. Any help with config or links to your environment
would be great.

thanks
-john
