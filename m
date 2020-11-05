Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:56837 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725468AbgKENO6 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 5 Nov 2020 08:14:58 -0500
Subject: Re: [PATCH seccomp 2/8] parisc: Enable seccomp architecture tracking
References: <cover.1604410035.git.yifeifz2@illinois.edu>
 <9bb86c546eda753adf5270425e7353202dbce87c.1604410035.git.yifeifz2@illinois.edu>
From: Helge Deller <deller@gmx.de>
Message-ID: <8d86100a-a3d6-d3bd-856c-38d17f363864@gmx.de>
Date: Thu, 5 Nov 2020 14:14:15 +0100
MIME-Version: 1.0
In-Reply-To: <9bb86c546eda753adf5270425e7353202dbce87c.1604410035.git.yifeifz2@illinois.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
List-ID: <linux-s390.vger.kernel.org>
To: YiFei Zhu <zhuyifei1999@gmail.com>, containers@lists.linux-foundation.org
Cc: YiFei Zhu <yifeifz2@illinois.edu>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>, Andrea Arcangeli <aarcange@redhat.com>, Andy Lutomirski <luto@amacapital.net>, David Laight <David.Laight@aculab.com>, Dimitrios Skarlatos <dskarlat@cs.cmu.edu>, Giuseppe Scrivano <gscrivan@redhat.com>, Hubertus Franke <frankeh@us.ibm.com>, Jack Chen <jianyan2@illinois.edu>, Jann Horn <jannh@google.com>, Josep Torrellas <torrella@illinois.edu>, Kees Cook <keescook@chromium.org>, Tianyin Xu <tyxu@illinois.edu>, Tobin Feldman-Fitzthum <tobin@ibm.com>, Tycho Andersen <tycho@tycho.pizza>, Valentin Rothberg <vrothber@redhat.com>, Will Drewry <wad@chromium.org>

On 11/3/20 2:42 PM, YiFei Zhu wrote:
> From: YiFei Zhu <yifeifz2@illinois.edu>
>
> To enable seccomp constant action bitmaps, we need to have a static
> mapping to the audit architecture and system call table size. Add these
> for parisc.
> > Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>

I did compile- and boot-tested it, works on 32- and 64-bit parisc kernel.
I don't know how to test it actually, but anyway:

Acked-by: Helge Deller <deller@gmx.de>

Thanks!
Helge

> ---
>  arch/parisc/include/asm/Kbuild    |  1 -
>  arch/parisc/include/asm/seccomp.h | 22 ++++++++++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>  create mode 100644 arch/parisc/include/asm/seccomp.h
>
> diff --git a/arch/parisc/include/asm/Kbuild b/arch/parisc/include/asm/Kb=
uild
> index e3ee5c0bfe80..f16c4db80116 100644
> --- a/arch/parisc/include/asm/Kbuild
> +++ b/arch/parisc/include/asm/Kbuild
> @@ -5,5 +5,4 @@ generated-y +=3D syscall_table_c32.h
>  generic-y +=3D kvm_para.h
>  generic-y +=3D local64.h
>  generic-y +=3D mcs_spinlock.h
> -generic-y +=3D seccomp.h
>  generic-y +=3D user.h
> diff --git a/arch/parisc/include/asm/seccomp.h b/arch/parisc/include/asm=
/seccomp.h
> new file mode 100644
> index 000000000000..b058b2220322
> --- /dev/null
> +++ b/arch/parisc/include/asm/seccomp.h
> @@ -0,0 +1,22 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +#ifndef _ASM_SECCOMP_H
> +#define _ASM_SECCOMP_H
> +
> +#include <asm-generic/seccomp.h>
> +
> +#ifdef CONFIG_64BIT
> +# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_PARISC64
> +# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
> +# define SECCOMP_ARCH_NATIVE_NAME	"parisc64"
> +# ifdef CONFIG_COMPAT
> +#  define SECCOMP_ARCH_COMPAT		AUDIT_ARCH_PARISC
> +#  define SECCOMP_ARCH_COMPAT_NR	NR_syscalls
> +#  define SECCOMP_ARCH_COMPAT_NAME	"parisc"
> +# endif
> +#else /* !CONFIG_64BIT */
> +# define SECCOMP_ARCH_NATIVE		AUDIT_ARCH_PARISC
> +# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
> +# define SECCOMP_ARCH_NATIVE_NAME	"parisc"
> +#endif
> +
> +#endif /* _ASM_SECCOMP_H */
>
