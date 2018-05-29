Return-Path: <linux-kbuild-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180528182735.18257-1-luc.vanoostenryck@gmail.com>
References: <20180528182735.18257-1-luc.vanoostenryck@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 29 May 2018 22:08:06 +0900
Message-ID: <CAK7LNASM461EHR-4VOMR8d-kx4v8RbZtr7cQ2YQ7X4JYTGenZg@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: add endianness flag to CHEKCFLAGS
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kbuild-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-kbuild/>
List-Post: <mailto:linux-kbuild@vger.kernel.org>
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, "James E . J . Bottomley" <jejb@parisc-linux.org>, Helge Deller <deller@gmx.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Marek <michal.lkml@markovi.net>, Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

2018-05-29 3:27 GMT+09:00 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>:
> The kernel depends on macros like __BYTE_ORDER__,
> __BIG_ENDIAN__ or __LITTLE_ENDIAN__.
>
> OTOH, sparse doesn't know about the endianness of the kernel and
> by default uses the same as the machine on which sparse was built.
>
> Ensure that sparse can predefine the macros corresponding to
> how the kernel was configured by adding -m{big,little}-endian
> to CHECKFLAGS in the main Makefile (and so for all archs).
> Also, remove the equivalent done in arch specific Makefiles.
>
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> ---


Applied to linux-kbuild. Thanks.


>  Makefile               | 3 +++
>  arch/openrisc/Makefile | 1 -
>  arch/parisc/Makefile   | 2 +-
>  arch/s390/Makefile     | 2 +-
>  4 files changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 56ba070df..6c6610913 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -878,6 +878,9 @@ ifeq ($(CONFIG_STRIP_ASM_SYMS),y)
>  LDFLAGS_vmlinux        += $(call ld-option, -X,)
>  endif
>
> +# insure the checker run with the right endianness
> +CHECKFLAGS += $(if $(CONFIG_CPU_BIG_ENDIAN),-mbig-endian,-mlittle-endian)
> +
>  # Default kernel image to build when no specific target is given.
>  # KBUILD_IMAGE may be overruled on the command line or
>  # set in the environment
> diff --git a/arch/openrisc/Makefile b/arch/openrisc/Makefile
> index cf8802962..89076a66e 100644
> --- a/arch/openrisc/Makefile
> +++ b/arch/openrisc/Makefile
> @@ -25,7 +25,6 @@ LDFLAGS_vmlinux :=
>  LIBGCC                 := $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
>
>  KBUILD_CFLAGS  += -pipe -ffixed-r10 -D__linux__
> -CHECKFLAGS     += -mbig-endian
>
>  ifeq ($(CONFIG_OPENRISC_HAVE_INST_MUL),y)
>         KBUILD_CFLAGS += $(call cc-option,-mhard-mul)
> diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
> index 34ac503e2..348ae4779 100644
> --- a/arch/parisc/Makefile
> +++ b/arch/parisc/Makefile
> @@ -22,7 +22,7 @@ KBUILD_IMAGE := vmlinuz
>  KBUILD_DEFCONFIG := default_defconfig
>
>  NM             = sh $(srctree)/arch/parisc/nm
> -CHECKFLAGS     += -D__hppa__=1 -mbig-endian
> +CHECKFLAGS     += -D__hppa__=1
>  LIBGCC         = $(shell $(CC) $(KBUILD_CFLAGS) -print-libgcc-file-name)
>  export LIBGCC
>
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index c79936d02..68a690442 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -18,7 +18,7 @@ KBUILD_CFLAGS += -m64
>  KBUILD_AFLAGS  += -m64
>  UTS_MACHINE    := s390x
>  STACK_SIZE     := 16384
> -CHECKFLAGS     += -D__s390__ -D__s390x__ -mbig-endian
> +CHECKFLAGS     += -D__s390__ -D__s390x__
>
>  export LD_BFD
>
> --
> 2.17.0
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kbuild" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards
Masahiro Yamada
