Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-6-hch@lst.de>
In-Reply-To: <20190213174005.28785-6-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 15 Feb 2019 16:55:47 +0900
Message-ID: <CAK7LNARDdPabSOq6vHvxTPPWaMguJUEtok=dNrfnLEz=UtHO+w@mail.gmail.com>
Subject: Re: [PATCH 05/11] tracing: consolidate the TRACE_IRQFLAGS_SUPPORT symbol
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-xtensa@linux-xtensa.org, linux-s390 <linux-s390@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ley Foon Tan <lftan@altera.com>, nios2-dev@lists.rocketboards.org
List-ID: <linux-s390.vger.kernel.org>

+CC: Ley Foon Tan <lftan@altera.com>
+CC: nios2-dev@lists.rocketboards.org


On Thu, Feb 14, 2019 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:

> diff --git a/arch/nios2/Kconfig b/arch/nios2/Kconfig
> index 715e6c09b4a5..3b50689007f5 100644
> --- a/arch/nios2/Kconfig
> +++ b/arch/nios2/Kconfig
> @@ -20,6 +20,7 @@ config NIOS2
>         select OF_EARLY_FLATTREE
>         select SOC_BUS
>         select SPARSE_IRQ
> +       select TRACE_IRQFLAGS_SUPPORT


This is a behavior change of nios2.

TRACE_IRQFLAGS_SUPPORT was previously 'n',
and this commit is changing it to 'y'.




Strangely, nios2 defines TRACE_IRQFLAGS_SUPPORT twice
with different default values.

In Kconfig, the first one becomes effective.

In this case, 'def_bool n' in arch/nios2/Kconfig is used.
'def_bool y' in arch/nios2/Kconfig.debug is dead code.


I think this select should be dropped
to keep the current behavior,
but I hope the NIOS2 maintainer will give us
some comments just in case.




>         select USB_ARCH_HAS_HCD if USB_SUPPORT
>         select CPU_NO_EFFICIENT_FFS
>         select ARCH_DISCARD_MEMBLOCK
> @@ -39,9 +40,6 @@ config NO_IOPORT_MAP
>  config FPU
>         def_bool n
>
> -config TRACE_IRQFLAGS_SUPPORT
> -       def_bool n
> -
>  menu "Kernel features"
>
>  source "kernel/Kconfig.hz"
> diff --git a/arch/nios2/Kconfig.debug b/arch/nios2/Kconfig.debug
> index f1da8a7b17ff..a8bc06e96ef5 100644
> --- a/arch/nios2/Kconfig.debug
> +++ b/arch/nios2/Kconfig.debug
> @@ -1,8 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
>
> -config TRACE_IRQFLAGS_SUPPORT
> -       def_bool y
> -
>  config EARLY_PRINTK
>         bool "Activate early kernel debugging"
>         default y

--
Best Regards
Masahiro Yamada
