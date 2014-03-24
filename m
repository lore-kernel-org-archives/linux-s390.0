Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 24 Mar 2014 07:22:45 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 03/16] s390: net: lcs: Add missing
 destroy_timer_on_stack()
Message-ID: <20140324062245.GD4487@osiris>
References: <20140323150557.288925975@linutronix.de>
 <20140323150752.843705144@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140323150752.843705144@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Andrew Morton <akpm@linux-foundation.org>, Ursula Braun <ursula.braun@de.ibm.com>, s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Mar 23, 2014 at 03:09:25PM -0000, Thomas Gleixner wrote:
> Otherwise we leak a tracking object when DEBUG_OBJECTS is enabled.


>  drivers/s390/net/lcs.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> Index: tip/drivers/s390/net/lcs.c
> ===================================================================
> --- tip.orig/drivers/s390/net/lcs.c
> +++ tip/drivers/s390/net/lcs.c
> @@ -899,6 +899,7 @@ lcs_send_lancmd(struct lcs_card *card, s
>  	add_timer(&timer);
>  	wait_event(reply->wait_q, reply->received);
>  	del_timer_sync(&timer);
> +	destroy_timer_on_stack(&timer);

Applied, thanks.
