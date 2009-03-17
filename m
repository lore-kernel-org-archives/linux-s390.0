Return-Path: <linux-kernel-owner+w=401wt.eu-S1757245AbZCQFP2@vger.kernel.org>
Subject: Re: [BUG,2.6.28,s390] Fails to boot in Hercules S/390 emulator
From: john stultz <johnstul@us.ibm.com>
In-Reply-To: <200903120751.27821.elendil@planet.nl>
References: <200903080230.10099.elendil@planet.nl>
	 <1236818044.7680.153.camel@localhost.localdomain>
	 <1236833245.7680.266.camel@localhost.localdomain>
	 <200903120751.27821.elendil@planet.nl>
Content-Type: text/plain
Date: Mon, 16 Mar 2009 22:15:01 -0700
Message-Id: <1237266901.7306.86.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Frans Pop <elendil@planet.nl>
Cc: linux-s390@vger.kernel.org, Roman Zippel <zippel@linux-m68k.org>, Thomas Gleixner <tglx@linutronix.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 2009-03-12 at 07:51 +0100, Frans Pop wrote:
> On Thursday 12 March 2009, John Stultz wrote:
> > * Reverting both 6c9bacb41c10 and 5cd1c9c5cf30 against 2.6-git did not
> > seem to help the issue, as originally reported. I also reverted
> > 49b5cf34727a as well just in case, and it didn't help either.
> 
> Hmm, interesting. I think you may have reproduced a similar failure case, 
> but not exactly the same as mine. I wonder if what you have reproduced is 
> the same as Debian bug report http://bugs.debian.org/511334. That is with 
> 2.6.26 which would match the fact that the reverts that work reliably for 
> me did not work for you. I've never had any problems with Debian's 2.6.26 
> in my configuration.

Hmmm. I have indeed seen issues w/ the 2.6.26 debian kernel, so that
does seem closer to what I'm seeing.


> For me 2.6.28.7 is rock solid with the two reverts. I've attached my 
> kernel config and my Hercules config. I think the critical thing in my 
> config may be the "TIMERINT 500" setting for Hercules, which is somewhat 
> similar to your "goes away if HZ is anything except 250" observation.

I'll have to checkout that option. Does changing HZ value or disabling
NO_HZ  change anything for your situation as well?


> > That's about all I can get for today. I'm out of town until Monday, so
> > I'll start digging back into it then.
> 
> From your other replies I've seen that I have been way off track at some 
> points. It looks as if I have been looking at events too early in the 
> boot and been confused by the use of clock->xtime_nsec. My apologies for 
> any confusion caused by that.
> 
> I have a few more tests I think I can usefully do, but will try harder not 
> to confuse the issue with my inexpert ramblings anymore :-P

No, no, this is subtle and optimized code that keeps very high precision
values. Its not trivial stuff, so your confusion is understandable.

thanks
-john
