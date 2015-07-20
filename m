Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 20 Jul 2015 15:03:55 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH] sched, arm64: Fix the fallout of increasing the offset
 of 'thread_struct' within 'task_struct'
Message-ID: <20150720140355.GM20385@e104818-lin.cambridge.arm.com>
References: <20150718232717.GA3235@groeck-UX31A>
 <20150718233455.GA3273@groeck-UX31A>
 <20150720072043.GA7696@gmail.com>
 <55ACFD1C.8090907@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55ACFD1C.8090907@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Ingo Molnar <mingo@kernel.org>, linux-s390@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, Olof Johansson <olof@lixom.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jul 20, 2015 at 06:52:28AM -0700, Guenter Roeck wrote:
> On 07/20/2015 12:20 AM, Ingo Molnar wrote:
> >* Guenter <linux@roeck-us.net> wrote:
> >>On Sat, Jul 18, 2015 at 04:27:17PM -0700, Guenter wrote:
> >>>Commit 0c8c0f03e3a2 ("x86/fpu, sched: Dynamically allocate 'struct fpu'")
> >>>causes s390 builds in mainline to fail as follows.
> >>>
> >>>arch/s390/kernel/traps.c: Assembler messages:
> >>>arch/s390/kernel/traps.c:262: Error: operand out of range
> >>>	(0x00000000000023e8 is not between 0x0000000000000000 and 0x0000000000000fff)
> >>>arch/s390/kernel/traps.c:300: Error: operand out of range
> >>>	(0x00000000000023e8 is not between 0x0000000000000000 and 0x0000000000000fff)
> >>>
> >>
> >>Also:
> >>
> >>arm64:allmodconfig:
> >>
> >>arch/arm64/kernel/entry.S: Assembler messages:
> >>arch/arm64/kernel/entry.S:588: Error: immediate out of range
> >>arch/arm64/kernel/entry.S:597: Error: immediate out of range
> >>make[1]: *** [arch/arm64/kernel/entry.o] Error 1
> >>
> >>I didn't bisect that one, but it looks like the cause is the same.
> >
> >Hm, it looks like the new, increased offset of 'thread_struct' within
> >'task_struct' goes over a limit that these instructions are able to support on
> >arm64:
> >
> >  arch/arm64/kernel/asm-offsets.c:  DEFINE(THREAD_CPU_CONTEXT,    offsetof(struct task_struct, thread.cpu_context));
> >  arch/arm64/kernel/entry.S:      add     x8, x0, #THREAD_CPU_CONTEXT
> >  arch/arm64/kernel/entry.S:      add     x8, x1, #THREAD_CPU_CONTEXT
> >
> >If there's no instruction that can support such offset sizes then I suspect the
> >straightforward fix would be to pass in thread_struct instead - like the patch
> >below. That's a tiny bit cleaner for type encapsulation anyway.
> 
> Olof submitted a different patch to solve the problem:
> 	http://www.spinics.net/lists/kernel/msg2036825.html
> 
> His patch is passing cpu_context instead of thread_context.

It's likely that we'll use this patch instead:

http://lkml.kernel.org/g/20150720105345.GC9908@arm.com

-- 
Catalin
