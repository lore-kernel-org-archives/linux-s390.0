From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC PATCH 4/6] mm: provide generic compat_sys_readahead()
 implementation
Date: Sun, 18 Mar 2018 17:40:14 +0000
Message-ID: <20180318174014.GR30522@ZenIV.linux.org.uk>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-5-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180318161056.5377-5-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, Mar 18, 2018 at 05:10:54PM +0100, Dominik Brodowski wrote:

> +#ifdef __ARCH_WANT_COMPAT_SYS_READAHEAD
> +#if defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE5(readahead, int, fd, unsigned int, padding,
> +		       unsigned int, off_lo, unsigned int, off_hi,
> +		       size_t, count)
> +#elif defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	!defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE5(readahead, int, fd, unsigned int, padding,
> +		       unsigned int, off_hi, unsigned int, off_lo,
> +		       size_t, count)
> +#elif !defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE4(readahead, int, fd,
> +		       unsigned int, off_lo, unsigned int, off_hi,
> +		       size_t, count)
> +#else /* no padding, big endian */
> +COMPAT_SYSCALL_DEFINE4(readahead, int, fd,
> +		       unsigned int, off_hi, unsigned int, off_lo,
> +		       size_t, count)
> +#endif
> +{
> +	return do_readahead(fd, ((u64) off_hi << 32) | off_lo, count);
>  }

*UGH*

static inline compat_to_u64(u32 w0, u32 w1)
{
#ifdef __BIG_ENDIAN
	return ((u64)w0 << 32) | w1;
#else
	return ((u64)w1 << 32) | w0;
#endif
}

in compat.h, then this turns into

#ifdef __ARCH_WANT_COMPAT_SYS_WITH_PADDING
COMPAT_SYSCALL_DEFINE5(readahead, int, fd, unsigned int, padding,
		       u32, off0, u32 off1,
		       compat_size_t, count)
#else
COMPAT_SYSCALL_DEFINE4(readahead, int, fd,
		       u32, off0, u32 off1,
		       compat_size_t, count)
#endif
{
	return do_readahead(fd, compat_to_u64(off0, off1), count);
}
