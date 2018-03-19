From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC PATCH 4/6] mm: provide generic compat_sys_readahead()
 implementation
Date: Mon, 19 Mar 2018 23:23:42 +0000
Message-ID: <20180319232342.GX30522@ZenIV.linux.org.uk>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net>
 <20180318174014.GR30522@ZenIV.linux.org.uk>
 <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
 <20180318181848.GU30522@ZenIV.linux.org.uk>
 <20180319042300.GW30522@ZenIV.linux.org.uk>
 <20180319092920.tbh2xwkruegshzqe@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180319092920.tbh2xwkruegshzqe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips <linux-mips@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Mar 19, 2018 at 10:29:20AM +0100, Ingo Molnar wrote:
> 
> * Al Viro <viro@ZenIV.linux.org.uk> wrote:
> 
> > On Sun, Mar 18, 2018 at 06:18:48PM +0000, Al Viro wrote:
> > 
> > > I'd done some digging in that area, will find the notes and post.
> > 
> > OK, found:
> 
> Very nice writeup - IMHO this should go into Documentation/!

If you want to turn that into something printable - more power to you...
FWIW, I think we need to require per-architecture descriptions of ABI
for all architectures.  Something along the lines of

alpha:
C ABI: 64bit, location sequence is ($16, $17, $18, $19, $20, $21, stack)
No arg padding (as for all 64bit).  Stack pointer in $30, return value
in $0.
Syscall ABI: syscall number in $0, arg slots filled from $16, $17, $18, $19,
$20, $21.  Return value in $0, error is reported as 1 in $19.  Saved
syscall number is used as a flag for __force_successful_syscall_return()
purposes - sticking 0 there inhibits the effect of negative return value.

arm:
C ABI: 32bit, location sequence is (r0, r1, r2, r3, stack).  Arg padding
for 64bit args: to even slot.  Stack pointer in sp, return value in r0
Syscall ABI, EABI variant: syscall number in r7.
Syscall ABI, OABI variant: syscall number encoded into insn.
Syscall ABI (both variants): arg slots filled from r0, r1, r2, r3, r4, r5.
Return value in r0.  It's not quite a biarch (support of e.g. ioctl
handling is absent, etc.; basic syscalls are handled, but that's it).

etc.  Ideally the information about callee-saved registers, syscall restart
logics, etc. should also go there.  I'm sick and tired of digging though
the asm glue of unfamiliar architectures ;-/

Another relevant piece of information (especially for biarch) is how
should sub-word arguments be normalized.  E.g. on amd64 both int and long
are passed in 64bit words and function that expects an int does *not*
care about the upper 32 bits.  If you have long f(int a) {return a;},
it will sign-extend the argument.  On ppc, OTOH, it won't - the caller
is responsible for having the bits 31..63 all equal.

That used to be a source of considerable PITA - e.g. kill(2) used to
require a compat wrapper on ppc.  These days SYSCALL_DEFINE and
COMPAT_SYSCALL_DEFINE glue takes care of normalizations.  However
it doesn't apply for the stuff that does *not* use ...DEFINE and
for use of native syscalls on biarch we need a bit more.  Consider
e.g. 32bit syscall on sparc64 wanting to use the native counterpart.
Arguments that are <= 32bit in both ABIs are fine - normalizations
will take care of them.  Anything that is 64bit in both ABIs means
that we will need compat anyway - the argument needs to be recombined
from two registers into one.  The headache comes from
	* signed long
	* unsigned long
	* pointers
Those are word-sized and we need to normalize.  Solution before
SYSCALL_DEFINE glue: have upper halves forcibly zeroed on entry (which
normalizes unsigned long and pointers) and then sign-extend every
signed int and signed long in per-syscall glue (that zeroing is
guaranteed to denormalize int arguments).  Once SYSCALL_DEFINE started
to do normalization we disposed on the need to do separate wrappers
for int arguments; that still leaves us with signed long ones, but
	* they are very rare
	* most of the syscalls passing them need compat for more
serious reasons anyway.
There are only two exceptions - bdflush(2) and pciconfig_iobase(2).
The latter doesn't exist on sparc, the former ignores its signed long
argument completely.  So we are left with "zero upper halves of all
argument-bearing registers upon the entry and have per-syscall glue
take care of the rest".

For s390 the situation is nastier - normalization for signed and
unsigned long is the same as usual, but pointers might have junk
in bit 31.  IOW, for anything with pointer in arguments we can't
just use the native syscall.  As the result, s390 doesn't bother
with zeroing upper halves in syscall dispatcher and does private
mini-wrappers for native syscalls with pointer/long/ulong arguments.

That kind of crap really needs to be documented - RTFS becomes
somewhat painful when it involves tens of assemblers *and*
missing ABI documents (try to locate one for something embedded -
great motivation for expanding vocabulary, that) ;-/

FWIW, SYSCALL_DEFINE and its ilk (COMPAT_SYSCALL_DEFINE,
s390 COMPAT_SYSCALL_WRAP, etc.) are all about stepping over the
ABI gap - we've got some values from userland caller and we
need to turn that into a valid C function call that would
satisfy C ABI constraints.  Some amount of normalization might've
been done by syscall dispatcher; this stuff does the rest on
per-function basis.

> One way to implement this would be to put the argument chain types (string) and 
> sizes (int) into a special debug section which isn't included in the final kernel 
> image but which can be checked at link time.

Umm...  Possible, but I actually believe that we can do that without
debug info.

WARNING: AVERT YOUR EYES IF YOU HAVE A WEAK STOMACH.  I'm _not_ saying that
the trickery below is a good idea, no need to break out a straightjacket.
It does have some merits, but in the current form it's ugly as hell and
almost certainly not fit for inclusion.  Consider that as a theoretical
exercise, please.

Again, don't read further if you are easily squicked.  You've been warned.
===============================================================================
Look:
* we can generate
	enum {S0 = __TYPE_IS_LL(int),
	      S1 = __TYPE_IS_LL(loff_t),
	      S2 = __TYPE_IS_LL(size_t)};
at preprocessor level (inside the compat wrapper being built).  Calculations
will be done at compile time, of course, but those _are_ constants (0, 1, 0 in
our case).
* we can generate
	enum {OFF0 = 0, OFF1 = STEP(OFF0 + S0, S1), OFF2 = STEP(OFF1 + S1, S2)};
at the same time, with STEP(base, big) defined as base + 1 for something like
x86, (big ? ((base) | 1) + 1 : (base) + 1) for arm and friends,
base + 1 + (big && base == 3) for s390.  Again, compile-time calculations.
For x86 - (0, 1, 3), for arm - (0, 2, 4), etc.
* we can generate
	C_S_moron((__force int)(S0 ? PAIR(OFF0) : ARG(OFF0)),
		  (__force loff_t)(S1 ? PAIR(OFF1) : ARG(OFF1)),
		  (__force size_t)(S2 ? PAIR(OFF2) : ARG(OFF2)));
in the body of wrapper.  With PAIR(n) defined as either ((u64)ARG(n) << 32) | ARG(n+1)
or ((u64)ARG(n+1) << 32) | ARG(n) (depending upon endianness) and ARG(n)
defined as (n == 0 ? a0 : n == 1 ? a1 : n == 2 ? a2 : n == 3 ? a3 :
	    n == 4 ? a4 : n == 5 ? a5 : a6)
Note that each of those suckers expands to a cascade of conditional
expressions with all conditions being integer constant expressions,
no more than one of those being true.  In our case that crap will fold into
	C_S_moron((__force int)a0,
		  (__force loff_t)(((u64)a2 << 32)|a1),
		  (__force size_t)a3);
as soon as optimizations at the level of 0 ? x : y => y and 1 ? x : y => x
are done.  And we have, in effect,

static inline long C_S_moron(int, loff_t, size_t);
long compat_SyS_moron(long a0, long a1, long a2, long a3, long a4, long a5, long a6)
{
	return C_S_moron((__force int)a0,
		  (__force loff_t)(((u64)a2 << 32)|a1),
		  (__force size_t)a3);
}
static inline long C_S_moron(int fd, loff_t offset, size_t count)
{
	whatever body you had for it
}

That - from
COMPAT_SYSCALL_DEFINE3(moron, int, fd, loff_t, offset, size_t, count)
{
	whatever body you had for it
}

We can use similar machinery for SYSCALL_DEFINE itself, so that
SyS_moron() would be defined with (long, long, long, long, long, long)
as arguments and not (long, long long, long) as we have now.

It's not impossible to do.  It won't be pretty, but that use of local
enums allows to avoid unbearably long expansions.

Benefits:
	* all SyS... wrappers (i.e. the thing that really ought to
go into syscall tables) have the same type.
	* we could have SYSCALL_DEFINE produce a trivial compat
wrapper, have explicit COMPAT_SYSCALL_DEFINE discard that thing
and populate the compat syscall table *entirely* with compat_SyS_...,
letting the linker sort it out.  That way we don't need to keep
track of what can use native and what needs compat in each compat
table on biarch.
	* s390 compat wrappers would disappear with that approach.
	* we could even stop generating sys_... aliases - if
syscall table is generated by slapping SyS_... or compat_SyS_...
on the name given there, we don't need to _have_ those sys_...
things at all.  All SyS_... would have the same type, so the pile
in syscalls.h would not be needed - we could generate the externs
at the same time we generate the syscall table.

And yes, it's a high-squick approach.  I know and I'm not saying
it's a good idea.  OTOH, to quote the motto of philosophers and
shell game operators, "there's something in it"...

> For example this attempt at creating a new system call:
> 
>   SYSCALL_DEFINE3(moron, int, fd, loff_t, offset, size_t, count)
> 
> ... would translate into something like:
> 
> 	.name = "moron", .pattern = "WWW", .type = "int",    .size = 4,
> 	.name = NULL,                      .type = "loff_t", .size = 8,
> 	.name = NULL,                      .type = "size_t", .size = 4,
> 	.name = NULL,                      .type = NULL,     .size = 0,     /* end of parameter list */
> 
> i.e. "WDW". The build-time constraint checker could then warn about:
> 
>   # error: System call "moron" uses invalid 'WWW' argument mapping for a 'WDW' sequence
>   #        please avoid long-long arguments or use 'SYSCALL_DEFINE3_WDW()' instead

... if you do 32bit build.

> Each architecture can provide its own syscall parameter checking logic. Both 
> 'stack boundary' and parameter packing rules would be straightforward to express 
> if we had such a data structure.
> 
> Also note that this tool could also check for optimum packing, i.e. if the new 
> system call is defined as:
> 
>   SYSCALL_DEFINE3_WDW(moron, int, fd, loff_t, offset, size_t, count)

> Such tooling could also do other things, such as limit the C types used for system 
> call defines to a well-chosen set of ABI-safe types, such as:
> 
>       3  key_t
>       3  uint32_t
>       4  aio_context_t
>       4  mqd_t
>       4  timer_t
>      10  clockid_t
>      10  gid_t
>      10  loff_t
>      10  long
Uhhuh - ABI-safe is not how I would describe that.  Sodding PITA, fortunately
rare, is more like it...

>      10  old_gid_t
>      10  old_uid_t
>      10  umode_t
>      11  uid_t
>      31  pid_t
>      34  size_t
>      69  unsigned int
>     130  unsigned long
>     226  int
> 
> This would also allow us some cleanups as well, such as dropping the pointless 
> 'const' from arithmetic types in syscall definitions for example.
> 
> etc.
> 
> Basically this tool would be a secondary parser of the syscall arguments, with 
> most of the parsing and type sizing difficulties solved by the C parser already.
> 
> I think this problem could be much more sanely solved via annotations and a bit of 
> tooling, than trying to trick CPP into doing this for us (which won't really work 
> in any case).

See above.  It *can* be done.  Not by cpp alone, of course - you need compiler
involvement.
