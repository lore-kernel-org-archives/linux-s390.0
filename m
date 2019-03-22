Return-Path: <linux-arch-owner@vger.kernel.org>
Date: Fri, 22 Mar 2019 12:30:10 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v5 1/3] locking/rwsem: Remove arch specific rwsem files
Message-ID: <20190322193010.azb7rmmmaclhal35@linux-r8p5>
References: <20190322143008.21313-1-longman@redhat.com>
 <20190322143008.21313-2-longman@redhat.com>
 <CAHk-=wikkO-1f1=FEOEzkSnaDg3yJLP=4Vd59UCuLBztFd0KOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wikkO-1f1=FEOEzkSnaDg3yJLP=4Vd59UCuLBztFd0KOw@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190322193010.jGIVF3ZzZk_bCByMDJFfLWIwzuiHjfIf40JJ9e1ObSI@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Waiman Long <longman@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>, linux-c6x-dev@linux-c6x.org, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, linux-mips@vger.kernel.org, nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, sparclinux@vger.kernel.org, linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org, linux-arch <linux-arch@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Tim Chen <tim.c.chen@linux.intel.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 22 Mar 2019, Linus Torvalds wrote:
>Some of them _might_ be performance-critical. There's the one on
>mmap_sem in the fault handling path, for example. And yes, I'd expect
>the normal case to very much be "no other readers or writers" for that
>one.

Yeah, the mmap_sem case in the fault path is really expecting an unlocked
state. To the point that four archs have added branch predictions, ie:

 92181f190b6 (x86: optimise x86's do_page_fault (C entry point for the page fault path))
 b15021d994f (powerpc/mm: Add a bunch of (un)likely annotations to do_page_fault)

And using PROFILE_ANNOTATED_BRANCHES shows pretty clearly:
(without resetting the counters)

 correct incorrect  %        Function              File          Line
 ------- ---------  -        --------              ----          ----
  4603685       34   0 do_user_addr_fault         fault.c          1416 (bootup)
382327745      449   0 do_user_addr_fault         fault.c          1416 (kernel build)
399446159      461   0 do_user_addr_fault         fault.c          1416 (redis benchmark)

It would probably wouldn't harm doing the unlikely() for all archs, or
alternatively, add likely() to the atomic_long_try_cmpxchg_acquire in
patch 3 and do it implicitly but maybe that would be less flexible(?)

Thanks,
Davidlohr
