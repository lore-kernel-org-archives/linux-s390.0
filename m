Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 11 Apr 2019 08:23:49 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 1/2] s390: only build for new CPUs with clang
References: <20190410201300.3528984-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410201300.3528984-1-arnd@arndb.de>
Message-Id: <20190411062349.GB4126@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, clang-built-linux@googlegroups.com, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>, linux-s390@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Philipp Rudo <prudo@linux.vnet.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 10, 2019 at 10:12:40PM +0200, Arnd Bergmann wrote:
> llvm does does not understand -march=z9-109 and older target
> specifiers, so disable the respective Kconfig settings and
> the logic to make the boot code work on old systems when
> building with clang.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/s390/Kconfig       | 6 ++++++
>  arch/s390/boot/Makefile | 2 ++
>  2 files changed, 8 insertions(+)
...
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
> @@ -25,6 +26,7 @@ CFLAGS_als.o			+= -march=z900
>  CFLAGS_REMOVE_sclp_early_core.o	+= $(CC_FLAGS_MARCH)
>  CFLAGS_sclp_early_core.o	+= -march=z900
>  endif
> +endif

This contradicts the whole purpose of als.c - printing an error
message to the console if the kernel is compiled for a newer
architecture than it is running on (and therefore uses instructions
unknown to the current system).
If this can't be fixed/changed in clang, then it should be at least
changed to the lowest possible architecture.
