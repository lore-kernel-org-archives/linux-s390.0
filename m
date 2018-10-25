Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 25 Oct 2018 10:11:08 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390/fault: use wake_up_klogd() in bust_spinlocks()
References: <20181024043048.21248-1-sergey.senozhatsky@gmail.com>
 <20181024043425.GA8862@jagdpanzerIV>
 <20181025062800.GB4037@osiris>
 <20181025070543.GB20702@jagdpanzerIV>
MIME-Version: 1.0
In-Reply-To: <20181025070543.GB20702@jagdpanzerIV>
Message-Id: <20181025081108.GB26561@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Peter Oberparleiter <oberpar@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Oct 25, 2018 at 04:05:43PM +0900, Sergey Senozhatsky wrote:
> On (10/25/18 08:28), Heiko Carstens wrote:
> > 
> > With your patch this looks nearly like the common code variant. I did
> > some code archaeology and this function is unchanged since ~17 years.
> > When it was introduced it was close to identical to the x86 variant.
> > All other architectures use the common code variant in the
> > meantime. So if we change this I'd prefer that we switch s390 to the
> > common code variant as well.
> > 
> > Right now I can't see a reason for not doing that, but I might be
> > wrong of course. So, could you please provide a new version which just
> > removes this variant and makes s390 use the generic one too.
> > 
> > We'll see if there is any fallout...
> 
> Heiko, if this one works for you then I'll submit a format patch.
> Let me know. Thanks.
> 
> ====
> 
> From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Subject: [PATCH] arch/s390: use common bust_spinlocks()
> 
> s390 is the only architecture that is using own bust_spinlocks()
> variant, while other arch-s seem to be OK with the common
> implementation.
> 
> Heiko Carstens [1] said he would prefer s390 to use the common
> bust_spinlocks() as well:
>   I did some code archaeology and this function is unchanged since ~17
>   years. When it was introduced it was close to identical to the x86
>   variant. All other architectures use the common code variant in the
>   meantime. So if we change this I'd prefer that we switch s390 to the
>   common code variant as well. Right now I can't see a reason for not
>   doing that
> 
> This patch removes s390 bust_spinlocks() and drops the weak attribute
> from the common bust_spinlocks() version.
> 
> [1] lkml.kernel.org/r/20181025062800.GB4037@osiris
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  arch/s390/mm/fault.c | 24 ------------------------
>  lib/bust_spinlocks.c |  6 +++---
>  2 files changed, 3 insertions(+), 27 deletions(-)

I gave this some testing and forced panic/die in interrupt as well as
process context with different consoles as well as single and multi
cpu systems. Everything still seems to work.

So I'm applying this to our internal queue first. It will hit upstream
latest in the next merge window if there aren't any issues found.

Thanks!
