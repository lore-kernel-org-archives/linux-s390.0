Return-Path: <pavel@ucw.cz>
Date: Wed, 7 Feb 2018 11:07:26 +0100
From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 6/6] s390: introduce execute-trampolines for branches
Message-ID: <20180207100726.GB31392@amd>
References: <1517986811-27819-1-git-send-email-schwidefsky@de.ibm.com>
 <1517986811-27819-7-git-send-email-schwidefsky@de.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <1517986811-27819-7-git-send-email-schwidefsky@de.ibm.com>
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Masters <jcm@redhat.com>, Marcus Meissner <meissner@suse.de>, Jiri Kosina <jkosina@suse.cz>, Dominik Brodowski <linux@dominikbrodowski.net>, Alan Cox <gnomes@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-s390.vger.kernel.org>


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2018-02-07 08:00:11, Martin Schwidefsky wrote:
> Add CONFIG_EXPOLINE to enable the use of the new -mindirect-branch=3D and
> -mfunction_return=3D compiler options to create a kernel fortified against
> the specte v2 attack.
>=20
> With CONFIG_EXPOLINE=3Dy all indirect branches will be issued with an
> execute type instruction. For z10 or newer the EXRL instruction will
> be used, for older machines the EX instruction. The typical indirect
> call
>=20
> 	basr	%r14,%r1
>=20
> is replaced with a PC relative call to a new thunk
>=20
> 	brasl	%r14,__s390x_indirect_jump_r1
>=20
> The thunk contains the EXRL/EX instruction to the indirect branch
>=20
> __s390x_indirect_jump_r1:
> 	exrl	0,0f
> 	j	.
> 0:	br	%r1
>=20
> The detour via the execute type instruction has a performance impact.
> To get rid of the detour the new kernel parameter "nospectre_v2" and
> "spectre_v2=3D[on,off,auto]" can be used. If the parameter is specified
> the kernel and module code will be patched at runtime.

This is really unfortunate naming of kernel option.

spectre_v2=3Doff sounds like we are turning the "bug" off, but i somehow
suspect you are turning the bug _workaround_ off.

									Pavel

> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> ---
>  arch/s390/Kconfig                     |  28 +++++++++
>  arch/s390/Makefile                    |  12 ++++
>  arch/s390/include/asm/lowcore.h       |   6 +-
>  arch/s390/include/asm/nospec-branch.h |  18 ++++++
>  arch/s390/kernel/Makefile             |   4 ++
>  arch/s390/kernel/entry.S              | 113 ++++++++++++++++++++++++++--=
------
>  arch/s390/kernel/module.c             |  62 ++++++++++++++++---
>  arch/s390/kernel/nospec-branch.c      | 100 ++++++++++++++++++++++++++++=
++
>  arch/s390/kernel/setup.c              |   4 ++
>  arch/s390/kernel/smp.c                |   1 +
>  arch/s390/kernel/vmlinux.lds.S        |  14 +++++
>  drivers/s390/char/Makefile            |   2 +
>  12 files changed, 329 insertions(+), 35 deletions(-)
>  create mode 100644 arch/s390/include/asm/nospec-branch.h
>  create mode 100644 arch/s390/kernel/nospec-branch.c
>=20
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index d514e25..d4a65bf 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -557,6 +557,34 @@ config KERNEL_NOBP
> =20
>  	  If unsure, say N.
> =20
> +config EXPOLINE
> +	def_bool n
> +	prompt "Avoid speculative indirect branches in the kernel"
> +	help
> +	  Compile the kernel with the expoline compiler options to guard
> +	  against kernel-to-user data leaks by avoiding speculative indirect
> +	  branches.
> +	  Requires a compiler with -mindirect-branch=3Dthunk support for full
> +	  protection. The kernel may run slower.
> +
> +	  If unsure, say N.
> +
> +choice
> +	prompt "Expoline default"
> +	depends on EXPOLINE
> +	default EXPOLINE_FULL
> +
> +config EXPOLINE_OFF
> +	bool "spectre_v2=3Doff"
> +
> +config EXPOLINE_MEDIUM
> +	bool "spectre_v2=3Dauto"
> +
> +config EXPOLINE_FULL
> +	bool "spectre_v2=3Don"
> +
> +endchoice
> +
>  endmenu
> =20
>  menu "Memory setup"
> diff --git a/arch/s390/Makefile b/arch/s390/Makefile
> index fd691c4..2f925ef 100644
> --- a/arch/s390/Makefile
> +++ b/arch/s390/Makefile
> @@ -78,6 +78,18 @@ ifeq ($(call cc-option-yn,-mwarn-dynamicstack),y)
>  cflags-$(CONFIG_WARN_DYNAMIC_STACK) +=3D -mwarn-dynamicstack
>  endif
> =20
> +ifdef CONFIG_EXPOLINE
> +  ifeq ($(call cc-option-yn,$(CC_FLAGS_MARCH) -mindirect-branch=3Dthunk)=
,y)
> +    CC_FLAGS_EXPOLINE :=3D -mindirect-branch=3Dthunk
> +    CC_FLAGS_EXPOLINE +=3D -mfunction-return=3Dthunk
> +    CC_FLAGS_EXPOLINE +=3D -mindirect-branch-table
> +    export CC_FLAGS_EXPOLINE
> +    cflags-y +=3D $(CC_FLAGS_EXPOLINE)
> +  else
> +    $(warning "Your gcc lacks the -mindirect-branch=3D option")
> +  endif
> +endif
> +
>  ifdef CONFIG_FUNCTION_TRACER
>  # make use of hotpatch feature if the compiler supports it
>  cc_hotpatch	:=3D -mhotpatch=3D0,3
> diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowc=
ore.h
> index c63986a..5bc8888 100644
> --- a/arch/s390/include/asm/lowcore.h
> +++ b/arch/s390/include/asm/lowcore.h
> @@ -136,7 +136,11 @@ struct lowcore {
>  	__u64	vdso_per_cpu_data;		/* 0x03b8 */
>  	__u64	machine_flags;			/* 0x03c0 */
>  	__u64	gmap;				/* 0x03c8 */
> -	__u8	pad_0x03d0[0x0e00-0x03d0];	/* 0x03d0 */
> +	__u8	pad_0x03d0[0x0400-0x03d0];	/* 0x03d0 */
> +
> +	/* br %r1 trampoline */
> +	__u16	br_r1_trampoline;		/* 0x0400 */
> +	__u8	pad_0x0402[0x0e00-0x0402];	/* 0x0402 */
> =20
>  	/*
>  	 * 0xe00 contains the address of the IPL Parameter Information
> diff --git a/arch/s390/include/asm/nospec-branch.h b/arch/s390/include/as=
m/nospec-branch.h
> new file mode 100644
> index 0000000..7df48e5
> --- /dev/null
> +++ b/arch/s390/include/asm/nospec-branch.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_S390_EXPOLINE_H
> +#define _ASM_S390_EXPOLINE_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/types.h>
> +
> +extern int nospec_call_disable;
> +extern int nospec_return_disable;
> +
> +void nospec_init_branches(void);
> +void nospec_call_revert(s32 *start, s32 *end);
> +void nospec_return_revert(s32 *start, s32 *end);
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#endif /* _ASM_S390_EXPOLINE_H */
> diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
> index 909bce6..7f27e3d 100644
> --- a/arch/s390/kernel/Makefile
> +++ b/arch/s390/kernel/Makefile
> @@ -29,6 +29,7 @@ UBSAN_SANITIZE_early.o	:=3D n
>  #
>  ifneq ($(CC_FLAGS_MARCH),-march=3Dz900)
>  CFLAGS_REMOVE_als.o	+=3D $(CC_FLAGS_MARCH)
> +CFLAGS_REMOVE_als.o	+=3D $(CC_FLAGS_EXPOLINE)
>  CFLAGS_als.o		+=3D -march=3Dz900
>  AFLAGS_REMOVE_head.o	+=3D $(CC_FLAGS_MARCH)
>  AFLAGS_head.o		+=3D -march=3Dz900
> @@ -63,6 +64,9 @@ obj-y	+=3D entry.o reipl.o relocate_kernel.o kdebugfs.o=
 alternative.o
> =20
>  extra-y				+=3D head.o head64.o vmlinux.lds
> =20
> +obj-$(CONFIG_EXPOLINE)		+=3D nospec-branch.o
> +CFLAGS_REMOVE_expoline.o	+=3D $(CC_FLAGS_EXPOLINE)
> +
>  obj-$(CONFIG_MODULES)		+=3D module.o
>  obj-$(CONFIG_SMP)		+=3D smp.o
>  obj-$(CONFIG_SCHED_TOPOLOGY)	+=3D topology.o
> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> index 53145b5..13a133a 100644
> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S
> @@ -222,6 +222,68 @@ _PIF_WORK	=3D (_PIF_PER_TRAP | _PIF_SYSCALL_RESTART)
>  	.popsection
>  	.endm
> =20
> +#ifdef CONFIG_EXPOLINE
> +
> +	.macro GEN_BR_THUNK name,reg,tmp
> +	.section .text.\name,"axG",@progbits,\name,comdat
> +	.globl \name
> +	.hidden \name
> +	.type \name,@function
> +\name:
> +	.cfi_startproc
> +#ifdef CONFIG_HAVE_MARCH_Z10_FEATURES
> +	exrl	0,0f
> +#else
> +	larl	\tmp,0f
> +	ex	0,0(\tmp)
> +#endif
> +	j	.
> +0:	br	\reg
> +	.cfi_endproc
> +	.endm
> +
> +	GEN_BR_THUNK __s390x_indirect_jump_r1use_r9,%r9,%r1
> +	GEN_BR_THUNK __s390x_indirect_jump_r1use_r14,%r14,%r1
> +	GEN_BR_THUNK __s390x_indirect_jump_r11use_r14,%r14,%r11
> +
> +	.macro BASR_R14_R9
> +0:	brasl	%r14,__s390x_indirect_jump_r1use_r9
> +	.pushsection .s390_indirect_branches,"a",@progbits
> +	.long	0b-.
> +	.popsection
> +	.endm
> +
> +	.macro BR_R1USE_R14
> +0:	jg	__s390x_indirect_jump_r1use_r14
> +	.pushsection .s390_indirect_branches,"a",@progbits
> +	.long	0b-.
> +	.popsection
> +	.endm
> +
> +	.macro BR_R11USE_R14
> +0:	jg	__s390x_indirect_jump_r11use_r14
> +	.pushsection .s390_indirect_branches,"a",@progbits
> +	.long	0b-.
> +	.popsection
> +	.endm
> +
> +#else	/* CONFIG_EXPOLINE */
> +
> +	.macro BASR_R14_R9
> +	basr	%r14,%r9
> +	.endm
> +
> +	.macro BR_R1USE_R14
> +	br	%r14
> +	.endm
> +
> +	.macro BR_R11USE_R14
> +	br	%r14
> +	.endm
> +
> +#endif /* CONFIG_EXPOLINE */
> +
> +
>  	.section .kprobes.text, "ax"
>  .Ldummy:
>  	/*
> @@ -237,7 +299,7 @@ _PIF_WORK	=3D (_PIF_PER_TRAP | _PIF_SYSCALL_RESTART)
>  ENTRY(__bpon)
>  	.globl __bpon
>  	BPON
> -	br	%r14
> +	BR_R1USE_R14
> =20
>  /*
>   * Scheduler resume function, called by switch_to
> @@ -261,9 +323,9 @@ ENTRY(__switch_to)
>  	mvc	__LC_CURRENT_PID(4,%r0),0(%r3)	# store pid of next
>  	lmg	%r6,%r15,__SF_GPRS(%r15)	# load gprs of next task
>  	TSTMSK	__LC_MACHINE_FLAGS,MACHINE_FLAG_LPP
> -	bzr	%r14
> +	jz	0f
>  	.insn	s,0xb2800000,__LC_LPP		# set program parameter
> -	br	%r14
> +0:	BR_R1USE_R14
> =20
>  .L__critical_start:
> =20
> @@ -330,7 +392,7 @@ sie_exit:
>  	xgr	%r5,%r5
>  	lmg	%r6,%r14,__SF_GPRS(%r15)	# restore kernel registers
>  	lg	%r2,__SF_EMPTY+16(%r15)		# return exit reason code
> -	br	%r14
> +	BR_R1USE_R14
>  .Lsie_fault:
>  	lghi	%r14,-EFAULT
>  	stg	%r14,__SF_EMPTY+16(%r15)	# set exit reason code
> @@ -389,7 +451,7 @@ ENTRY(system_call)
>  	lgf	%r9,0(%r8,%r10)			# get system call add.
>  	TSTMSK	__TI_flags(%r12),_TIF_TRACE
>  	jnz	.Lsysc_tracesys
> -	basr	%r14,%r9			# call sys_xxxx
> +	BASR_R14_R9				# call sys_xxxx
>  	stg	%r2,__PT_R2(%r11)		# store return value
> =20
>  .Lsysc_return:
> @@ -574,7 +636,7 @@ ENTRY(system_call)
>  	lmg	%r3,%r7,__PT_R3(%r11)
>  	stg	%r7,STACK_FRAME_OVERHEAD(%r15)
>  	lg	%r2,__PT_ORIG_GPR2(%r11)
> -	basr	%r14,%r9		# call sys_xxx
> +	BASR_R14_R9			# call sys_xxx
>  	stg	%r2,__PT_R2(%r11)	# store return value
>  .Lsysc_tracenogo:
>  	TSTMSK	__TI_flags(%r12),_TIF_TRACE
> @@ -598,7 +660,7 @@ ENTRY(ret_from_fork)
>  	lmg	%r9,%r10,__PT_R9(%r11)	# load gprs
>  ENTRY(kernel_thread_starter)
>  	la	%r2,0(%r10)
> -	basr	%r14,%r9
> +	BASR_R14_R9
>  	j	.Lsysc_tracenogo
> =20
>  /*
> @@ -678,9 +740,9 @@ ENTRY(pgm_check_handler)
>  	nill	%r10,0x007f
>  	sll	%r10,2
>  	je	.Lpgm_return
> -	lgf	%r1,0(%r10,%r1)		# load address of handler routine
> +	lgf	%r9,0(%r10,%r1)		# load address of handler routine
>  	lgr	%r2,%r11		# pass pointer to pt_regs
> -	basr	%r14,%r1		# branch to interrupt-handler
> +	BASR_R14_R9			# branch to interrupt-handler
>  .Lpgm_return:
>  	LOCKDEP_SYS_EXIT
>  	tm	__PT_PSW+1(%r11),0x01	# returning to user ?
> @@ -998,7 +1060,7 @@ ENTRY(psw_idle)
>  	stpt	__TIMER_IDLE_ENTER(%r2)
>  .Lpsw_idle_lpsw:
>  	lpswe	__SF_EMPTY(%r15)
> -	br	%r14
> +	BR_R1USE_R14
>  .Lpsw_idle_end:
> =20
>  /*
> @@ -1012,7 +1074,7 @@ ENTRY(save_fpu_regs)
>  	lg	%r2,__LC_CURRENT
>  	aghi	%r2,__TASK_thread
>  	TSTMSK	__LC_CPU_FLAGS,_CIF_FPU
> -	bor	%r14
> +	jo	.Lsave_fpu_regs_exit
>  	stfpc	__THREAD_FPU_fpc(%r2)
>  	lg	%r3,__THREAD_FPU_regs(%r2)
>  	TSTMSK	__LC_MACHINE_FLAGS,MACHINE_FLAG_VX
> @@ -1039,7 +1101,8 @@ ENTRY(save_fpu_regs)
>  	std	15,120(%r3)
>  .Lsave_fpu_regs_done:
>  	oi	__LC_CPU_FLAGS+7,_CIF_FPU
> -	br	%r14
> +.Lsave_fpu_regs_exit:
> +	BR_R1USE_R14
>  .Lsave_fpu_regs_end:
>  EXPORT_SYMBOL(save_fpu_regs)
> =20
> @@ -1057,7 +1120,7 @@ load_fpu_regs:
>  	lg	%r4,__LC_CURRENT
>  	aghi	%r4,__TASK_thread
>  	TSTMSK	__LC_CPU_FLAGS,_CIF_FPU
> -	bnor	%r14
> +	jno	.Lload_fpu_regs_exit
>  	lfpc	__THREAD_FPU_fpc(%r4)
>  	TSTMSK	__LC_MACHINE_FLAGS,MACHINE_FLAG_VX
>  	lg	%r4,__THREAD_FPU_regs(%r4)	# %r4 <- reg save area
> @@ -1084,7 +1147,8 @@ load_fpu_regs:
>  	ld	15,120(%r4)
>  .Lload_fpu_regs_done:
>  	ni	__LC_CPU_FLAGS+7,255-_CIF_FPU
> -	br	%r14
> +.Lload_fpu_regs_exit:
> +	BR_R1USE_R14
>  .Lload_fpu_regs_end:
> =20
>  .L__critical_end:
> @@ -1301,7 +1365,7 @@ cleanup_critical:
>  	jl	0f
>  	clg	%r9,BASED(.Lcleanup_table+104)	# .Lload_fpu_regs_end
>  	jl	.Lcleanup_load_fpu_regs
> -0:	br	%r14
> +0:	BR_R11USE_R14
> =20
>  	.align	8
>  .Lcleanup_table:
> @@ -1337,7 +1401,7 @@ cleanup_critical:
>  	ni	__SIE_PROG0C+3(%r9),0xfe	# no longer in SIE
>  	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
>  	larl	%r9,sie_exit			# skip forward to sie_exit
> -	br	%r14
> +	BR_R11USE_R14
>  #endif
> =20
>  .Lcleanup_system_call:
> @@ -1390,7 +1454,7 @@ cleanup_critical:
>  	stg	%r15,56(%r11)		# r15 stack pointer
>  	# set new psw address and exit
>  	larl	%r9,.Lsysc_do_svc
> -	br	%r14
> +	BR_R11USE_R14
>  .Lcleanup_system_call_insn:
>  	.quad	system_call
>  	.quad	.Lsysc_stmg
> @@ -1402,7 +1466,7 @@ cleanup_critical:
> =20
>  .Lcleanup_sysc_tif:
>  	larl	%r9,.Lsysc_tif
> -	br	%r14
> +	BR_R11USE_R14
> =20
>  .Lcleanup_sysc_restore:
>  	# check if stpt has been executed
> @@ -1419,14 +1483,14 @@ cleanup_critical:
>  	mvc	0(64,%r11),__PT_R8(%r9)
>  	lmg	%r0,%r7,__PT_R0(%r9)
>  1:	lmg	%r8,%r9,__LC_RETURN_PSW
> -	br	%r14
> +	BR_R11USE_R14
>  .Lcleanup_sysc_restore_insn:
>  	.quad	.Lsysc_exit_timer
>  	.quad	.Lsysc_done - 4
> =20
>  .Lcleanup_io_tif:
>  	larl	%r9,.Lio_tif
> -	br	%r14
> +	BR_R11USE_R14
> =20
>  .Lcleanup_io_restore:
>  	# check if stpt has been executed
> @@ -1440,7 +1504,7 @@ cleanup_critical:
>  	mvc	0(64,%r11),__PT_R8(%r9)
>  	lmg	%r0,%r7,__PT_R0(%r9)
>  1:	lmg	%r8,%r9,__LC_RETURN_PSW
> -	br	%r14
> +	BR_R11USE_R14
>  .Lcleanup_io_restore_insn:
>  	.quad	.Lio_exit_timer
>  	.quad	.Lio_done - 4
> @@ -1493,17 +1557,17 @@ cleanup_critical:
>  	# prepare return psw
>  	nihh	%r8,0xfcfd		# clear irq & wait state bits
>  	lg	%r9,48(%r11)		# return from psw_idle
> -	br	%r14
> +	BR_R11USE_R14
>  .Lcleanup_idle_insn:
>  	.quad	.Lpsw_idle_lpsw
> =20
>  .Lcleanup_save_fpu_regs:
>  	larl	%r9,save_fpu_regs
> -	br	%r14
> +	BR_R11USE_R14
> =20
>  .Lcleanup_load_fpu_regs:
>  	larl	%r9,load_fpu_regs
> -	br	%r14
> +	BR_R11USE_R14
> =20
>  /*
>   * Integer constants
> @@ -1523,7 +1587,6 @@ cleanup_critical:
>  .Lsie_crit_mcck_length:
>  	.quad   .Lsie_skip - .Lsie_entry
>  #endif
> -
>  	.section .rodata, "a"
>  #define SYSCALL(esame,emu)	.long esame
>  	.globl	sys_call_table
> diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
> index b7abfad..1fc6d1f 100644
> --- a/arch/s390/kernel/module.c
> +++ b/arch/s390/kernel/module.c
> @@ -19,6 +19,8 @@
>  #include <linux/moduleloader.h>
>  #include <linux/bug.h>
>  #include <asm/alternative.h>
> +#include <asm/nospec-branch.h>
> +#include <asm/facility.h>
> =20
>  #if 0
>  #define DEBUGP printk
> @@ -156,7 +158,11 @@ int module_frob_arch_sections(Elf_Ehdr *hdr, Elf_Shd=
r *sechdrs,
>  	me->arch.got_offset =3D me->core_layout.size;
>  	me->core_layout.size +=3D me->arch.got_size;
>  	me->arch.plt_offset =3D me->core_layout.size;
> -	me->core_layout.size +=3D me->arch.plt_size;
> +	if (me->arch.plt_size) {
> +		if (IS_ENABLED(CONFIG_EXPOLINE) && !nospec_call_disable)
> +			me->arch.plt_size +=3D PLT_ENTRY_SIZE;
> +		me->core_layout.size +=3D me->arch.plt_size;
> +	}
>  	return 0;
>  }
> =20
> @@ -310,9 +316,21 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base,=
 Elf_Sym *symtab,
>  			unsigned int *ip;
>  			ip =3D me->core_layout.base + me->arch.plt_offset +
>  				info->plt_offset;
> -			ip[0] =3D 0x0d10e310; /* basr 1,0; lg 1,10(1); br 1 */
> -			ip[1] =3D 0x100a0004;
> -			ip[2] =3D 0x07f10000;
> +			ip[0] =3D 0x0d10e310;	/* basr 1,0  */
> +			ip[1] =3D 0x100a0004;	/* lg	1,10(1) */
> +			if (IS_ENABLED(CONFIG_EXPOLINE) &&
> +			    !nospec_call_disable) {
> +				unsigned int *ij;
> +				ij =3D me->core_layout.base +
> +					me->arch.plt_offset +
> +					me->arch.plt_size - PLT_ENTRY_SIZE;
> +				ip[2] =3D 0xa7f40000 +	/* j __jump_r1 */
> +					(unsigned int)(u16)
> +					(((unsigned long) ij - 8 -
> +					  (unsigned long) ip) / 2);
> +			} else {
> +				ip[2] =3D 0x07f10000;	/* br %r1 */
> +			}
>  			ip[3] =3D (unsigned int) (val >> 32);
>  			ip[4] =3D (unsigned int) val;
>  			info->plt_initialized =3D 1;
> @@ -418,16 +436,42 @@ int module_finalize(const Elf_Ehdr *hdr,
>  		    struct module *me)
>  {
>  	const Elf_Shdr *s;
> -	char *secstrings;
> +	char *secstrings, *secname;
> +	void *aseg;
> +
> +	if (IS_ENABLED(CONFIG_EXPOLINE) &&
> +	    !nospec_call_disable && me->arch.plt_size) {
> +		unsigned int *ij;
> +
> +		ij =3D me->core_layout.base + me->arch.plt_offset +
> +			me->arch.plt_size - PLT_ENTRY_SIZE;
> +		if (test_facility(35)) {
> +			ij[0] =3D 0xc6000000;	/* exrl	%r0,.+10	*/
> +			ij[1] =3D 0x0005a7f4;	/* j	.		*/
> +			ij[2] =3D 0x000007f1;	/* br	%r1		*/
> +		} else {
> +			ij[0] =3D 0x44000000 | (unsigned int)
> +				offsetof(struct lowcore, br_r1_trampoline);
> +			ij[1] =3D 0xa7f40000;	/* j	.		*/
> +		}
> +	}
> =20
>  	secstrings =3D (void *)hdr + sechdrs[hdr->e_shstrndx].sh_offset;
>  	for (s =3D sechdrs; s < sechdrs + hdr->e_shnum; s++) {
> -		if (!strcmp(".altinstructions", secstrings + s->sh_name)) {
> -			/* patch .altinstructions */
> -			void *aseg =3D (void *)s->sh_addr;
> +		aseg =3D (void *) s->sh_addr;
> +		secname =3D secstrings + s->sh_name;
> =20
> +		if (!strcmp(".altinstructions", secname))
> +			/* patch .altinstructions */
>  			apply_alternatives(aseg, aseg + s->sh_size);
> -		}
> +
> +		if (IS_ENABLED(CONFIG_EXPOLINE) &&
> +		    (!strcmp(".nospec_call_table", secname)))
> +			nospec_call_revert(aseg, aseg + s->sh_size);
> +
> +		if (IS_ENABLED(CONFIG_EXPOLINE) &&
> +		    (!strcmp(".nospec_return_table", secname)))
> +			nospec_return_revert(aseg, aseg + s->sh_size);
>  	}
> =20
>  	jump_label_apply_nops(me);
> diff --git a/arch/s390/kernel/nospec-branch.c b/arch/s390/kernel/nospec-b=
ranch.c
> new file mode 100644
> index 0000000..69d7fcf
> --- /dev/null
> +++ b/arch/s390/kernel/nospec-branch.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <linux/module.h>
> +#include <asm/nospec-branch.h>
> +
> +int nospec_call_disable =3D IS_ENABLED(EXPOLINE_OFF);
> +int nospec_return_disable =3D !IS_ENABLED(EXPOLINE_FULL);
> +
> +static int __init nospectre_v2_setup_early(char *str)
> +{
> +	nospec_call_disable =3D 1;
> +	nospec_return_disable =3D 1;
> +	return 0;
> +}
> +early_param("nospectre_v2", nospectre_v2_setup_early);
> +
> +static int __init spectre_v2_setup_early(char *str)
> +{
> +	if (str && !strncmp(str, "on", 2)) {
> +		nospec_call_disable =3D 0;
> +		nospec_return_disable =3D 0;
> +	}
> +	if (str && !strncmp(str, "off", 3)) {
> +		nospec_call_disable =3D 1;
> +		nospec_return_disable =3D 1;
> +	}
> +	if (str && !strncmp(str, "auto", 4)) {
> +		nospec_call_disable =3D 0;
> +		nospec_return_disable =3D 1;
> +	}
> +	return 0;
> +}
> +early_param("spectre_v2", spectre_v2_setup_early);
> +
> +static void __init_or_module __nospec_revert(s32 *start, s32 *end)
> +{
> +	enum { BRCL_EXPOLINE, BRASL_EXPOLINE } type;
> +	u8 *instr, *thunk, *br;
> +	u8 insnbuf[6];
> +	s32 *epo;
> +
> +	/* Second part of the instruction replace is always a nop */
> +	memcpy(insnbuf + 2, (char[]) { 0x47, 0x00, 0x00, 0x00 }, 4);
> +	for (epo =3D start; epo < end; epo++) {
> +		instr =3D (u8 *) epo + *epo;
> +		if (instr[0] =3D=3D 0xc0 && (instr[1] & 0x0f) =3D=3D 0x04)
> +			type =3D BRCL_EXPOLINE;	/* brcl instruction */
> +		else if (instr[0] =3D=3D 0xc0 && (instr[1] & 0x0f) =3D=3D 0x05)
> +			type =3D BRASL_EXPOLINE;	/* brasl instruction */
> +		else
> +			continue;
> +		thunk =3D instr + (*(int *)(instr + 2)) * 2;
> +		if (thunk[0] =3D=3D 0xc6 && thunk[1] =3D=3D 0x00)
> +			/* exrl %r0,<target-br> */
> +			br =3D thunk + (*(int *)(thunk + 2)) * 2;
> +		else if (thunk[0] =3D=3D 0xc0 && (thunk[1] & 0x0f) =3D=3D 0x00 &&
> +			 thunk[6] =3D=3D 0x44 && thunk[7] =3D=3D 0x00 &&
> +			 (thunk[8] & 0x0f) =3D=3D 0x00 && thunk[9] =3D=3D 0x00 &&
> +			 (thunk[1] & 0xf0) =3D=3D (thunk[8] & 0xf0))
> +			/* larl %rx,<target br> + ex %r0,0(%rx) */
> +			br =3D thunk + (*(int *)(thunk + 2)) * 2;
> +		else
> +			continue;
> +		if (br[0] !=3D 0x07 || (br[1] & 0xf0) !=3D 0xf0)
> +			continue;
> +		switch (type) {
> +		case BRCL_EXPOLINE:
> +			/* brcl to thunk, replace with br + nop */
> +			insnbuf[0] =3D br[0];
> +			insnbuf[1] =3D (instr[1] & 0xf0) | (br[1] & 0x0f);
> +			break;
> +		case BRASL_EXPOLINE:
> +			/* brasl to thunk, replace with basr + nop */
> +			insnbuf[0] =3D 0x0d;
> +			insnbuf[1] =3D (instr[1] & 0xf0) | (br[1] & 0x0f);
> +			break;
> +		}
> +
> +		s390_kernel_write(instr, insnbuf, 6);
> +	}
> +}
> +
> +void __init_or_module nospec_call_revert(s32 *start, s32 *end)
> +{
> +	if (nospec_call_disable)
> +		__nospec_revert(start, end);
> +}
> +
> +void __init_or_module nospec_return_revert(s32 *start, s32 *end)
> +{
> +	if (nospec_return_disable)
> +		__nospec_revert(start, end);
> +}
> +
> +extern s32 __nospec_call_start[], __nospec_call_end[];
> +extern s32 __nospec_return_start[], __nospec_return_end[];
> +void __init nospec_init_branches(void)
> +{
> +	nospec_call_revert(__nospec_call_start, __nospec_call_end);
> +	nospec_return_revert(__nospec_return_start, __nospec_return_end);
> +}
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index bcd2a4a..a6a91f0 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -68,6 +68,7 @@
>  #include <asm/sysinfo.h>
>  #include <asm/numa.h>
>  #include <asm/alternative.h>
> +#include <asm/nospec-branch.h>
>  #include "entry.h"
> =20
>  /*
> @@ -379,6 +380,7 @@ static void __init setup_lowcore(void)
>  	lc->spinlock_index =3D 0;
>  	arch_spin_lock_setup(0);
>  #endif
> +	lc->br_r1_trampoline =3D 0x07f1;	/* br %r1 */
> =20
>  	set_prefix((u32)(unsigned long) lc);
>  	lowcore_ptr[0] =3D lc;
> @@ -954,6 +956,8 @@ void __init setup_arch(char **cmdline_p)
>  	set_preferred_console();
> =20
>  	apply_alternative_instructions();
> +	if (IS_ENABLED(CONFIG_EXPOLINE))
> +		nospec_init_branches();
> =20
>  	/* Setup zfcpdump support */
>  	setup_zfcpdump();
> diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
> index 2fd7d60..a4a9fe1 100644
> --- a/arch/s390/kernel/smp.c
> +++ b/arch/s390/kernel/smp.c
> @@ -214,6 +214,7 @@ static int pcpu_alloc_lowcore(struct pcpu *pcpu, int =
cpu)
>  	lc->cpu_nr =3D cpu;
>  	lc->spinlock_lockval =3D arch_spin_lockval(cpu);
>  	lc->spinlock_index =3D 0;
> +	lc->br_r1_trampoline =3D 0x07f1;	/* br %r1 */
>  	if (nmi_alloc_per_cpu(lc))
>  		goto out;
>  	if (vdso_alloc_per_cpu(lc))
> diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.ld=
s.S
> index 608cf29..08d12cf 100644
> --- a/arch/s390/kernel/vmlinux.lds.S
> +++ b/arch/s390/kernel/vmlinux.lds.S
> @@ -123,6 +123,20 @@ SECTIONS
>  		*(.altinstr_replacement)
>  	}
> =20
> +	/*
> +	 * Table with the patch locations to undo expolines
> +	*/
> +	.nospec_call_table : {
> +		__nospec_call_start =3D . ;
> +		*(.s390_indirect*)
> +		__nospec_call_end =3D . ;
> +	}
> +	.nospec_return_table : {
> +		__nospec_return_start =3D . ;
> +		*(.s390_return*)
> +		__nospec_return_end =3D . ;
> +	}
> +
>  	/* early.c uses stsi, which requires page aligned data. */
>  	. =3D ALIGN(PAGE_SIZE);
>  	INIT_DATA_SECTION(0x100)
> diff --git a/drivers/s390/char/Makefile b/drivers/s390/char/Makefile
> index 614b44e..a2b33a2 100644
> --- a/drivers/s390/char/Makefile
> +++ b/drivers/s390/char/Makefile
> @@ -19,6 +19,8 @@ endif
> =20
>  CFLAGS_sclp_early_core.o		+=3D -D__NO_FORTIFY
> =20
> +CFLAGS_REMOVE_sclp_early_core.o	+=3D $(CC_FLAGS_EXPOLINE)
> +
>  obj-y +=3D ctrlchar.o keyboard.o defkeymap.o sclp.o sclp_rw.o sclp_quies=
ce.o \
>  	 sclp_cmd.o sclp_config.o sclp_cpi_sys.o sclp_ocf.o sclp_ctl.o \
>  	 sclp_early.o sclp_early_core.o

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlp6z94ACgkQMOfwapXb+vK6UACguU2Rm5KSyDzV+0Srsu61z2Rb
PKcAn0TiUoDb7aKxjfwN+0sHHxgObpR3
=zxlA
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
