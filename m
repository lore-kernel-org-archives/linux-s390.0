Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Mon, 8 Apr 2019 15:03:12 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 03/12] s390: purgatory: pass --target option to clang
Message-ID: <20190408220312.GA18333@archlinux-i9>
References: <20190408212648.2407234-1-arnd@arndb.de>
 <20190408212648.2407234-3-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408212648.2407234-3-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, linux-s390@vger.kernel.org, Philipp Rudo <prudo@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 08, 2019 at 11:26:16PM +0200, Arnd Bergmann wrote:
> The purgatory Makefile does not inherit the original cflags,
> so clang falls back to the default target architecture when
> building it, typically this would be x86 when cross-compiling.
> 
> Pass --target=s390x-linux to all compilers that understand
> this option.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/purgatory/Makefile | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
> index ce6a3f75065b..3a14b968cec3 100644
> --- a/arch/s390/purgatory/Makefile
> +++ b/arch/s390/purgatory/Makefile
> @@ -22,6 +22,7 @@ KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
>  KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
>  KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
>  KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
> +KBUILD_CFLAGS += $(call cc-option,--target=s390x-linux)
>  KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
>  KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
>  
> -- 
> 2.20.0
> 

Would

ifdef CONFIG_CC_IS_CLANG
KBUILD_CFLAGS += --target=s390x-linux
endif

be a little clearer (and save a cc-option call)?

Otherwise, makes sense.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
