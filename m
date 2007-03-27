Return-Path: <linux-kernel-owner+w=401wt.eu-S965496AbXC0VgH@vger.kernel.org>
Date: Tue, 27 Mar 2007 21:35:29 +0000
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 1/8] Processor degredation support.
Message-ID: <20070327213529.GB5842@ucw.cz>
References: <20070326212459.711271424@de.ibm.com> <20070326212634.931820139@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070326212634.931820139@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi!

> From: Heiko Carstens <heiko.carstens@de.ibm.com>
> 
> Emit a warning if cpu capability changes e.g. because the cpus are
> overheating. The new cpu capability can be read via /proc/sysinfo.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>

> +++ linux-2.6/drivers/s390/char/sclp_confmgm.c

Can we get less cyptic name?


> +#define SCLP_CONFMGM_PRINT_HEADER	"sclp_confmgm: "

Uah, define longer than text it expands to... 

> +static void sclp_conf_receiver_fn(struct evbuf_header *evbuf)
> +{
> +	struct conf_mgm_data *cdata;
> +
> +	cdata = (struct conf_mgm_data *)(evbuf + 1);
> +	if (cdata->ev_qualifier == EV_QUAL_CAP_CHANGE)
> +		/* Will be parsed. Don't change. */
> +		printk(KERN_WARNING "sclp: CPU capability changed.\n");
> +}

What's that? I do not think printk provides guaranteed delivery.

> +static struct sclp_register sclp_conf_register =
> +{
> +	.receive_mask = EvTyp_ConfMgmData_Mask,

NoCamelCasePlease.

> @@ -27,6 +27,7 @@
>  #define EvTyp_CntlProgIdent	0x0B
>  #define EvTyp_SigQuiesce	0x1D
>  #define EvTyp_VT220Msg		0x1A
> +#define EvTyp_ConfMgmData	0x04
>  
>  #define EvTyp_OpCmd_Mask	0x80000000
>  #define EvTyp_Msg_Mask		0x40000000
> @@ -36,6 +37,7 @@
>  #define EvTyp_CtlProgIdent_Mask	0x00200000
>  #define EvTyp_SigQuiesce_Mask	0x00000008
>  #define EvTyp_VT220Msg_Mask	0x00000040
> +#define EvTyp_ConfMgmData_Mask	0x10000000
>  
>  #define GnrlMsgFlgs_DOM		0x8000
>  #define GnrlMsgFlgs_SndAlrm	0x4000

Yep, you have more CamelCases to fix.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
