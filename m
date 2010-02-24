Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084448.616386828@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:38 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/32] [PATCH] zfcpdump: remove cross arch dump support
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=107-zfcpdump-cross-dump.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Remove support to be able to dump 31 bit systems with a 64 bit dumper.
This is mostly useless since no distro ships 31 bit kernels together
with a 64 bit dumper.
We also get rid of a bit of hacky code.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/lowcore.h |   26 ++-----
 arch/s390/include/asm/smp.h     |    2 
 arch/s390/kernel/head64.S       |   70 -------------------
 arch/s390/kernel/smp.c          |   19 -----
 arch/s390/kvm/kvm-s390.c        |   20 ++---
 drivers/s390/char/zcore.c       |  146 +++++++++++++---------------------------
 6 files changed, 75 insertions(+), 208 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/lowcore.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/lowcore.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/lowcore.h	2010-02-24 09:44:24.000000000 +0100
@@ -144,7 +144,9 @@
 void mcck_int_handler(void);
 void io_int_handler(void);
 
-struct save_area_s390 {
+#ifdef CONFIG_32BIT
+
+struct save_area {
 	u32	ext_save;
 	u64	timer;
 	u64	clk_cmp;
@@ -158,7 +160,11 @@
 	u32	ctrl_regs[16];
 }  __attribute__((packed));
 
-struct save_area_s390x {
+#define SAVE_AREA_BASE offsetof(struct _lowcore, extended_save_area_addr)
+
+#else /* CONFIG_32BIT */
+
+struct save_area {
 	u64	fp_regs[16];
 	u64	gp_regs[16];
 	u8	psw[16];
@@ -174,21 +180,9 @@
 	u64	ctrl_regs[16];
 }  __attribute__((packed));
 
-union save_area {
-	struct save_area_s390	s390;
-	struct save_area_s390x	s390x;
-};
+#define SAVE_AREA_BASE offsetof(struct _lowcore, floating_pt_save_area)
 
-#define SAVE_AREA_BASE_S390	0xd4
-#define SAVE_AREA_BASE_S390X	0x1200
-
-#ifndef __s390x__
-#define SAVE_AREA_SIZE sizeof(struct save_area_s390)
-#define SAVE_AREA_BASE SAVE_AREA_BASE_S390
-#else
-#define SAVE_AREA_SIZE sizeof(struct save_area_s390x)
-#define SAVE_AREA_BASE SAVE_AREA_BASE_S390X
-#endif
+#endif /* CONFIG_32BIT */
 
 #ifndef __s390x__
 #define LC_ORDER 0
Index: quilt-2.6/arch/s390/include/asm/smp.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/smp.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/smp.h	2010-02-24 09:44:24.000000000 +0100
@@ -29,7 +29,7 @@
 extern void arch_send_call_function_single_ipi(int cpu);
 extern void arch_send_call_function_ipi_mask(const struct cpumask *mask);
 
-extern union save_area *zfcpdump_save_areas[NR_CPUS + 1];
+extern struct save_area *zfcpdump_save_areas[NR_CPUS + 1];
 
 #endif /* CONFIG_SMP */
 
Index: quilt-2.6/arch/s390/kernel/head64.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/head64.S	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/head64.S	2010-02-24 09:44:24.000000000 +0100
@@ -16,71 +16,9 @@
 	basr	%r13,0			# get base
 .LPG1:	sll	%r13,1			# remove high order bit
 	srl	%r13,1
-
-#ifdef CONFIG_ZFCPDUMP
-
-	# check if we have been ipled using zfcp dump:
-
-	tm	0xb9,0x01		# test if subchannel is enabled
-	jno	.nodump			# subchannel disabled
-	l	%r1,0xb8
-	la	%r5,.Lipl_schib-.LPG1(%r13)
-	stsch	0(%r5)			# get schib of subchannel
-	jne	.nodump			# schib not available
-	tm	5(%r5),0x01		# devno valid?
-	jno	.nodump
-	tm	4(%r5),0x80		# qdio capable device?
-	jno	.nodump
-	l	%r2,20(%r0)		# address of ipl parameter block
-	lhi	%r3,0
-	ic	%r3,0x148(%r2)		# get opt field
-	chi	%r3,0x20		# load with dump?
-	jne	.nodump
-
-	# store all prefix registers in case of load with dump:
-
-	la	%r7,0			# base register for 0 page
-	la	%r8,0			# first cpu
-	l	%r11,.Lpref_arr_ptr-.LPG1(%r13)	# address of prefix array
-	ahi	%r11,4			# skip boot cpu
-	lr	%r12,%r11
-	ahi	%r12,(CONFIG_NR_CPUS*4)	# end of prefix array
-	stap	.Lcurrent_cpu+2-.LPG1(%r13)	# store current cpu addr
-1:
-	cl	%r8,.Lcurrent_cpu-.LPG1(%r13)	# is ipl cpu ?
-	je	4f				# if yes get next cpu
-2:
-	lr	%r9,%r7
-	sigp	%r9,%r8,0x9		# stop & store status of cpu
-	brc	8,3f			# accepted
-	brc	4,4f			# status stored: next cpu
-	brc	2,2b			# busy: 	 try again
-	brc	1,4f			# not op:	 next cpu
-3:
-	mvc	0(4,%r11),264(%r7)	# copy prefix register to prefix array
-	ahi	%r11,4			# next element in prefix array
-	clr	%r11,%r12
-	je	5f			# no more space in prefix array
-4:
-	ahi	%r8,1			# next cpu (r8 += 1)
-	chi	%r8,MAX_CPU_ADDRESS	# is last possible cpu ?
-	jle	1b			# jump if not last cpu
-5:
-	lhi	%r1,2			# mode 2 = esame (dump)
-	j	6f
-	.align 4
-.Lipl_schib:
-	.rept 13
-	.long 0
-	.endr
-.nodump:
-	lhi	%r1,1			# mode 1 = esame (normal ipl)
-6:
-#else
-	lhi	%r1,1			# mode 1 = esame (normal ipl)
-#endif /* CONFIG_ZFCPDUMP */
 	mvi	__LC_AR_MODE_ID,1	# set esame flag
 	slr	%r0,%r0 		# set cpuid to zero
+	lhi	%r1,2			# mode 2 = esame (dump)
 	sigp	%r1,%r0,0x12		# switch to esame mode
 	sam64				# switch to 64 bit mode
 	llgfr	%r13,%r13		# clear high-order half of base reg
@@ -130,12 +68,6 @@
 .Lscan2g:.quad	0x80000000 + 0x20000 - 8	# 2GB + 128K - 8
 .Lnop:	.long	0x07000700
 .Lzero64:.fill	16,4,0x0
-#ifdef CONFIG_ZFCPDUMP
-.Lcurrent_cpu:
-	.long 0x0
-.Lpref_arr_ptr:
-	.long zfcpdump_prefix_array
-#endif /* CONFIG_ZFCPDUMP */
 .Lparmaddr:
 	.quad	PARMAREA
 	.align	64
Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/smp.c	2010-02-24 09:44:24.000000000 +0100
@@ -248,15 +248,6 @@
 
 #ifdef CONFIG_ZFCPDUMP
 
-/*
- * zfcpdump_prefix_array holds prefix registers for the following scenario:
- * 64 bit zfcpdump kernel and 31 bit kernel which is to be dumped. We have to
- * save its prefix registers, since they get lost, when switching from 31 bit
- * to 64 bit.
- */
-unsigned int zfcpdump_prefix_array[NR_CPUS + 1] \
-	__attribute__((__section__(".data")));
-
 static void __init smp_get_save_area(unsigned int cpu, unsigned int phy_cpu)
 {
 	if (ipl_info.type != IPL_TYPE_FCP_DUMP)
@@ -266,21 +257,17 @@
 			   "the dump\n", cpu, NR_CPUS - 1);
 		return;
 	}
-	zfcpdump_save_areas[cpu] = kmalloc(sizeof(union save_area), GFP_KERNEL);
+	zfcpdump_save_areas[cpu] = kmalloc(sizeof(struct save_area), GFP_KERNEL);
 	__cpu_logical_map[CPU_INIT_NO] = (__u16) phy_cpu;
 	while (signal_processor(CPU_INIT_NO, sigp_stop_and_store_status) ==
 	       sigp_busy)
 		cpu_relax();
 	memcpy(zfcpdump_save_areas[cpu],
 	       (void *)(unsigned long) store_prefix() + SAVE_AREA_BASE,
-	       SAVE_AREA_SIZE);
-#ifdef CONFIG_64BIT
-	/* copy original prefix register */
-	zfcpdump_save_areas[cpu]->s390x.pref_reg = zfcpdump_prefix_array[cpu];
-#endif
+	       sizeof(struct save_area));
 }
 
-union save_area *zfcpdump_save_areas[NR_CPUS + 1];
+struct save_area *zfcpdump_save_areas[NR_CPUS + 1];
 EXPORT_SYMBOL_GPL(zfcpdump_save_areas);
 
 #else
Index: quilt-2.6/arch/s390/kvm/kvm-s390.c
===================================================================
--- quilt-2.6.orig/arch/s390/kvm/kvm-s390.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kvm/kvm-s390.c	2010-02-24 09:44:24.000000000 +0100
@@ -603,45 +603,45 @@
 	} else
 		prefix = 0;
 
-	if (__guestcopy(vcpu, addr + offsetof(struct save_area_s390x, fp_regs),
+	if (__guestcopy(vcpu, addr + offsetof(struct save_area, fp_regs),
 			vcpu->arch.guest_fpregs.fprs, 128, prefix))
 		return -EFAULT;
 
-	if (__guestcopy(vcpu, addr + offsetof(struct save_area_s390x, gp_regs),
+	if (__guestcopy(vcpu, addr + offsetof(struct save_area, gp_regs),
 			vcpu->arch.guest_gprs, 128, prefix))
 		return -EFAULT;
 
-	if (__guestcopy(vcpu, addr + offsetof(struct save_area_s390x, psw),
+	if (__guestcopy(vcpu, addr + offsetof(struct save_area, psw),
 			&vcpu->arch.sie_block->gpsw, 16, prefix))
 		return -EFAULT;
 
-	if (__guestcopy(vcpu, addr + offsetof(struct save_area_s390x, pref_reg),
+	if (__guestcopy(vcpu, addr + offsetof(struct save_area, pref_reg),
 			&vcpu->arch.sie_block->prefix, 4, prefix))
 		return -EFAULT;
 
 	if (__guestcopy(vcpu,
-			addr + offsetof(struct save_area_s390x, fp_ctrl_reg),
+			addr + offsetof(struct save_area, fp_ctrl_reg),
 			&vcpu->arch.guest_fpregs.fpc, 4, prefix))
 		return -EFAULT;
 
-	if (__guestcopy(vcpu, addr + offsetof(struct save_area_s390x, tod_reg),
+	if (__guestcopy(vcpu, addr + offsetof(struct save_area, tod_reg),
 			&vcpu->arch.sie_block->todpr, 4, prefix))
 		return -EFAULT;
 
-	if (__guestcopy(vcpu, addr + offsetof(struct save_area_s390x, timer),
+	if (__guestcopy(vcpu, addr + offsetof(struct save_area, timer),
 			&vcpu->arch.sie_block->cputm, 8, prefix))
 		return -EFAULT;
 
-	if (__guestcopy(vcpu, addr + offsetof(struct save_area_s390x, clk_cmp),
+	if (__guestcopy(vcpu, addr + offsetof(struct save_area, clk_cmp),
 			&vcpu->arch.sie_block->ckc, 8, prefix))
 		return -EFAULT;
 
-	if (__guestcopy(vcpu, addr + offsetof(struct save_area_s390x, acc_regs),
+	if (__guestcopy(vcpu, addr + offsetof(struct save_area, acc_regs),
 			&vcpu->arch.guest_acrs, 64, prefix))
 		return -EFAULT;
 
 	if (__guestcopy(vcpu,
-			addr + offsetof(struct save_area_s390x, ctrl_regs),
+			addr + offsetof(struct save_area, ctrl_regs),
 			&vcpu->arch.sie_block->gcr, 128, prefix))
 		return -EFAULT;
 	return 0;
Index: quilt-2.6/drivers/s390/char/zcore.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/zcore.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/drivers/s390/char/zcore.c	2010-02-24 09:44:24.000000000 +0100
@@ -40,12 +40,12 @@
 /* dump system info */
 
 struct sys_info {
-	enum arch_id	arch;
-	unsigned long	sa_base;
-	u32		sa_size;
-	int		cpu_map[NR_CPUS];
-	unsigned long	mem_size;
-	union save_area	lc_mask;
+	enum arch_id	 arch;
+	unsigned long	 sa_base;
+	u32		 sa_size;
+	int		 cpu_map[NR_CPUS];
+	unsigned long	 mem_size;
+	struct save_area lc_mask;
 };
 
 struct ipib_info {
@@ -183,52 +183,9 @@
 	return 0;
 }
 
-#ifdef __s390x__
-/*
- * Convert s390x (64 bit) cpu info to s390 (32 bit) cpu info
- */
-static void __init s390x_to_s390_regs(union save_area *out, union save_area *in,
-				      int cpu)
-{
-	int i;
-
-	for (i = 0; i < 16; i++) {
-		out->s390.gp_regs[i] = in->s390x.gp_regs[i] & 0x00000000ffffffff;
-		out->s390.acc_regs[i] = in->s390x.acc_regs[i];
-		out->s390.ctrl_regs[i] =
-			in->s390x.ctrl_regs[i] & 0x00000000ffffffff;
-	}
-	/* locore for 31 bit has only space for fpregs 0,2,4,6 */
-	out->s390.fp_regs[0] = in->s390x.fp_regs[0];
-	out->s390.fp_regs[1] = in->s390x.fp_regs[2];
-	out->s390.fp_regs[2] = in->s390x.fp_regs[4];
-	out->s390.fp_regs[3] = in->s390x.fp_regs[6];
-	memcpy(&(out->s390.psw[0]), &(in->s390x.psw[0]), 4);
-	out->s390.psw[1] |= 0x8; /* set bit 12 */
-	memcpy(&(out->s390.psw[4]),&(in->s390x.psw[12]), 4);
-	out->s390.psw[4] |= 0x80; /* set (31bit) addressing bit */
-	out->s390.pref_reg = in->s390x.pref_reg;
-	out->s390.timer = in->s390x.timer;
-	out->s390.clk_cmp = in->s390x.clk_cmp;
-}
-
-static void __init s390x_to_s390_save_areas(void)
-{
-	int i = 1;
-	static union save_area tmp;
-
-	while (zfcpdump_save_areas[i]) {
-		s390x_to_s390_regs(&tmp, zfcpdump_save_areas[i], i);
-		memcpy(zfcpdump_save_areas[i], &tmp, sizeof(tmp));
-		i++;
-	}
-}
-
-#endif /* __s390x__ */
-
 static int __init init_cpu_info(enum arch_id arch)
 {
-	union save_area *sa;
+	struct save_area *sa;
 
 	/* get info for boot cpu from lowcore, stored in the HSA */
 
@@ -241,14 +198,6 @@
 		return -EIO;
 	}
 	zfcpdump_save_areas[0] = sa;
-
-#ifdef __s390x__
-	/* convert s390x regs to s390, if we are dumping an s390 Linux */
-
-	if (arch == ARCH_S390)
-		s390x_to_s390_save_areas();
-#endif
-
 	return 0;
 }
 
@@ -289,7 +238,7 @@
 	.dump_level	= 0,
 	.page_size	= PAGE_SIZE,
 	.mem_start	= 0,
-#ifdef __s390x__
+#ifdef CONFIG_64BIT
 	.build_arch	= DUMP_ARCH_S390X,
 #else
 	.build_arch	= DUMP_ARCH_S390,
@@ -340,11 +289,7 @@
 		unsigned long prefix;
 		unsigned long sa_off, len, buf_off;
 
-		if (sys_info.arch == ARCH_S390)
-			prefix = zfcpdump_save_areas[i]->s390.pref_reg;
-		else
-			prefix = zfcpdump_save_areas[i]->s390x.pref_reg;
-
+		prefix = zfcpdump_save_areas[i]->pref_reg;
 		sa_start = prefix + sys_info.sa_base;
 		sa_end = prefix + sys_info.sa_base + sys_info.sa_size;
 
@@ -561,34 +506,39 @@
 	.release	= zcore_reipl_release,
 };
 
+#ifdef CONFIG_32BIT
 
-static void __init set_s390_lc_mask(union save_area *map)
+static void __init set_lc_mask(struct save_area *map)
 {
-	memset(&map->s390.ext_save, 0xff, sizeof(map->s390.ext_save));
-	memset(&map->s390.timer, 0xff, sizeof(map->s390.timer));
-	memset(&map->s390.clk_cmp, 0xff, sizeof(map->s390.clk_cmp));
-	memset(&map->s390.psw, 0xff, sizeof(map->s390.psw));
-	memset(&map->s390.pref_reg, 0xff, sizeof(map->s390.pref_reg));
-	memset(&map->s390.acc_regs, 0xff, sizeof(map->s390.acc_regs));
-	memset(&map->s390.fp_regs, 0xff, sizeof(map->s390.fp_regs));
-	memset(&map->s390.gp_regs, 0xff, sizeof(map->s390.gp_regs));
-	memset(&map->s390.ctrl_regs, 0xff, sizeof(map->s390.ctrl_regs));
-}
-
-static void __init set_s390x_lc_mask(union save_area *map)
-{
-	memset(&map->s390x.fp_regs, 0xff, sizeof(map->s390x.fp_regs));
-	memset(&map->s390x.gp_regs, 0xff, sizeof(map->s390x.gp_regs));
-	memset(&map->s390x.psw, 0xff, sizeof(map->s390x.psw));
-	memset(&map->s390x.pref_reg, 0xff, sizeof(map->s390x.pref_reg));
-	memset(&map->s390x.fp_ctrl_reg, 0xff, sizeof(map->s390x.fp_ctrl_reg));
-	memset(&map->s390x.tod_reg, 0xff, sizeof(map->s390x.tod_reg));
-	memset(&map->s390x.timer, 0xff, sizeof(map->s390x.timer));
-	memset(&map->s390x.clk_cmp, 0xff, sizeof(map->s390x.clk_cmp));
-	memset(&map->s390x.acc_regs, 0xff, sizeof(map->s390x.acc_regs));
-	memset(&map->s390x.ctrl_regs, 0xff, sizeof(map->s390x.ctrl_regs));
+	memset(&map->ext_save, 0xff, sizeof(map->ext_save));
+	memset(&map->timer, 0xff, sizeof(map->timer));
+	memset(&map->clk_cmp, 0xff, sizeof(map->clk_cmp));
+	memset(&map->psw, 0xff, sizeof(map->psw));
+	memset(&map->pref_reg, 0xff, sizeof(map->pref_reg));
+	memset(&map->acc_regs, 0xff, sizeof(map->acc_regs));
+	memset(&map->fp_regs, 0xff, sizeof(map->fp_regs));
+	memset(&map->gp_regs, 0xff, sizeof(map->gp_regs));
+	memset(&map->ctrl_regs, 0xff, sizeof(map->ctrl_regs));
+}
+
+#else /* CONFIG_32BIT */
+
+static void __init set_lc_mask(struct save_area *map)
+{
+	memset(&map->fp_regs, 0xff, sizeof(map->fp_regs));
+	memset(&map->gp_regs, 0xff, sizeof(map->gp_regs));
+	memset(&map->psw, 0xff, sizeof(map->psw));
+	memset(&map->pref_reg, 0xff, sizeof(map->pref_reg));
+	memset(&map->fp_ctrl_reg, 0xff, sizeof(map->fp_ctrl_reg));
+	memset(&map->tod_reg, 0xff, sizeof(map->tod_reg));
+	memset(&map->timer, 0xff, sizeof(map->timer));
+	memset(&map->clk_cmp, 0xff, sizeof(map->clk_cmp));
+	memset(&map->acc_regs, 0xff, sizeof(map->acc_regs));
+	memset(&map->ctrl_regs, 0xff, sizeof(map->ctrl_regs));
 }
 
+#endif /* CONFIG_32BIT */
+
 /*
  * Initialize dump globals for a given architecture
  */
@@ -599,21 +549,18 @@
 	switch (arch) {
 	case ARCH_S390X:
 		pr_alert("DETECTED 'S390X (64 bit) OS'\n");
-		sys_info.sa_base = SAVE_AREA_BASE_S390X;
-		sys_info.sa_size = sizeof(struct save_area_s390x);
-		set_s390x_lc_mask(&sys_info.lc_mask);
 		break;
 	case ARCH_S390:
 		pr_alert("DETECTED 'S390 (32 bit) OS'\n");
-		sys_info.sa_base = SAVE_AREA_BASE_S390;
-		sys_info.sa_size = sizeof(struct save_area_s390);
-		set_s390_lc_mask(&sys_info.lc_mask);
 		break;
 	default:
 		pr_alert("0x%x is an unknown architecture.\n",arch);
 		return -EINVAL;
 	}
+	sys_info.sa_base = SAVE_AREA_BASE;
+	sys_info.sa_size = sizeof(struct save_area);
 	sys_info.arch = arch;
+	set_lc_mask(&sys_info.lc_mask);
 	rc = init_cpu_info(arch);
 	if (rc)
 		return rc;
@@ -741,14 +688,21 @@
 	if (rc)
 		goto fail;
 
-#ifndef __s390x__
+#ifdef CONFIG_64BIT
+	if (arch == ARCH_S390) {
+		pr_alert("The 64-bit dump tool cannot be used for a "
+			 "32-bit system\n");
+		rc = -EINVAL;
+		goto fail;
+	}
+#else /* CONFIG_64BIT */
 	if (arch == ARCH_S390X) {
 		pr_alert("The 32-bit dump tool cannot be used for a "
 			 "64-bit system\n");
 		rc = -EINVAL;
 		goto fail;
 	}
-#endif
+#endif /* CONFIG_64BIT */
 
 	rc = sys_info_init(arch);
 	if (rc)
