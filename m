Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from merlin.infradead.org ([205.233.59.134]:40428 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfLJKQK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 10 Dec 2019 05:16:10 -0500
Date: Tue, 10 Dec 2019 11:15:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-2 tag
 (topic/kasan-bitops)
Message-ID: <20191210101545.GL2844@hirez.programming.kicks-ass.net>
References: <87blslei5o.fsf@mpe.ellerman.id.au>
 <20191206131650.GM2827@hirez.programming.kicks-ass.net>
 <87wob4pwnl.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wob4pwnl.fsf@mpe.ellerman.id.au>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, dja@axtens.net, elver@google.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, christophe.leroy@c-s.fr, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Tue, Dec 10, 2019 at 04:38:54PM +1100, Michael Ellerman wrote:

> Good question, I'll have a look.
> 
> There seems to be confusion about what the type of the bit number is,
> which is leading to sign extension in some cases and not others.

Shiny.

> It looks like the type should be unsigned long?

I'm thinking unsigned makes most sense, I mean, negative bit offsets
should 'work' but that's almost always guaranteed to be an out-of-bound
operation.

As to 'long' vs 'int', I'm not sure, 4G bits is a long bitmap. But I
suppose since the bitmap itself is 'unsigned long', we might as well use
'unsigned long' for the bitnr too.

>   Documentation/core-api/atomic_ops.rst:  void __clear_bit_unlock(unsigned long nr, unsigned long *addr);
>   arch/mips/include/asm/bitops.h:static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *addr)
>   arch/powerpc/include/asm/bitops.h:static inline void arch___clear_bit_unlock(int nr, volatile unsigned long *addr)
>   arch/riscv/include/asm/bitops.h:static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *addr)
>   arch/s390/include/asm/bitops.h:static inline void arch___clear_bit_unlock(unsigned long nr,
>   include/asm-generic/bitops/instrumented-lock.h:static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
>   include/asm-generic/bitops/lock.h:static inline void __clear_bit_unlock(unsigned int nr,
> 
> So I guess step one is to convert our versions to use unsigned long, so
> we're at least not tripping over that difference when comparing the
> assembly.

Yeah, I'll look at fixing the generic code, bitops/atomic.h and
bitops/non-atomic.h don't even agree on the type of bitnr.
