Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Thu, 14 Feb 2019 11:37:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 0/3] locking/rwsem: Rwsem rearchitecture part 0
Message-ID: <20190214103715.GI32494@hirez.programming.kicks-ass.net>
References: <1550095217-12047-1-git-send-email-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550095217-12047-1-git-send-email-longman@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190214103715.O61xiyDUtFfJywghpz2Nwi_R2OMcuxbREoUd59m9Ey4@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Waiman Long <longman@redhat.com>
Cc: Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-arch@vger.kernel.org, x86@kernel.org, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Davidlohr Bueso <dave@stgolabs.net>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Tim Chen <tim.c.chen@linux.intel.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Feb 13, 2019 at 05:00:14PM -0500, Waiman Long wrote:
> v4:
>  - Remove rwsem-spinlock.c and make all archs use rwsem-xadd.c.
> 
> v3:
>  - Optimize __down_read_trylock() for the uncontended case as suggested
>    by Linus.
> 
> v2:
>  - Add patch 2 to optimize __down_read_trylock() as suggested by PeterZ.
>  - Update performance test data in patch 1.
> 
> The goal of this patchset is to remove the architecture specific files
> for rwsem-xadd to make it easer to add enhancements in the later rwsem
> patches. It also removes the legacy rwsem-spinlock.c file and make all
> the architectures use one single implementation of rwsem - rwsem-xadd.c.
> 
> Waiman Long (3):
>   locking/rwsem: Remove arch specific rwsem files
>   locking/rwsem: Remove rwsem-spinlock.c & use rwsem-xadd.c for all
>     archs
>   locking/rwsem: Optimize down_read_trylock()

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

with the caveat that I'm happy to exchange patch 3 back to my earlier
suggestion in case Will expesses concerns wrt the ARM64 performance of
Linus' suggestion.
