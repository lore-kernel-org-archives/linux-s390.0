Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1518106752-29228-6-git-send-email-yamada.masahiro@socionext.com>
References: <1518106752-29228-1-git-send-email-yamada.masahiro@socionext.com> <1518106752-29228-6-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 9 Feb 2018 02:19:54 +0900
Message-ID: <CAK7LNARSd6QOcr05z-V9UGCspib=yMDSjdBLXB5h1CGXCmwKjw@mail.gmail.com>
Subject: Re: [RFC PATCH 5/7] kconfig: invoke silentoldconfig when compiler is updated
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Nicolas Pitre <nicolas.pitre@linaro.org>, "Luis R . Rodriguez" <mcgrof@suse.com>, Randy Dunlap <rdunlap@infradead.org>, Ulf Magnusson <ulfalizer@gmail.com>, Sam Ravnborg <sam@ravnborg.org>, Michal Marek <michal.lkml@markovi.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Pavel Machek <pavel@ucw.cz>, linux-s390 <linux-s390@vger.kernel.org>, Jiri Kosina <jkosina@suse.cz>, Masahiro Yamada <yamada.masahiro@socionext.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

2018-02-09 1:19 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> Moving compiler option tests to Kconfig means you need to re-run
> Kconfig when you update your compiler.  All CC_HAS_... symbols
> and other symbols that depend on them must be re-calculated.
>
> It will be nice to detect the compiler update and automatically
> invoke silentoldconfig.
>
> This can be done by adding one environment.  With this, silentoldconfig
> will add something like follows into include/config/auto.conf.cmd:
>
> ifneq "$(CC_VERSION_TEXT)" "gcc (Ubuntu 5.4.0-6ubuntu1~16.04.6) 5.4.0 20160609"
> include/config/auto.conf: FORCE
> endif
>
> CC_VERSION_TEXT contains the first line of "$(CC) --version".  If this text
> is changed, silentoldconfig will be invoked.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>


Currently, the updated compiler
is detected only when building the kernel.


External modules should be built by the
same compiler as used for building the kernel.

If a different compiler is used,
different options will be specified by
CONFIG_CC_HAS_... options from the .config


Should this be checked?
Or, is it just "Don't do it" thing?


If desired, CONFIG_CC_VERSION_TEXT is cached in .config
then it will be possible to compare it with $(shell $(CC) --version)
when building external modules.



>
>  Makefile     | 2 ++
>  init/Kconfig | 9 +++++++++
>  2 files changed, 11 insertions(+)
>
> diff --git a/Makefile b/Makefile
> index 2ee49c9..9afd617 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -441,6 +441,8 @@ export KBUILD_AFLAGS_MODULE KBUILD_CFLAGS_MODULE KBUILD_LDFLAGS_MODULE
>  export KBUILD_AFLAGS_KERNEL KBUILD_CFLAGS_KERNEL
>  export KBUILD_ARFLAGS
>
> +export CC_VERSION_TEXT := $(shell $(CC) --version | head -n 1)
> +
>  # When compiling out-of-tree modules, put MODVERDIR in the module
>  # tree rather than in the kernel tree. The kernel tree might
>  # even be read-only.
> diff --git a/init/Kconfig b/init/Kconfig
> index e37f4b2..64f9dd2 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -16,6 +16,15 @@ config DEFCONFIG_LIST
>         default "$ARCH_DEFCONFIG"
>         default "arch/$ARCH/defconfig"
>
> +# CC_VERSION_TEXT is needed here to invoke Kconfig when compiler is updated
> +config CC_VERSION_TEXT
> +       string
> +       option env="CC_VERSION_TEXT"
> +       help
> +         This is used to detect if the compiler is changed. If the version
> +         text does not match, silentoldconfig will be invoked because we need
> +         to re-compute compiler capabilities and symbols that depends on them.
> +
>  config CONSTRUCTORS
>         bool
>         depends on !UML
> --
> 2.7.4
>



-- 
Best Regards
Masahiro Yamada
