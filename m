Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 19 Jun 2020 16:17:17 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2] s390: fix build error for sys_call_table_emu
Message-ID: <20200619141717.GB9971@osiris>
References: <20200618141426.16884-1-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618141426.16884-1-nixiaoming@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Xiaoming Ni <nixiaoming@huawei.com>
Cc: acme@kernel.org, alexander.shishkin@linux.intel.com, arnd@arndb.de, borntraeger@de.ibm.com, catalin.marinas@arm.com, christian@brauner.io, cyphar@cyphar.com, dhowells@redhat.com, ebiederm@xmission.com, fenghua.yu@intel.com, geert@linux-m68k.org, gor@linux.ibm.com, ink@jurassic.park.msu.ru, jolsa@redhat.com, linux@armlinux.org.uk, lkp@intel.com, mark.rutland@arm.com, mattst88@gmail.com, minchan@kernel.org, mingo@redhat.com, monstr@monstr.eu, namhyung@kernel.org, peterz@infradead.org, rth@twiddle.net, sargun@sargun.me, sfr@canb.auug.org.au, tony.luck@intel.com, will@kernel.org, akpm@linux-foundation.org, alex.huangjianhui@huawei.com, zhongjubin@huawei.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, clang-built-linux@googlegroups.com, kbuild-all@lists.01.org, linux-mm@kvack.org

On Thu, Jun 18, 2020 at 10:14:26PM +0800, Xiaoming Ni wrote:
> Build error on s390:
> 	arch/s390/kernel/entry.o: in function `sys_call_table_emu':
> 	>> (.rodata+0x1288): undefined reference to `__s390_'
> 
> In commit ("All arch: remove system call sys_sysctl")
>  148  common	fdatasync		sys_fdatasync			sys_fdatasync
> -149  common	_sysctl			sys_sysctl			compat_sys_sysctl
> +149  common	_sysctl			sys_ni_syscall
>  150  common	mlock			sys_mlock			sys_mlock
> 
> After the patch is integrated, there is a format error in the generated
> arch/s390/include/generated/asm/syscall_table.h:
> 	SYSCALL(sys_fdatasync, sys_fdatasync)
> 	SYSCALL(sys_ni_syscall,) /* cause build error */
> 	SYSCALL(sys_mlock,sys_mlock)
> 
> According to the guidance of Heiko Carstens, use "-" to fill the empty system call
>  Similarly, modify tools/perf/arch/s390/entry/syscalls/syscall.tbl.
> 
> Fixes: ("All arch: remove system call sys_sysctl")
> Fixes: https://lore.kernel.org/linuxppc-dev/20200616030734.87257-1-nixiaoming@huawei.com/
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> 
> changes in v2:
> 	use "-" to fill the empty system call
> 
> v1: https://lore.kernel.org/lkml/20200618110320.104013-1-nixiaoming@huawei.com/
> ---
>  arch/s390/kernel/syscalls/syscall.tbl           | 2 +-
>  tools/perf/arch/s390/entry/syscalls/syscall.tbl | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
