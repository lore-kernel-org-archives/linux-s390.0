From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
Date: Mon, 16 May 2016 18:06:05 +0100
Message-ID: <20160516170605.GB19290@e104818-lin.cambridge.arm.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-21-git-send-email-ynorov@caviumnetworks.com>
 <20160514150352.GA30533@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160514150352.GA30533@yury-N73SV>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, heiko.carstens@de.ibm.com, linux-doc@vger.kernel.org, Nathan_Lynch@mentor.com, agraf@suse.de, klimov.linux@gmail.com, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, broonie@kernel.org, bamvor.zhangjian@huawei.com, Andrew Pinski <apinski@cavium.com>, schwab@suse.de, schwidefsky@de.ibm.com, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Sat, May 14, 2016 at 06:03:52PM +0300, Yury Norov wrote:
> +SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
> +       unsigned long, prot, unsigned long, flags, unsigned long, fd,
> +       unsigned long, pgoff)

To avoid the types confusion we could add __SC_WRAP to mmap2 in unistd.h
and use COMPAT_SYSCALL_DEFINE6 here (together with compat_ptr_t etc.).

> +{
> +       if (pgoff & (~PAGE_MASK >> 12))
> +               return -EINVAL;
> +
> +       return sys_mmap_pgoff((compat_uptr_t) addr, (compat_size_t) len,
> +		       (int) prot, (int) flags, (int) fd,
> +		       pgoff >> (PAGE_SHIFT-12));

Then we wouldn't need the explicit casting here.

> +}
> +
> +COMPAT_SYSCALL_DEFINE4(pread64, unsigned int, fd, compat_uptr_t __user *, ubuf,
> +		       compat_size_t, count, off_t, offset)
> +{
> +	return sys_pread64(fd, (char *) ubuf, count, offset);
> +}
> +
> +COMPAT_SYSCALL_DEFINE4(pwrite64, unsigned int, fd, compat_uptr_t __user *, ubuf,
> +		       compat_size_t, count, off_t, offset)
> +{
> +	return sys_pwrite64(fd, (char *) ubuf, count, offset);

Nitpick: no space between cast type and variable name: (char *)ubuf, ...

We can also make these functions static as they are not used outside
this file.

-- 
Catalin
