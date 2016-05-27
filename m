From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 01/23] all: syscall wrappers: add documentation
Date: Fri, 27 May 2016 10:01:42 +0100
Message-ID: <20160527090141.GA7865@e104818-lin.cambridge.arm.com>
References: <6293194.tGy03QJ9ME@wuerfel>
 <20160525.135039.244098606649448826.davem@davemloft.net>
 <6407614.fdv5XFSBue@wuerfel>
 <20160525.142821.1719403997976778673.davem@davemloft.net>
 <20160526204819.GA10274@yury-N73SV>
 <20160526222943.GA16729@MBP.local>
 <20160527003753.GA14247@yury-N73SV>
 <20160527060357.GB3820@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160527060357.GB3820@osiris>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Yury Norov <ynorov@caviumnetworks.com>, David Miller <davem@davemloft.net>, arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, May 27, 2016 at 08:03:57AM +0200, Heiko Carstens wrote:
> > > > The cost is pretty trivial though. See kernel/compat_wrapper.o:
> > > > COMPAT_SYSCALL_WRAP2(creat, const char __user *, pathname, umode_t, mode);
> > > > 0:   a9bf7bfd        stp     x29, x30, [sp,#-16]!
> > > > 4:   910003fd        mov     x29, sp
> > > > 8:   2a0003e0        mov     w0, w0
> > > > c:   94000000        bl      0 <sys_creat>
> > > > 10:  a8c17bfd        ldp     x29, x30, [sp],#16
> > > > 14:  d65f03c0        ret
> > > 
> > > I would say the above could be more expensive than 8 movs (16 bytes to
> > > write, read, a branch and a ret). You can also add the I-cache locality,
> > > having wrappers for each syscalls instead of a single place for zeroing
> > > the upper half (where no other wrapper is necessary).
> > > 
> > > Can we trick the compiler into doing a tail call optimisation. This
> > > could have simply been:
> > > 
> > > COMPAT_SYSCALL_WRAP2(creat, ...):
> > > 	mov	w0, w0
> > > 	b	<sys_creat>
> > 
> > What you talk about was in my initial version. But Heiko insisted on having all
> > wrappers together.
> > http://www.spinics.net/lists/linux-s390/msg11593.html
> > 
> > Grep your email for discussion.
> 
> I think Catalin's question was more about why there is even a stack frame
> generated. It looks like it is not necessary. I did ask this too a couple
> of months ago, when we discussed this.

Indeed, I was questioning the need for prologue/epilogue, not the use of
COMPAT_SYSCALL_WRAPx(). Maybe something like __naked would do.

> > > > > Cost wise, this seems like it all cancels out in the end, but what
> > > > > do I know?
> > > > 
> > > > I think you know something, and I also think Heiko and other s390 guys
> > > > know something as well. So I'd like to listen their arguments here.
> 
> If it comes to 64 bit arguments for compat system calls: s390 also has an
> x32-like ABI extension which allows user space to use full 64 bit
> registers. As far as I know hardly anybody ever made use of that.
> 
> However even if that would be widely used, to me it wouldn't make sense to
> add new compat system calls which allow 64 bit arguments, simply because
> something like
> 
> c = (u32)a | (u64)b << 32;
> 
> can be done with a single 1-cycle instruction. It's just not worth the
> extra effort to maintain additional system call variants.

If we split 64-bit arguments in two, we can go a step further and avoid
most of the COMPAT_SYSCALL_WRAPx annotations in favour of a common
upper-half zeroing of the argument registers on ILP32 syscall entry.
There would be a few exceptions where we need to re-build 64-bit
arguments on sign-extend.

-- 
Catalin
