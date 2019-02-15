Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-12-hch@lst.de>
In-Reply-To: <20190213174005.28785-12-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 15 Feb 2019 16:44:19 +0900
Message-ID: <CAK7LNAQRv4ksk_bryE_PsHtiojEQos2BY8vQQ1sDcKkdypYH8A@mail.gmail.com>
Subject: Re: [PATCH 11/11] s390: don't redefined the HAS_IOMEM symbol
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-xtensa@linux-xtensa.org, linux-s390 <linux-s390@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Feb 14, 2019 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Rely on the common defintion instead.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/s390/Kconfig | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 9a25e19364f5..0f62e33ffcb2 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -159,6 +159,7 @@ config S390
>         select MODULES_USE_ELF_RELA
>         select NEED_DMA_MAP_STATE       if PCI
>         select NEED_SG_DMA_LENGTH       if PCI
> +       select NO_IOMEM                 if !PCI


This does not work because NO_IOMEM is defined
in arch/um/Kconfig.


If you want to do this,
you must move NO_IOMEM  to lib/Kconfig.



>         select OLD_SIGACTION
>         select OLD_SIGSUSPEND3
>         select PCI_DOMAINS              if PCI
> @@ -708,9 +709,6 @@ config PCI_NR_FUNCTIONS
>
>  endif  # PCI
>
> -config HAS_IOMEM
> -       def_bool PCI
> -
>  config CHSC_SCH
>         def_tristate m
>         prompt "Support for CHSC subchannels"
> --
> 2.20.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Best Regards
Masahiro Yamada
