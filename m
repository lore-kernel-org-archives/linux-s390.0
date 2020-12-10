Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from aserp2130.oracle.com ([141.146.126.79]:55024 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394234AbgLJXWj (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 10 Dec 2020 18:22:39 -0500
Subject: Re: [patch 24/30] xen/events: Remove unused
 bind_evtchn_to_irq_lateeoi()
References: <20201210192536.118432146@linutronix.de>
 <20201210194044.972064156@linutronix.de>
From: boris.ostrovsky@oracle.com
Message-ID: <748d8d81-ac0f-aee2-1a56-ba9c40fee52f@oracle.com>
Date: Thu, 10 Dec 2020 18:19:19 -0500
MIME-Version: 1.0
In-Reply-To: <20201210194044.972064156@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, afzal mohammed <afzal.mohd.ma@gmail.com>, linux-parisc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>, Wambui Karuga <wambui.karugax@gmail.com>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, Lee Jones <lee.jones@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@xilinx.com>, linux-pci@vger.kernel.org, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>


On 12/10/20 2:26 PM, Thomas Gleixner wrote:
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: Stefano Stabellini <sstabellini@kernel.org>
> Cc: xen-devel@lists.xenproject.org
> ---
>  drivers/xen/events/events_base.c |    6 ------
>  1 file changed, 6 deletions(-)
>
> --- a/drivers/xen/events/events_base.c
> +++ b/drivers/xen/events/events_base.c
> @@ -1132,12 +1132,6 @@ int bind_evtchn_to_irq(evtchn_port_t evt
>  }
>  EXPORT_SYMBOL_GPL(bind_evtchn_to_irq);
>  
> -int bind_evtchn_to_irq_lateeoi(evtchn_port_t evtchn)
> -{
> -	return bind_evtchn_to_irq_chip(evtchn, &xen_lateeoi_chip);
> -}
> -EXPORT_SYMBOL_GPL(bind_evtchn_to_irq_lateeoi);



include/xen/events.h also needs to be updated (and in the next patch for xen_set_affinity_evtchn() as well).


-boris
