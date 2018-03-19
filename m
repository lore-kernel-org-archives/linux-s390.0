From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC PATCH 4/6] mm: provide generic compat_sys_readahead()
 implementation
Date: Mon, 19 Mar 2018 04:23:00 +0000
Message-ID: <20180319042300.GW30522@ZenIV.linux.org.uk>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net>
 <20180318174014.GR30522@ZenIV.linux.org.uk>
 <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
 <20180318181848.GU30522@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180318181848.GU30522@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips <linux-mips@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, the arch/x86 maintainers <x86@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Mar 18, 2018 at 06:18:48PM +0000, Al Viro wrote:

> I'd done some digging in that area, will find the notes and post.

OK, found:

We have two ABIs in the game - syscall and normal C.  The latter
(for all targets we support) can be described in the following
terms:
	* there is a series of word-sized objects used to pass
arguments, some in registers, some on stack.  Arguments are
mapped on that sequence.  Anything up to word size simply takes
the next available word, so on 64bit it's all there is - nth
argument goes into the nth object, types simply do not matter.
On 32bit it's not that simple - there 64bit arguments occupy
two objects.  They are still picked from the same sequence;
on little-endian the lower half goes first, on big-endian -
the higher one.  For some architectures that's all there is to it.
However, on quite a few there's an extra complication - not every
pair can be used for 64bit value.  Rules for those are arch-dependent.
One variety is "pairs should be aligned", i.e. "if we'd consumed
an odd number of slots, add a dummy one before eating a pair".
Another is "don't let a pair span the registers/stack boundary";
surprisingly enough, that's not universal.

The syscall ABI can considerably differ from C one.  First of all,
we really do *not* want to pass anything on stack - it's a major
headache at syscall entry.  See mips/o32 for the scale of that headache.
Not fun.  OTOH, the registers that can be used are a limited resource.
i386 can't pass more than 6 words and that has served as an upper
limit.  If we encode the argument sizes (W - word, D - 64bit) we
have the following variants among the syscalls:
	* no arguments at all (SYSCALL_DEFINE0)
	* W (SYSCALL_DEFINE1)
	* WW (SYSCALL_DEFINE2)
	* WWW (SYSCALL_DEFINE3)
	* WWWW (SYSCALL_DEFINE4)
	* WWWWW (SYSCALL_DEFINE5)
	* WWWWWW (SYSCALL_DEFINE6)
	* WD (SYSCALL_DEFINE2, truncate64, ftruncate64)
	* DWW (SYSCALL_DEFINE3, lookup_dcookie)
	* WDW (SYSCALL_DEFINE3, readahead)
	* WWWD (SYSCALL_DEFINE4, pread64, pwrite64)
	* WWDD (SYSCALL_DEFINE4, fallocate, sync_file_range2)
	* WDDW (SYSCALL_DEFINE4, sync_file_range, fadvise64_64)
	* WDWW (SYSCALL_DEFINE4, fadvise64)
	* WWDWW (SYSCALL_DEFINE5, fanotify_mark)

The list for each long long-passing variant might be incomplete, but
they really are rare.  And a source of headache; not just for biarch
architectures - e.g. c6x and metag are not biarch and these syscalls
are exactly what stinks them up.

One thing we *really* don't want is syscall-dependent mapping from
syscall ABI registers to C ABI sequence.  Inside a syscall (or in
per-syscall glue) - sure, we can do it (if not happily).  In the
syscall dispatcher - fuck no, too much PITA.  mips/o32 used to be
a horrible example of why not, then they went for "copy from userland
stack whether we need it or not"...

For simple syscalls (first 7 classes in the above, each argument fits
into word) we simply map registers to the first 6 slots of the sequence
and we are done.  It's bloody tempting to use the same mapping for
the rest - use the same code that calls simple syscalls and have it
call sys_readahead() instead of sys_mkdir(), etc.  For something like
x86 or sparc that works perfectly - these guys have no padding for 64bit
arguments, so we are good (provided that userland sets those registers
sanely, that is).

OTOH, consider arm.  There we have
	* r0, r1, r2, r3, [sp,#8], [sp,#12], [sp,#16]... is the sequence
of objects used to pass arguments
	* 32bit and less - pick the next available slot
	* 64bit - skip a slot if we'd already taken an odd number, then use
the next two slots for lower and upper 32 bits of the argument.

So our classes take
simple n-argument:	0 to 6 slots
WD			4 slots
DWW			4 slots
WDW			5 slots
WWDD			6 slots
WDWW			5 slots
WWWD			6 slots
WWDWW			6 slots
WDDW			7 slots (!)  Also ****, !!!!, !@#!@#!@#!# and other nice
and well-deserved comments from arch maintainers, some of them even printable:
/* It would be nice if people remember that not all the world's an i386
   when they introduce new system calls */
SYSCALL_DEFINE4(sync_file_range2, int, fd, unsigned int, flags,
                                 loff_t, offset, loff_t, nbytes)

No idea why that hadn't been done to fadvise64_64() - that got
/*
 * Since loff_t is a 64 bit type we avoid a lot of ABI hassle
 * with a different argument ordering.
 */
asmlinkage long sys_arm_fadvise64_64(int fd, int advice,
                                     loff_t offset, loff_t len)
{
        return sys_fadvise64_64(fd, offset, len, advice);
}
long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
                      u32 len_high, u32 len_low)
{
        return sys_fadvise64(fd, (u64)offset_high << 32 | offset_low,
                             (u64)len_high << 32 | len_low, advice);
}
and
asmlinkage long parisc_fadvise64_64(int fd,
                        unsigned int high_off, unsigned int low_off,
                        unsigned int high_len, unsigned int low_len, int advice)
{
        return sys_fadvise64_64(fd, (loff_t)high_off << 32 | low_off,
                        (loff_t)high_len << 32 | low_len, advice);
}
consistency, shmonsistency...  And yes, glibc has
#ifdef __ASSUME_FADVISE64_64_6ARG
  int ret = INTERNAL_SYSCALL_CALL (fadvise64_64, err, fd, advise,
                                   SYSCALL_LL64 (offset), SYSCALL_LL64 (len));
#else
  int ret = INTERNAL_SYSCALL_CALL (fadvise64_64, err, fd,
                                   __ALIGNMENT_ARG SYSCALL_LL64 (offset),
                                   SYSCALL_LL64 (len), advise);
#endif
with __ASSUME_FADVISE64_64_6ARG defined for arm and ppc...
xtensa, BTW, has
asmlinkage long xtensa_fadvise64_64(int fd, int advice,
                unsigned long long offset, unsigned long long len)
{
        return sys_fadvise64_64(fd, offset, len, advice);
}
In other words, same solution as arm and ppc.  No xtensa support in
glibc, AFAICS...

Anyway, padding rules for 32bit ones, with not too many arguments:

* arc cris frv h8300 i386 m32r m68k microblaze mn10300 nios2 openrisc
riscv sparc - no padding.
Note that e.g. frv *does* have a "don't let it cross regs/stack
boundary" rule, but it has 6 register slots, so for syscalls it
doesn't matter.  OTOH, sparc (and m32r, and...) really won't
care about regs/stack boundary.

* arm mips parisc ppc xtensa - pad to even number of words consumed;
since the number of registers in the sequence is even for all those,
there is nothing special going on at the edge.  WDDW is a bitch for
that group; mips goes for "fuck it, we copy userland stack anyway",
the rest try to cope in various ways.

* s390 - 5 register slots, padding on the crossing the regs/stack
boundary and nowhere else (i.e. pad if exactly 4 words had been
consumed).  WWDD runs afoul of that one.

* bfin - similar, except that we pad on exactly 2 words.  Same
story as with s390, only we have 3 register slots.  Headache
on: WWDWW and WWDD.

* c6x - strange beast, that; registers are 32bit, but for the
argument passing purposes it's using 64bit register pairs, filling
only the lower half when passing a 32bit argument.

* sh - really weird.  If 64bit would span the registers/stack
boundary (4 register slots there), it's done on stack... and
the first 32bit argument after that will eat the remaining
register.  Out of our classes it affects WWWD (as if there
had been a padding) and WDDW (as if the last two arguments had
switched places).

FWIW, it looks like we have several different issues mixed here

1) teaching COMPAT_SYSCALL_DEFINE to do the right thing in case
when 64bit arguments are present.  It's not terribly hard (sh
is not biarch, thankfully), but we'd better watch out carefully
when unifying - "fucker eats 7 slots" cases are irregular by
definition and solutions used for those differ between the
architectures.  It won't be pretty, though - we can get something
like
asmlinkage long compat_sys_truncate64(long a0, long a1, long a2, long a3, long a4, long a5)
{
	CS_truncate64((const char __user *)a0, ((u64)a2<<32)|(u64)a3);
}
static inline long CS_truncate64(const char __user *path, loff_t length)
{
	return sys_truncate64(path, length);
}
out of
COMPAT_SYSCALL_DEFINE2(trucate64, const char __user *, path, loff_t, length)
{
	return sys_truncate(path, length);
}
but the damn thing will be 6-argument and expressions for arguments will
expand to something equal to the forms above, but they'll be choke-full
of conditional expressions with constant 0 or 1 for selectors.  What we can't
do is evaluation of "is it long long" at macro expansion time - we can't tell
int, loff_t from int, pid_t until typedefs had been handled, at which point
the parse tree is cast in stone.  It will have to be 6-argument.
Alternatively, we could do COMPAT_SYSCALL_DEFINE_WD et.al. so that preprocessor
would get that information directly from us.

[snip the preprocessor horrors - the sketches I've got there are downright obscene]

2) s390 compat wrappers ;-/  I still wonder if we would be better
off with SYSCALL_DEFINE on s390 defining a wrapper with COMPAT_SYSCALL_DEFINE
(if present) redefining it, throwing the original away.  That could be done
with some amount of linker trickery.

3) sparc wrappers in sys32.S.  Most of those got killed off back in 2012,
what remained was
SIGN1(sys32_getrusage, compat_sys_getrusage, %o0)
SIGN1(sys32_readahead, compat_sys_readahead, %o0)
SIGN2(sys32_fadvise64, compat_sys_fadvise64, %o0, %o4)
SIGN2(sys32_fadvise64_64, compat_sys_fadvise64_64, %o0, %o5)
SIGN1(sys32_clock_nanosleep, compat_sys_clock_nanosleep, %o1)
SIGN1(sys32_timer_settime, compat_sys_timer_settime, %o1)
SIGN1(sys32_io_submit, compat_sys_io_submit, %o1)
SIGN1(sys32_mq_open, compat_sys_mq_open, %o1)
SIGN1(sys32_select, compat_sys_select, %o0)
SIGN3(sys32_futex, compat_sys_futex, %o1, %o2, %o5)
SIGN2(sys32_sendfile, compat_sys_sendfile, %o0, %o1)
SIGN1(sys32_recvfrom, compat_sys_recvfrom, %o0)
SIGN1(sys32_recvmsg, compat_sys_recvmsg, %o0)
SIGN1(sys32_sendmsg, compat_sys_sendmsg, %o0)
SIGN2(sys32_sync_file_range, compat_sync_file_range, %o0, %o5)
SIGN1(sys32_vmsplice, compat_sys_vmsplice, %o0)
with some of those killed off later and (completely pointless)
SIGN2(sys32_renameat2, sys_renameat2, %o0, %o2)
added.

Since then clock_nanosleep(), timer_settime(), io_submit(), mq_open(),
select(), recvfrom(), recvmsg(), sendmsg(), getrusage(), sync_file_range(),
futex() and vmsplice() got switched to COMPAT_SYSCALL_DEFINE, making those
SIGN... wrappers pointless.  That leaves
SIGN1(sys32_readahead, compat_sys_readahead, %o0)
SIGN2(sys32_fadvise64, compat_sys_fadvise64, %o0, %o4)
SIGN2(sys32_fadvise64_64, compat_sys_fadvise64_64, %o0, %o5)
all of which are right there in arch/sparc/kernel/sys_sparc32.c and
trivially converted to COMPAT_SYSCALL_DEFINE.  Which would kill all the
SIGN... bunch off, leaving there sys_mmap() and sys_socketcall()

4) stuff in arch really needs a good look.  And not just biarch -
I could've easily missed some "takes a 64bit argument" cases in
that area.  Moreover, it might be a good idea to have all syscall
tables generated a-la x86 and s390 ones are, ideally with the same
format of input data for all of them...
