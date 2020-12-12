Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405486AbgLLNXM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 12 Dec 2020 08:23:12 -0500
MIME-Version: 1.0
References: <20201210192536.118432146@linutronix.de> <20201210194042.860029489@linutronix.de>
 <CAHp75Vc-2OjE2uwvNRiyLMQ8GSN3P7SehKD-yf229_7ocaktiw@mail.gmail.com>
 <87h7osgifc.fsf@nanos.tec.linutronix.de> <87360cgfol.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87360cgfol.fsf@nanos.tec.linutronix.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 12 Dec 2020 15:22:14 +0200
Message-ID: <CAHp75Ve5zzeQw8P2wD083WW5+KGehETTy810wksfpXbj+3GBug@mail.gmail.com>
Subject: Re: [patch 03/30] genirq: Move irq_set_lockdep_class() to core
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, afzal mohammed <afzal.mohd.ma@gmail.com>, linux-parisc@vger.kernel.org, Russell King <linux@armlinux.org.uk>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>, Wambui Karuga <wambui.karugax@gmail.com>, intel-gfx <intel-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, Linus Walleij <linus.walleij@linaro.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Michal Simek <michal.simek@xilinx.com>, linux-pci <linux-pci@vger.kernel.org>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>, "open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, xen-devel@lists.xenproject.org

On Sat, Dec 12, 2020 at 12:07 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Fri, Dec 11 2020 at 22:08, Thomas Gleixner wrote:
>
> > On Fri, Dec 11 2020 at 19:53, Andy Shevchenko wrote:
> >
> >> On Thu, Dec 10, 2020 at 10:14 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>>
> >>> irq_set_lockdep_class() is used from modules and requires irq_to_desc() to
> >>> be exported. Move it into the core code which lifts another requirement for
> >>> the export.
> >>
> >> ...
> >>
> >>> +       if (IS_ENABLED(CONFIG_LOCKDEP))
> >>> +               __irq_set_lockdep_class(irq, lock_class, request_class);
> >
> > You are right. Let me fix that.
>
> No. I have to correct myself. You're wrong.
>
> The inline is evaluated in the compilation units which include that
> header and because the function declaration is unconditional it is
> happy.
>
> Now the optimizer stage makes the whole thing a NOOP if CONFIG_LOCKDEP=n
> and thereby drops the reference to the function which makes it not
> required for linking.
>
> So in the file where the function is implemented:
>
> #ifdef CONFIG_LOCKDEP
> void __irq_set_lockdep_class(....)
> {
> }
> #endif
>
> The whole block is either discarded because CONFIG_LOCKDEP is not
> defined or compile if it is defined which makes it available for the
> linker.
>
> And in the latter case the optimizer keeps the call in the inline (it
> optimizes the condition away because it's always true).
>
> So in both cases the compiler and the linker are happy and everything
> works as expected.
>
> It would fail if the header file had the following:
>
> #ifdef CONFIG_LOCKDEP
> void __irq_set_lockdep_class(....);
> #endif
>
> Because then it would complain about the missing function prototype when
> it evaluates the inline.

I understand that (that's why I put "if even no warning") and what I'm
talking about is the purpose of IS_ENABLED(). It's usually good for
compile testing !CONFIG_FOO cases. But here it seems inconsistent.

The pattern I usually see in the cases like this is

 #ifdef CONFIG_LOCKDEP
 void __irq_set_lockdep_class(....);
 #else
 static inline void ... {}
 #endif

and call it directly in the caller.

It's not a big deal, so up to you.

-- 
With Best Regards,
Andy Shevchenko
