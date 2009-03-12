Return-Path: <linux-kernel-owner+w=401wt.eu-S1754477AbZCLAai@vger.kernel.org>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator
From: john stultz <johnstul@us.ibm.com>
In-Reply-To: <200903111703.41663.elendil@planet.nl>
References: <200903080230.10099.elendil@planet.nl>
	 <200903091604.56455.elendil@planet.nl> <1236733226.6080.28.camel@localhost>
	 <200903111703.41663.elendil@planet.nl>
Content-Type: text/plain
Date: Wed, 11 Mar 2009 17:30:22 -0700
Message-Id: <1236817822.7680.148.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Frans Pop <elendil@planet.nl>
Cc: linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 2009-03-11 at 17:03 +0100, Frans Pop wrote:
> OK, I think I've gotten a lot further now.
> 
> On Wednesday 11 March 2009, john stultz wrote:
> > Also the negative conditional you add doesn't really make sense either,
> > as we expect the xtime.tv_nsec << clock->shift to be larger then
> > clock->xtime_nsec, as we've rounded it up by one. We then accumulate
> > the negative difference between them into clock->error.
> 
> I'm not at all fluent in casts, bit shifting and stuff, so it took a
> while for the quarter to drop. But AFAICT what you're saying here is
> exactly the problem.
> 
> Indeed you do round xtime.tv_nsec up, so when you do
>    clock->xtime_nsec -= (s64)xtime.tv_nsec << clock->shift;
> or
>    clock->xtime_nsec = clock->xtime_nsec - ((s64)xtime.tv_nsec << clock->shift);
> the second argument is always going to be bigger than the first, so you
> always end up with a negative value.
> 
> > Hmm.. Does the following explicit casting help?
> 
> Even with the cast you're just papering over the issue that we're moving a
> negative value into a field that is defined as unsigned:
> include/linux/clocksource.h:    u64 xtime_nsec;

Probably agreed here, xtime_nsec probably should be converted to a s64
as negative values are possible.


However, Its unclear to me if my patch worked or not? 
Did you try it alone?



> Why does clock->xtime_nsec get set to the _difference_ (-=) at all? It
> almost seems to me as if that field is getting abused as a temporary
> variable. We're also not doing as the comment says:
>         /* store full nanoseconds into xtime after rounding it up and
>          * add the remainder to the error difference.
> What we are actually doing is storing the _remainder_ in xtime.


Yes, after Romans patch we do basically store the remainder in
xtime_nsec, however we then use that to add to error and xtime_nsec
isn't used until it is cleared the next time we hit update_wall_clock.

So yea, xtime_nsec scope is now basically a local variable right now,
but there is code in subfunctions that use it so we didn't change it
totally. I agree there is some cleanup needed here.

> The patch included below gives me saner values, but still leaves a
> problem with the calculation of clock->error. Here are the first
> wall_update calls after a reboot. This is with the patch and some
> debugging code, but *without* actually changing clock->error.
> 
> With that the system boots correctly!

By this you probably disabled the clock steering. Still not sure how it
affected the issue.


> 0: scale/shift: 32/8, xtime_ns old: 155790080000, new: 155790080256
>     tv_ns: 608555001, rem: -256, old_err: 0, error: -4294867296
> 1: scale/shift: 32/8, xtime_ns old: 155790080256, new: 155790080512
>     tv_ns: 608555002, rem: -256, old_err: 0, error: -4294867296
> 2: scale/shift: 32/8, xtime_ns old: 155790080512, new: 155790080768
>     tv_ns: 608555003, rem: -256, old_err: 0, error: -4294867296
> 3: scale/shift: 32/8, xtime_ns old: 155790080768, new: 155790081024
>     tv_ns: 608555004, rem: -256, old_err: 0, error: -4294867296
> 4: scale/shift: 32/8, xtime_ns old: 155790081024, new: 155790081280
>     tv_ns: 608555005, rem: -256, old_err: 0, error: -4294867296
> 5: scale/shift: 32/8, xtime_ns old: 155790081280, new: 155790081536
>     tv_ns: 608555006, rem: -256, old_err: 0, error: -4294867296
> 
> First observation is that clock->shift is not 12, but 8! This explains
> the "strange" values we got for xtime.tv_nsec. But I agree with you that
> from the code in arch/s390/time.c it looks like the value should be 12
> for the tod clocksource. No idea what mangles it. It also means that
> clock->error gets shifted by 24 (!) as NTP_SCALE_SHIFT is 32.

So if the shift value is 8, that likely means the jiffies clock is still
in use here and we haven't switched to the TOD clocksource.


> Second observation is that clock->error (old_err) remains at 0. So
> apparently it's not getting set anywhere else if we don't set it here
> first. The calculated new error is correct given the shift.
> 
> So, lets look next what happens if I allow clock->error to be changed
> here. This makes the boot fail and I believe that this is the critical
> change in 5cd1c9c5cf30.
> 
> 0: scale/shift: 32/8, xtime_ns old: 496319488000, new: 496319488256
>     tv_ns: 1938748001, rem: -256, old_err: 0, error: -4294867296
> 1: scale/shift: 32/8, xtime_ns old: 496315293952, new: 496315294208
>     tv_ns: 1938731618, rem: -256, old_err: -4292487689804800, error: -4292501984672096
> 2: scale/shift: 32/8, xtime_ns old: 496302611296, new: 496302611552
>     tv_ns: 1938682467, rem: -256, old_err: -12807120030269440, error: -12807124325236736
> 3: scale/shift: 32/8, xtime_ns old: 496298417248, new: 496298417504
>     tv_ns: 1938666084, rem: -256, old_err: -14918186650466656, error: -14918180945433952
> 4: scale/shift: 32/8, xtime_ns old: 496295896064, new: 496295896320
>     tv_ns: 1938655845, rem: -256, old_err: -15964926015076704, error: -15964920310044000
> 5: scale/shift: 32/8, xtime_ns old: 496294223456, new: 496294223712
>     tv_ns: 1938649702, rem: -256, old_err: -16483889798454272, error: -16483904093421568
> 
> Note that clock->xtime_nsec is now running backwards and the crazy values
> for clock->error.

That could be acceptable. clocksource_adjust() can do some negative
steering and still have correct output.


> From this I conclude that clock->error is getting buggered somewhere
> else: we get a completely different value back from what is calculated
> here. The calculation here is still correct:
> $ echo $(( -4292487689804800 + (-256 << 24) ))
> -4292491984772096
> 
> I suspect that clock->error running back is what causes my hang.
> 
> I hope that I'm at least somewhat on the right track here?
> I keep wondering why I'm the only one seeing problems...

Me too. Its a little hard to unpack everything you've gone through here,
as some of your assumptions aren't quite right. Its understandable as
this code is fairly dense, and has evolved over the last couple of years
to handle a number of corner cases found. 

But its likely some cleanup here is in order to shake out these signed
shift issues that were not part of the original design.

thanks
-john
