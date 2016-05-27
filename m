From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 01/23] all: syscall wrappers: add documentation
Date: Fri, 27 May 2016 03:37:53 +0300
Message-ID: <20160527003753.GA14247@yury-N73SV>
References: <6293194.tGy03QJ9ME@wuerfel>
 <20160525.135039.244098606649448826.davem@davemloft.net>
 <6407614.fdv5XFSBue@wuerfel>
 <20160525.142821.1719403997976778673.davem@davemloft.net>
 <20160526204819.GA10274@yury-N73SV>
 <20160526222943.GA16729@MBP.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160526222943.GA16729@MBP.local>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: David Miller <davem@davemloft.net>, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 26, 2016 at 11:29:45PM +0100, Catalin Marinas wrote:
> On Thu, May 26, 2016 at 11:48:19PM +0300, Yury Norov wrote:
> > On Wed, May 25, 2016 at 02:28:21PM -0700, David Miller wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > > Date: Wed, 25 May 2016 23:01:06 +0200
> > > 
> > > > On Wednesday, May 25, 2016 1:50:39 PM CEST David Miller wrote:
> > > >> From: Arnd Bergmann <arnd@arndb.de>
> > > >> Date: Wed, 25 May 2016 22:47:33 +0200
> > > >> 
> > > >> > If we use the normal calling conventions, we could remove these overrides
> > > >> > along with the respective special-case handling in glibc. None of them
> > > >> > look particularly performance-sensitive, but I could be wrong there.
> > > >> 
> > > >> You could set the lowest bit in the system call entry pointer to indicate
> > > >> the upper-half clears should be elided.
> > > > 
> > > > Right, but that would introduce an extra conditional branch in the syscall
> > > > hotpath, and likely eliminate the gains from passing the loff_t arguments
> > > > in a single register instead of a pair.
> > > 
> > > Ok, then, how much are you really gaining from avoiding a 'shift' and
> > > an 'or' to build the full 64-bit value?  3 cycles?  Maybe 4?
> > 
> > 4 cycles in kernel and ~same cost in glibc to create a pair.
> 
> It would take a single instruction per argument in the kernel to do
> shift+or and maybe 1-2 more instructions to move the remaining arguments
> in place (we do this for a few wrappers in arch/arm64/kernel/entry32.S).
> And the glibc counterpart.
> 
> > And 8 'mov's that exist for every syscall, even yield().
> > 
> > > And the executing the wrappers, those have a non-trivial cost too.
> > 
> > The cost is pretty trivial though. See kernel/compat_wrapper.o:
> > COMPAT_SYSCALL_WRAP2(creat, const char __user *, pathname, umode_t, mode);
> > 0:   a9bf7bfd        stp     x29, x30, [sp,#-16]!
> > 4:   910003fd        mov     x29, sp
> > 8:   2a0003e0        mov     w0, w0
> > c:   94000000        bl      0 <sys_creat>
> > 10:  a8c17bfd        ldp     x29, x30, [sp],#16
> > 14:  d65f03c0        ret
> 
> I would say the above could be more expensive than 8 movs (16 bytes to
> write, read, a branch and a ret). You can also add the I-cache locality,
> having wrappers for each syscalls instead of a single place for zeroing
> the upper half (where no other wrapper is necessary).
> 
> Can we trick the compiler into doing a tail call optimisation. This
> could have simply been:
> 
> COMPAT_SYSCALL_WRAP2(creat, ...):
> 	mov	w0, w0
> 	b	<sys_creat>

What you talk about was in my initial version. But Heiko insisted on having all
wrappers together.
http://www.spinics.net/lists/linux-s390/msg11593.html

Grep your email for discussion.

> 
> > > Cost wise, this seems like it all cancels out in the end, but what
> > > do I know?
> > 
> > I think you know something, and I also think Heiko and other s390 guys
> > know something as well. So I'd like to listen their arguments here.
> > 
> > For me spark64 way is looking reasonable only because it's really simple
> > and takes less coding. I'll try it on some branch and share here what happened.
> 
> The kernel code will definitely look simpler ;). It would be good to see
> if there actually is any performance impact. Even with 16 more cycles on
> syscall entry, would they be lost in the noise? You don't need a full
> implementation, just some dummy mov x0, x0 on the entry path.
> 
> -- 
> Catalin
