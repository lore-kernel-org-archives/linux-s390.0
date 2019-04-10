Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20190410201300.3528984-1-arnd@arndb.de> <20190410201300.3528984-2-arnd@arndb.de>
In-Reply-To: <20190410201300.3528984-2-arnd@arndb.de>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 10 Apr 2019 15:14:30 -0700
Message-ID: <CAKwvOdk-tfsZRVaOr8Suv5C146F-w3jUA-Rx0n2OxkVy+L8tCg@mail.gmail.com>
Subject: Re: [PATCH 2/2] s390: boot, purgatory: pass $(CLANG_FLAGS) where needed
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Philipp Rudo <prudo@linux.ibm.com>, Hendrik Brueckner <brueckner@linux.ibm.com>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 10, 2019 at 1:13 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> The purgatory and boot Makefiles do not inherit the original cflags,
> so clang falls back to the default target architecture when building it,
> typically this would be x86 when cross-compiling.
>
> Add $(CLANG_FLAGS) everywhere so we pass the correct --target=s390x-linux
> option when cross-compiling.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/Makefile           | 5 +++--
>  arch/s390/purgatory/Makefile | 1 +
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index 9c079a506325..443990791099 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -17,12 +17,13 @@ KBUILD_CFLAGS_MODULE += -fPIC
>  KBUILD_AFLAGS  += -m64
>  KBUILD_CFLAGS  += -m64
>  aflags_dwarf   := -Wa,-gdwarf-2
> -KBUILD_AFLAGS_DECOMPRESSOR := -m64 -D__ASSEMBLY__
> +KBUILD_AFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -D__ASSEMBLY__
>  KBUILD_AFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),$(aflags_dwarf))
> -KBUILD_CFLAGS_DECOMPRESSOR := -m64 -O2
> +KBUILD_CFLAGS_DECOMPRESSOR := $(CLANG_FLAGS) -m64 -O2
>  KBUILD_CFLAGS_DECOMPRESSOR += -DDISABLE_BRANCH_PROFILING -D__NO_FORTIFY
>  KBUILD_CFLAGS_DECOMPRESSOR += -fno-delete-null-pointer-checks -msoft-float
>  KBUILD_CFLAGS_DECOMPRESSOR += -fno-asynchronous-unwind-tables

Thanks for the respin with Nathan's suggestion.

> +KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-disable-warning,pointer-sign)

What's up with this ^ ?  Seems like the top level sets it (without
cc-disable-warning :( ), but then KBUILD_CFLAGS_DECOMPRESSOR discards
it.  Does Clang actually flag code in this arch (that GCC doesn't)?

>  KBUILD_CFLAGS_DECOMPRESSOR += $(call cc-option,-ffreestanding)
>  KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO),-g)
>  KBUILD_CFLAGS_DECOMPRESSOR += $(if $(CONFIG_DEBUG_INFO_DWARF4), $(call cc-option, -gdwarf-4,))
> diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
> index ce6a3f75065b..ecd0b3847fef 100644
> --- a/arch/s390/purgatory/Makefile
> +++ b/arch/s390/purgatory/Makefile
> @@ -22,6 +22,7 @@ KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
>  KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
>  KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
>  KBUILD_CFLAGS += -c -MD -Os -m64 -msoft-float -fno-common
> +KBUILD_CFLAGS += $(CLANG_FLAGS)
>  KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
>  KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
>
> --
> 2.20.0
>


-- 
Thanks,
~Nick Desaulniers
