Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-9-hch@lst.de>
In-Reply-To: <20190213174005.28785-9-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 15 Feb 2019 17:42:25 +0900
Message-ID: <CAK7LNASycJG=26WUPwJsMwYPhj26YFhj+NH5jNcMGx3PQ-miTQ@mail.gmail.com>
Subject: Re: [PATCH 08/11] lib: consolidate the GENERIC_BUG symbol
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-xtensa@linux-xtensa.org, linux-s390 <linux-s390@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Feb 14, 2019 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
>
> And just let the architectures that want it select the symbol.
> Same for GENERIC_BUG_RELATIVE_POINTERS.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>


This slightly changes the behavior of GENERIC_BUG_RELATIVE_POINTERS
for arm64, riscv, x86.
Previously, GENERIC_BUG_RELATIVE_POINTERS was enabled only when BUG=y.


Having said that, this is not a big deal.
When CONFIG_GENERIC_BUG=n, CONFIG_GENERIC_BUG_RELATIVE_POINTERS
is actually don't care.



If you change this,
could you add some comments in commit description?


> ---

> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index c39dac831f08..913b2ca7ec22 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -85,6 +85,8 @@ config ARM64
>         select FRAME_POINTER
>         select GENERIC_ALLOCATOR
>         select GENERIC_ARCH_TOPOLOGY
> +       select GENERIC_BUG if BUG
> +       select GENERIC_BUG_RELATIVE_POINTERS

Precisely,

          select GENERIC_BUG_RELATIVE_POINTERS if BUG




> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 732614eb3683..c410ed896567 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -19,6 +19,8 @@ config RISCV
>         select ARCH_WANT_FRAME_POINTERS
>         select CLONE_BACKWARDS
>         select COMMON_CLK
> +       select GENERIC_BUG if BUG
> +       select GENERIC_BUG_RELATIVE_POINTERS if 64BIT

Precisely,

          select GENERIC_BUG_RELATIVE_POINTERS if 64BIT && BUG


> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 15ccdd04814e..2a5c12be633e 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -17,12 +17,6 @@ config ARCH_HAS_ILOG2_U64
>  config GENERIC_HWEIGHT
>         def_bool y
>
> -config GENERIC_BUG
> -       def_bool y if BUG
> -
> -config GENERIC_BUG_RELATIVE_POINTERS
> -       def_bool y
> -


Hmm, s390 enables GENERIC_BUG_RELATIVE_POINTERS
irrespective of BUG...





> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 1bd4f19b6b28..f4cb31174e1b 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -91,6 +91,8 @@ config X86
>         select DCACHE_WORD_ACCESS
>         select EDAC_ATOMIC_SCRUB
>         select EDAC_SUPPORT
> +       select GENERIC_BUG                      if BUG
> +       select GENERIC_BUG_RELATIVE_POINTERS    if X86_64

Precisely,

          select GENERIC_BUG_RELATIVE_POINTERS    if X86_64 && BUG






--
Best Regards
Masahiro Yamada
