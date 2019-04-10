Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 10 Apr 2019 17:57:25 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 01/12] s390: remove -fno-strength-reduce flag
In-Reply-To: <20190408212648.2407234-1-arnd@arndb.de>
References: <20190408212648.2407234-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20190410175725.23b7f051@mschwideX1>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon,  8 Apr 2019 23:26:14 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> This was added as a workaround for really old compilers, and it prevents
> building with clang now. I can see no reason for keeping it, as it has
> already been removed for most architectures in the pre-git era, so
> let's remove it everywhere, rather than only for clang.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index 86c76b149cc2..0087d11e3eaf 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -114,7 +114,7 @@ endif
>  cfi := $(call as-instr,.cfi_startproc\n.cfi_val_offset 15$(comma)-160\n.cfi_endproc,-DCONFIG_AS_CFI_VAL_OFFSET=1)
> 
>  KBUILD_CFLAGS	+= -mbackchain -msoft-float $(cflags-y)
> -KBUILD_CFLAGS	+= -pipe -fno-strength-reduce -Wno-sign-compare
> +KBUILD_CFLAGS	+= -pipe -Wno-sign-compare
>  KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables $(cfi)
>  KBUILD_AFLAGS	+= $(aflags-y) $(cfi)
>  export KBUILD_AFLAGS_DECOMPRESSOR

Added to s390/linux:features for the next merge window. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
