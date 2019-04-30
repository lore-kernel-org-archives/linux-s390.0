Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
MIME-Version: 1.0
References: <20190423210058.249510-1-ndesaulniers@google.com>
In-Reply-To: <20190423210058.249510-1-ndesaulniers@google.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Tue, 30 Apr 2019 13:25:09 -0700
Message-ID: <CAKwvOd=aR_GsJkaMTtV83UAAyqkZGuToD+3Zbq5sv=U_bogXmg@mail.gmail.com>
Subject: Re: [PATCH] s390: vdso: drop unnecessary cc-ldoption
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: clang-built-linux <clang-built-linux@googlegroups.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Vasily Gorbik <gor@linux.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 23, 2019 at 2:01 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Towards the goal of removing cc-ldoption, it seems that --hash-style=
> was added to binutils 2.17.50.0.2 in 2006. The minimal required version
> of binutils for the kernel according to
> Documentation/process/changes.rst is 2.20.
>
> Link: https://gcc.gnu.org/ml/gcc/2007-01/msg01141.html
> Cc: clang-built-linux@googlegroups.com
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/s390/kernel/vdso32/Makefile | 2 +-
>  arch/s390/kernel/vdso64/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/s390/kernel/vdso32/Makefile b/arch/s390/kernel/vdso32/Makefile
> index e76309fbbcb3..aee9ffbccb54 100644
> --- a/arch/s390/kernel/vdso32/Makefile
> +++ b/arch/s390/kernel/vdso32/Makefile
> @@ -19,7 +19,7 @@ KBUILD_AFLAGS_31 += -m31 -s
>  KBUILD_CFLAGS_31 := $(filter-out -m64,$(KBUILD_CFLAGS))
>  KBUILD_CFLAGS_31 += -m31 -fPIC -shared -fno-common -fno-builtin
>  KBUILD_CFLAGS_31 += -nostdlib -Wl,-soname=linux-vdso32.so.1 \
> -                       $(call cc-ldoption, -Wl$(comma)--hash-style=both)
> +                   -Wl,--hash-style=both
>
>  $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_31)
>  $(targets:%=$(obj)/%.dbg): KBUILD_AFLAGS = $(KBUILD_AFLAGS_31)
> diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/Makefile
> index f849ac61c5da..bec19e7e6e1c 100644
> --- a/arch/s390/kernel/vdso64/Makefile
> +++ b/arch/s390/kernel/vdso64/Makefile
> @@ -19,7 +19,7 @@ KBUILD_AFLAGS_64 += -m64 -s
>  KBUILD_CFLAGS_64 := $(filter-out -m64,$(KBUILD_CFLAGS))
>  KBUILD_CFLAGS_64 += -m64 -fPIC -shared -fno-common -fno-builtin
>  KBUILD_CFLAGS_64 += -nostdlib -Wl,-soname=linux-vdso64.so.1 \
> -                       $(call cc-ldoption, -Wl$(comma)--hash-style=both)
> +                   -Wl,--hash-style=both
>
>  $(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_64)
>  $(targets:%=$(obj)/%.dbg): KBUILD_AFLAGS = $(KBUILD_AFLAGS_64)
> --
> 2.21.0.593.g511ec345e18-goog
>

bumping for review
-- 
Thanks,
~Nick Desaulniers
