From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
Date: Thu, 28 Apr 2016 22:19:14 +0300
Message-ID: <20160428191914.GA28527@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-21-git-send-email-ynorov@caviumnetworks.com>
 <20160426165701.GE8525@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160426165701.GE8525@e104818-lin.cambridge.arm.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, broonie@kernel.org, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, agraf@suse.de, klimov.linux@gmail.com, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, bamvor.zhangjian@huawei.com, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, Nathan_Lynch@mentor.com, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 26, 2016 at 05:57:01PM +0100, Catalin Marinas wrote:
> On Wed, Apr 06, 2016 at 01:08:42AM +0300, Yury Norov wrote:
> > +/* Using non-compat syscalls where necessary */
> > +#define compat_sys_fadvise64_64        sys_fadvise64_64
> > +#define compat_sys_fallocate           sys_fallocate
> > +#define compat_sys_ftruncate64         sys_ftruncate
> > +#define compat_sys_lookup_dcookie      sys_lookup_dcookie
> > +#define compat_sys_pread64             sys_pread64
> > +#define compat_sys_pwrite64            sys_pwrite64
> > +#define compat_sys_readahead           sys_readahead
> > +#define compat_sys_shmat               sys_shmat
> 
> Why don't we use compat_sys_shmat? Is it because of COMPAT_SHMLBA?

Yes. COMPAT_SHMLBA is 4 pages, and it's aarch32-only limitation.

> 
> > +#define compat_sys_sync_file_range     sys_sync_file_range
> > +#define compat_sys_truncate64          sys_truncate
> > +#define sys_llseek                     sys_lseek
> > +#define sys_mmap2		       sys_mmap
> 
> Nitpick: there are some whitespace inconsistencies above (just convert
> all spaces to tabs).
> 
> I think you should also update Documentation/arm64/ilp32.txt to include
> the list above.

OK

> 
> > +
> > +#include <asm/syscall.h>
> > +
> > +#undef __SYSCALL
> > +#undef __SC_COMP
> > +#undef __SC_WRAP
> > +#undef __SC_3264
> > +#undef __SC_COMP_3264
> 
> Minor detail: do we actually need to undef all these? Maybe we can get
> away with just defining __SYSCALL_COMPAT at the top of the file.
> 

Yes, we need. Otherwise we have circular dependency like this:
arch/arm64/kernel/sys_ilp32.c:60:0: warning: "__SC_WRAP" redefined
 #define __SC_WRAP(nr, sym) [nr] = compat_##sym,
  ^
  In file included from include/asm-generic/unistd.h:1:0,
                   from ./arch/arm64/include/uapi/asm/unistd.h:16,
                   from ./arch/arm64/include/asm/unistd.h:62,
                   from ./include/uapi/linux/unistd.h:7,
                   from include/linux/syscalls.h:23,
                   from arch/arm64/kernel/sys_ilp32.c:30:
include/uapi/asm-generic/unistd.h:33:0: note: this is the location of the previous definition
 #define __SC_WRAP __SYSCALL

Defining __SYSCALL_COMPAT at the top of the file does not help much.

> > +
> > +#define __SYSCALL_COMPAT
> > +#define __SYSCALL(nr, sym)	[nr] = sym,
> > +#define __SC_WRAP(nr, sym)	[nr] = compat_##sym,
> > +
> > +/*
> > + * The sys_call_ilp32_table array must be 4K aligned to be accessible from
> > + * kernel/entry.S.
> > + */
> > +void *sys_call_ilp32_table[__NR_syscalls] __aligned(4096) = {
> > +	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
> > +#include <asm/unistd.h>
> > +};
> 
> -- 
> Catalin
