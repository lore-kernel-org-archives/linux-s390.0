Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 24 Mar 2014 07:22:07 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 01/16] s390: tape: Use del_timer_sync()
Message-ID: <20140324062207.GB4487@osiris>
References: <20140323150557.288925975@linutronix.de>
 <20140323150752.607059123@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140323150752.607059123@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Mar 23, 2014 at 03:09:24PM -0000, Thomas Gleixner wrote:
> del_timer() does not wait for a possible running callback to
> complete. So the call side might free request and the associated
> objects while on another cpu the timer handler runs.

[...]

>  
> -	del_timer(&timeout);
> +	del_timer_sync(&timeout);

Applied, thanks.
