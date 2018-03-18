From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC PATCH 4/6] mm: provide generic compat_sys_readahead()
 implementation
Date: Sun, 18 Mar 2018 18:18:48 +0000
Message-ID: <20180318181848.GU30522@ZenIV.linux.org.uk>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net>
 <20180318174014.GR30522@ZenIV.linux.org.uk>
 <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips <linux-mips@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, the arch/x86 maintainers <x86@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Mar 18, 2018 at 11:06:42AM -0700, Linus Torvalds wrote:

> and then we can do
> 
>   COMPAT_SYSCALL_DEFINE5(readahead, int, fd,
> COMPAT_ARG_64BIT_ODD(off), compat_size_t, count)
>   {
>       return do_readahead(fd, off_lo + ((u64)off_hi << 64), count);
>   }
> 
> which at least looks reasonably legible, and has *zero* ifdef's anywhere.

It's a bit more complicated, but...

> I do *not* want to see those disgusting __ARCH_WANT_LE_COMPAT_SYS
> things and crazy #ifdef's in code.

Absolutely.  Those piles of ifdefs are unreadable garbage.

> So either let the architectures do their own trivial wrappers
> entirely, or do something clean like the above. Do *not* do
> #ifdef'fery at the system call declaration time.
> 
> Also note that the "ODD" arguments may not be the ones that need
> padding. I could easily see a system call argument numbering scheme
> like
> 
>    r0 - system call number
>    r1 - first argument
>    r2 - second argument
>    ...
> 
> and then it's the *EVEN* 64-bit arguments that would need the padding
> (because they are actually odd in the register numbers). The above
> COMPAT_ARG_64BIT[_ODD]() model allows for that too.
> 
> Of course, if some architecture then has some other arbitrary rules (I
> could see register pairing rules that aren't the usual "even register"
> ones), then such an architecture would really have to have its own
> wrapper, but the above at least would handle the simple cases, and
> doesn't look disgusting to use.

I'd done some digging in that area, will find the notes and post.
Basically, we can even avoid the odd/even annotations and have
COMPAT_SYSCALL_DEFINE... sort it out.  It's a bit more hairy than
I would like at this stage in the cycle, though.  I'll see if it can
be done without too much PITA.

However, there still are genuinely speci^Wfucked in head cases - see
e.g. this sad story:
commit ab8a261ba5e2dd9206da640de5870cc31d568a7c
Author: Helge Deller <deller@gmx.de>
Date:   Thu Jul 10 18:07:17 2014 +0200

    parisc: fix fanotify_mark() syscall on 32bit compat kernel

Those certainly ought to stay in arch/*
