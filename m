From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/2] introduce vdso on s390
Date: Wed, 15 Oct 2008 19:45:08 +0200
Message-ID: <20081015175305.332585239@de.ibm.com>
References: <20081015174506.107691579@de.ibm.com>
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline; filename=101-vdso-s390.diff
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add a vdso to speed up gettimeofday and clock_getres/clock_gettime for
CLOCK_REALTIME/CLOCK_MONOTONIC.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/Kconfig                        |    3 
 arch/s390/include/asm/auxvec.h           |    2 
 arch/s390/include/asm/elf.h              |   16 ++
 arch/s390/include/asm/mmu.h              |    1 
 arch/s390/include/asm/page.h             |    2 
 arch/s390/include/asm/vdso.h             |   39 +++++
 arch/s390/kernel/Makefile                |    9 -
 arch/s390/kernel/asm-offsets.c           |   15 ++
 arch/s390/kernel/time.c                  |   31 ++++
 arch/s390/kernel/vdso.c                  |  232 +++++++++++++++++++++++++++++++
 arch/s390/kernel/vdso32/Makefile         |   55 +++++++
 arch/s390/kernel/vdso32/clock_getres.S   |   39 +++++
 arch/s390/kernel/vdso32/clock_gettime.S  |  128 +++++++++++++++++
 arch/s390/kernel/vdso32/gettimeofday.S   |   82 ++++++++++
 arch/s390/kernel/vdso32/note.S           |   12 +
 arch/s390/kernel/vdso32/vdso32.lds.S     |  138 ++++++++++++++++++
 arch/s390/kernel/vdso32/vdso32_wrapper.S |   13 +
 arch/s390/kernel/vdso64/Makefile         |   55 +++++++
 arch/s390/kernel/vdso64/clock_getres.S   |   39 +++++
 arch/s390/kernel/vdso64/clock_gettime.S  |   89 +++++++++++
 arch/s390/kernel/vdso64/gettimeofday.S   |   56 +++++++
 arch/s390/kernel/vdso64/note.S           |   12 +
 arch/s390/kernel/vdso64/vdso64.lds.S     |  138 ++++++++++++++++++
 arch/s390/kernel/vdso64/vdso64_wrapper.S |   13 +
 24 files changed, 1217 insertions(+), 2 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/auxvec.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/auxvec.h
+++ quilt-2.6/arch/s390/include/asm/auxvec.h
@@ -1,4 +1,6 @@
 #ifndef __ASMS390_AUXVEC_H
 #define __ASMS390_AUXVEC_H
 
+#define AT_SYSINFO_EHDR		33
+
 #endif
Index: quilt-2.6/arch/s390/include/asm/elf.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/elf.h
+++ quilt-2.6/arch/s390/include/asm/elf.h
@@ -120,6 +120,10 @@ typedef s390_compat_regs compat_elf_greg
 #include <asm/system.h>		/* for save_access_regs */
 #include <asm/mmu_context.h>
 
+#include <asm/vdso.h>
+
+extern unsigned int vdso_enabled;
+
 /*
  * This is used to ensure we don't load something for the wrong architecture.
  */
@@ -193,4 +197,16 @@ do {							\
 	current->mm->context.noexec == 0;		\
 })
 
+#define ARCH_DLINFO							    \
+do {									    \
+	if (vdso_enabled)						    \
+		NEW_AUX_ENT(AT_SYSINFO_EHDR,				    \
+			    (unsigned long)current->mm->context.vdso_base); \
+} while (0)
+
+struct linux_binprm;
+
+#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
+int arch_setup_additional_pages(struct linux_binprm *, int);
+
 #endif
Index: quilt-2.6/arch/s390/include/asm/mmu.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/mmu.h
+++ quilt-2.6/arch/s390/include/asm/mmu.h
@@ -6,6 +6,7 @@ typedef struct {
 	struct list_head pgtable_list;
 	unsigned long asce_bits;
 	unsigned long asce_limit;
+	unsigned long vdso_base;
 	int noexec;
 	int has_pgste;	 /* The mmu context has extended page tables */
 	int alloc_pgste; /* cloned contexts will have extended page tables */
Index: quilt-2.6/arch/s390/include/asm/page.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/page.h
+++ quilt-2.6/arch/s390/include/asm/page.h
@@ -152,4 +152,6 @@ void arch_alloc_page(struct page *page, 
 #include <asm-generic/memory_model.h>
 #include <asm-generic/page.h>
 
+#define __HAVE_ARCH_GATE_AREA 1
+
 #endif /* _S390_PAGE_H */
Index: quilt-2.6/arch/s390/include/asm/vdso.h
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/include/asm/vdso.h
@@ -0,0 +1,39 @@
+#ifndef __S390_VDSO_H__
+#define __S390_VDSO_H__
+
+#ifdef __KERNEL__
+
+/* Default link addresses for the vDSOs */
+#define VDSO32_LBASE	0
+#define VDSO64_LBASE	0
+
+#define VDSO_VERSION_STRING	LINUX_2.6.26
+
+#ifndef __ASSEMBLY__
+
+/*
+ * Note about this structure:
+ *
+ * NEVER USE THIS IN USERSPACE CODE DIRECTLY. The layout of this
+ * structure is supposed to be known only to the function in the vdso
+ * itself and may change without notice.
+ */
+
+struct vdso_data {
+	__u64 tb_update_count;		/* Timebase atomicity ctr	0x00 */
+	__u64 xtime_tod_stamp;		/* TOD clock for xtime		0x08 */
+	__u64 xtime_clock_sec;		/* Kernel time			0x10 */
+	__u64 xtime_clock_nsec;		/*				0x18 */
+	__u64 wtom_clock_sec;		/* Wall to monotonic clock	0x20 */
+	__u64 wtom_clock_nsec;		/*				0x28 */
+	__u32 tz_minuteswest;		/* Minutes west of Greenwich	0x30 */
+	__u32 tz_dsttime;		/* Type of dst correction	0x34 */
+};
+
+extern struct vdso_data *vdso_data;
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* __KERNEL__ */
+
+#endif /* __S390_VDSO_H__ */
Index: quilt-2.6/arch/s390/Kconfig
===================================================================
--- quilt-2.6.orig/arch/s390/Kconfig
+++ quilt-2.6/arch/s390/Kconfig
@@ -43,6 +43,9 @@ config GENERIC_HWEIGHT
 config GENERIC_TIME
 	def_bool y
 
+config GENERIC_TIME_VSYSCALL
+	def_bool y
+
 config GENERIC_CLOCKEVENTS
 	def_bool y
 
Index: quilt-2.6/arch/s390/kernel/asm-offsets.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/asm-offsets.c
+++ quilt-2.6/arch/s390/kernel/asm-offsets.c
@@ -6,6 +6,7 @@
 
 #include <linux/sched.h>
 #include <linux/kbuild.h>
+#include <asm/vdso.h>
 
 int main(void)
 {
@@ -38,5 +39,19 @@ int main(void)
 	DEFINE(__SF_BACKCHAIN, offsetof(struct stack_frame, back_chain));
 	DEFINE(__SF_GPRS, offsetof(struct stack_frame, gprs));
 	DEFINE(__SF_EMPTY, offsetof(struct stack_frame, empty1));
+	BLANK();
+	/* timeval/timezone offsets for use by vdso */
+	DEFINE(__VDSO_UPD_COUNT, offsetof(struct vdso_data, tb_update_count));
+	DEFINE(__VDSO_XTIME_STAMP, offsetof(struct vdso_data, xtime_tod_stamp));
+	DEFINE(__VDSO_XTIME_SEC, offsetof(struct vdso_data, xtime_clock_sec));
+	DEFINE(__VDSO_XTIME_NSEC, offsetof(struct vdso_data, xtime_clock_nsec));
+	DEFINE(__VDSO_WTOM_SEC, offsetof(struct vdso_data, wtom_clock_sec));
+	DEFINE(__VDSO_WTOM_NSEC, offsetof(struct vdso_data, wtom_clock_nsec));
+	DEFINE(__VDSO_TIMEZONE, offsetof(struct vdso_data, tz_minuteswest));
+	/* constants used by the vdso */
+	DEFINE(CLOCK_REALTIME, CLOCK_REALTIME);
+	DEFINE(CLOCK_MONOTONIC, CLOCK_MONOTONIC);
+	DEFINE(CLOCK_REALTIME_RES, MONOTONIC_RES_NSEC);
+
 	return 0;
 }
Index: quilt-2.6/arch/s390/kernel/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/Makefile
+++ quilt-2.6/arch/s390/kernel/Makefile
@@ -13,8 +13,9 @@ CFLAGS_smp.o	:= -Wno-nonnull
 CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 
 obj-y	:=  bitmap.o traps.o time.o process.o base.o early.o \
-            setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
-	    s390_ext.o debug.o irq.o ipl.o dis.o diag.o mem_detect.o
+	    setup.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
+	    s390_ext.o debug.o irq.o ipl.o dis.o diag.o mem_detect.o \
+	    vdso.o
 
 obj-y	+= $(if $(CONFIG_64BIT),entry64.o,entry.o)
 obj-y	+= $(if $(CONFIG_64BIT),reipl64.o,reipl.o)
@@ -39,3 +40,7 @@ S390_KEXEC_OBJS := machine_kexec.o crash
 S390_KEXEC_OBJS += $(if $(CONFIG_64BIT),relocate_kernel64.o,relocate_kernel.o)
 obj-$(CONFIG_KEXEC) += $(S390_KEXEC_OBJS)
 
+# vdso
+obj-$(CONFIG_64BIT)		+= vdso64/
+obj-$(CONFIG_32BIT)		+= vdso32/
+obj-$(CONFIG_COMPAT)		+= vdso32/
Index: quilt-2.6/arch/s390/kernel/time.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/time.c
+++ quilt-2.6/arch/s390/kernel/time.c
@@ -36,6 +36,7 @@
 #include <asm/delay.h>
 #include <asm/s390_ext.h>
 #include <asm/div64.h>
+#include <asm/vdso.h>
 #include <asm/irq.h>
 #include <asm/irq_regs.h>
 #include <asm/timer.h>
@@ -223,6 +224,36 @@ static struct clocksource clocksource_to
 };
 
 
+void update_vsyscall(struct timespec *wall_time, struct clocksource *clock)
+{
+	if (clock != &clocksource_tod)
+		return;
+
+	/* Make userspace gettimeofday spin until we're done. */
+	++vdso_data->tb_update_count;
+	smp_mb();
+	vdso_data->xtime_tod_stamp = clock->cycle_last;
+	vdso_data->xtime_clock_sec = xtime.tv_sec;
+	vdso_data->xtime_clock_nsec = xtime.tv_nsec;
+	vdso_data->wtom_clock_sec = wall_to_monotonic.tv_sec;
+	vdso_data->wtom_clock_nsec = wall_to_monotonic.tv_nsec;
+	smp_wmb();
+	++(vdso_data->tb_update_count);
+}
+
+extern struct timezone sys_tz;
+
+void update_vsyscall_tz(void)
+{
+	/* Make userspace gettimeofday spin until we're done. */
+	++vdso_data->tb_update_count;
+	smp_mb();
+	vdso_data->tz_minuteswest = sys_tz.tz_minuteswest;
+	vdso_data->tz_dsttime = sys_tz.tz_dsttime;
+	smp_mb();
+	++vdso_data->tb_update_count;
+}
+
 /*
  * Initialize the TOD clock and the CPU timer of
  * the boot cpu.
Index: quilt-2.6/arch/s390/kernel/vdso32/clock_getres.S
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/vdso32/clock_getres.S
@@ -0,0 +1,39 @@
+/*
+ * Userland implementation of clock_getres() for 32 bits processes in a
+ * s390 kernel for use in the vDSO
+ *
+ *  Copyright IBM Corp. 2008
+ *  Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ */
+#include <asm/vdso.h>
+#include <asm/asm-offsets.h>
+#include <asm/unistd.h>
+
+	.text
+	.align 4
+	.globl __kernel_clock_getres
+	.type  __kernel_clock_getres,@function
+__kernel_clock_getres:
+	.cfi_startproc
+	chi	%r2,CLOCK_REALTIME
+	je	0f
+	chi	%r2,CLOCK_MONOTONIC
+	jne	3f
+0:	ltr	%r3,%r3
+	jz	2f				/* res == NULL */
+	basr	%r1,0
+1:	l	%r0,4f-1b(%r1)
+	xc	0(4,%r3),0(%r3)			/* set tp->tv_sec to zero */
+	st	%r0,4(%r3)			/* store tp->tv_usec */
+2:	lhi	%r2,0
+	br	%r14
+3:	lhi	%r1,__NR_clock_getres		/* fallback to svc */
+	svc	0
+	br	%r14
+4:	.long	CLOCK_REALTIME_RES
+	.cfi_endproc
+	.size	__kernel_clock_getres,.-__kernel_clock_getres
Index: quilt-2.6/arch/s390/kernel/vdso32/clock_gettime.S
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/vdso32/clock_gettime.S
@@ -0,0 +1,128 @@
+/*
+ * Userland implementation of clock_gettime() for 32 bits processes in a
+ * s390 kernel for use in the vDSO
+ *
+ *  Copyright IBM Corp. 2008
+ *  Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ */
+#include <asm/vdso.h>
+#include <asm/asm-offsets.h>
+#include <asm/unistd.h>
+
+	.text
+	.align 4
+	.globl __kernel_clock_gettime
+	.type  __kernel_clock_gettime,@function
+__kernel_clock_gettime:
+	.cfi_startproc
+	basr	%r5,0
+0:	al	%r5,21f-0b(%r5)			/* get &_vdso_data */
+	chi	%r2,CLOCK_REALTIME
+	je	10f
+	chi	%r2,CLOCK_MONOTONIC
+	jne	19f
+
+	/* CLOCK_MONOTONIC */
+	ltr	%r3,%r3
+	jz	9f				/* tp == NULL */
+1:	l	%r4,__VDSO_UPD_COUNT+4(%r5)	/* load update counter */
+	tml	%r4,0x0001			/* pending update ? loop */
+	jnz	1b
+	stck	24(%r15)			/* Store TOD clock */
+	lm	%r0,%r1,24(%r15)
+	s	%r0,__VDSO_XTIME_STAMP(%r5)	/* TOD - cycle_last */
+	sl	%r1,__VDSO_XTIME_STAMP+4(%r5)
+	brc	3,2f
+	ahi	%r0,-1
+2:	mhi	%r0,1000			/* cyc2ns(clock,cycle_delta) */
+	lr	%r2,%r0
+	lhi	%r0,1000
+	ltr	%r1,%r1
+	mr	%r0,%r0
+	jnm	3f
+	ahi	%r0,1000
+3:	alr	%r0,%r2
+	srdl	%r0,12
+	al	%r0,__VDSO_XTIME_NSEC(%r5)	/*  + xtime */
+	al	%r1,__VDSO_XTIME_NSEC+4(%r5)
+	brc	12,4f
+	ahi	%r0,1
+4:	l	%r2,__VDSO_XTIME_SEC+4(%r5)
+	al	%r0,__VDSO_WTOM_NSEC(%r5)	/*  + wall_to_monotonic */
+	al	%r1,__VDSO_WTOM_NSEC+4(%r5)
+	brc	12,5f
+	ahi	%r0,1
+5:	al	%r2,__VDSO_WTOM_SEC+4(%r5)
+	cl	%r4,__VDSO_UPD_COUNT+4(%r5)	/* check update counter */
+	jne	1b
+	basr	%r5,0
+6:	ltr	%r0,%r0
+	jnz	7f
+	cl	%r1,20f-6b(%r5)
+	jl	8f
+7:	ahi	%r2,1
+	sl	%r1,20f-6b(%r5)
+	brc	3,6b
+	ahi	%r0,-1
+	j	6b
+8:	st	%r2,0(%r3)			/* store tp->tv_sec */
+	st	%r1,4(%r3)			/* store tp->tv_nsec */
+9:	lhi	%r2,0
+	br	%r14
+
+	/* CLOCK_REALTIME */
+10:	ltr	%r3,%r3				/* tp == NULL */
+	jz	18f
+11:	l	%r4,__VDSO_UPD_COUNT+4(%r5)	/* load update counter */
+	tml	%r4,0x0001			/* pending update ? loop */
+	jnz	11b
+	stck	24(%r15)			/* Store TOD clock */
+	lm	%r0,%r1,24(%r15)
+	s	%r0,__VDSO_XTIME_STAMP(%r5)	/* TOD - cycle_last */
+	sl	%r1,__VDSO_XTIME_STAMP+4(%r5)
+	brc	3,12f
+	ahi	%r0,-1
+12:	mhi	%r0,1000			/* cyc2ns(clock,cycle_delta) */
+	lr	%r2,%r0
+	lhi	%r0,1000
+	ltr	%r1,%r1
+	mr	%r0,%r0
+	jnm	13f
+	ahi	%r0,1000
+13:	alr	%r0,%r2
+	srdl	%r0,12
+	al	%r0,__VDSO_XTIME_NSEC(%r5)	/*  + xtime */
+	al	%r1,__VDSO_XTIME_NSEC+4(%r5)
+	brc	12,14f
+	ahi	%r0,1
+14:	l	%r2,__VDSO_XTIME_SEC+4(%r5)
+	cl	%r4,__VDSO_UPD_COUNT+4(%r5)	/* check update counter */
+	jne	11b
+	basr	%r5,0
+15:	ltr	%r0,%r0
+	jnz	16f
+	cl	%r1,20f-15b(%r5)
+	jl	17f
+16:	ahi	%r2,1
+	sl	%r1,20f-15b(%r5)
+	brc	3,15b
+	ahi	%r0,-1
+	j	15b
+17:	st	%r2,0(%r3)			/* store tp->tv_sec */
+	st	%r1,4(%r3)			/* store tp->tv_nsec */
+18:	lhi	%r2,0
+	br	%r14
+
+	/* Fallback to system call */
+19:	lhi	%r1,__NR_clock_gettime
+	svc	0
+	br	%r14
+
+20:	.long	1000000000
+21:	.long	_vdso_data - 0b
+	.cfi_endproc
+	.size	__kernel_clock_gettime,.-__kernel_clock_gettime
Index: quilt-2.6/arch/s390/kernel/vdso32/gettimeofday.S
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/vdso32/gettimeofday.S
@@ -0,0 +1,82 @@
+/*
+ * Userland implementation of gettimeofday() for 32 bits processes in a
+ * s390 kernel for use in the vDSO
+ *
+ *  Copyright IBM Corp. 2008
+ *  Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ */
+#include <asm/vdso.h>
+#include <asm/asm-offsets.h>
+#include <asm/unistd.h>
+
+#include <asm/vdso.h>
+#include <asm/asm-offsets.h>
+#include <asm/unistd.h>
+
+	.text
+	.align 4
+	.globl __kernel_gettimeofday
+	.type  __kernel_gettimeofday,@function
+__kernel_gettimeofday:
+	.cfi_startproc
+	basr	%r5,0
+0:	al	%r5,13f-0b(%r5)			/* get &_vdso_data */
+1:	ltr	%r3,%r3				/* check if tz is NULL */
+	je	2f
+	mvc	0(8,%r3),__VDSO_TIMEZONE(%r5)
+2:	ltr	%r2,%r2				/* check if tv is NULL */
+	je	10f
+	l	%r4,__VDSO_UPD_COUNT+4(%r5)	/* load update counter */
+	tml	%r4,0x0001			/* pending update ? loop */
+	jnz	1b
+	stck	24(%r15)			/* Store TOD clock */
+	lm	%r0,%r1,24(%r15)
+	s	%r0,__VDSO_XTIME_STAMP(%r5)	/* TOD - cycle_last */
+	sl	%r1,__VDSO_XTIME_STAMP+4(%r5)
+	brc	3,3f
+	ahi	%r0,-1
+3:	mhi	%r0,1000			/* cyc2ns(clock,cycle_delta) */
+	st	%r0,24(%r15)
+	lhi	%r0,1000
+	ltr	%r1,%r1
+	mr	%r0,%r0
+	jnm	4f
+	ahi	%r0,1000
+4:	al	%r0,24(%r15)
+	srdl	%r0,12
+	al	%r0,__VDSO_XTIME_NSEC(%r5)	/*  + xtime */
+	al	%r1,__VDSO_XTIME_NSEC+4(%r5)
+	brc	12,5f
+	ahi	%r0,1
+5:	mvc	24(4,%r15),__VDSO_XTIME_SEC+4(%r5)
+	cl	%r4,__VDSO_UPD_COUNT+4(%r5)	/* check update counter */
+	jne	1b
+	l	%r4,24(%r15)			/* get tv_sec from stack */
+	basr	%r5,0
+6:	ltr	%r0,%r0
+	jnz	7f
+	cl	%r1,11f-6b(%r5)
+	jl	8f
+7:	ahi	%r4,1
+	sl	%r1,11f-6b(%r5)
+	brc	3,6b
+	ahi	%r0,-1
+	j	6b
+8:	st	%r4,0(%r2)			/* store tv->tv_sec */
+	ltr	%r1,%r1
+	m	%r0,12f-6b(%r5)
+	jnm	9f
+	al	%r0,12f-6b(%r5)
+9:	srl	%r0,6
+	st	%r0,4(%r2)			/* store tv->tv_usec */
+10:	slr	%r2,%r2
+	br	%r14
+11:	.long	1000000000
+12:	.long	274877907
+13:	.long	_vdso_data - 0b
+	.cfi_endproc
+	.size	__kernel_gettimeofday,.-__kernel_gettimeofday
Index: quilt-2.6/arch/s390/kernel/vdso32/Makefile
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/vdso32/Makefile
@@ -0,0 +1,55 @@
+# List of files in the vdso, has to be asm only for now
+
+obj-vdso32 = gettimeofday.o clock_getres.o clock_gettime.o note.o
+
+# Build rules
+
+targets := $(obj-vdso32) vdso32.so vdso32.so.dbg
+obj-vdso32 := $(addprefix $(obj)/, $(obj-vdso32))
+
+KBUILD_AFLAGS_31 := $(filter-out -m64,$(KBUILD_AFLAGS))
+KBUILD_AFLAGS_31 += -m31 -s
+
+KBUILD_CFLAGS_31 := $(filter-out -m64,$(KBUILD_CFLAGS))
+KBUILD_CFLAGS_31 += -m31 -fPIC -shared -fno-common -fno-builtin
+KBUILD_CFLAGS_31 += -nostdlib -Wl,-soname=linux-vdso32.so.1 \
+			$(call ld-option, -Wl$(comma)--hash-style=sysv)
+
+$(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_31)
+$(targets:%=$(obj)/%.dbg): KBUILD_AFLAGS = $(KBUILD_AFLAGS_31)
+
+obj-y += vdso32_wrapper.o
+extra-y += vdso32.lds
+CPPFLAGS_vdso32.lds += -P -C -U$(ARCH)
+
+# Force dependency (incbin is bad)
+$(obj)/vdso32_wrapper.o : $(obj)/vdso32.so
+
+# link rule for the .so file, .lds has to be first
+$(obj)/vdso32.so.dbg: $(src)/vdso32.lds $(obj-vdso32)
+	$(call if_changed,vdso32ld)
+
+# strip rule for the .so file
+$(obj)/%.so: OBJCOPYFLAGS := -S
+$(obj)/%.so: $(obj)/%.so.dbg FORCE
+	$(call if_changed,objcopy)
+
+# assembly rules for the .S files
+$(obj-vdso32): %.o: %.S
+	$(call if_changed_dep,vdso32as)
+
+# actual build commands
+quiet_cmd_vdso32ld = VDSO32L $@
+      cmd_vdso32ld = $(CC) $(c_flags) -Wl,-T $^ -o $@
+quiet_cmd_vdso32as = VDSO32A $@
+      cmd_vdso32as = $(CC) $(a_flags) -c -o $@ $<
+
+# install commands for the unstripped file
+quiet_cmd_vdso_install = INSTALL $@
+      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
+
+vdso32.so: $(obj)/vdso32.so.dbg
+	@mkdir -p $(MODLIB)/vdso
+	$(call cmd,vdso_install)
+
+vdso_install: vdso32.so
Index: quilt-2.6/arch/s390/kernel/vdso32/note.S
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/vdso32/note.S
@@ -0,0 +1,12 @@
+/*
+ * This supplies .note.* sections to go into the PT_NOTE inside the vDSO text.
+ * Here we can supply some information useful to userland.
+ */
+
+#include <linux/uts.h>
+#include <linux/version.h>
+#include <linux/elfnote.h>
+
+ELFNOTE_START(Linux, 0, "a")
+	.long LINUX_VERSION_CODE
+ELFNOTE_END
Index: quilt-2.6/arch/s390/kernel/vdso32/vdso32.lds.S
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/vdso32/vdso32.lds.S
@@ -0,0 +1,138 @@
+/*
+ * This is the infamous ld script for the 32 bits vdso
+ * library
+ */
+#include <asm/vdso.h>
+
+OUTPUT_FORMAT("elf32-s390", "elf32-s390", "elf32-s390")
+OUTPUT_ARCH(s390:31-bit)
+ENTRY(_start)
+
+SECTIONS
+{
+	. = VDSO32_LBASE + SIZEOF_HEADERS;
+
+	.hash		: { *(.hash) }			:text
+	.gnu.hash	: { *(.gnu.hash) }
+	.dynsym		: { *(.dynsym) }
+	.dynstr		: { *(.dynstr) }
+	.gnu.version	: { *(.gnu.version) }
+	.gnu.version_d	: { *(.gnu.version_d) }
+	.gnu.version_r	: { *(.gnu.version_r) }
+
+	.note		: { *(.note.*) }		:text	:note
+
+	. = ALIGN(16);
+	.text		: {
+		*(.text .stub .text.* .gnu.linkonce.t.*)
+	} :text
+	PROVIDE(__etext = .);
+	PROVIDE(_etext = .);
+	PROVIDE(etext = .);
+
+	/*
+	 * Other stuff is appended to the text segment:
+	 */
+	.rodata		: { *(.rodata .rodata.* .gnu.linkonce.r.*) }
+	.rodata1	: { *(.rodata1) }
+
+	.dynamic	: { *(.dynamic) }		:text	:dynamic
+
+	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
+	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
+	.gcc_except_table : { *(.gcc_except_table .gcc_except_table.*) }
+
+	.rela.dyn ALIGN(8) : { *(.rela.dyn) }
+	.got ALIGN(8)	: { *(.got .toc) }
+
+	_end = .;
+	PROVIDE(end = .);
+
+	/*
+	 * Stabs debugging sections are here too.
+	 */
+	.stab	       0 : { *(.stab) }
+	.stabstr       0 : { *(.stabstr) }
+	.stab.excl     0 : { *(.stab.excl) }
+	.stab.exclstr  0 : { *(.stab.exclstr) }
+	.stab.index    0 : { *(.stab.index) }
+	.stab.indexstr 0 : { *(.stab.indexstr) }
+	.comment       0 : { *(.comment) }
+
+	/*
+	 * DWARF debug sections.
+	 * Symbols in the DWARF debugging sections are relative to the
+	 * beginning of the section so we begin them at 0.
+	 */
+	/* DWARF 1 */
+	.debug		0 : { *(.debug) }
+	.line		0 : { *(.line) }
+	/* GNU DWARF 1 extensions */
+	.debug_srcinfo	0 : { *(.debug_srcinfo) }
+	.debug_sfnames	0 : { *(.debug_sfnames) }
+	/* DWARF 1.1 and DWARF 2 */
+	.debug_aranges	0 : { *(.debug_aranges) }
+	.debug_pubnames 0 : { *(.debug_pubnames) }
+	/* DWARF 2 */
+	.debug_info	0 : { *(.debug_info .gnu.linkonce.wi.*) }
+	.debug_abbrev	0 : { *(.debug_abbrev) }
+	.debug_line	0 : { *(.debug_line) }
+	.debug_frame	0 : { *(.debug_frame) }
+	.debug_str	0 : { *(.debug_str) }
+	.debug_loc	0 : { *(.debug_loc) }
+	.debug_macinfo	0 : { *(.debug_macinfo) }
+	/* SGI/MIPS DWARF 2 extensions */
+	.debug_weaknames 0 : { *(.debug_weaknames) }
+	.debug_funcnames 0 : { *(.debug_funcnames) }
+	.debug_typenames 0 : { *(.debug_typenames) }
+	.debug_varnames  0 : { *(.debug_varnames) }
+	/* DWARF 3 */
+	.debug_pubtypes 0 : { *(.debug_pubtypes) }
+	.debug_ranges	0 : { *(.debug_ranges) }
+	.gnu.attributes 0 : { KEEP (*(.gnu.attributes)) }
+
+	. = ALIGN(4096);
+	PROVIDE(_vdso_data = .);
+
+	/DISCARD/	: {
+		*(.note.GNU-stack)
+		*(.branch_lt)
+		*(.data .data.* .gnu.linkonce.d.* .sdata*)
+		*(.bss .sbss .dynbss .dynsbss)
+	}
+}
+
+/*
+ * Very old versions of ld do not recognize this name token; use the constant.
+ */
+#define PT_GNU_EH_FRAME	0x6474e550
+
+/*
+ * We must supply the ELF program headers explicitly to get just one
+ * PT_LOAD segment, and set the flags explicitly to make segments read-only.
+ */
+PHDRS
+{
+	text		PT_LOAD FILEHDR PHDRS FLAGS(5);	/* PF_R|PF_X */
+	dynamic		PT_DYNAMIC FLAGS(4);		/* PF_R */
+	note		PT_NOTE FLAGS(4);		/* PF_R */
+	eh_frame_hdr	PT_GNU_EH_FRAME;
+}
+
+/*
+ * This controls what symbols we export from the DSO.
+ */
+VERSION
+{
+	VDSO_VERSION_STRING {
+	global:
+		/*
+		 * Has to be there for the kernel to find
+		 */
+		__kernel_gettimeofday;
+		__kernel_clock_gettime;
+		__kernel_clock_getres;
+
+	local: *;
+	};
+}
Index: quilt-2.6/arch/s390/kernel/vdso32/vdso32_wrapper.S
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/vdso32/vdso32_wrapper.S
@@ -0,0 +1,13 @@
+#include <linux/init.h>
+#include <asm/page.h>
+
+	.section ".data.page_aligned"
+
+	.globl vdso32_start, vdso32_end
+	.balign PAGE_SIZE
+vdso32_start:
+	.incbin "arch/s390/kernel/vdso32/vdso32.so"
+	.balign PAGE_SIZE
+vdso32_end:
+
+	.previous
Index: quilt-2.6/arch/s390/kernel/vdso64/clock_getres.S
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/vdso64/clock_getres.S
@@ -0,0 +1,39 @@
+/*
+ * Userland implementation of clock_getres() for 64 bits processes in a
+ * s390 kernel for use in the vDSO
+ *
+ *  Copyright IBM Corp. 2008
+ *  Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ */
+#include <asm/vdso.h>
+#include <asm/asm-offsets.h>
+#include <asm/unistd.h>
+
+	.text
+	.align 4
+	.globl __kernel_clock_getres
+	.type  __kernel_clock_getres,@function
+__kernel_clock_getres:
+	.cfi_startproc
+	cghi	%r2,CLOCK_REALTIME
+	je	0f
+	cghi	%r2,CLOCK_MONOTONIC
+	jne	2f
+0:	ltgr	%r3,%r3
+	jz	1f				/* res == NULL */
+	larl	%r1,3f
+	lg	%r0,0(%r1)
+	xc	0(8,%r3),0(%r3)			/* set tp->tv_sec to zero */
+	stg	%r0,8(%r3)			/* store tp->tv_usec */
+1:	lghi	%r2,0
+	br	%r14
+2:	lghi	%r1,__NR_clock_getres		/* fallback to svc */
+	svc	0
+	br	%r14
+3:	.quad	CLOCK_REALTIME_RES
+	.cfi_endproc
+	.size	__kernel_clock_getres,.-__kernel_clock_getres
Index: quilt-2.6/arch/s390/kernel/vdso64/clock_gettime.S
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/vdso64/clock_gettime.S
@@ -0,0 +1,89 @@
+/*
+ * Userland implementation of clock_gettime() for 64 bits processes in a
+ * s390 kernel for use in the vDSO
+ *
+ *  Copyright IBM Corp. 2008
+ *  Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ */
+#include <asm/vdso.h>
+#include <asm/asm-offsets.h>
+#include <asm/unistd.h>
+
+	.text
+	.align 4
+	.globl __kernel_clock_gettime
+	.type  __kernel_clock_gettime,@function
+__kernel_clock_gettime:
+	.cfi_startproc
+	larl	%r5,_vdso_data
+	cghi	%r2,CLOCK_REALTIME
+	je	4f
+	cghi	%r2,CLOCK_MONOTONIC
+	jne	9f
+
+	/* CLOCK_MONOTONIC */
+	ltgr	%r3,%r3
+	jz	3f				/* tp == NULL */
+0:	lg	%r4,__VDSO_UPD_COUNT(%r5)	/* load update counter */
+	tmll	%r4,0x0001			/* pending update ? loop */
+	jnz	0b
+	stck	48(%r15)			/* Store TOD clock */
+	lg	%r1,48(%r15)
+	sg	%r1,__VDSO_XTIME_STAMP(%r5)	/* TOD - cycle_last */
+	mghi	%r1,1000
+	srlg	%r1,%r1,12			/* cyc2ns(clock,cycle_delta) */
+	alg	%r1,__VDSO_XTIME_NSEC(%r5)	/*  + xtime */
+	lg	%r0,__VDSO_XTIME_SEC(%r5)
+	alg	%r1,__VDSO_WTOM_NSEC(%r5)	/*  + wall_to_monotonic */
+	alg	%r0,__VDSO_WTOM_SEC(%r5)
+	clg	%r4,__VDSO_UPD_COUNT(%r5)	/* check update counter */
+	jne	0b
+	larl	%r5,10f
+1:	clg	%r1,0(%r5)
+	jl	2f
+	slg	%r1,0(%r5)
+	aghi	%r0,1
+	j	1b
+2:	stg	%r0,0(%r3)			/* store tp->tv_sec */
+	stg	%r1,8(%r3)			/* store tp->tv_nsec */
+3:	lghi	%r2,0
+	br	%r14
+
+	/* CLOCK_REALTIME */
+4:	ltr	%r3,%r3				/* tp == NULL */
+	jz	8f
+5:	lg	%r4,__VDSO_UPD_COUNT(%r5)	/* load update counter */
+	tmll	%r4,0x0001			/* pending update ? loop */
+	jnz	5b
+	stck	48(%r15)			/* Store TOD clock */
+	lg	%r1,48(%r15)
+	sg	%r1,__VDSO_XTIME_STAMP(%r5)	/* TOD - cycle_last */
+	mghi	%r1,1000
+	srlg	%r1,%r1,12			/* cyc2ns(clock,cycle_delta) */
+	alg	%r1,__VDSO_XTIME_NSEC(%r5)	/*  + xtime */
+	lg	%r0,__VDSO_XTIME_SEC(%r5)
+	clg	%r4,__VDSO_UPD_COUNT(%r5)	/* check update counter */
+	jne	5b
+	larl	%r5,10f
+6:	clg	%r1,0(%r5)
+	jl	7f
+	slg	%r1,0(%r5)
+	aghi	%r0,1
+	j	6b
+7:	stg	%r0,0(%r3)			/* store tp->tv_sec */
+	stg	%r1,8(%r3)			/* store tp->tv_nsec */
+8:	lghi	%r2,0
+	br	%r14
+
+	/* Fallback to system call */
+9:	lghi	%r1,__NR_clock_gettime
+	svc	0
+	br	%r14
+
+10:	.quad	1000000000
+	.cfi_endproc
+	.size	__kernel_clock_gettime,.-__kernel_clock_gettime
Index: quilt-2.6/arch/s390/kernel/vdso64/gettimeofday.S
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/vdso64/gettimeofday.S
@@ -0,0 +1,56 @@
+/*
+ * Userland implementation of gettimeofday() for 64 bits processes in a
+ * s390 kernel for use in the vDSO
+ *
+ *  Copyright IBM Corp. 2008
+ *  Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ */
+#include <asm/vdso.h>
+#include <asm/asm-offsets.h>
+#include <asm/unistd.h>
+
+	.text
+	.align 4
+	.globl __kernel_gettimeofday
+	.type  __kernel_gettimeofday,@function
+__kernel_gettimeofday:
+	.cfi_startproc
+	larl	%r5,_vdso_data
+0:	ltgr	%r3,%r3				/* check if tz is NULL */
+	je	1f
+	mvc	0(8,%r3),__VDSO_TIMEZONE(%r5)
+1:	ltgr	%r2,%r2				/* check if tv is NULL */
+	je	4f
+	lg	%r4,__VDSO_UPD_COUNT(%r5)	/* load update counter */
+	tmll	%r4,0x0001			/* pending update ? loop */
+	jnz	0b
+	stck	48(%r15)			/* Store TOD clock */
+	lg	%r1,48(%r15)
+	sg	%r1,__VDSO_XTIME_STAMP(%r5)	/* TOD - cycle_last */
+	mghi	%r1,1000
+	srlg	%r1,%r1,12			/* cyc2ns(clock,cycle_delta) */
+	alg	%r1,__VDSO_XTIME_NSEC(%r5)	/*  + xtime.tv_nsec */
+	lg	%r0,__VDSO_XTIME_SEC(%r5)	/* xtime.tv_sec */
+	clg	%r4,__VDSO_UPD_COUNT(%r5)	/* check update counter */
+	jne	0b
+	larl	%r5,5f
+2:	clg	%r1,0(%r5)
+	jl	3f
+	slg	%r1,0(%r5)
+	aghi	%r0,1
+	j	2b
+3:	stg	%r0,0(%r2)			/* store tv->tv_sec */
+	slgr	%r0,%r0				/* tv_nsec -> tv_usec */
+	ml	%r0,8(%r5)
+	srlg	%r0,%r0,6
+	stg	%r0,8(%r2)			/* store tv->tv_usec */
+4:	lghi	%r2,0
+	br	%r14
+5:	.quad	1000000000
+	.long	274877907
+	.cfi_endproc
+	.size	__kernel_gettimeofday,.-__kernel_gettimeofday
Index: quilt-2.6/arch/s390/kernel/vdso64/Makefile
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/vdso64/Makefile
@@ -0,0 +1,55 @@
+# List of files in the vdso, has to be asm only for now
+
+obj-vdso64 = gettimeofday.o clock_getres.o clock_gettime.o note.o
+
+# Build rules
+
+targets := $(obj-vdso64) vdso64.so vdso64.so.dbg
+obj-vdso64 := $(addprefix $(obj)/, $(obj-vdso64))
+
+KBUILD_AFLAGS_64 := $(filter-out -m64,$(KBUILD_AFLAGS))
+KBUILD_AFLAGS_64 += -m64 -s
+
+KBUILD_CFLAGS_64 := $(filter-out -m64,$(KBUILD_CFLAGS))
+KBUILD_CFLAGS_64 += -m64 -fPIC -shared -fno-common -fno-builtin
+KBUILD_CFLAGS_64 += -nostdlib -Wl,-soname=linux-vdso64.so.1 \
+			$(call ld-option, -Wl$(comma)--hash-style=sysv)
+
+$(targets:%=$(obj)/%.dbg): KBUILD_CFLAGS = $(KBUILD_CFLAGS_64)
+$(targets:%=$(obj)/%.dbg): KBUILD_AFLAGS = $(KBUILD_AFLAGS_64)
+
+obj-y += vdso64_wrapper.o
+extra-y += vdso64.lds
+CPPFLAGS_vdso64.lds += -P -C -U$(ARCH)
+
+# Force dependency (incbin is bad)
+$(obj)/vdso64_wrapper.o : $(obj)/vdso64.so
+
+# link rule for the .so file, .lds has to be first
+$(obj)/vdso64.so.dbg: $(src)/vdso64.lds $(obj-vdso64)
+	$(call if_changed,vdso64ld)
+
+# strip rule for the .so file
+$(obj)/%.so: OBJCOPYFLAGS := -S
+$(obj)/%.so: $(obj)/%.so.dbg FORCE
+	$(call if_changed,objcopy)
+
+# assembly rules for the .S files
+$(obj-vdso64): %.o: %.S
+	$(call if_changed_dep,vdso64as)
+
+# actual build commands
+quiet_cmd_vdso64ld = VDSO64L $@
+      cmd_vdso64ld = $(CC) $(c_flags) -Wl,-T $^ -o $@
+quiet_cmd_vdso64as = VDSO64A $@
+      cmd_vdso64as = $(CC) $(a_flags) -c -o $@ $<
+
+# install commands for the unstripped file
+quiet_cmd_vdso_install = INSTALL $@
+      cmd_vdso_install = cp $(obj)/$@.dbg $(MODLIB)/vdso/$@
+
+vdso64.so: $(obj)/vdso64.so.dbg
+	@mkdir -p $(MODLIB)/vdso
+	$(call cmd,vdso_install)
+
+vdso_install: vdso64.so
Index: quilt-2.6/arch/s390/kernel/vdso64/note.S
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/vdso64/note.S
@@ -0,0 +1,12 @@
+/*
+ * This supplies .note.* sections to go into the PT_NOTE inside the vDSO text.
+ * Here we can supply some information useful to userland.
+ */
+
+#include <linux/uts.h>
+#include <linux/version.h>
+#include <linux/elfnote.h>
+
+ELFNOTE_START(Linux, 0, "a")
+	.long LINUX_VERSION_CODE
+ELFNOTE_END
Index: quilt-2.6/arch/s390/kernel/vdso64/vdso64.lds.S
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/vdso64/vdso64.lds.S
@@ -0,0 +1,138 @@
+/*
+ * This is the infamous ld script for the 64 bits vdso
+ * library
+ */
+#include <asm/vdso.h>
+
+OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
+OUTPUT_ARCH(s390:64-bit)
+ENTRY(_start)
+
+SECTIONS
+{
+	. = VDSO64_LBASE + SIZEOF_HEADERS;
+
+	.hash		: { *(.hash) }			:text
+	.gnu.hash	: { *(.gnu.hash) }
+	.dynsym		: { *(.dynsym) }
+	.dynstr		: { *(.dynstr) }
+	.gnu.version	: { *(.gnu.version) }
+	.gnu.version_d	: { *(.gnu.version_d) }
+	.gnu.version_r	: { *(.gnu.version_r) }
+
+	.note		: { *(.note.*) }		:text	:note
+
+	. = ALIGN(16);
+	.text		: {
+		*(.text .stub .text.* .gnu.linkonce.t.*)
+	} :text
+	PROVIDE(__etext = .);
+	PROVIDE(_etext = .);
+	PROVIDE(etext = .);
+
+	/*
+	 * Other stuff is appended to the text segment:
+	 */
+	.rodata		: { *(.rodata .rodata.* .gnu.linkonce.r.*) }
+	.rodata1	: { *(.rodata1) }
+
+	.dynamic	: { *(.dynamic) }		:text	:dynamic
+
+	.eh_frame_hdr	: { *(.eh_frame_hdr) }		:text	:eh_frame_hdr
+	.eh_frame	: { KEEP (*(.eh_frame)) }	:text
+	.gcc_except_table : { *(.gcc_except_table .gcc_except_table.*) }
+
+	.rela.dyn ALIGN(8) : { *(.rela.dyn) }
+	.got ALIGN(8)	: { *(.got .toc) }
+
+	_end = .;
+	PROVIDE(end = .);
+
+	/*
+	 * Stabs debugging sections are here too.
+	 */
+	.stab	       0 : { *(.stab) }
+	.stabstr       0 : { *(.stabstr) }
+	.stab.excl     0 : { *(.stab.excl) }
+	.stab.exclstr  0 : { *(.stab.exclstr) }
+	.stab.index    0 : { *(.stab.index) }
+	.stab.indexstr 0 : { *(.stab.indexstr) }
+	.comment       0 : { *(.comment) }
+
+	/*
+	 * DWARF debug sections.
+	 * Symbols in the DWARF debugging sections are relative to the
+	 * beginning of the section so we begin them at 0.
+	 */
+	/* DWARF 1 */
+	.debug		0 : { *(.debug) }
+	.line		0 : { *(.line) }
+	/* GNU DWARF 1 extensions */
+	.debug_srcinfo	0 : { *(.debug_srcinfo) }
+	.debug_sfnames	0 : { *(.debug_sfnames) }
+	/* DWARF 1.1 and DWARF 2 */
+	.debug_aranges	0 : { *(.debug_aranges) }
+	.debug_pubnames 0 : { *(.debug_pubnames) }
+	/* DWARF 2 */
+	.debug_info	0 : { *(.debug_info .gnu.linkonce.wi.*) }
+	.debug_abbrev	0 : { *(.debug_abbrev) }
+	.debug_line	0 : { *(.debug_line) }
+	.debug_frame	0 : { *(.debug_frame) }
+	.debug_str	0 : { *(.debug_str) }
+	.debug_loc	0 : { *(.debug_loc) }
+	.debug_macinfo	0 : { *(.debug_macinfo) }
+	/* SGI/MIPS DWARF 2 extensions */
+	.debug_weaknames 0 : { *(.debug_weaknames) }
+	.debug_funcnames 0 : { *(.debug_funcnames) }
+	.debug_typenames 0 : { *(.debug_typenames) }
+	.debug_varnames  0 : { *(.debug_varnames) }
+	/* DWARF 3 */
+	.debug_pubtypes 0 : { *(.debug_pubtypes) }
+	.debug_ranges	0 : { *(.debug_ranges) }
+	.gnu.attributes 0 : { KEEP (*(.gnu.attributes)) }
+
+	. = ALIGN(4096);
+	PROVIDE(_vdso_data = .);
+
+	/DISCARD/	: {
+		*(.note.GNU-stack)
+		*(.branch_lt)
+		*(.data .data.* .gnu.linkonce.d.* .sdata*)
+		*(.bss .sbss .dynbss .dynsbss)
+	}
+}
+
+/*
+ * Very old versions of ld do not recognize this name token; use the constant.
+ */
+#define PT_GNU_EH_FRAME	0x6474e550
+
+/*
+ * We must supply the ELF program headers explicitly to get just one
+ * PT_LOAD segment, and set the flags explicitly to make segments read-only.
+ */
+PHDRS
+{
+	text		PT_LOAD FILEHDR PHDRS FLAGS(5);	/* PF_R|PF_X */
+	dynamic		PT_DYNAMIC FLAGS(4);		/* PF_R */
+	note		PT_NOTE FLAGS(4);		/* PF_R */
+	eh_frame_hdr	PT_GNU_EH_FRAME;
+}
+
+/*
+ * This controls what symbols we export from the DSO.
+ */
+VERSION
+{
+	VDSO_VERSION_STRING {
+	global:
+		/*
+		 * Has to be there for the kernel to find
+		 */
+		__kernel_gettimeofday;
+		__kernel_clock_gettime;
+		__kernel_clock_getres;
+
+	local: *;
+	};
+}
Index: quilt-2.6/arch/s390/kernel/vdso64/vdso64_wrapper.S
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/vdso64/vdso64_wrapper.S
@@ -0,0 +1,13 @@
+#include <linux/init.h>
+#include <asm/page.h>
+
+	.section ".data.page_aligned"
+
+	.globl vdso64_start, vdso64_end
+	.balign PAGE_SIZE
+vdso64_start:
+	.incbin "arch/s390/kernel/vdso64/vdso64.so"
+	.balign PAGE_SIZE
+vdso64_end:
+
+	.previous
Index: quilt-2.6/arch/s390/kernel/vdso.c
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/vdso.c
@@ -0,0 +1,232 @@
+/*
+ * vdso setup for s390
+ *
+ *  Copyright IBM Corp. 2008
+ *  Author(s): Martin Schwidefsky (schwidefsky@de.ibm.com)
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License (version 2 only)
+ * as published by the Free Software Foundation.
+ */
+
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/smp.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+#include <linux/slab.h>
+#include <linux/user.h>
+#include <linux/elf.h>
+#include <linux/security.h>
+#include <linux/bootmem.h>
+
+#include <asm/pgtable.h>
+#include <asm/system.h>
+#include <asm/processor.h>
+#include <asm/mmu.h>
+#include <asm/mmu_context.h>
+#include <asm/sections.h>
+#include <asm/vdso.h>
+
+/* Max supported size for symbol names */
+#define MAX_SYMNAME	64
+
+#if defined(CONFIG_32BIT) || defined(CONFIG_COMPAT)
+extern char vdso32_start, vdso32_end;
+static void *vdso32_kbase = &vdso32_start;
+static unsigned int vdso32_pages;
+static struct page **vdso32_pagelist;
+#endif
+
+#ifdef CONFIG_64BIT
+extern char vdso64_start, vdso64_end;
+static void *vdso64_kbase = &vdso64_start;
+static unsigned int vdso64_pages;
+static struct page **vdso64_pagelist;
+#endif /* CONFIG_64BIT */
+
+/*
+ * Should the kernel map a VDSO page into processes and pass its
+ * address down to glibc upon exec()?
+ */
+unsigned int __read_mostly vdso_enabled = 1;
+
+static int __init vdso_setup(char *s)
+{
+	vdso_enabled = simple_strtoul(s, NULL, 0);
+	return 1;
+}
+__setup("vdso=", vdso_setup);
+
+/*
+ * The vdso data page
+ */
+static union {
+	struct vdso_data	data;
+	u8			page[PAGE_SIZE];
+} vdso_data_store __attribute__((__section__(".data.page_aligned")));
+struct vdso_data *vdso_data = &vdso_data_store.data;
+
+/*
+ * This is called from binfmt_elf, we create the special vma for the
+ * vDSO and insert it into the mm struct tree
+ */
+int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
+{
+	struct mm_struct *mm = current->mm;
+	struct page **vdso_pagelist;
+	unsigned long vdso_pages;
+	unsigned long vdso_base;
+	int rc;
+
+	/*
+	 * Only map the vdso for dynamically linked elf binaries.
+	 */
+	if (!uses_interp)
+		return 0;
+
+	vdso_base = mm->mmap_base;
+#ifdef CONFIG_64BIT
+	vdso_pagelist = vdso64_pagelist;
+	vdso_pages = vdso64_pages;
+#ifdef CONFIG_COMPAT
+	if (test_thread_flag(TIF_31BIT)) {
+		vdso_pagelist = vdso32_pagelist;
+		vdso_pages = vdso32_pages;
+	}
+#endif
+#else
+	vdso_pagelist = vdso32_pagelist;
+	vdso_pages = vdso32_pages;
+#endif
+
+	/*
+	 * vDSO has a problem and was disabled, just don't "enable" it for
+	 * the process
+	 */
+	if (vdso_pages == 0)
+		return 0;
+
+	current->mm->context.vdso_base = 0;
+
+	/*
+	 * pick a base address for the vDSO in process space. We try to put
+	 * it at vdso_base which is the "natural" base for it, but we might
+	 * fail and end up putting it elsewhere.
+	 */
+	down_write(&mm->mmap_sem);
+	vdso_base = get_unmapped_area(NULL, vdso_base,
+				      vdso_pages << PAGE_SHIFT, 0, 0);
+	if (IS_ERR_VALUE(vdso_base)) {
+		rc = vdso_base;
+		goto out_up;
+	}
+
+	/*
+	 * our vma flags don't have VM_WRITE so by default, the process
+	 * isn't allowed to write those pages.
+	 * gdb can break that with ptrace interface, and thus trigger COW
+	 * on those pages but it's then your responsibility to never do that
+	 * on the "data" page of the vDSO or you'll stop getting kernel
+	 * updates and your nice userland gettimeofday will be totally dead.
+	 * It's fine to use that for setting breakpoints in the vDSO code
+	 * pages though
+	 *
+	 * Make sure the vDSO gets into every core dump.
+	 * Dumping its contents makes post-mortem fully interpretable later
+	 * without matching up the same kernel and hardware config to see
+	 * what PC values meant.
+	 */
+	rc = install_special_mapping(mm, vdso_base, vdso_pages << PAGE_SHIFT,
+				     VM_READ|VM_EXEC|
+				     VM_MAYREAD|VM_MAYWRITE|VM_MAYEXEC|
+				     VM_ALWAYSDUMP,
+				     vdso_pagelist);
+	if (rc)
+		goto out_up;
+
+	/* Put vDSO base into mm struct */
+	current->mm->context.vdso_base = vdso_base;
+
+	up_write(&mm->mmap_sem);
+	return 0;
+
+out_up:
+	up_write(&mm->mmap_sem);
+	return rc;
+}
+
+const char *arch_vma_name(struct vm_area_struct *vma)
+{
+	if (vma->vm_mm && vma->vm_start == vma->vm_mm->context.vdso_base)
+		return "[vdso]";
+	return NULL;
+}
+
+static int __init vdso_init(void)
+{
+	int i;
+
+#if defined(CONFIG_32BIT) || defined(CONFIG_COMPAT)
+	/* Calculate the size of the 32 bit vDSO */
+	vdso32_pages = ((&vdso32_end - &vdso32_start
+			 + PAGE_SIZE - 1) >> PAGE_SHIFT) + 1;
+
+	/* Make sure pages are in the correct state */
+	vdso32_pagelist = kzalloc(sizeof(struct page *) * (vdso32_pages + 1),
+				  GFP_KERNEL);
+	BUG_ON(vdso32_pagelist == NULL);
+	for (i = 0; i < vdso32_pages - 1; i++) {
+		struct page *pg = virt_to_page(vdso32_kbase + i*PAGE_SIZE);
+		ClearPageReserved(pg);
+		get_page(pg);
+		vdso32_pagelist[i] = pg;
+	}
+	vdso32_pagelist[vdso32_pages - 1] = virt_to_page(vdso_data);
+	vdso32_pagelist[vdso32_pages] = NULL;
+#endif
+
+#ifdef CONFIG_64BIT
+	/* Calculate the size of the 64 bit vDSO */
+	vdso64_pages = ((&vdso64_end - &vdso64_start
+			 + PAGE_SIZE - 1) >> PAGE_SHIFT) + 1;
+
+	/* Make sure pages are in the correct state */
+	vdso64_pagelist = kzalloc(sizeof(struct page *) * (vdso64_pages + 1),
+				  GFP_KERNEL);
+	BUG_ON(vdso64_pagelist == NULL);
+	for (i = 0; i < vdso64_pages - 1; i++) {
+		struct page *pg = virt_to_page(vdso64_kbase + i*PAGE_SIZE);
+		ClearPageReserved(pg);
+		get_page(pg);
+		vdso64_pagelist[i] = pg;
+	}
+	vdso64_pagelist[vdso64_pages - 1] = virt_to_page(vdso_data);
+	vdso64_pagelist[vdso64_pages] = NULL;
+#endif /* CONFIG_64BIT */
+
+	get_page(virt_to_page(vdso_data));
+
+	smp_wmb();
+
+	return 0;
+}
+arch_initcall(vdso_init);
+
+int in_gate_area_no_task(unsigned long addr)
+{
+	return 0;
+}
+
+int in_gate_area(struct task_struct *task, unsigned long addr)
+{
+	return 0;
+}
+
+struct vm_area_struct *get_gate_vma(struct task_struct *tsk)
+{
+	return NULL;
+}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
