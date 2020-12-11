Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392465AbgLKRyP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 11 Dec 2020 12:54:15 -0500
MIME-Version: 1.0
References: <20201210192536.118432146@linutronix.de> <20201210194042.860029489@linutronix.de>
In-Reply-To: <20201210194042.860029489@linutronix.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 11 Dec 2020 19:53:07 +0200
Message-ID: <CAHp75Vc-2OjE2uwvNRiyLMQ8GSN3P7SehKD-yf229_7ocaktiw@mail.gmail.com>
Subject: Re: [patch 03/30] genirq: Move irq_set_lockdep_class() to core
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, afzal mohammed <afzal.mohd.ma@gmail.com>, linux-parisc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>, Wambui Karuga <wambui.karugax@gmail.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@xilinx.com>, linux-pci <linux-pci@vger.kernel.org>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>, "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On Thu, Dec 10, 2020 at 10:14 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> irq_set_lockdep_class() is used from modules and requires irq_to_desc() to
> be exported. Move it into the core code which lifts another requirement for
> the export.

...

> +       if (IS_ENABLED(CONFIG_LOCKDEP))
> +               __irq_set_lockdep_class(irq, lock_class, request_class);

Maybe I missed something, but even if the compiler does not warn the
use of if IS_ENABLED() with complimentary #ifdef seems inconsistent.

> +#ifdef CONFIG_LOCKDEP
...
> +EXPORT_SYMBOL_GPL(irq_set_lockdep_class);
> +#endif


-- 
With Best Regards,
Andy Shevchenko
