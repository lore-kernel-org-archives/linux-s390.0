From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 01/23] all: syscall wrappers: add documentation
Date: Thu, 26 May 2016 23:48:19 +0300
Message-ID: <20160526204819.GA10274@yury-N73SV>
References: <6293194.tGy03QJ9ME@wuerfel>
 <20160525.135039.244098606649448826.davem@davemloft.net>
 <6407614.fdv5XFSBue@wuerfel>
 <20160525.142821.1719403997976778673.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160525.142821.1719403997976778673.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 25, 2016 at 02:28:21PM -0700, David Miller wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> Date: Wed, 25 May 2016 23:01:06 +0200
> 
> > On Wednesday, May 25, 2016 1:50:39 PM CEST David Miller wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> Date: Wed, 25 May 2016 22:47:33 +0200
> >> 
> >> > If we use the normal calling conventions, we could remove these overrides
> >> > along with the respective special-case handling in glibc. None of them
> >> > look particularly performance-sensitive, but I could be wrong there.
> >> 
> >> You could set the lowest bit in the system call entry pointer to indicate
> >> the upper-half clears should be elided.
> > 
> > Right, but that would introduce an extra conditional branch in the syscall
> > hotpath, and likely eliminate the gains from passing the loff_t arguments
> > in a single register instead of a pair.
> 
> Ok, then, how much are you really gaining from avoiding a 'shift' and
> an 'or' to build the full 64-bit value?  3 cycles?  Maybe 4?

4 cycles in kernel and ~same cost in glibc to create a pair. And 8
'mov's that exist for every syscall, even yield().

> And the executing the wrappers, those have a non-trivial cost too.

The cost is pretty trivial though. See kernel/compat_wrapper.o:
COMPAT_SYSCALL_WRAP2(creat, const char __user *, pathname, umode_t, mode);
0:   a9bf7bfd        stp     x29, x30, [sp,#-16]!
4:   910003fd        mov     x29, sp
8:   2a0003e0        mov     w0, w0
c:   94000000        bl      0 <sys_creat>
10:  a8c17bfd        ldp     x29, x30, [sp],#16
14:  d65f03c0        ret

> Cost wise, this seems like it all cancels out in the end, but what
> do I know?

I think you know something, and I also think Heiko and other s390 guys
know something as well. So I'd like to listen their arguments here.

For me spark64 way is looking reasonable only because it's really simple
and takes less coding. I'll try it on some branch and share here what happened.
