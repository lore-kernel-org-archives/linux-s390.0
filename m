From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
Date: Tue, 26 Apr 2016 17:57:01 +0100
Message-ID: <20160426165701.GE8525@e104818-lin.cambridge.arm.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-21-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1459894127-17698-21-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, broonie@kernel.org, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, agraf@suse.de, klimov.linux@gmail.com, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, bamvor.zhangjian@huawei.com, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, Nathan_Lynch@mentor.com, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, Apr 06, 2016 at 01:08:42AM +0300, Yury Norov wrote:
> +/* Using non-compat syscalls where necessary */
> +#define compat_sys_fadvise64_64        sys_fadvise64_64
> +#define compat_sys_fallocate           sys_fallocate
> +#define compat_sys_ftruncate64         sys_ftruncate
> +#define compat_sys_lookup_dcookie      sys_lookup_dcookie
> +#define compat_sys_pread64             sys_pread64
> +#define compat_sys_pwrite64            sys_pwrite64
> +#define compat_sys_readahead           sys_readahead
> +#define compat_sys_shmat               sys_shmat

Why don't we use compat_sys_shmat? Is it because of COMPAT_SHMLBA?

> +#define compat_sys_sync_file_range     sys_sync_file_range
> +#define compat_sys_truncate64          sys_truncate
> +#define sys_llseek                     sys_lseek
> +#define sys_mmap2		       sys_mmap

Nitpick: there are some whitespace inconsistencies above (just convert
all spaces to tabs).

I think you should also update Documentation/arm64/ilp32.txt to include
the list above.

> +
> +#include <asm/syscall.h>
> +
> +#undef __SYSCALL
> +#undef __SC_COMP
> +#undef __SC_WRAP
> +#undef __SC_3264
> +#undef __SC_COMP_3264

Minor detail: do we actually need to undef all these? Maybe we can get
away with just defining __SYSCALL_COMPAT at the top of the file.

> +
> +#define __SYSCALL_COMPAT
> +#define __SYSCALL(nr, sym)	[nr] = sym,
> +#define __SC_WRAP(nr, sym)	[nr] = compat_##sym,
> +
> +/*
> + * The sys_call_ilp32_table array must be 4K aligned to be accessible from
> + * kernel/entry.S.
> + */
> +void *sys_call_ilp32_table[__NR_syscalls] __aligned(4096) = {
> +	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
> +#include <asm/unistd.h>
> +};

-- 
Catalin
