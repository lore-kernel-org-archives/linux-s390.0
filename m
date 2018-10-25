Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 25 Oct 2018 15:48:04 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] s390/fault: use wake_up_klogd() in bust_spinlocks()
Message-ID: <20181025064804.GA20702@jagdpanzerIV>
References: <20181024043048.21248-1-sergey.senozhatsky@gmail.com>
 <20181024043425.GA8862@jagdpanzerIV>
 <20181025062800.GB4037@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025062800.GB4037@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Peter Oberparleiter <oberpar@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On (10/25/18 08:28), Heiko Carstens wrote:
[..]
> >  		int loglevel_save = console_loglevel;
> > -		console_unblank();
> > -		oops_in_progress = 0;
> > -		/*
> > -		 * OK, the message is on the console.  Now we call printk()
> > -		 * without oops_in_progress set so that printk will give klogd
> > -		 * a poke.  Hold onto your hats...
> > -		 */
> > +
> >  		console_loglevel = 15;
> > -		printk(" ");
> > +		console_unblank();
> >  		console_loglevel = loglevel_save;
> > +		oops_in_progress = 0;
> > +		wake_up_klogd();
> >  	}
> 
> With your patch this looks nearly like the common code variant. I did
> some code archaeology and this function is unchanged since ~17 years.
> When it was introduced it was close to identical to the x86 variant.
> All other architectures use the common code variant in the
> meantime. So if we change this I'd prefer that we switch s390 to the
> common code variant as well.

Right. I couldn't clearly understand what was so special that s390
bust_spinlock() was doing, but assumed that this `console_loglevel'
manipulation probably was somehow important to s390. Though this
console_loglevel adjustment is not 100% guaranteed to make any difference,
because of the way console_unblank() works: if it can't lock console_sem
and it sees oops_in_progress then it does nothing; it doesn't even print
logbuf messages to the consoles. If, however, console_sem is not locked,
then it does print pending logbuf messages, with temporarily verbose
console_loglevel. I concluded that this might be important to you in
one way or another.

> Right now I can't see a reason for not doing that, but I might be
> wrong of course. So, could you please provide a new version which just
> removes this variant and makes s390 use the generic one too.
> 
> We'll see if there is any fallout...

Will do! Sounds good.

	-ss
