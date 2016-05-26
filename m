From: "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
Subject: Re: [PATCH 16/23] arm64: ilp32: introduce binfmt_ilp32.c
Date: Thu, 26 May 2016 21:49:42 +0800
Message-ID: <5746FEF6.9070405@huawei.com>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
 <1464048292-30136-17-git-send-email-ynorov@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1464048292-30136-17-git-send-email-ynorov@caviumnetworks.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>, arnd@arndb.de, catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, libc-alpha@sourceware.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pinskia@gmail.com, broonie@kernel.org, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com, szabolcs.nagy@arm.com, klimov.linux@gmail.com, Nathan_Lynch@mentor.com, agraf@suse.de, Prasun.Kapoor@caviumnetworks.com, kilobyte@angband.pl, geert@linux-m68k.org, philipp.tomsich@theobroma-systems.com, Hanjun Guo <guohanjun@huawei.com>, "Zhangjian (Bamvor)" <bamvor.zhangjian@huawei.com>
List-ID: <linux-s390.vger.kernel.org>

Hi, yury

The coredump is usable in our platform. It miss the following definition:
+#define compat_elf_greg_t	elf_greg_t
+#define compat_elf_gregset_t	elf_gregset_t

And it leads to the wrong register save in core dump. After apply this patch,
gdb could debug core dump files.

Here is the full patch:
 From 102624840aa5dacdd1bbfe3b390290f52f530ea2 Mon Sep 17 00:00:00 2001
From: Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>
Date: Thu, 26 May 2016 21:00:16 +0800
Subject: [PATCH hulk-4.1-next] arm64: ilp32: fix coredump issue

ILP32 use aarch64 register and 32bit signal struct which means it
could not make use of the existing compat_elf_prstatus/elf_prstatus
and compat_elf_prpsinfo/elf_prpsinfo.

This patch fix this issue by introducing the different
compat_elf_greg_t, compat_elf_gregset_t for aarch64 ilp32 and aarch32
el0.

Tested pass on huawei's hardware in bigendian.

Signed-off-by: Bamvor Jian Zhang <bamvor.zhangjian@huawei.com>
---
  arch/arm64/include/asm/elf.h     | 14 +++++++-------
  arch/arm64/kernel/binfmt_elf32.c |  3 +++
  arch/arm64/kernel/binfmt_ilp32.c |  8 +++++++-
  arch/arm64/kernel/ptrace.c       | 20 ++++++++++----------
  4 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index 0106d18..9019441 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -154,18 +154,18 @@ extern int arch_setup_additional_pages(struct linux_binprm *bprm,
  				       int uses_interp);

  /* 1GB of VA */
-#define STACK_RND_MASK			(is_compat_task() ? \
-						0x7ff >> (PAGE_SHIFT - 12) : \
-						0x3ffff >> (PAGE_SHIFT - 12))
+#define STACK_RND_MASK		(is_compat_task() ? \
+					0x7ff >> (PAGE_SHIFT - 12) : \
+					0x3ffff >> (PAGE_SHIFT - 12))

  #ifdef CONFIG_COMPAT

-#define COMPAT_ELF_ET_DYN_BASE		(2 * TASK_SIZE_32 / 3)
+#define COMPAT_ELF_ET_DYN_BASE	(2 * TASK_SIZE_32 / 3)

  /* AArch32 registers. */
-#define COMPAT_ELF_NGREG		18
-typedef unsigned int			compat_elf_greg_t;
-typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
+#define COMPAT_ELF_NGREG	18
+typedef unsigned int		compat_a32_elf_greg_t;
+typedef compat_a32_elf_greg_t	compat_a32_elf_gregset_t[COMPAT_ELF_NGREG];

  #endif /* CONFIG_COMPAT */

diff --git a/arch/arm64/kernel/binfmt_elf32.c b/arch/arm64/kernel/binfmt_elf32.c
index 7b9b445..f75253c 100644
--- a/arch/arm64/kernel/binfmt_elf32.c
+++ b/arch/arm64/kernel/binfmt_elf32.c
@@ -31,4 +31,7 @@ struct linux_binprm;
  extern int aarch32_setup_vectors_page(struct linux_binprm *bprm,
  				      int uses_interp);

+#define compat_elf_greg_t	compat_a32_elf_greg_t
+#define compat_elf_gregset_t	compat_a32_elf_gregset_t
+
  #include "../../../fs/compat_binfmt_elf.c"
diff --git a/arch/arm64/kernel/binfmt_ilp32.c b/arch/arm64/kernel/binfmt_ilp32.c
index b827a9a..01baf83 100644
--- a/arch/arm64/kernel/binfmt_ilp32.c
+++ b/arch/arm64/kernel/binfmt_ilp32.c
@@ -2,7 +2,9 @@
   * Support for ILP32 Linux/aarch64 ELF binaries.
   */

-#include <linux/elfcore-compat.h>
+#include <linux/elf.h>
+#include <linux/elfcore.h>
+#include <linux/compat.h>
  #include <linux/time.h>

  #undef	ELF_CLASS
@@ -30,9 +32,13 @@
   * The machine-dependent core note format types are defined in elfcore-compat.h,
   * which requires asm/elf.h to define compat_elf_gregset_t et al.
   */
+#define compat_elf_greg_t	elf_greg_t
+#define compat_elf_gregset_t	elf_gregset_t
  #define elf_prstatus	compat_elf_prstatus
  #define elf_prpsinfo	compat_elf_prpsinfo

+#include <linux/elfcore-compat.h>
+
  /*
   * Compat version of cputime_to_compat_timeval, perhaps this
   * should be an inline in <linux/compat.h>.
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 5c86135..9784c77 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -913,8 +913,8 @@ static const struct user_regset aarch32_regsets[] = {
  	[REGSET_COMPAT_GPR] = {
  		.core_note_type = NT_PRSTATUS,
  		.n = COMPAT_ELF_NGREG,
-		.size = sizeof(compat_elf_greg_t),
-		.align = sizeof(compat_elf_greg_t),
+		.size = sizeof(compat_a32_elf_greg_t),
+		.align = sizeof(compat_a32_elf_greg_t),
  		.get = compat_gpr_get,
  		.set = compat_gpr_set
  	},
@@ -947,7 +947,7 @@ static int compat_ptrace_read_user(struct task_struct *tsk, compat_ulong_t off,
  		tmp = tsk->mm->start_data;
  	else if (off == COMPAT_PT_TEXT_END_ADDR)
  		tmp = tsk->mm->end_code;
-	else if (off < sizeof(compat_elf_gregset_t))
+	else if (off < sizeof(compat_a32_elf_gregset_t))
  		return copy_regset_to_user(tsk, &user_aarch32_view,
  					   REGSET_COMPAT_GPR, off,
  					   sizeof(compat_ulong_t), ret);
@@ -968,7 +968,7 @@ static int compat_ptrace_write_user(struct task_struct *tsk, compat_ulong_t off,
  	if (off & 3 || off >= COMPAT_USER_SZ)
  		return -EIO;

-	if (off >= sizeof(compat_elf_gregset_t))
+	if (off >= sizeof(compat_a32_elf_gregset_t))
  		return 0;

  	set_fs(KERNEL_DS);
@@ -1116,9 +1116,11 @@ static long compat_a32_ptrace(struct task_struct *child, compat_long_t request,
  	unsigned long addr = caddr;
  	unsigned long data = cdata;
  	void __user *datap = compat_ptr(data);
+	unsigned int pr_reg_size = sizeof(compat_a32_elf_gregset_t);
  	int ret;

  	switch (request) {
+
  		case PTRACE_PEEKUSR:
  			ret = compat_ptrace_read_user(child, addr, datap);
  			break;
@@ -1130,17 +1132,15 @@ static long compat_a32_ptrace(struct task_struct *child, compat_long_t request,
  		case COMPAT_PTRACE_GETREGS:
  			ret = copy_regset_to_user(child,
  						  &user_aarch32_view,
-						  REGSET_COMPAT_GPR,
-						  0, sizeof(compat_elf_gregset_t),
-						  datap);
+						  REGSET_COMPAT_GPR, 0,
+						  pr_reg_size, datap);
  			break;

  		case COMPAT_PTRACE_SETREGS:
  			ret = copy_regset_from_user(child,
  						    &user_aarch32_view,
-						    REGSET_COMPAT_GPR,
-						    0, sizeof(compat_elf_gregset_t),
-						    datap);
+						    REGSET_COMPAT_GPR, 0,
+						    pr_reg_size, datap);
  			break;

  		case COMPAT_PTRACE_GET_THREAD_AREA:
-- 
1.8.4.5


On 2016/5/24 8:04, Yury Norov wrote:
> to handle ILP32 binaries
>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>   arch/arm64/kernel/Makefile       |  1 +
>   arch/arm64/kernel/binfmt_ilp32.c | 91 ++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 92 insertions(+)
>   create mode 100644 arch/arm64/kernel/binfmt_ilp32.c
>
> diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
> index 6bc9738..9dfdf86 100644
> --- a/arch/arm64/kernel/Makefile
> +++ b/arch/arm64/kernel/Makefile
> @@ -28,6 +28,7 @@ $(obj)/%.stub.o: $(obj)/%.o FORCE
>   arm64-obj-$(CONFIG_AARCH32_EL0)		+= sys32.o kuser32.o signal32.o 	\
>   					   sys_compat.o entry32.o		\
>   					   ../../arm/kernel/opcodes.o binfmt_elf32.o
> +arm64-obj-$(CONFIG_ARM64_ILP32)		+= binfmt_ilp32.o
>   arm64-obj-$(CONFIG_FUNCTION_TRACER)	+= ftrace.o entry-ftrace.o
>   arm64-obj-$(CONFIG_MODULES)		+= arm64ksyms.o module.o
>   arm64-obj-$(CONFIG_ARM64_MODULE_PLTS)	+= module-plts.o
> diff --git a/arch/arm64/kernel/binfmt_ilp32.c b/arch/arm64/kernel/binfmt_ilp32.c
> new file mode 100644
> index 0000000..a934fd4
> --- /dev/null
> +++ b/arch/arm64/kernel/binfmt_ilp32.c
> @@ -0,0 +1,91 @@
> +/*
> + * Support for ILP32 Linux/aarch64 ELF binaries.
> + */
> +
> +#include <linux/elfcore-compat.h>
> +#include <linux/time.h>
> +
> +#undef	ELF_CLASS
> +#define ELF_CLASS	ELFCLASS32
> +
> +#undef	elfhdr
> +#undef	elf_phdr
> +#undef	elf_shdr
> +#undef	elf_note
> +#undef	elf_addr_t
> +#define elfhdr		elf32_hdr
> +#define elf_phdr	elf32_phdr
> +#define elf_shdr	elf32_shdr
> +#define elf_note	elf32_note
> +#define elf_addr_t	Elf32_Addr
> +
> +/*
> + * Some data types as stored in coredump.
> + */
> +#define user_long_t		compat_long_t
> +#define user_siginfo_t		compat_siginfo_t
> +#define copy_siginfo_to_user	copy_siginfo_to_user32
> +
> +/*
> + * The machine-dependent core note format types are defined in elfcore-compat.h,
> + * which requires asm/elf.h to define compat_elf_gregset_t et al.
> + */
> +#define elf_prstatus	compat_elf_prstatus
> +#define elf_prpsinfo	compat_elf_prpsinfo
> +
> +/*
> + * Compat version of cputime_to_compat_timeval, perhaps this
> + * should be an inline in <linux/compat.h>.
> + */
> +static void cputime_to_compat_timeval(const cputime_t cputime,
> +				      struct compat_timeval *value)
> +{
> +	struct timeval tv;
> +	cputime_to_timeval(cputime, &tv);
> +	value->tv_sec = tv.tv_sec;
> +	value->tv_usec = tv.tv_usec;
> +}
> +
> +#undef cputime_to_timeval
> +#define cputime_to_timeval cputime_to_compat_timeval
> +
> +/* AARCH64 ILP32 EABI. */
> +#undef elf_check_arch
> +#define elf_check_arch(x)		(((x)->e_machine == EM_AARCH64)	\
> +					&& (x)->e_ident[EI_CLASS] == ELFCLASS32)
> +
> +#undef SET_PERSONALITY
> +#define SET_PERSONALITY(ex)						\
> +do {									\
> +	set_thread_flag(TIF_32BIT_AARCH64);				\
> +	clear_thread_flag(TIF_32BIT);					\
> +} while (0)
> +
> +#undef ARCH_DLINFO
> +#define ARCH_DLINFO							\
> +do {									\
> +	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
> +		    (elf_addr_t)(long)current->mm->context.vdso);	\
> +} while (0)
> +
> +#ifdef __AARCH64EB__
> +#define COMPAT_ELF_PLATFORM		("aarch64_be:ilp32")
> +#else
> +#define COMPAT_ELF_PLATFORM		("aarch64:ilp32")
> +#endif
> +
> +#undef ELF_HWCAP
> +#undef ELF_HWCAP2
> +#define ELF_HWCAP			((u32) elf_hwcap)
> +#define ELF_HWCAP2			((u32) (elf_hwcap >> 32))
> +
> +/*
> + * Rename a few of the symbols that binfmt_elf.c will define.
> + * These are all local so the names don't really matter, but it
> + * might make some debugging less confusing not to duplicate them.
> + */
> +#define elf_format		compat_elf_format
> +#define init_elf_binfmt		init_compat_elf_binfmt
> +#define exit_elf_binfmt		exit_compat_elf_binfmt
> +
> +#include "../../../fs/binfmt_elf.c"
>
