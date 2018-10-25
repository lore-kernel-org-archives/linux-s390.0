Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 25 Oct 2018 08:28:00 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH] s390/fault: use wake_up_klogd() in bust_spinlocks()
References: <20181024043048.21248-1-sergey.senozhatsky@gmail.com>
 <20181024043425.GA8862@jagdpanzerIV>
MIME-Version: 1.0
In-Reply-To: <20181024043425.GA8862@jagdpanzerIV>
Message-Id: <20181025062800.GB4037@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Peter Oberparleiter <oberpar@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Oct 24, 2018 at 01:34:25PM +0900, Sergey Senozhatsky wrote:
> On (10/24/18 13:30), Sergey Senozhatsky wrote:
> From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> Subject: [PATCH] s390/fault: use wake_up_klogd() in bust_spinlocks()

...

> From the comment it seems that s390 wants to just poke klogd.
> There is wake_up_klogd() for this purpose, so we can replace
> that printk(" ").
> 
> Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
> ---
>  arch/s390/mm/fault.c | 12 ++++--------
>  1 file changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
> index 2b8f32f56e0c..53915c61ad95 100644
> --- a/arch/s390/mm/fault.c
> +++ b/arch/s390/mm/fault.c
> @@ -92,16 +92,12 @@ void bust_spinlocks(int yes)
>  		oops_in_progress = 1;
>  	} else {
>  		int loglevel_save = console_loglevel;
> -		console_unblank();
> -		oops_in_progress = 0;
> -		/*
> -		 * OK, the message is on the console.  Now we call printk()
> -		 * without oops_in_progress set so that printk will give klogd
> -		 * a poke.  Hold onto your hats...
> -		 */
> +
>  		console_loglevel = 15;
> -		printk(" ");
> +		console_unblank();
>  		console_loglevel = loglevel_save;
> +		oops_in_progress = 0;
> +		wake_up_klogd();
>  	}

With your patch this looks nearly like the common code variant. I did
some code archaeology and this function is unchanged since ~17 years.
When it was introduced it was close to identical to the x86 variant.
All other architectures use the common code variant in the
meantime. So if we change this I'd prefer that we switch s390 to the
common code variant as well.

Right now I can't see a reason for not doing that, but I might be
wrong of course. So, could you please provide a new version which just
removes this variant and makes s390 use the generic one too.

We'll see if there is any fallout...
