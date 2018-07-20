Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 20 Jul 2018 10:30:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 4/7] x86,tlb: make lazy TLB mode lazier
Message-ID: <20180720083016.GN2494@hirez.programming.kicks-ass.net>
References: <20180716190337.26133-1-riel@surriel.com>
 <20180716190337.26133-5-riel@surriel.com>
 <CALCETrUMntRe_LYX5wj9YD4xZ+84QExK+ZNb3yxEBDEKa7nePQ@mail.gmail.com>
 <B6566AA4-2E8A-43BD-A224-0F6D4747B8FB@surriel.com>
 <F93A3335-4830-4E36-9179-D0FA5D640C8A@amacapital.net>
 <B976CC13-D014-433A-83DE-F8DF9AB4F421@surriel.com>
 <CALCETrWDiMhgiR3f8n0jdWcW31EDJ+Waq0wh5sMDutfigANGnA@mail.gmail.com>
 <CALCETrXLMsSBChDvrms-omwYV4LHT30GenDjbnD-+LTg55yPow@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrXLMsSBChDvrms-omwYV4LHT30GenDjbnD-+LTg55yPow@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20180720083016.BpDTcdsnbuRyUOtxNreYw3eRpK6Xg58BNui43io8Xeg@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andy Lutomirski <luto@kernel.org>
Cc: Rik van Riel <riel@surriel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, Juergen Gross <jgross@suse.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, linux-arch <linux-arch@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, linux-s390@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, Mike Galbraith <efault@gmx.de>, kernel-team <kernel-team@fb.com>, Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@intel.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jul 19, 2018 at 10:04:09AM -0700, Andy Lutomirski wrote:
> I added some more arch maintainers.  The idea here is that, on x86 at
> least, task->active_mm and all its refcounting is pure overhead.  When
> a process exits, __mmput() gets called, but the core kernel has a
> longstanding "optimization" in which other tasks (kernel threads and
> idle tasks) may have ->active_mm pointing at this mm.  This is nasty,
> complicated, and hurts performance on large systems, since it requires
> extra atomic operations whenever a CPU switches between real users
> threads and idle/kernel threads.
> 
> It's also almost completely worthless on x86 at least, since __mmput()
> frees pagetables, and that operation *already* forces a remote TLB
> flush, so we might as well zap all the active_mm references at the
> same time.

So I disagree that active_mm is complicated (the code is less than ideal
but that is actually fixable). And aside from the process exit case, it
does avoid CR3 writes when switching between user and kernel threads
(which can be far more often than exit if you have longer running
tasks).

Now agreed, recent x86 work has made that less important.

And I of course also agree that not doing those refcount atomics is
better.
