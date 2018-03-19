From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 4/6] mm: provide generic compat_sys_readahead()
 implementation
Date: Mon, 19 Mar 2018 10:29:20 +0100
Message-ID: <20180319092920.tbh2xwkruegshzqe@gmail.com>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net>
 <20180318174014.GR30522@ZenIV.linux.org.uk>
 <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
 <20180318181848.GU30522@ZenIV.linux.org.uk>
 <20180319042300.GW30522@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180319042300.GW30522@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips <linux-mips@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>
List-ID: <linux-s390.vger.kernel.org>


* Al Viro <viro@ZenIV.linux.org.uk> wrote:

> On Sun, Mar 18, 2018 at 06:18:48PM +0000, Al Viro wrote:
> 
> > I'd done some digging in that area, will find the notes and post.
> 
> OK, found:

Very nice writeup - IMHO this should go into Documentation/!

> OTOH, consider arm.  There we have
> 	* r0, r1, r2, r3, [sp,#8], [sp,#12], [sp,#16]... is the sequence
> of objects used to pass arguments
> 	* 32bit and less - pick the next available slot
> 	* 64bit - skip a slot if we'd already taken an odd number, then use
> the next two slots for lower and upper 32 bits of the argument.
> 
> So our classes take
> simple n-argument:	0 to 6 slots
> WD			4 slots
> DWW			4 slots
> WDW			5 slots
> WWDD			6 slots
> WDWW			5 slots
> WWWD			6 slots
> WWDWW			6 slots
> WDDW			7 slots (!)  Also ****, !!!!, !@#!@#!@#!# and other nice
> and well-deserved comments from arch maintainers, some of them even printable:
> /* It would be nice if people remember that not all the world's an i386
>    when they introduce new system calls */
> SYSCALL_DEFINE4(sync_file_range2, int, fd, unsigned int, flags,
>                                  loff_t, offset, loff_t, nbytes)

Such idiosyncratic platform quirks that have an impact on generic code should be 
as self-maintaining as possible: i.e. there should be a build time warning even on 
x86 if someone introduces a new, suboptimally packed system call.

Otherwise we'll have such incidents again and again as new system calls get added.

> [snip the preprocessor horrors - the sketches I've got there are downright obscene]

I still think we should consider creating a generic facility and a tool: which 
would immediately and automatically add new system calls to *every* architecture - 
or which would initially at least check these syscall ABI constraints.

I.e. this would start with a new generic kernel facility that warns about 
suboptimal new system call argument layouts on every architecture, not just on the 
affected ones.

That's a significant undertaking but should be possible to do.

Once such a facility is in place all the existing old mess is still a PITA, but 
should be manageable eventually - as no new mess is added to it.

IMHO that's the only thing that could break the somewhat deadly current dynamic of 
system call mappings mess. Complaining about people not knowing about quirks won't 
help.

One way to implement this would be to put the argument chain types (string) and 
sizes (int) into a special debug section which isn't included in the final kernel 
image but which can be checked at link time.

For example this attempt at creating a new system call:

  SYSCALL_DEFINE3(moron, int, fd, loff_t, offset, size_t, count)

... would translate into something like:

	.name = "moron", .pattern = "WWW", .type = "int",    .size = 4,
	.name = NULL,                      .type = "loff_t", .size = 8,
	.name = NULL,                      .type = "size_t", .size = 4,
	.name = NULL,                      .type = NULL,     .size = 0,     /* end of parameter list */

i.e. "WDW". The build-time constraint checker could then warn about:

  # error: System call "moron" uses invalid 'WWW' argument mapping for a 'WDW' sequence
  #        please avoid long-long arguments or use 'SYSCALL_DEFINE3_WDW()' instead

Each architecture can provide its own syscall parameter checking logic. Both 
'stack boundary' and parameter packing rules would be straightforward to express 
if we had such a data structure.

Also note that this tool could also check for optimum packing, i.e. if the new 
system call is defined as:

  SYSCALL_DEFINE3_WDW(moron, int, fd, loff_t, offset, size_t, count)

... would translate to something like:

	.name = "moron", .pattern = "WDW", .type = "int",    .size = 4,
	.name = NULL,                      .type = "loff_t", .size = 8,
	.name = NULL,                      .type = "size_t", .size = 4,
	.name = NULL,                      .type = NULL,     .size = 0,     /* end of parameter list */

where the tool would print out this error:

  # error: System call "moron" uses suboptimal 'WDW' argument mapping instead of 'WWD'

there would be a whitelist of existing system calls that are already using an 
suboptimal argument order - but the warnings/errors would trigger for all new 
system calls.

But adding non-straight-mapped system calls would be the exception in any case.

Such tooling could also do other things, such as limit the C types used for system 
call defines to a well-chosen set of ABI-safe types, such as:

      3  key_t
      3  uint32_t
      4  aio_context_t
      4  mqd_t
      4  timer_t
     10  clockid_t
     10  gid_t
     10  loff_t
     10  long
     10  old_gid_t
     10  old_uid_t
     10  umode_t
     11  uid_t
     31  pid_t
     34  size_t
     69  unsigned int
    130  unsigned long
    226  int

This would also allow us some cleanups as well, such as dropping the pointless 
'const' from arithmetic types in syscall definitions for example.

etc.

Basically this tool would be a secondary parser of the syscall arguments, with 
most of the parsing and type sizing difficulties solved by the C parser already.

I think this problem could be much more sanely solved via annotations and a bit of 
tooling, than trying to trick CPP into doing this for us (which won't really work 
in any case).

Thanks,

	Ingo
