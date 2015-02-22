Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 22 Feb 2015 13:53:52 +0100 (CET)
From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: [PATCH 19/27] s390: Remove use of seq_printf return value
In-Reply-To: <1ed484d91a317c990a6316c22382b989fc317994.1424573328.git.joe@perches.com>
Message-ID: <alpine.LFD.2.11.1502221352190.1738@denkbrett>
References: <cover.1424573328.git.joe@perches.com>  <1ed484d91a317c990a6316c22382b989fc317994.1424573328.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Peter Oberparleiter <oberpar@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sat, 21 Feb 2015, Joe Perches wrote:

> The seq_printf return value, because it's frequently misused,
> will eventually be converted to void.
> 
> See: commit 1f33c41c03da ("seq_file: Rename seq_overflow() to
>      seq_has_overflowed() and make public")
> 

Acked-By: Sebastian Ott <sebott@linux.vnet.ibm.com>

Regards,
Sebastian

> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>  arch/s390/pci/pci_debug.c    |  6 ++++--
>  drivers/s390/cio/blacklist.c | 12 +++++++-----
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/s390/pci/pci_debug.c b/arch/s390/pci/pci_debug.c
> index 3229a2e..c22d440 100644
> --- a/arch/s390/pci/pci_debug.c
> +++ b/arch/s390/pci/pci_debug.c
> @@ -45,8 +45,10 @@ static int pci_perf_show(struct seq_file *m, void *v)
> 
>  	if (!zdev)
>  		return 0;
> -	if (!zdev->fmb)
> -		return seq_printf(m, "FMB statistics disabled\n");
> +	if (!zdev->fmb) {
> +		seq_puts(m, "FMB statistics disabled\n");
> +		return 0;
> +	}
> 
>  	/* header */
>  	seq_printf(m, "FMB @ %p\n", zdev->fmb);
> diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
> index b3f791b..20314aa 100644
> --- a/drivers/s390/cio/blacklist.c
> +++ b/drivers/s390/cio/blacklist.c
> @@ -330,18 +330,20 @@ cio_ignore_proc_seq_show(struct seq_file *s, void *it)
>  	if (!iter->in_range) {
>  		/* First device in range. */
>  		if ((iter->devno == __MAX_SUBCHANNEL) ||
> -		    !is_blacklisted(iter->ssid, iter->devno + 1))
> +		    !is_blacklisted(iter->ssid, iter->devno + 1)) {
>  			/* Singular device. */
> -			return seq_printf(s, "0.%x.%04x\n",
> -					  iter->ssid, iter->devno);
> +			seq_printf(s, "0.%x.%04x\n", iter->ssid, iter->devno);
> +			return 0;
> +		}
>  		iter->in_range = 1;
> -		return seq_printf(s, "0.%x.%04x-", iter->ssid, iter->devno);
> +		seq_printf(s, "0.%x.%04x-", iter->ssid, iter->devno);
> +		return 0;
>  	}
>  	if ((iter->devno == __MAX_SUBCHANNEL) ||
>  	    !is_blacklisted(iter->ssid, iter->devno + 1)) {
>  		/* Last device in range. */
>  		iter->in_range = 0;
> -		return seq_printf(s, "0.%x.%04x\n", iter->ssid, iter->devno);
> +		seq_printf(s, "0.%x.%04x\n", iter->ssid, iter->devno);
>  	}
>  	return 0;
>  }
> -- 
> 2.1.2
> 
> 
