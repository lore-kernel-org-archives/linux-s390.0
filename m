From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 4/6] mm: provide generic compat_sys_readahead() implementation
Date: Sun, 18 Mar 2018 11:06:42 -0700
Message-ID: <CA+55aFwuZCpAZRpsTGiUmG065ZHHpj+03_NeWiy-OGkMGw7e3g@mail.gmail.com>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net> <20180318174014.GR30522@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180318174014.GR30522@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips <linux-mips@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, the arch/x86 maintainers <x86@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Mar 18, 2018 at 10:40 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> *UGH*
>
> static inline compat_to_u64(u32 w0, u32 w1)
> {
> #ifdef __BIG_ENDIAN
>         return ((u64)w0 << 32) | w1;
> #else
>         return ((u64)w1 << 32) | w0;
> #endif
> }
>
> in compat.h, then this turns into
>
> #ifdef __ARCH_WANT_COMPAT_SYS_WITH_PADDING
> COMPAT_SYSCALL_DEFINE5(readahead, int, fd, unsigned int, padding,
>                        u32, off0, u32 off1,
>                        compat_size_t, count)
> #else
> COMPAT_SYSCALL_DEFINE4(readahead, int, fd,
>                        u32, off0, u32 off1,
>                        compat_size_t, count)
> #endif

No. This is still too ugly to live.

What *may* be acceptable is if architectures defined something like this:

x86:

    /* Little endian registers - low bits first, no padding for odd
register numbers necessary */
    #define COMPAT_ARG_64BIT(x) unsigned int x##_lo, unsigned int x##_hi
    #define COMPAT_ARG_64BIT_ODD(x) COMPAT_ARG_64BIT(x)

ppc BE:

    /* Big-endian registers - high bits first, odd argument pairs
padded up to the next even register */
    #define COMPAT_ARG_64BIT(x) unsigned int x##_hi, unsigned int x##_lo
    #define COMPAT_ARG_64BIT_ODD(x) unsigned int  x##_padding,
COMPAT_ARG_64BIT(x)

and then we can do

  COMPAT_SYSCALL_DEFINE5(readahead, int, fd,
COMPAT_ARG_64BIT_ODD(off), compat_size_t, count)
  {
      return do_readahead(fd, off_lo + ((u64)off_hi << 64), count);
  }

which at least looks reasonably legible, and has *zero* ifdef's anywhere.

I do *not* want to see those disgusting __ARCH_WANT_LE_COMPAT_SYS
things and crazy #ifdef's in code.

So either let the architectures do their own trivial wrappers
entirely, or do something clean like the above. Do *not* do
#ifdef'fery at the system call declaration time.

Also note that the "ODD" arguments may not be the ones that need
padding. I could easily see a system call argument numbering scheme
like

   r0 - system call number
   r1 - first argument
   r2 - second argument
   ...

and then it's the *EVEN* 64-bit arguments that would need the padding
(because they are actually odd in the register numbers). The above
COMPAT_ARG_64BIT[_ODD]() model allows for that too.

Of course, if some architecture then has some other arbitrary rules (I
could see register pairing rules that aren't the usual "even register"
ones), then such an architecture would really have to have its own
wrapper, but the above at least would handle the simple cases, and
doesn't look disgusting to use.

                   Linus

PS. It is possible that we should then add a

   #define COMPAT_ARG_64BIT_VAL(x) (x_##lo + ((u64)x_##hi << 32))

and then do

  COMPAT_SYSCALL_DEFINE5(readahead, int, fd,
COMPAT_ARG_64BIT_ODD(off), compat_size_t, count)
  {
      return do_readahead(fd, COMPAT_ARG_64BIT_VAL(off), count);
  }

because then we could perhaps generate the *non*compat system calls
this way too, just using

    #define COMPAT_ARG_64BIT(x) unsigned long x
    #define COMPAT_ARG_64BIT_VAL(x) (x)

instead (there might also be a "compat" mode that actually has access
to 64-bit registers, like x32 does, but I suspect it would have other
issues).
