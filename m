From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Fri, 30 Jun 2017 11:37:47 +0000
Subject: Re: [CRIU] [PATCH v2 01/17] s390:compel/arch/s390: Add architecture support to compel tool and libra
Message-Id: <CAJwJo6bni2g36jTDSbVz79cWNQL2XaCEoF07CSGHUEMzZ0HkgA@mail.gmail.com>
In-Reply-To: <20170629192445.55580-2-holzheu@linux.vnet.ibm.com>
References: <20170629192445.55580-2-holzheu@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org, openvz-criu@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

2017-06-29 22:24 GMT+03:00 Michael Holzheu <holzheu@linux.vnet.ibm.com>:
> This patch only adds the support but does not enable it for building.
>
> Reviewed-by: Alice Frosi <alice@linux.vnet.ibm.com>
> Signed-off-by: Michael Holzheu <holzheu@linux.vnet.ibm.com>

LGTM, and looking at diffstat - shouldn't break anything we already have,
Reviewed-by: Dmitry Safonov <dsafonov@virtuozzo.com>

> ---
...
> diff --git a/compel/arch/s390/plugins/std/syscalls/syscall-common-s390.S b/compel/arch/s390/plugins/std/syscalls/syscall-common-s390.S
> new file mode 100644
> index 0000000..79e3b8e
> --- /dev/null
> +++ b/compel/arch/s390/plugins/std/syscalls/syscall-common-s390.S
> @@ -0,0 +1,37 @@
> +#include "common/asm/linkage.h"
> +
> +/*
> + * Define a system call
> + *
> + * C-ABI on s390:
> + * - Parameters 1-5 are passed in %r2-%r6
> + * - Parameter 6 is passed on the stack 160(%r15)
> + * - Return value is in %r2
> + * - Return address is in %r14
> + * - Registers %r0-%r6,%r14 are call-clobbered
> + * - Registers %r7-%r13,%r15 are call-saved
> + *
> + * SVC ABI on s390:
> + * - For SVC 0 the system call number is passed in %r1
> + * - Parameters 1-6 are passed in %r2-%r7
> + * - Return value is passed in %r2
> + * - Besides of %r2 all registers are call-saved
> + */

I like the comment :)

> +#define SYSCALL(name, opcode)                                          \
> +ENTRY(name);                                                           \
> +       lgr     %r0,%r7;                /* Save %r7 */                  \
> +       lg      %r7,160(%r15);          /* Load 6th parameter */        \
> +       lghi    %r1,opcode;             /* Load SVC number */           \
> +       svc     0;                      /* Issue SVC 0 */               \
> +       lgr     %r7,%r0;                /* Restore %r7 */               \
> +       br      %r14;                   /* Return to caller */          \
> +END(name)                                                              \
> +
> +/*
> + * Issue rt_sigreturn system call for sa_restorer
> + */
> +ENTRY(__cr_restore_rt)
> +       lghi    %r1,__NR_rt_sigreturn
> +       svc     0
> +END(__cr_restore_rt)
> +
...
> +/*
> + * Issue s390 mmap call
> + */
> +void *remote_mmap(struct parasite_ctl *ctl,
> +                 void *addr, size_t length, int prot,
> +                 int flags, int fd, off_t offset)
> +{
> +       void *where = (void *)ctl->ictx.syscall_ip + BUILTIN_SYSCALL_SIZE;
> +       struct mmap_arg_struct arg_struct;
> +       pid_t pid = ctl->rpid;
> +       long map = 0;
> +       int err;
> +
> +       /* Setup s390 mmap data */
> +       arg_struct.addr = (unsigned long)addr;
> +       arg_struct.len = length;
> +       arg_struct.prot = prot;
> +       arg_struct.flags = flags;
> +       arg_struct.fd = fd;
> +       arg_struct.offset = offset;
> +
> +       /* Move args to process */
> +       if (ptrace_swap_area(pid, where, &arg_struct, sizeof(arg_struct))) {
> +               pr_err("Can't inject memfd args (pid: %d)\n", pid);
> +               return NULL;
> +       }
> +
> +       /* Do syscall */
> +       err = compel_syscall(ctl, __NR_mmap, &map, (unsigned long) where,
> +                            0, 0, 0, 0, 0);
> +       if (err < 0 || (long)map < 0)
> +               map = 0;
> +
> +       /* Restore data */
> +       if (ptrace_poke_area(pid, &arg_struct, where, sizeof(arg_struct))) {
> +               pr_err("Can't restore mmap args (pid: %d)\n", pid);
> +               if (map != 0) {
> +                       err = compel_syscall(ctl, __NR_munmap, NULL, map,
> +                                            length, 0, 0, 0, 0);

Well, we could avoid setting err here, as we can't handle it
anyway - we're so fucked up here %)
But that's not significant.

...
> +/*
> + * Kernel task size level
> + *
> + * We have (dynamic) 4 level page tables for 64 bit since linux 2.6.25:
> + *
> + *  5a216a2083 ("[S390] Add four level page tables for CONFIG_64BIT=y.")
> + *  6252d702c5 ("[S390] dynamic page tables.")
> + *
> + * The code below is already prepared for future (dynamic) 5 level page tables.
> + *
> + * Besides that there is one problematic kernel bug that has been fixed for
> + * linux 4.11 by the following commit:
> + *
> + *  ee71d16d22 ("s390/mm: make TASK_SIZE independent from the number
> + *              of page table levels")
> + *
> + * A 64 bit process on s390x always starts with 3 levels and upgrades to 4
> + * levels for mmap(> 4 TB) and to 5 levels for mmap(> 16 EB).
> + *
> + * Unfortunately before fix ee71d16d22 for a 3 level process munmap()
> + * and mremap() fail for addresses > 4 TB. CRIU uses the task size,
> + * to unmap() all memory from a starting point to task size to get rid of
> + * unwanted mappings. CRIU uses mremap() to establish the final mappings
> + * which also fails if we want to restore mappings > 4 TB and the initial
> + * restore process still runs with 3 levels.
> + *
> + * To support the current CRIU design on s390 we return task size = 4 TB when
> + * a kernel without fix ee71d16d22 is detected. In this case we can dump at
> + * least processes with < 4 TB which is the most likely case anyway.
> + *
> + * For kernels with fix ee71d16d22 we are fully functional.
> + */
> +enum kernel_ts_level {
> +       /* Kernel with 4 level page tables without fix ee71d16d22 */
> +       KERNEL_TS_LEVEL_4_FIX_NO,
> +       /* Kernel with 4 level page tables with fix ee71d16d22 */
> +       KERNEL_TS_LEVEL_4_FIX_YES,
> +       /* Kernel with 4 level page tables with or without fix ee71d16d22 */
> +       KERNEL_TS_LEVEL_4_FIX_UNKN,
> +       /* Kernel with 5 level page tables */
> +       KERNEL_TS_LEVEL_5,
> +};
> +
> +/* See arch/s390/include/asm/processor.h */
> +#define TASK_SIZE_LEVEL_3      0x40000000000UL         /* 4 TB */
> +#define TASK_SIZE_LEVEL_4      0x20000000000000UL      /* 8 PB */
> +#define TASK_SIZE_LEVEL_5      0xffffffffffffefffUL    /* 16 EB - 0x1000 */
> +
> +/*
> + * Return detected kernel version regarding task size level
> + *
> + * We use unmap() to probe the maximum possible page table level of kernel
> + */
> +static enum kernel_ts_level get_kernel_ts_level(void)
> +{
> +       unsigned long criu_end_addr = max_mapped_addr();
> +
> +       /* Check for 5 levels */
> +       if (criu_end_addr > TASK_SIZE_LEVEL_4)
> +               return KERNEL_TS_LEVEL_5;
> +       else if (munmap((void *) TASK_SIZE_LEVEL_4, 0x1000) == 0)

Can't we occasionally unmap something that's already mapped?
Is it restricted by kernel to mmap() on such high address?

> +               return KERNEL_TS_LEVEL_5;
> +
> +       if (criu_end_addr < TASK_SIZE_LEVEL_3) {
> +               /* Check for 4 level kernel with fix */
> +               if (munmap((void *) TASK_SIZE_LEVEL_3, 0x1000) == 0)
> +                       return KERNEL_TS_LEVEL_4_FIX_YES;
> +               else
> +                       return KERNEL_TS_LEVEL_4_FIX_NO;
> +       }
> +       /* We can't find out if kernel has the fix */
> +       return KERNEL_TS_LEVEL_4_FIX_UNKN;
> +}
> +
> +/*

-- 
             Dmitry
