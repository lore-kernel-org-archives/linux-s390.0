From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 01/23] all: syscall wrappers: add documentation
Date: Thu, 26 May 2016 15:20:58 +0100
Message-ID: <20160526142057.GA7456@e104818-lin.cambridge.arm.com>
References: <6293194.tGy03QJ9ME@wuerfel>
 <20160525.135039.244098606649448826.davem@davemloft.net>
 <6407614.fdv5XFSBue@wuerfel>
 <20160525.142821.1719403997976778673.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160525.142821.1719403997976778673.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: arnd@arndb.de, ynorov@caviumnetworks.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com
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

It's possible a few more cycles overall. Whether this is noticeable, I
can't really tell without some benchmarks (e.g. a getpid wrapper zeroing
top 32-bit of all possible 6 arguments, called in a loop).

On arm64 with ILP32 we have three types of syscalls w.r.t. parameter
width (I guess that's true for all other compat implementations):

1. User syscall definition with 32-bit arguments, kernel handling 32-bit
   arguments

2. User 32-bit arguments, kernel 64-bit arguments

3. User 64-bit arguments, kernel 64-bit arguments

For (1), the AArch64 ABI (AAPCS) allows us to ignore the garbage in the
top 32-bit of a 64-bit register as long as the callee has 32-bit
arguments (IOW, the generated code will use 32-git Wn instead of 64-bit
Xn registers). In this case, zeroing the top 32-bit of all 6 arguments
is unnecessary.

In the 2nd case, we need sign or zero extension of 32-bit arguments. For
sign extension we would still need a wrapper as the generic one can only
zero-extend without knowing the underlying type. How many cases do we
have where sign extension is required (off_t is a signed type but does
it actually make sense as a negative value)? The __SC_WRAP and
COMPAT_SYSCALL_WRAP macros introduced by patches 3-5 in this series
handle such conversion for both sign and unsigned arguments.

We don't have such problem with AArch32 tasks since the architecture
guarantees zeroing or preserving the top half of all registers.

For (3), with the current ILP32 approach we wouldn't need any wrapper.
If we are to pass the argument as two 32-bit values, we would need both
the user (glibc) to split the argument and the kernel to re-construct
it. This would be in addition to any default top 32-bit zeroing on
kernel entry.

The overhead may be lost in the noise (we need some data) but IIRC our
decision was mostly based on a cleaner user implementation for point (3)
above. Since an AArch64/ILP32 process can freely use 64-bit registers,
we found it nicer to be able to pass such value directly to the kernel.
Reusing the s390 macros should reduce the amount of new code added to
the kernel.


While writing the above, I realised the current ILP32 patches still miss
on converting pointers passed from user space (unless I got myself
confused in macros). The new __SC_WRAP() and COMPAT_SYSCALL_WRAPx()
macros take care of zero or sign extension via __SC_COMPAT_CAST().
However, we have two more existing cases which I don't see covered:

a) Native syscalls taking a pointer argument and invoked directly from
   ILP32. For example, sys_read() takes a pointer but I don't see any
   __SC_WRAP added by patch 5

b) Current compat syscalls taking a pointer argument. For example,
   compat_sys_vmsplice() gets the iov32 pointer and the compiler assumes
   it is a 64-bit variable. I don't see where the upper half is zeroed

We can solve (a) by adding more __SC_WRAP annotations in the generic
unistd.h. For (b), we would need an __SC_DELOUSE with a bit of penalty
on AArch32/compat support where it isn't needed. So maybe davem has a
point on the overall impact of always zeroing the upper half of the
arguments ;) (both from a performance and maintainability perspective).
I guess this part of the ABI is still up for discussion.

-- 
Catalin
