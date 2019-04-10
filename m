Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20190410201300.3528984-1-arnd@arndb.de>
In-Reply-To: <20190410201300.3528984-1-arnd@arndb.de>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 10 Apr 2019 15:20:09 -0700
Message-ID: <CAKwvOdnZjj_FRQkAqmmmMcG=s+TGFXqQS5-ZhT2E9fcGu-nm8w@mail.gmail.com>
Subject: Re: [PATCH 1/2] s390: only build for new CPUs with clang
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>, linux-s390 <linux-s390@vger.kernel.org>, Masahiro Yamada <yamada.masahiro@socionext.com>, Philipp Rudo <prudo@linux.vnet.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 10, 2019 at 1:13 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> llvm does does not understand -march=z9-109 and older target

Please file bugs for these in LLVM's issue tracker.  It might be
possible to enable these additional architecture variants if they're
similar to existing ones and simply unrecognized.  IIRC, we had this
issue with armv7 variants.

> specifiers, so disable the respective Kconfig settings and
> the logic to make the boot code work on old systems when
> building with clang.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/Kconfig       | 6 ++++++
>  arch/s390/boot/Makefile | 2 ++
>  2 files changed, 8 insertions(+)
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 8cd860cba4d1..1a2eec61196d 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -240,6 +240,7 @@ choice
>
>  config MARCH_Z900
>         bool "IBM zSeries model z800 and z900"
> +       depends on !CC_IS_CLANG
>         select HAVE_MARCH_Z900_FEATURES
>         help
>           Select this to enable optimizations for model z800/z900 (2064 and
> @@ -248,6 +249,7 @@ config MARCH_Z900
>
>  config MARCH_Z990
>         bool "IBM zSeries model z890 and z990"
> +       depends on !CC_IS_CLANG
>         select HAVE_MARCH_Z990_FEATURES
>         help
>           Select this to enable optimizations for model z890/z990 (2084 and
> @@ -256,6 +258,7 @@ config MARCH_Z990
>
>  config MARCH_Z9_109
>         bool "IBM System z9"
> +       depends on !CC_IS_CLANG
>         select HAVE_MARCH_Z9_109_FEATURES
>         help
>           Select this to enable optimizations for IBM System z9 (2094 and
> @@ -347,12 +350,15 @@ config TUNE_DEFAULT
>
>  config TUNE_Z900
>         bool "IBM zSeries model z800 and z900"
> +       depends on !CC_IS_CLANG
>
>  config TUNE_Z990
>         bool "IBM zSeries model z890 and z990"
> +       depends on !CC_IS_CLANG
>
>  config TUNE_Z9_109
>         bool "IBM System z9"
> +       depends on !CC_IS_CLANG
>
>  config TUNE_Z10
>         bool "IBM System z10"
> diff --git a/arch/s390/boot/Makefile b/arch/s390/boot/Makefile
> index c844eaf24ed7..953a74d04990 100644
> --- a/arch/s390/boot/Makefile
> +++ b/arch/s390/boot/Makefile
> @@ -11,6 +11,7 @@ KASAN_SANITIZE := n
>  KBUILD_AFLAGS := $(KBUILD_AFLAGS_DECOMPRESSOR)
>  KBUILD_CFLAGS := $(KBUILD_CFLAGS_DECOMPRESSOR)
>
> +ifndef CONFIG_CC_IS_CLANG
>  #
>  # Use -march=z900 for als.c to be able to print an error
>  # message if the kernel is started on a machine which is too old
> @@ -25,6 +26,7 @@ CFLAGS_als.o                  += -march=z900
>  CFLAGS_REMOVE_sclp_early_core.o        += $(CC_FLAGS_MARCH)
>  CFLAGS_sclp_early_core.o       += -march=z900
>  endif
> +endif
>
>  CFLAGS_sclp_early_core.o += -I$(srctree)/drivers/s390/char
>
> --
> 2.20.0
>


-- 
Thanks,
~Nick Desaulniers
