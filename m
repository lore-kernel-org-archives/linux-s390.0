From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 18/23] arm64: ilp32: add sys_ilp32.c and a separate table (in entry.S) to use it
Date: Wed, 25 May 2016 22:26:54 +0200
Message-ID: <4731114.hBXBvkC8xh@wuerfel>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com> <1464048292-30136-19-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <1464048292-30136-19-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, bamvor.zhangjian@huawei.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, Andrew Pinski <apinski@cavium.com>, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
List-ID: <linux-s390.vger.kernel.org>

On Tuesday, May 24, 2016 3:04:47 AM CEST Yury Norov wrote:
> +static unsigned long compat_sys_mmap2(compat_uptr_t addr, compat_size_t len,
> +       int prot, int flags, int fd, off_t pgoff)
> +{
> +       if (pgoff & (~PAGE_MASK >> 12))
> +               return -EINVAL;
> +
> +       return sys_mmap_pgoff(addr, len, prot, flags, fd,
> +                      pgoff >> (PAGE_SHIFT - 12));
> +}
> +
> +static unsigned long compat_sys_pread64(unsigned int fd,
> +               compat_uptr_t __user *ubuf, compat_size_t count, off_t offset)
> +{
> +       return sys_pread64(fd, (char *) ubuf, count, offset);
> +}
> +
> +static unsigned long compat_sys_pwrite64(unsigned int fd,
> +               compat_uptr_t __user *ubuf, compat_size_t count, off_t offset)
> +{
> +       return sys_pwrite64(fd, (char *) ubuf, count, offset);
> +}
> 

The use of compat_uptr_t seems inconsistent here, and neither of the two
ways of doing it is what we do elsewhere. compat_uptr_t is meant to
be a scalar 32-bit type that gets converted into a pointer using the
compat_ptr() macro, so compat_sys_mmap2 should not use compat_ptr_t
(we don't access it as a pointer in mmap_pgoff) but compat_ulong_t,
and compat_sys_pread64() should have a compat_uptr_t argument, not
pointer to compat_uptr_t.

	Arnd
