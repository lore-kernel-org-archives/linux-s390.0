From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 3/6] fs: provide generic compat_sys_p{read,write}64() implementations
Date: Sun, 18 Mar 2018 10:40:22 -0700
Message-ID: <CA+55aFy3THY_nw7NNeUZYoGcszSDkGW-DFK0K063uFMUEO9w=g@mail.gmail.com>
References: <20180318161056.5377-1-linux@dominikbrodowski.net> <20180318161056.5377-4-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180318161056.5377-4-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Al Viro <viro@zeniv.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips <linux-mips@linux-mips.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, the arch/x86 maintainers <x86@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Honestly, I think the patches like this are disgusting:

On Sun, Mar 18, 2018 at 9:10 AM, Dominik Brodowski
<linux@dominikbrodowski.net> wrote:
> +#ifdef __ARCH_WANT_COMPAT_SYS_PREADWRITE64
> +#if defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +       defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE6(pread64, unsigned int, fd, char __user *, ubuf,
> +                      u32, count, u32, padding, u32, poslo, u32, poshi)
> +#elif defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +       !defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE6(pread64, unsigned int, fd, char __user *, ubuf,
> +                      u32, count, u32, padding, u32, poshi, u32, poslo)
> +#elif !defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +       defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE5(pread64, unsigned int, fd, char __user *, ubuf,
> +                      u32, count, u32, poslo, u32, poshi)
> +#else /* no padding, big endian */
> +COMPAT_SYSCALL_DEFINE5(pread64, unsigned int, fd, char __user *, ubuf,
> +                      u32, count, u32, poshi, u32, poslo)
> +#endif
> +{
> +#ifdef CONFIG_S390
> +       if ((compat_ssize_t) count < 0)
> +               return -EINVAL;
> +#endif /* CONFIG_S390 */

and we should just keep code like this entirely architecture-dependent.

It doesn't save all that many lines:

 19 files changed, 97 insertions(+), 106 deletions(-)

and the lines it adds are an unreadable mess compared to the lines it removes.

So please keep the high/low/padding stuff in the arch wrapper, and
just make them use "do_pwrite64()" and friends instead (or
"kern_pwrite64()", or whatever we ended up using as the kernel naming
for in-kernel system call wrappers).

                Linus
