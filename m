From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 2/6] fs: provide a generic compat_sys_truncate64() implementation
Date: Sun, 18 Mar 2018 11:21:26 -0700
Message-ID: <CA+55aFz+WARfpwuWmr+-F1tDVzoyWpN9naZJfTq25Q2WT=9CyQ@mail.gmail.com>
References: <20180318161056.5377-1-linux@dominikbrodowski.net> <20180318161056.5377-3-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180318161056.5377-3-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips <linux-mips@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, the arch/x86 maintainers <x86@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sun, Mar 18, 2018 at 9:10 AM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> +#ifdef __ARCH_WANT_COMPAT_SYS_TRUNCATE64
> +#if defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +       defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE4(truncate64, const char __user *, filename, u32 padding,
> +                      unsigned int, offset_low, unsigned int, offset_high)
> +#elif defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +       !defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE4(truncate64, const char __user *, filename, u32 padding,
> +                      unsigned int, offset_high, unsigned int, offset_low)
> +#elif !defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +       defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, filename,
> +                      unsigned int, offset_low, unsigned int, offset_high)
> +#else /* no padding, big endian */
> +COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, filename,
> +                      unsigned int, offset_high, unsigned int, offset_low)
> +#endif
> +{
> +#ifdef CONFIG_SPARC
> +       if ((int) offset_high < 0)
> +               return -EINVAL;
> +#endif
> +       return do_sys_truncate(filename,
> +                              ((loff_t) offset_high << 32) | offset_low);
> +}
> +#endif /* __ARCH_WANT_COMPAT_SYS_TRUNCATE64 */

This really screams out for a sparc-specific wrapper, or maybe that
#ifdef CONFIG_SPARC should just happen for everybody.

But regardless, code like the above is completely unacceptable.

And yes, it also shows that my suggested alternative doesn't really
work, because of the way the padding changes the number of arguments,
giving that whole COMPAT_SYSCALL_DEFINE 3-vs-4 argument version.

So I think just making it be arch-specific is the right thing.

Alternatively, the COMPAT_SYSCALL_DEFINE() macro could be made smarter
and do self-counting. There are generally tricks to count macro
arguments, particularly when you know that they are limited. Things
like

    #define NARG(...) __NARG(__VA_ARGS__##, 6,5,4,3,2,1)
    #define _NARG(a,b,c,d,e,f,...) f

or something (I may have screwed that up, you get the idea).

                Linus
