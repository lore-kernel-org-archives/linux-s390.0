From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [RFC PATCH 2/6] fs: provide a generic compat_sys_truncate64()
 implementation
Date: Sun, 18 Mar 2018 17:49:56 +0000
Message-ID: <20180318174956.GS30522@ZenIV.linux.org.uk>
References: <20180318161056.5377-1-linux@dominikbrodowski.net>
 <20180318161056.5377-3-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180318161056.5377-3-linux@dominikbrodowski.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, arnd@arndb.de, linux-arch@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Jiri Slaby <jslaby@suse.com>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Sun, Mar 18, 2018 at 05:10:52PM +0100, Dominik Brodowski wrote:

> +#ifdef __ARCH_WANT_COMPAT_SYS_TRUNCATE64
> +#if defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE4(truncate64, const char __user *, filename, u32 padding,
> +		       unsigned int, offset_low, unsigned int, offset_high)
> +#elif defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	!defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE4(truncate64, const char __user *, filename, u32 padding,
> +		       unsigned int, offset_high, unsigned int, offset_low)
> +#elif !defined(__ARCH_WANT_COMPAT_SYS_WITH_PADDING) && \
> +	defined(__ARCH_WANT_LE_COMPAT_SYS)
> +COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, filename,
> +		       unsigned int, offset_low, unsigned int, offset_high)
> +#else /* no padding, big endian */
> +COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, filename,
> +		       unsigned int, offset_high, unsigned int, offset_low)
> +#endif
> +{
> +#ifdef CONFIG_SPARC
> +	if ((int) offset_high < 0)
> +		return -EINVAL;
> +#endif
> +	return do_sys_truncate(filename,
> +			       ((loff_t) offset_high << 32) | offset_low);
> +}
> +#endif /* __ARCH_WANT_COMPAT_SYS_TRUNCATE64 */

Ow...

For one thing, the same observation as for readahead(2).  For another, that
sparc-specific test is very suspicious, innit?  Let's take a look at
do_sys_truncate():
static long do_sys_truncate(const char __user *pathname, loff_t length)
{
        unsigned int lookup_flags = LOOKUP_FOLLOW;
        struct path path;
        int error;

        if (length < 0) /* sorry, but loff_t says... */
                return -EINVAL;

So in case of offset_high having bit 31 set, we would get length with bit 63 set,
and step into that if (length < 0) return -EINVAL;

Sure, any set of texts can be combined, given a sufficiently large pile of ifdefs,
but you are replacing an arseload of almost but not quite identical functions
spread all over the tree with something that is in one place, but is awfully hard
to look at, nevermind reading it...
