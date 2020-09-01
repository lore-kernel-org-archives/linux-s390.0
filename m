Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbgIALbA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 1 Sep 2020 07:31:00 -0400
MIME-Version: 1.0
References: <20200831182239.480317-1-masahiroy@kernel.org>
In-Reply-To: <20200831182239.480317-1-masahiroy@kernel.org>
From: Greentime Hu <green.hu@gmail.com>
Date: Tue, 1 Sep 2020 19:29:19 +0800
Message-ID: <CAEbi=3cqogHs=p_y=_jfcC+D5a9e5=Nic=ECr_YvJ9p-DZEAJQ@mail.gmail.com>
Subject: Re: [PATCH] arch: vdso: add vdso linker script to 'targets' instead
 of extra-y
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Catalin Marinas <catalin.marinas@arm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nick Hu <nickhu@andestech.com>, Paul Mackerras <paulus@samba.org>, Vasily Gorbik <gor@linux.ibm.com>, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

Masahiro Yamada <masahiroy@kernel.org> =E6=96=BC 2020=E5=B9=B49=E6=9C=881=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=882:23=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> The vdso linker script is preprocessed on demand.
> Adding it to 'targets' is enough to include the .cmd file.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/arm64/kernel/vdso/Makefile     | 2 +-
>  arch/arm64/kernel/vdso32/Makefile   | 2 +-
>  arch/nds32/kernel/vdso/Makefile     | 2 +-
>  arch/powerpc/kernel/vdso32/Makefile | 2 +-
>  arch/powerpc/kernel/vdso64/Makefile | 2 +-
>  arch/s390/kernel/vdso64/Makefile    | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Mak=
efile
> index 45d5cfe46429..7cd8aafbe96e 100644
> --- a/arch/arm64/kernel/vdso/Makefile
> +++ b/arch/arm64/kernel/vdso/Makefile
> @@ -54,7 +54,7 @@ endif
>  GCOV_PROFILE :=3D n
>
>  obj-y +=3D vdso.o
> -extra-y +=3D vdso.lds
> +targets +=3D vdso.lds
>  CPPFLAGS_vdso.lds +=3D -P -C -U$(ARCH)
>
>  # Force dependency (incbin is bad)
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32=
/Makefile
> index d6adb4677c25..572475b7b7ed 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -155,7 +155,7 @@ asm-obj-vdso :=3D $(addprefix $(obj)/, $(asm-obj-vdso=
))
>  obj-vdso :=3D $(c-obj-vdso) $(c-obj-vdso-gettimeofday) $(asm-obj-vdso)
>
>  obj-y +=3D vdso.o
> -extra-y +=3D vdso.lds
> +targets +=3D vdso.lds
>  CPPFLAGS_vdso.lds +=3D -P -C -U$(ARCH)
>
>  # Force dependency (vdso.s includes vdso.so through incbin)
> diff --git a/arch/nds32/kernel/vdso/Makefile b/arch/nds32/kernel/vdso/Mak=
efile
> index 7c3c1ccb196e..55df25ef0057 100644
> --- a/arch/nds32/kernel/vdso/Makefile
> +++ b/arch/nds32/kernel/vdso/Makefile
> @@ -20,7 +20,7 @@ GCOV_PROFILE :=3D n
>
>
>  obj-y +=3D vdso.o
> -extra-y +=3D vdso.lds
> +targets +=3D vdso.lds
>  CPPFLAGS_vdso.lds +=3D -P -C -U$(ARCH)
>
>  # Force dependency
> diff --git a/arch/powerpc/kernel/vdso32/Makefile b/arch/powerpc/kernel/vd=
so32/Makefile
> index 87ab1152d5ce..fd5072a4c73c 100644
> --- a/arch/powerpc/kernel/vdso32/Makefile
> +++ b/arch/powerpc/kernel/vdso32/Makefile
> @@ -29,7 +29,7 @@ ccflags-y :=3D -shared -fno-common -fno-builtin -nostdl=
ib \
>  asflags-y :=3D -D__VDSO32__ -s
>
>  obj-y +=3D vdso32_wrapper.o
> -extra-y +=3D vdso32.lds
> +targets +=3D vdso32.lds
>  CPPFLAGS_vdso32.lds +=3D -P -C -Upowerpc
>
>  # Force dependency (incbin is bad)
> diff --git a/arch/powerpc/kernel/vdso64/Makefile b/arch/powerpc/kernel/vd=
so64/Makefile
> index 38c317f25141..c737b3ea3207 100644
> --- a/arch/powerpc/kernel/vdso64/Makefile
> +++ b/arch/powerpc/kernel/vdso64/Makefile
> @@ -17,7 +17,7 @@ ccflags-y :=3D -shared -fno-common -fno-builtin -nostdl=
ib \
>  asflags-y :=3D -D__VDSO64__ -s
>
>  obj-y +=3D vdso64_wrapper.o
> -extra-y +=3D vdso64.lds
> +targets +=3D vdso64.lds
>  CPPFLAGS_vdso64.lds +=3D -P -C -U$(ARCH)
>
>  # Force dependency (incbin is bad)
> diff --git a/arch/s390/kernel/vdso64/Makefile b/arch/s390/kernel/vdso64/M=
akefile
> index 4a66a1cb919b..d0d406cfffa9 100644
> --- a/arch/s390/kernel/vdso64/Makefile
> +++ b/arch/s390/kernel/vdso64/Makefile
> @@ -25,7 +25,7 @@ $(targets:%=3D$(obj)/%.dbg): KBUILD_CFLAGS =3D $(KBUILD=
_CFLAGS_64)
>  $(targets:%=3D$(obj)/%.dbg): KBUILD_AFLAGS =3D $(KBUILD_AFLAGS_64)
>
>  obj-y +=3D vdso64_wrapper.o
> -extra-y +=3D vdso64.lds
> +targets +=3D vdso64.lds
>  CPPFLAGS_vdso64.lds +=3D -P -C -U$(ARCH)
>
>  # Disable gcov profiling, ubsan and kasan for VDSO code

For nds32:

Acked-by: Greentime Hu <green.hu@gmail.com>
