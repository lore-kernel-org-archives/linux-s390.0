Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgKDKWi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Nov 2020 05:22:38 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH seccomp 3/8] powerpc: Enable seccomp architecture tracking
In-Reply-To: <4ec2970fcc819eb4d5dac2bd35233ccdadfda845.1604410035.git.yifeifz2@illinois.edu>
References: <cover.1604410035.git.yifeifz2@illinois.edu> <4ec2970fcc819eb4d5dac2bd35233ccdadfda845.1604410035.git.yifeifz2@illinois.edu>
Date: Wed, 04 Nov 2020 21:22:28 +1100
Message-ID: <87wnz1to9n.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-s390.vger.kernel.org>
To: YiFei Zhu <zhuyifei1999@gmail.com>, containers@lists.linux-foundation.org
Cc: linux-sh@vger.kernel.org, Tobin Feldman-Fitzthum <tobin@ibm.com>, Hubertus Franke <frankeh@us.ibm.com>, Jack Chen <jianyan2@illinois.edu>, linux-riscv@lists.infradead.org, Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org, YiFei Zhu <yifeifz2@illinois.edu>, linux-csky@vger.kernel.org, Tianyin Xu <tyxu@illinois.edu>, linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>, Valentin Rothberg <vrothber@redhat.com>, Aleksa Sarai <cyphar@cyphar.com>, Josep Torrellas <torrella@illinois.edu>, Will Drewry <wad@chromium.org>, linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>, Dimitrios Skarlatos <dskarlat@cs.cmu.edu>, David Laight <David.Laight@aculab.com>, Giuseppe Scrivano <gscrivan@redhat.com>, linuxppc-dev@lists.ozlabs.org, Tycho Andersen <tycho@tycho.pizza>

YiFei Zhu <zhuyifei1999@gmail.com> writes:
> From: YiFei Zhu <yifeifz2@illinois.edu>
>
> To enable seccomp constant action bitmaps, we need to have a static
> mapping to the audit architecture and system call table size. Add these
> for powerpc.
>
> Signed-off-by: YiFei Zhu <yifeifz2@illinois.edu>
> ---
>  arch/powerpc/include/asm/seccomp.h | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/powerpc/include/asm/seccomp.h b/arch/powerpc/include/asm/seccomp.h
> index 51209f6071c5..3efcc83e9cc6 100644
> --- a/arch/powerpc/include/asm/seccomp.h
> +++ b/arch/powerpc/include/asm/seccomp.h
> @@ -8,4 +8,25 @@
>  
>  #include <asm-generic/seccomp.h>
>  
> +#ifdef __LITTLE_ENDIAN__

As Kees mentioned this should (must?!) match the configured endian.

But I think it would still be better to use the CONFIG symbol, which is
CONFIG_CPU_LITTLE_ENDIAN.

> +#define __SECCOMP_ARCH_LE_BIT		__AUDIT_ARCH_LE
> +#else
> +#define __SECCOMP_ARCH_LE_BIT		0
> +#endif
> +
> +#ifdef CONFIG_PPC64
> +# define SECCOMP_ARCH_NATIVE		(AUDIT_ARCH_PPC64 | __SECCOMP_ARCH_LE)

You use __SECCOMP_ARCH_LE there, but previously you only defined
__SECCOMP_ARCH_LE_BIT.

Is there some magic somewhere that defines __SECCOMP_ARCH_LE based on
__SECCOMP_ARCH_LE_BIT ?

> +# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
> +# define SECCOMP_ARCH_NATIVE_NAME	"ppc64"

What's the name used for?

Usually we use "ppc64" for 64-bit big endian and "ppc64le" for 64-bit
little endian.

> +# ifdef CONFIG_COMPAT
> +#  define SECCOMP_ARCH_COMPAT		(AUDIT_ARCH_PPC | __SECCOMP_ARCH_LE)
> +#  define SECCOMP_ARCH_COMPAT_NR	NR_syscalls
> +#  define SECCOMP_ARCH_COMPAT_NAME	"powerpc"

And usually we use "ppc" for 32-bit.

> +# endif
> +#else /* !CONFIG_PPC64 */
> +# define SECCOMP_ARCH_NATIVE		(AUDIT_ARCH_PPC | __SECCOMP_ARCH_LE)
> +# define SECCOMP_ARCH_NATIVE_NR		NR_syscalls
> +# define SECCOMP_ARCH_NATIVE_NAME	"powerpc"
> +#endif
> +
>  #endif	/* _ASM_POWERPC_SECCOMP_H */
> -- 
> 2.29.2


cheers
