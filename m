Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 24 Mar 2014 07:22:29 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [patch 02/16] s390: tape: Add missing destroy_timer_on_stack()
Message-ID: <20140324062229.GC4487@osiris>
References: <20140323150557.288925975@linutronix.de>
 <20140323150752.720915842@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140323150752.720915842@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>, Andrew Morton <akpm@linux-foundation.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Mar 23, 2014 at 03:09:25PM -0000, Thomas Gleixner wrote:
> Otherwise we leak a tracking object when DEBUG_OBJECTS is enabled.
> 

[...]

>  	del_timer_sync(&timeout);
> +	destroy_timer_on_stack(&timeout);

Applied, thanks.
