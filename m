Return-Path: <linux-kbuild-owner@vger.kernel.org>
Message-ID: <1550540432.2534.1.camel@intel.com>
Subject: Re: [PATCH 05/11] tracing: consolidate the TRACE_IRQFLAGS_SUPPORT
 symbol
From: Ley Foon Tan <ley.foon.tan@intel.com>
Date: Tue, 19 Feb 2019 09:40:32 +0800
In-Reply-To: <CAK7LNARDdPabSOq6vHvxTPPWaMguJUEtok=dNrfnLEz=UtHO+w@mail.gmail.com>
References: <20190213174005.28785-1-hch@lst.de>
         <20190213174005.28785-6-hch@lst.de>
         <CAK7LNARDdPabSOq6vHvxTPPWaMguJUEtok=dNrfnLEz=UtHO+w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Mime-Version: 1.0
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Christoph Hellwig <hch@lst.de>
Cc: linux-xtensa@linux-xtensa.org, linux-s390 <linux-s390@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 2019-02-15 at 16:55 +0900, Masahiro Yamada wrote:
> +CC: Ley Foon Tan <lftan@altera.com>
> +CC: nios2-dev@lists.rocketboards.org
> 
> 
> On Thu, Feb 14, 2019 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
> 
> > 
> > diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
> > index 715e6c09b4a5..3b50689007f5 100644
> > --- a/arch/nios2/Kconfig
> > +++ b/arch/nios2/Kconfig
> > @@ -20,6 +20,7 @@ config NIOS2
> >         select OF_EARLY_FLATTREE
> >         select SOC_BUS
> >         select SPARSE_IRQ
> > +       select TRACE_IRQFLAGS_SUPPORT
> 
> This is a behavior change of nios2.
> 
> TRACE_IRQFLAGS_SUPPORT was previously 'n',
> and this commit is changing it to 'y'.
> 
> 
> 
> 
> Strangely, nios2 defines TRACE_IRQFLAGS_SUPPORT twice
> with different default values.
> 
> In Kconfig, the first one becomes effective.
> 
> In this case, 'def_bool n' in arch/nios2/Kconfig is used.
> 'def_bool y' in arch/nios2/Kconfig.debug is dead code.
> 
> 
> I think this select should be dropped
> to keep the current behavior,
> but I hope the NIOS2 maintainer will give us
> some comments just in case.
> 
Yes, please drop this patch to keep original behavior.
Thanks.

Regards
Ley Foon
> 
> 
> 
> > 
> >         select USB_ARCH_HAS_HCD if USB_SUPPORT
> >         select CPU_NO_EFFICIENT_FFS
> >         select ARCH_DISCARD_MEMBLOCK
> > @@ -39,9 +40,6 @@ config NO_IOPORT_MAP
> >  config FPU
> >         def_bool n
> > 
> > -config TRACE_IRQFLAGS_SUPPORT
> > -       def_bool n
> > -
> >  menu "Kernel features"
> > 
> >  source "kernel/Kconfig.hz"
> > diff --git a/arch/nios2/Kconfig.debug b/arch/nios2/Kconfig.debug
> > index f1da8a7b17ff..a8bc06e96ef5 100644
> > --- a/arch/nios2/Kconfig.debug
> > +++ b/arch/nios2/Kconfig.debug
> > @@ -1,8 +1,5 @@
> >  # SPDX-License-Identifier: GPL-2.0
> > 
> > -config TRACE_IRQFLAGS_SUPPORT
> > -       def_bool y
> > -
> >  config EARLY_PRINTK
> >         bool "Activate early kernel debugging"
> >         default y
> --
> Best Regards
> Masahiro Yamada
> 
> ________________________________
> 
> Confidentiality Notice.
> This message may contain information that is confidential or
> otherwise protected from disclosure. If you are not the intended
> recipient, you are hereby notified that any use, disclosure,
> dissemination, distribution, or copying of this message, or any
> attachments, is strictly prohibited. If you have received this
> message in error, please advise the sender by reply e-mail, and
> delete the message and any attachments. Thank you.
