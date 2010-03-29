Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 29 Mar 2010 17:57:00 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 2/12] arch/s390/kernel: Add missing unlock
Message-ID: <20100329155700.GA3066@osiris.boeblingen.de.ibm.com>
References: <Pine.LNX.4.64.1003291733350.21896@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1003291733350.21896@ask.diku.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Julia Lawall <julia@diku.dk>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 29, 2010 at 05:33:52PM +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> In the default case the lock is not unlocked.  The return is
> converted to a goto, to share the unlock at the end of the function.
> 
> diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
> index 14ef6f0..247b4c2 100644
> --- a/arch/s390/kernel/topology.c
> +++ b/arch/s390/kernel/topology.c
> @@ -165,10 +165,11 @@ static void tl_to_cores(struct tl_info *info)
>  		default:
>  			clear_cores();
>  			machine_has_topology = 0;
> -			return;
> +			goto out;
>  		}
>  		tle = next_tle(tle);
>  	}
> +out:
>  	spin_unlock_irq(&topology_lock);

Applied. Thank you!
