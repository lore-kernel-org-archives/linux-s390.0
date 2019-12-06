Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 6 Dec 2019 14:16:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.5-2 tag
 (topic/kasan-bitops)
Message-ID: <20191206131650.GM2827@hirez.programming.kicks-ass.net>
References: <87blslei5o.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blslei5o.fsf@mpe.ellerman.id.au>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, dja@axtens.net, elver@google.com, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, christophe.leroy@c-s.fr, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, x86@kernel.org, kasan-dev@googlegroups.com, Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>

On Fri, Dec 06, 2019 at 11:46:11PM +1100, Michael Ellerman wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
> 
> Hi Linus,
> 
> Please pull another powerpc update for 5.5.
> 
> As you'll see from the diffstat this is mostly not powerpc code. In order to do
> KASAN instrumentation of bitops we needed to juggle some of the generic bitops
> headers.
> 
> Because those changes potentially affect several architectures I wasn't
> confident putting them directly into my tree, so I've had them sitting in a
> topic branch. That branch (topic/kasan-bitops) has been in linux-next for a
> month, and I've not had any feedback that it's caused any problems.
> 
> So I think this is good to merge, but it's a standalone pull so if anyone does
> object it's not a problem.

No objections, but here:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=topic/kasan-bitops&id=81d2c6f81996e01fbcd2b5aeefbb519e21c806e9

you write:

  "Currently bitops-instrumented.h assumes that the architecture provides
atomic, non-atomic and locking bitops (e.g. both set_bit and __set_bit).
This is true on x86 and s390, but is not always true: there is a
generic bitops/non-atomic.h header that provides generic non-atomic
operations, and also a generic bitops/lock.h for locking operations."

Is there any actual benefit for PPC to using their own atomic bitops
over bitops/lock.h ? I'm thinking that the generic code is fairly
optimal for most LL/SC architectures.

I've been meaning to audit the various architectures and move them over,
but alas, it's something I've not yet had time for...
