From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Fri, 30 Jun 2017 12:43:23 +0000
Subject: Re: [CRIU] [PATCH v2 02/17] s390:compel: Enable s390 in compel/
Message-Id: <CAJwJo6bgTengar4a_Mj-8yMMrQrFkdbCWx18=dFFgqva3s_1QA@mail.gmail.com>
In-Reply-To: <20170630143749.5cbdfbfe@TP-holzheu>
References: <20170630143749.5cbdfbfe@TP-holzheu>
To: linux-s390@vger.kernel.org, openvz-criu@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

2017-06-30 15:37 GMT+03:00 Michael Holzheu <holzheu@linux.vnet.ibm.com>:
> Am Fri, 30 Jun 2017 15:23:09 +0300
> schrieb Dmitry Safonov <0x7f454c46@gmail.com>:
>
>> 2017-06-29 22:24 GMT+03:00 Michael Holzheu <holzheu@linux.vnet.ibm.com>:
>> > Add s390 parts to common code files.
>> >
>> > Reviewed-by: Alice Frosi <alice@linux.vnet.ibm.com>
>> > Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>
>> > ---
>> >  compel/.gitignore           |  1 +
>> >  compel/Makefile             |  8 ++++++++
>> >  compel/plugins/Makefile     |  7 +++++++
>> >  compel/src/lib/handle-elf.c | 25 +++++++++++++++++++++++++
>> >  compel/src/main.c           |  3 +++
>> >  5 files changed, 44 insertions(+)
>> >
>> > diff --git a/compel/.gitignore b/compel/.gitignore
>> > index 5b68863..e959dc5 100644
>> > --- a/compel/.gitignore
>> > +++ b/compel/.gitignore
>> > @@ -1,6 +1,7 @@
>> >  arch/x86/plugins/std/sys-exec-tbl-64.c
>> >  arch/x86/plugins/std/syscalls-64.S
>> >  arch/arm/plugins/std/syscalls/syscalls.S
>> > +arch/s390/plugins/std/syscalls/syscalls.S
>> >  include/version.h
>> >  plugins/include/uapi/std/asm/syscall-types.h
>> >  plugins/include/uapi/std/syscall-64.h
>> > diff --git a/compel/Makefile b/compel/Makefile
>> > index 43d27f5..ebe006d 100644
>> > --- a/compel/Makefile
>> > +++ b/compel/Makefile
>> > @@ -34,6 +34,14 @@ CFLAGS                       += -DNO_RELOCS
>> >  HOSTCFLAGS             += -DNO_RELOCS
>> >  endif
>> >
>> > +# We assume that compel code does not change floating point registers.
>> > +# On s390 gcc uses fprs to cache gprs. Therefore disable floating point
>> > +# with -msoft-float.
>> > +ifeq ($(filter s390x,$(ARCH)),)
>> > +CFLAGS += -msoft-float
>> > +HOSTCFLAGS += -msoft-float
>> > +endif
>>
>> Could it be moved to top Makefile.compel,
>> so it wouldn't repeat two times?
>> Or there is a reason not to do it?
>
> I just did not understand your build process completely.
>
> Looks like it also works with the following patch:
> ---
> [PATCH] Consolidate msoft-float into Makefile.compel
>
> Suggested-by: Dmitry Safonov <dsafonov@virtuozzo.com>
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>

Thanks for both patches
Reviewed-by: Dmitry Safonov <dsafonov@virtuozzo.com>

> ---
>  Makefile.compel         | 8 ++++++++
>  compel/Makefile         | 8 --------
>  compel/plugins/Makefile | 7 -------
>  3 files changed, 8 insertions(+), 15 deletions(-)
>
> diff --git a/Makefile.compel b/Makefile.compel
> index 1ef7f8c..9b40079 100644
> --- a/Makefile.compel
> +++ b/Makefile.compel
> @@ -70,3 +70,11 @@ compel/$(LIBCOMPEL_SO): compel/$(LIBCOMPEL_A)
>  compel-install-targets += compel/$(LIBCOMPEL_SO)
>  compel-install-targets += compel/compel
>  compel-install-targets += $(compel-plugins)
> +
> +# We assume that compel code does not change floating point registers.
> +# On s390 gcc uses fprs to cache gprs. Therefore disable floating point
> +# with -msoft-float.
> +ifeq ($(ARCH),s390)
> +CFLAGS += -msoft-float
> +HOSTCFLAGS += -msoft-float
> +endif
> diff --git a/compel/Makefile b/compel/Makefile
> index 0bc2324..43d27f5 100644
> --- a/compel/Makefile
> +++ b/compel/Makefile
> @@ -34,14 +34,6 @@ CFLAGS                       += -DNO_RELOCS
>  HOSTCFLAGS             += -DNO_RELOCS
>  endif
>
> -# We assume that compel code does not change floating point registers.
> -# On s390 gcc uses fprs to cache gprs. Therefore disable floating point
> -# with -msoft-float.
> -ifeq ($(ARCH),s390)
> -CFLAGS += -msoft-float
> -HOSTCFLAGS += -msoft-float
> -endif
> -
>  obj-y                  += src/main.o
>  obj-y                  += arch/$(ARCH)/src/lib/handle-elf.o
>  obj-y                  += src/lib/handle-elf.o
> diff --git a/compel/plugins/Makefile b/compel/plugins/Makefile
> index 39251b0..7127425 100644
> --- a/compel/plugins/Makefile
> +++ b/compel/plugins/Makefile
> @@ -7,13 +7,6 @@ PLUGIN_ARCH_DIR                := compel/arch/$(ARCH)/plugins
>  #
>  # CFLAGS, ASFLAGS, LDFLAGS
>
> -# We assume that compel code does not change floating point registers.
> -# On s390 gcc uses fprs to cache gprs. Therefore disable floating point
> -# with -msoft-float.
> -ifeq ($(ARCH), s390)
> -CFLAGS += -msoft-float
> -endif
> -
>  #
>  # UAPI inclusion, referred as <compel/...>
>  ccflags-y              += -I compel/include/uapi
> --
> 1.9.1
>



-- 
             Dmitry
