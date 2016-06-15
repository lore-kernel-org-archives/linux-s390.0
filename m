From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 16/23] arm64: ilp32: introduce binfmt_ilp32.c
Date: Wed, 15 Jun 2016 03:40:19 +0300
Message-ID: <20160615004019.GA20783@yury-N73SV>
References: <5746FEF6.9070405@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <libc-alpha-return-70641-glibc-alpha=m.gmane.org@sourceware.org>
List-Unsubscribe: <mailto:libc-alpha-unsubscribe-glibc-alpha=m.gmane.org@sourceware.org>
List-Subscribe: <mailto:libc-alpha-subscribe@sourceware.org>
List-Archive: <http://sourceware.org/ml/libc-alpha/>
List-Post: <mailto:libc-alpha@sourceware.org>
List-Help: <mailto:libc-alpha-help@sourceware.org>, <http://sourceware.org/ml/#faqs>
Sender: libc-alpha-owner@sourceware.org
Content-Disposition: inline
In-Reply-To: <5746FEF6.9070405@huawei.com>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Cc: arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, Hanjun Guo <guohanjun@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 26, 2016 at 09:49:42PM +0800, Zhangjian (Bamvor) wrote:
> Hi, yury
> 
> The coredump is usable in our platform. It miss the following definition:
> +#define compat_elf_greg_t	elf_greg_t
> +#define compat_elf_gregset_t	elf_gregset_t
> 
> And it leads to the wrong register save in core dump. After apply this patch,
> gdb could debug core dump files.
> 
> Here is the full patch:
> From 102624840aa5dacdd1bbfe3b390290f52f530ea2 Mon Sep 17 00:00:00 2001
> From: Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>
> Date: Thu, 26 May 2016 21:00:16 +0800
> Subject: [PATCH hulk-4.1-next] arm64: ilp32: fix coredump issue
> 
> ILP32 use aarch64 register and 32bit signal struct which means it
> could not make use of the existing compat_elf_prstatus/elf_prstatus
> and compat_elf_prpsinfo/elf_prpsinfo.
> 
> This patch fix this issue by introducing the different
> compat_elf_greg_t, compat_elf_gregset_t for aarch64 ilp32 and aarch32
> el0.
> 
> Tested pass on huawei's hardware in bigendian.
> 
> Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>
> ---
>  arch/arm64/include/asm/elf.h     | 14 +++++++-------
>  arch/arm64/kernel/binfmt_elf32.c |  3 +++
>  arch/arm64/kernel/binfmt_ilp32.c |  8 +++++++-
>  arch/arm64/kernel/ptrace.c       | 20 ++++++++++----------
>  4 files changed, 27 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
> index 0106d18..9019441 100644
> --- a/arch/arm64/include/asm/elf.h
> +++ b/arch/arm64/include/asm/elf.h
> @@ -154,18 +154,18 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
>  				       int uses_interp);
> 
>  /* 1GB of VA */
> -#define STACK_RND_MASK			(is_compat_task() ? \
> -						0x7ff >> (PAGE_SHIFT - 12) : \
> -						0x3ffff >> (PAGE_SHIFT - 12))
> +#define STACK_RND_MASK		(is_compat_task() ? \
> +					0x7ff >> (PAGE_SHIFT - 12) : \
> +					0x3ffff >> (PAGE_SHIFT - 12))
> 
>  #ifdef CONFIG_COMPAT
> 
> -#define COMPAT_ELF_ET_DYN_BASE		(2 * TASK_SIZE_32 / 3)
> +#define COMPAT_ELF_ET_DYN_BASE	(2 * TASK_SIZE_32 / 3)
> 
>  /* AArch32 registers. */
> -#define COMPAT_ELF_NGREG		18
> -typedef unsigned int			compat_elf_greg_t;
> -typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
> +#define COMPAT_ELF_NGREG	18
> +typedef unsigned int		compat_a32_elf_greg_t;
> +typedef compat_a32_elf_greg_t	compat_a32_elf_gregset_t[COMPAT_ELF_NGREG];
> 
>  #endif /* CONFIG_COMPAT */
> 
> diff --git a/arch/arm64/kernel/binfmt_elf32.c b/arch/arm64/kernel/binfmt_elf32.c
> index 7b9b445..f75253c 100644
> --- a/arch/arm64/kernel/binfmt_elf32.c
> +++ b/arch/arm64/kernel/binfmt_elf32.c
> @@ -31,4 +31,7 @@ struct linux_binprm;
>  extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
>  				      int uses_interp);
> 
> +#define compat_elf_greg_t	compat_a32_elf_greg_t
> +#define compat_elf_gregset_t	compat_a32_elf_gregset_t
> +
>  #include "../../../fs/compat_binfmt_elf.c"
> diff --git a/arch/arm64/kernel/binfmt_ilp32.c b/arch/arm64/kernel/binfmt_ilp32.c
> index b827a9a..01baf83 100644
> --- a/arch/arm64/kernel/binfmt_ilp32.c
> +++ b/arch/arm64/kernel/binfmt_ilp32.c
> @@ -2,7 +2,9 @@
>   * Support for ILP32 Linux/aarch64 ELF binaries.
>   */
> 
> -#include <linux/elfcore-compat.h>
> +#include <linux/elf.h>
> +#include <linux/elfcore.h>
> +#include <linux/compat.h>
>  #include <linux/time.h>
> 
>  #undef	ELF_CLASS
> @@ -30,9 +32,13 @@
>   * The machine-dependent core note format types are defined in elfcore-compat.h,
>   * which requires asm/elf.h to define compat_elf_gregset_t et al.
>   */
> +#define compat_elf_greg_t	elf_greg_t
> +#define compat_elf_gregset_t	elf_gregset_t
>  #define elf_prstatus	compat_elf_prstatus
>  #define elf_prpsinfo	compat_elf_prpsinfo
> 
> +#include <linux/elfcore-compat.h>
> +
>  /*
>   * Compat version of cputime_to_compat_timeval, perhaps this
>   * should be an inline in <linux/compat.h>.
> diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
> index 5c86135..9784c77 100644
> --- a/arch/arm64/kernel/ptrace.c
> +++ b/arch/arm64/kernel/ptrace.c
> @@ -913,8 +913,8 @@ static const struct user_regset aarch32_regsets[] = {
>  	[REGSET_COMPAT_GPR] = {
>  		.core_note_type = NT_PRSTATUS,
>  		.n = COMPAT_ELF_NGREG,
> -		.size = sizeof(compat_elf_greg_t),
> -		.align = sizeof(compat_elf_greg_t),
> +		.size = sizeof(compat_a32_elf_greg_t),
> +		.align = sizeof(compat_a32_elf_greg_t),
>  		.get = compat_gpr_get,
>  		.set = compat_gpr_set
>  	},
> @@ -947,7 +947,7 @@ static int compat_ptrace_read_user(struct task_struct *tsk, compat_ulong_t off,
>  		tmp = tsk->mm->start_data;
>  	else if (off == COMPAT_PT_TEXT_END_ADDR)
>  		tmp = tsk->mm->end_code;
> -	else if (off < sizeof(compat_elf_gregset_t))
> +	else if (off < sizeof(compat_a32_elf_gregset_t))
>  		return copy_regset_to_user(tsk, &user_aarch32_view,
>  					   REGSET_COMPAT_GPR, off,
>  					   sizeof(compat_ulong_t), ret);
> @@ -968,7 +968,7 @@ static int compat_ptrace_write_user(struct task_struct *tsk, compat_ulong_t off,
>  	if (off & 3 || off >= COMPAT_USER_SZ)
>  		return -EIO;
> 
> -	if (off >= sizeof(compat_elf_gregset_t))
> +	if (off >= sizeof(compat_a32_elf_gregset_t))
>  		return 0;
> 
>  	set_fs(KERNEL_DS);
> @@ -1116,9 +1116,11 @@ static long compat_a32_ptrace(struct task_struct *child, compat_long_t request,
>  	unsigned long addr = caddr;
>  	unsigned long data = cdata;
>  	void __user *datap = compat_ptr(data);
> +	unsigned int pr_reg_size = sizeof(compat_a32_elf_gregset_t);
>  	int ret;
> 
>  	switch (request) {
> +
>  		case PTRACE_PEEKUSR:
>  			ret = compat_ptrace_read_user(child, addr, datap);
>  			break;
> @@ -1130,17 +1132,15 @@ static long compat_a32_ptrace(struct task_struct *child, compat_long_t request,
>  		case COMPAT_PTRACE_GETREGS:
>  			ret = copy_regset_to_user(child,
>  						  &user_aarch32_view,
> -						  REGSET_COMPAT_GPR,
> -						  0, sizeof(compat_elf_gregset_t),
> -						  datap);
> +						  REGSET_COMPAT_GPR, 0,
> +						  pr_reg_size, datap);
>  			break;
> 
>  		case COMPAT_PTRACE_SETREGS:
>  			ret = copy_regset_from_user(child,
>  						    &user_aarch32_view,
> -						    REGSET_COMPAT_GPR,
> -						    0, sizeof(compat_elf_gregset_t),
> -						    datap);
> +						    REGSET_COMPAT_GPR, 0,
> +						    pr_reg_size, datap);
>  			break;
> 
>  		case COMPAT_PTRACE_GET_THREAD_AREA:

Hi Bamvor,

I didn't work much with ilp32 debugging and coredumps yet, but what I
see in your patch is an attempt to use elf_gregset_t in compat_elf_prstatus
for ilp32 instead of compat_elf_gregset_t.

I think we can do it simpler. That's what pahole shows for binfmt_ilp32.o
after applying the attached patch:

struct compat_elf_prstatus {
        struct compat_elf_siginfo  pr_info;              /*     0    12 */
        short int                  pr_cursig;            /*    12     2 */

        /* XXX 2 bytes hole, try to pack */

        compat_ulong_t             pr_sigpend;           /*    16     4 */
        compat_ulong_t             pr_sighold;           /*    20     4 */
        compat_pid_t               pr_pid;               /*    24     4 */
        compat_pid_t               pr_ppid;              /*    28     4 */
        compat_pid_t               pr_pgrp;              /*    32     4 */
        compat_pid_t               pr_sid;               /*    36     4 */
        struct compat_timeval      pr_utime;             /*    40     8 */
        struct compat_timeval      pr_stime;             /*    48     8 */
        struct compat_timeval      pr_cutime;            /*    56     8 */
        /* --- cacheline 1 boundary (64 bytes) --- */
        struct compat_timeval      pr_cstime;            /*    64     8 */
        elf_gregset_t              pr_reg;               /*    72   272 */
        /* --- cacheline 5 boundary (320 bytes) was 24 bytes ago --- */
        compat_int_t               pr_fpvalid;           /*   344     4 */

        /* size: 352, cachelines: 6, members: 14 */
        /* sum members: 346, holes: 1, sum holes: 2 */
        /* padding: 4 */
        /* last cacheline: 32 bytes */
};

Did I miss something?
---
 arch/arm64/include/asm/elf.h     | 6 ++++++
 arch/arm64/kernel/binfmt_ilp32.c | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index a967726..4dcbcec 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -174,10 +174,16 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
 
 #define COMPAT_ELF_ET_DYN_BASE		(2 * TASK_SIZE_32 / 3)
 
+#ifndef USE_AARCH64_GREG
 /* AArch32 registers. */
 #define COMPAT_ELF_NGREG		18
 typedef unsigned int			compat_elf_greg_t;
 typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
+#else /* AArch64 registers for AARCH64/ILP32 */
+#define COMPAT_ELF_NGREG	ELF_NGREG
+#define compat_elf_greg_t	elf_greg_t
+#define compat_elf_gregset_t	elf_gregset_t
+#endif
 
 /* AArch32 EABI. */
 #define EF_ARM_EABI_MASK		0xff000000
diff --git a/arch/arm64/kernel/binfmt_ilp32.c b/arch/arm64/kernel/binfmt_ilp32.c
index b2bd590..416b3f5 100644
--- a/arch/arm64/kernel/binfmt_ilp32.c
+++ b/arch/arm64/kernel/binfmt_ilp32.c
@@ -1,6 +1,7 @@
 /*
  * Support for ILP32 Linux/aarch64 ELF binaries.
  */
+#define USE_AARCH64_GREG
 
 #include <linux/elfcore-compat.h>
 #include <linux/time.h>
-- 
2.7.4
