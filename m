From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2] arch: s390: appldata: using strncpy() and strnlen()
 instead of sprintf()
Date: Wed, 29 May 2013 09:30:20 +0300
Message-ID: <20130529063020.GG23932@mwanda>
References: <51A48EE9.2040401@asianux.com>
 <51A32D81.2010105@asianux.com>
 <51A2CC07.5010100@asianux.com>
 <CAMuHMdXTW3QOxfAfqQXdbSpP4R83srFf7eMfu5fA-75S_Mujsg@mail.gmail.com>
 <4310.1369736553@warthog.procyon.org.uk>
 <5895.1369743429@warthog.procyon.org.uk>
 <51A559CB.3020804@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <51A559CB.3020804@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: David Howells <dhowells@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, jang@linux.vnet.ibm.com, linux390@de.ibm.com, linux-s390@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 29, 2013 at 09:28:43AM +0800, Chen Gang wrote:

> diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
> index bae0f40..27f200d 100644
> --- a/arch/s390/appldata/appldata_base.c
> +++ b/arch/s390/appldata/appldata_base.c
> @@ -212,10 +212,9 @@ appldata_timer_handler(ctl_table *ctl, int write,
>  		return 0;
>  	}
>  	if (!write) {
> -		len = sprintf(buf, appldata_timer_active ? "1\n" : "0\n");
> -		if (len > *lenp)
> -			len = *lenp;
> -		if (copy_to_user(buffer, buf, len))
> +		if (copy_to_user(buffer,
> +				 appldata_timer_active ? "1\n" : "0\n",
> +				 min(2, *lenp))

I don't have a cross compiler set up, but this will generate a
warning, I think.  min_t() is needed.

regards,
dan carpenter
