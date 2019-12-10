Return-Path: <linux-arch-owner@vger.kernel.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops)
In-Reply-To: <20191206131650.GM2827@hirez.programming.kicks-ass.net>
References: <87blslei5o.fsf@mpe.ellerman.id.au> <20191206131650.GM2827@hirez.programming.kicks-ass.net>
Date: Tue, 10 Dec 2019 16:38:54 +1100
Message-ID: <87wob4pwnl.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, dja@axtens.net, elver@google.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, christophe.leroy@c-s.fr, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>

Peter Zijlstra <peterz@infradead.org> writes:
> On Fri, Dec 06, 2019 at 11:46:11PM +1100, Michael Ellerman wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA256
>> 
>> Hi Linus,
>> 
>> Please pull another powerpc update for 5.5.
>> 
>> As you'll see from the diffstat this is mostly not powerpc code. In order to do
>> KASAN instrumentation of bitops we needed to juggle some of the generic bitops
>> headers.
>> 
>> Because those changes potentially affect several architectures I wasn't
>> confident putting them directly into my tree, so I've had them sitting in a
>> topic branch. That branch (topic/kasan-bitops) has been in linux-next for a
>> month, and I've not had any feedback that it's caused any problems.
>> 
>> So I think this is good to merge, but it's a standalone pull so if anyone does
>> object it's not a problem.
>
> No objections, but here:
>
>   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=topic/kasan-bitops&id=81d2c6f81996e01fbcd2b5aeefbb519e21c806e9
>
> you write:
>
>   "Currently bitops-instrumented.h assumes that the architecture provides
> atomic, non-atomic and locking bitops (e.g. both set_bit and __set_bit).
> This is true on x86 and s390, but is not always true: there is a
> generic bitops/non-atomic.h header that provides generic non-atomic
> operations, and also a generic bitops/lock.h for locking operations."
>
> Is there any actual benefit for PPC to using their own atomic bitops
> over bitops/lock.h ? I'm thinking that the generic code is fairly
> optimal for most LL/SC architectures.

Good question, I'll have a look.

There seems to be confusion about what the type of the bit number is,
which is leading to sign extension in some cases and not others.

eg, comparing the generic clear_bit_unlock() vs ours:

 1 c000000000031890 <generic_clear_bit_unlock>:             1 c0000000000319a0 <ppc_clear_bit_unlock>:
                                                            2         extsw   r3,r3
                                                            3         li      r10,1
                                                            4         srawi   r9,r3,6
                                                            5         addze   r9,r9
                                                            6         rlwinm  r8,r9,6,0,25
                                                            7         extsw   r9,r9
                                                            8         subf    r3,r8,r3
 2         rlwinm  r9,r3,29,3,28                            9         rldicr  r9,r9,3,60
                                                           10         sld     r3,r10,r3
 3         add     r4,r4,r9                                11         add     r4,r4,r9
 4         lwsync                                          12         lwsync
 5         li      r9,-2
 6         clrlwi  r3,r3,26
 7         rotld   r3,r9,r3
 8         ldarx   r9,0,r4                                 13         ldarx   r9,0,r4
 9         and     r10,r3,r9                               14         andc    r9,r9,r3
10         stdcx.  r10,0,r4                                15         stdcx.  r9,0,r4
11         bne-    <generic_clear_bit_unlock+0x18>         16         bne-    <ppc_clear_bit_unlock+0x2c>
12         blr                                             17         blr

It looks like in actual usage it often doesn't matter, ie. when we pass
a constant bit number it all gets inlined and the compiler works it out.

It looks like the type should be unsigned long?

  Documentation/core-api/atomic_ops.rst:  void __clear_bit_unlock(unsigned long nr, unsigned long *addr);
  arch/mips/include/asm/bitops.h:static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *addr)
  arch/powerpc/include/asm/bitops.h:static inline void arch___clear_bit_unlock(int nr, volatile unsigned long *addr)
  arch/riscv/include/asm/bitops.h:static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *addr)
  arch/s390/include/asm/bitops.h:static inline void arch___clear_bit_unlock(unsigned long nr,
  include/asm-generic/bitops/instrumented-lock.h:static inline void __clear_bit_unlock(long nr, volatile unsigned long *addr)
  include/asm-generic/bitops/lock.h:static inline void __clear_bit_unlock(unsigned int nr,

So I guess step one is to convert our versions to use unsigned long, so
we're at least not tripping over that difference when comparing the
assembly.

cheers
