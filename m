Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 1 Apr 2014 08:52:18 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [GIT PULL] s390 patches for the 3.15 merge window
Message-ID: <20140401085218.72f67e51@mschwide>
In-Reply-To: <CA+55aFzPP6kBzWrcvps6NVu=f-FUtrfs1U6DyRpdwX6hH6PM-Q@mail.gmail.com>
References: <20140331092400.17071766@mschwide>
	<CA+55aFzPP6kBzWrcvps6NVu=f-FUtrfs1U6DyRpdwX6hH6PM-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 31 Mar 2014 14:45:32 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, Mar 31, 2014 at 12:24 AM, Martin Schwidefsky
> <schwidefsky@de.ibm.com> wrote:
> >
> > There are two memory management related changes, the CMMA support for
> > KVM to avoid swap-in of freed pages and the split page table lock for
> > the PMD level. These two come with common code changes in mm/.
> 
> Ugh. I pulled it, but things like this makes me want to dig my eyes
> out with a spoon:
> 
>   +#ifdef finish_arch_post_lock_switch
>   +        finish_arch_post_lock_switch();
>   +#endif
> 
> when I think the proper thing to do would have been to move the
> #ifndef that creates an empty finish_arch_post_lock_switch() from
> kernel/sched/sched.h to some common file, or possibly even just
> duplicate it.
> 
> I detest #ifdef's in the middle of code. Yes, we do have them, but we
> should try to avoid adding more of them.
> 
> Maybe we could have a <linux/mmu_context.h> that includes the
> <asm/mmu_context.h> and then does that "let's add the dummy function
> for architectures that don't need it"?
> 
> Added Ingo to the cc, since this ends up intersecting with the
> scheduler code that now does the wrapper on its own.

Yes, I feel the pain. I actually tried to move the finish_arch_post_lock_switch
to linux/mmu_context.h but it turned out that this does not work. It broke
the corgi_defconfig, this is what I got from the friendly kbuild test robot:

-- snip

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git features
head:   05bb2956f28ff01a102bf16702ba7bcb116ecf72
commit: 8f6d84ba48d8d4377c61477803c8ff2cd4b007b7 [10/14] sched/mm: call finish_arch_post_lock_switch in idle_task_exit and use_mm
config: make ARCH=arm corgi_defconfig

All error/warnings:

   In file included from include/linux/mmu_context.h:5:0,
                    from drivers/usb/gadget/inode.c:27:
   arch/arm/include/asm/mmu_context.h: In function 'finish_arch_post_lock_switch':
>> arch/arm/include/asm/mmu_context.h:82:3: error: implicit declaration of function 'preempt_enable_no_resched' [-Werror=implicit-function-declaration]  
   cc1: some warnings being treated as errors

vim +/preempt_enable_no_resched +82 arch/arm/include/asm/mmu_context.h

bdae73cd arch/arm/include/asm/mmu_context.h Catalin Marinas 2013-07-23  76  		 */
bdae73cd arch/arm/include/asm/mmu_context.h Catalin Marinas 2013-07-23  77  		preempt_disable();
bdae73cd arch/arm/include/asm/mmu_context.h Catalin Marinas 2013-07-23  78  		if (mm->context.switch_pending) {
bdae73cd arch/arm/include/asm/mmu_context.h Catalin Marinas 2013-07-23  79  			mm->context.switch_pending = 0;
bdae73cd arch/arm/include/asm/mmu_context.h Catalin Marinas 2013-07-23  80  			cpu_switch_mm(mm->pgd, mm);
bdae73cd arch/arm/include/asm/mmu_context.h Catalin Marinas 2013-07-23  81  		}
bdae73cd arch/arm/include/asm/mmu_context.h Catalin Marinas 2013-07-23 @82  		preempt_enable_no_resched();
b9d4d42a arch/arm/include/asm/mmu_context.h Catalin Marinas 2011-11-28  83  	}
b9d4d42a arch/arm/include/asm/mmu_context.h Catalin Marinas 2011-11-28  84  }
^1da177e include/asm-arm/mmu_context.h      Linus Torvalds  2005-04-16  85  

:::::: The code at line 82 was first introduced by commit
:::::: bdae73cd374e28db544fdd9b77de689a36e3c129 ARM: 7790/1: Fix deferred mm switch on VIVT processors

:::::: TO: Catalin Marinas <catalin.marinas@arm.com>
:::::: CC: Russell King <rmk+kernel@arm.linux.org.uk>

-- snip

I gave up after a few hours trying to solve the header dependencies, the two
trouble makes are alpha with the task_thread_info call in mmu_context.h and
arm with the preempt_enable_no_resched call. Welcome to include file hell.


-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
