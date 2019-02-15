Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
References: <20190213174005.28785-1-hch@lst.de> <20190213174005.28785-3-hch@lst.de>
In-Reply-To: <20190213174005.28785-3-hch@lst.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 15 Feb 2019 18:32:07 +0900
Message-ID: <CAK7LNAQFSQN=42X1dqt5io+gOG8mUpwXhLmspqryvmzakUCSWw@mail.gmail.com>
Subject: Re: [PATCH 02/11] riscv: remove the HAVE_KPROBES option
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-xtensa@linux-xtensa.org, linux-s390 <linux-s390@vger.kernel.org>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-riscv@lists.infradead.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Feb 14, 2019 at 2:40 AM Christoph Hellwig <hch@lst.de> wrote:
>
> HAVE_KPROBES is defined genericly in arch/Kconfig and architectures
> should just select it if supported.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Do you want this patch picked up by me?

Or, by Palmer?



> ---
>  arch/riscv/Kconfig | 3 ---
>  1 file changed, 3 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 515fc3cc9687..b60f4e3e36f4 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -94,9 +94,6 @@ config PGTABLE_LEVELS
>         default 3 if 64BIT
>         default 2
>
> -config HAVE_KPROBES
> -       def_bool n
> -
>  menu "Platform type"
>
>  choice
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
