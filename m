Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 25 Oct 2018 17:28:27 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH] s390/fault: use wake_up_klogd() in bust_spinlocks()
Message-ID: <20181025082827.GC20702@jagdpanzerIV>
References: <20181024043048.21248-1-sergey.senozhatsky@gmail.com>
 <20181024043425.GA8862@jagdpanzerIV>
 <20181025062800.GB4037@osiris>
 <20181025070543.GB20702@jagdpanzerIV>
 <20181025081108.GB26561@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025081108.GB26561@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Peter Oberparleiter <oberpar@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On (10/25/18 10:11), Heiko Carstens wrote:
> > s390 is the only architecture that is using own bust_spinlocks()
> > variant, while other arch-s seem to be OK with the common
> > implementation.
> > 
> > Heiko Carstens [1] said he would prefer s390 to use the common
> > bust_spinlocks() as well:
> >   I did some code archaeology and this function is unchanged since ~17
> >   years. When it was introduced it was close to identical to the x86
> >   variant. All other architectures use the common code variant in the
> >   meantime. So if we change this I'd prefer that we switch s390 to the
> >   common code variant as well. Right now I can't see a reason for not
> >   doing that
> > 
> > This patch removes s390 bust_spinlocks() and drops the weak attribute
> > from the common bust_spinlocks() version.
> > 
> > [1] lkml.kernel.org/r/20181025062800.GB4037@osiris
> > Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> > ---
> >  arch/s390/mm/fault.c | 24 ------------------------
> >  lib/bust_spinlocks.c |  6 +++---
> >  2 files changed, 3 insertions(+), 27 deletions(-)
> 
> I gave this some testing and forced panic/die in interrupt as well as
> process context with different consoles as well as single and multi
> cpu systems. Everything still seems to work.

That was quick ;) Thanks.

> So I'm applying this to our internal queue first. It will hit upstream
> latest in the next merge window if there aren't any issues found.

Sure; sounds like a plan.

	-ss
