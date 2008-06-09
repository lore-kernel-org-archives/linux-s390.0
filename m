From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Mon, 09 Jun 2008 12:05:12 +0000
Subject: Re: [PATCH] s390: Fix build failure in __cpu_up()
Message-Id: <1213013112.19343.31.camel@localhost>
In-Reply-To: <1213013059.19343.29.camel@localhost>
References: <1213013059.19343.29.camel@localhost>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2008-06-09 at 13:31 +0200, Segher Boessenkool wrote:
> >> I'll add this patch to the queue for 2.6.26 and have to think
> about 
> >> some
> >> more fixes.
> >
> > The patch below should fix the problem with unsigned long arguments
> > instead of arrays of unsigned long. Could you test if your gcc still
> > crashes with the patch (but without yours)?
> 
> Sure.  Nope, no more crash.  Good :-)

Thanks for the verification. I will send both patches soonish.

-- 
blue skies,
  Martin.

"Reality continues to ruin my life." - Calvin.
