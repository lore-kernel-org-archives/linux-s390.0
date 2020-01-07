Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bilbo.ozlabs.org ([203.11.71.1]:38625 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727250AbgAGCFc (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 6 Jan 2020 21:05:32 -0500
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 02/22] compat: provide compat_ptr() on all architectures
In-Reply-To: <20200102145552.1853992-3-arnd@arndb.de>
References: <20200102145552.1853992-1-arnd@arndb.de> <20200102145552.1853992-3-arnd@arndb.de>
Date: Tue, 07 Jan 2020 13:05:22 +1100
Message-ID: <87woa410nx.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Arnd Bergmann <arnd@arndb.de>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paulburton@kernel.org>, James Hogan <jhogan@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Robert Richter <rric@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, oprofile-list@lists.sf.net, linux-s390@vger.kernel.org, sparclinux@vger.kernel.org

Arnd Bergmann <arnd@arndb.de> writes:
> In order to avoid needless #ifdef CONFIG_COMPAT checks,
> move the compat_ptr() definition to linux/compat.h
> where it can be seen by any file regardless of the
> architecture.
>
> Only s390 needs a special definition, this can use the
> self-#define trick we have elsewhere.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm64/include/asm/compat.h   | 17 -----------------
>  arch/mips/include/asm/compat.h    | 18 ------------------
>  arch/parisc/include/asm/compat.h  | 17 -----------------
>  arch/powerpc/include/asm/compat.h | 17 -----------------
>  arch/powerpc/oprofile/backtrace.c |  2 +-

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

One minor comment:

> diff --git a/include/linux/compat.h b/include/linux/compat.h
> index 68f79d855c3d..11083d84eb23 100644
> --- a/include/linux/compat.h
> +++ b/include/linux/compat.h
> @@ -958,4 +958,22 @@ static inline bool in_compat_syscall(void) { return false; }
>  
>  #endif /* CONFIG_COMPAT */
>  
> +/*
> + * A pointer passed in from user mode. This should not
> + * be used for syscall parameters, just declare them
> + * as pointers because the syscall entry code will have
> + * appropriately converted them already.
> + */
> +#ifndef compat_ptr
> +static inline void __user *compat_ptr(compat_uptr_t uptr)
> +{
> +	return (void __user *)(unsigned long)uptr;
> +}
> +#endif
> +
> +static inline compat_uptr_t ptr_to_compat(void __user *uptr)
> +{
> +	return (u32)(unsigned long)uptr;
> +}

Is there a reason we cast to u32 directly instead of using compat_uptr_t?

cheers
