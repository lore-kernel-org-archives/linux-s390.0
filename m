Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084451.256286616@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:50 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 20/32] [PATCH] Cleanup struct _lowcore usage and defines.
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=119-lowcore-cleanup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Use asm offsets to make sure the offset defines to struct _lowcore and
its layout don't get out of sync.
Also add a BUILD_BUG_ON() which checks that the size of the structure
is sane.
And while being at it change those sites which use odd casts to access
the current lowcore. These should use S390_lowcore instead.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/lowcore.h     |  241 ++++++++----------------------------
 arch/s390/include/asm/setup.h       |    6 
 arch/s390/include/asm/thread_info.h |    2 
 arch/s390/kernel/asm-offsets.c      |   91 ++++++++++++-
 arch/s390/kernel/base.S             |    2 
 arch/s390/kernel/entry.S            |    1 
 arch/s390/kernel/entry64.S          |    2 
 arch/s390/kernel/ftrace.c           |    2 
 arch/s390/kernel/head.S             |    1 
 arch/s390/kernel/ipl.c              |    6 
 arch/s390/kernel/reipl.S            |    2 
 arch/s390/kernel/reipl64.S          |    2 
 arch/s390/kernel/setup.c            |    7 -
 arch/s390/kernel/smp.c              |    3 
 arch/s390/kernel/switch_cpu.S       |    1 
 arch/s390/kernel/switch_cpu64.S     |    1 
 arch/s390/kernel/vdso.c             |    1 
 arch/s390/kvm/interrupt.c           |   10 -
 arch/s390/kvm/kvm-s390.c            |    1 
 arch/s390/mm/fault.c                |    1 
 drivers/s390/char/zcore.c           |    1 
 drivers/s390/cio/ccwreq.c           |    2 
 drivers/s390/cio/chsc_sch.c         |    2 
 drivers/s390/cio/cio.c              |   12 -
 drivers/s390/cio/device_fsm.c       |    4 
 drivers/s390/kvm/kvm_virtio.c       |    4 
 26 files changed, 174 insertions(+), 234 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/lowcore.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/lowcore.h	2010-02-24 09:44:24.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/lowcore.h	2010-02-24 09:44:26.000000000 +0100
@@ -1,144 +1,16 @@
 /*
- *  include/asm-s390/lowcore.h
- *
- *  S390 version
- *    Copyright (C) 1999,2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Hartmut Penner (hp@de.ibm.com),
- *               Martin Schwidefsky (schwidefsky@de.ibm.com),
- *               Denis Joseph Barrow (djbarrow@de.ibm.com,barrow_dj@yahoo.com)
+ *    Copyright IBM Corp. 1999,2010
+ *    Author(s): Hartmut Penner <hp@de.ibm.com>,
+ *		 Martin Schwidefsky <schwidefsky@de.ibm.com>,
+ *		 Denis Joseph Barrow,
  */
 
 #ifndef _ASM_S390_LOWCORE_H
 #define _ASM_S390_LOWCORE_H
 
-#define __LC_IPL_PARMBLOCK_PTR		0x0014
-#define __LC_EXT_PARAMS			0x0080
-#define __LC_CPU_ADDRESS		0x0084
-#define __LC_EXT_INT_CODE		0x0086
-
-#define __LC_SVC_ILC			0x0088
-#define __LC_SVC_INT_CODE		0x008a
-#define __LC_PGM_ILC			0x008c
-#define __LC_PGM_INT_CODE		0x008e
-
-#define __LC_PER_ATMID			0x0096
-#define __LC_PER_ADDRESS		0x0098
-#define __LC_PER_ACCESS_ID		0x00a1
-#define __LC_AR_MODE_ID			0x00a3
-
-#define __LC_SUBCHANNEL_ID		0x00b8
-#define __LC_SUBCHANNEL_NR		0x00ba
-#define __LC_IO_INT_PARM		0x00bc
-#define __LC_IO_INT_WORD		0x00c0
-#define __LC_STFL_FAC_LIST		0x00c8
-#define __LC_MCCK_CODE			0x00e8
-
-#define __LC_DUMP_REIPL			0x0e00
-
-#ifndef __s390x__
-#define __LC_RST_NEW_PSW		0x0000
-#define __LC_RST_OLD_PSW		0x0008
-#define __LC_EXT_OLD_PSW		0x0018
-#define __LC_SVC_OLD_PSW		0x0020
-#define __LC_PGM_OLD_PSW		0x0028
-#define __LC_MCK_OLD_PSW		0x0030
-#define __LC_IO_OLD_PSW			0x0038
-#define __LC_EXT_NEW_PSW		0x0058
-#define __LC_SVC_NEW_PSW		0x0060
-#define __LC_PGM_NEW_PSW		0x0068
-#define __LC_MCK_NEW_PSW		0x0070
-#define __LC_IO_NEW_PSW			0x0078
-#define __LC_SAVE_AREA			0x0200
-#define __LC_RETURN_PSW			0x0240
-#define __LC_RETURN_MCCK_PSW		0x0248
-#define __LC_SYNC_ENTER_TIMER		0x0250
-#define __LC_ASYNC_ENTER_TIMER		0x0258
-#define __LC_EXIT_TIMER			0x0260
-#define __LC_USER_TIMER			0x0268
-#define __LC_SYSTEM_TIMER		0x0270
-#define __LC_STEAL_TIMER		0x0278
-#define __LC_LAST_UPDATE_TIMER		0x0280
-#define __LC_LAST_UPDATE_CLOCK		0x0288
-#define __LC_CURRENT			0x0290
-#define __LC_THREAD_INFO		0x0294
-#define __LC_KERNEL_STACK		0x0298
-#define __LC_ASYNC_STACK		0x029c
-#define __LC_PANIC_STACK		0x02a0
-#define __LC_KERNEL_ASCE		0x02a4
-#define __LC_USER_ASCE			0x02a8
-#define __LC_USER_EXEC_ASCE		0x02ac
-#define __LC_CPUID			0x02b0
-#define __LC_INT_CLOCK			0x02c8
-#define __LC_MACHINE_FLAGS		0x02d8
-#define __LC_FTRACE_FUNC		0x02dc
-#define __LC_IRB			0x0300
-#define __LC_PFAULT_INTPARM		0x0080
-#define __LC_CPU_TIMER_SAVE_AREA	0x00d8
-#define __LC_CLOCK_COMP_SAVE_AREA	0x00e0
-#define __LC_PSW_SAVE_AREA		0x0100
-#define __LC_PREFIX_SAVE_AREA		0x0108
-#define __LC_AREGS_SAVE_AREA		0x0120
-#define __LC_FPREGS_SAVE_AREA		0x0160
-#define __LC_GPREGS_SAVE_AREA		0x0180
-#define __LC_CREGS_SAVE_AREA		0x01c0
-#else /* __s390x__ */
-#define __LC_LAST_BREAK			0x0110
-#define __LC_RST_OLD_PSW		0x0120
-#define __LC_EXT_OLD_PSW		0x0130
-#define __LC_SVC_OLD_PSW		0x0140
-#define __LC_PGM_OLD_PSW		0x0150
-#define __LC_MCK_OLD_PSW		0x0160
-#define __LC_IO_OLD_PSW			0x0170
-#define __LC_RST_NEW_PSW		0x01a0
-#define __LC_EXT_NEW_PSW		0x01b0
-#define __LC_SVC_NEW_PSW		0x01c0
-#define __LC_PGM_NEW_PSW		0x01d0
-#define __LC_MCK_NEW_PSW		0x01e0
-#define __LC_IO_NEW_PSW			0x01f0
-#define __LC_SAVE_AREA			0x0200
-#define __LC_RETURN_PSW			0x0280
-#define __LC_RETURN_MCCK_PSW		0x0290
-#define __LC_SYNC_ENTER_TIMER		0x02a0
-#define __LC_ASYNC_ENTER_TIMER		0x02a8
-#define __LC_EXIT_TIMER			0x02b0
-#define __LC_USER_TIMER			0x02b8
-#define __LC_SYSTEM_TIMER		0x02c0
-#define __LC_STEAL_TIMER		0x02c8
-#define __LC_LAST_UPDATE_TIMER		0x02d0
-#define __LC_LAST_UPDATE_CLOCK		0x02d8
-#define __LC_CURRENT			0x02e0
-#define __LC_THREAD_INFO		0x02e8
-#define __LC_KERNEL_STACK		0x02f0
-#define __LC_ASYNC_STACK		0x02f8
-#define __LC_PANIC_STACK		0x0300
-#define __LC_KERNEL_ASCE		0x0308
-#define __LC_USER_ASCE			0x0310
-#define __LC_USER_EXEC_ASCE		0x0318
-#define __LC_CPUID			0x0320
-#define __LC_INT_CLOCK			0x0340
-#define __LC_VDSO_PER_CPU		0x0350
-#define __LC_MACHINE_FLAGS		0x0358
-#define __LC_FTRACE_FUNC		0x0360
-#define __LC_IRB			0x0380
-#define __LC_PASTE			0x03c0
-#define __LC_PFAULT_INTPARM		0x11b8
-#define __LC_FPREGS_SAVE_AREA		0x1200
-#define __LC_GPREGS_SAVE_AREA		0x1280
-#define __LC_PSW_SAVE_AREA		0x1300
-#define __LC_PREFIX_SAVE_AREA		0x1318
-#define __LC_FP_CREG_SAVE_AREA		0x131c
-#define __LC_TODREG_SAVE_AREA		0x1324
-#define __LC_CPU_TIMER_SAVE_AREA	0x1328
-#define __LC_CLOCK_COMP_SAVE_AREA	0x1331
-#define __LC_AREGS_SAVE_AREA		0x1340
-#define __LC_CREGS_SAVE_AREA		0x1380
-#endif /* __s390x__ */
-
-#ifndef __ASSEMBLY__
-
-#include <asm/cpu.h>
-#include <asm/ptrace.h>
 #include <linux/types.h>
+#include <asm/ptrace.h>
+#include <asm/cpu.h>
 
 void restart_int_handler(void);
 void ext_int_handler(void);
@@ -149,6 +21,9 @@
 
 #ifdef CONFIG_32BIT
 
+#define LC_ORDER 0
+#define LC_PAGES 1
+
 struct save_area {
 	u32	ext_save;
 	u64	timer;
@@ -161,46 +36,13 @@
 	u64	fp_regs[4];
 	u32	gp_regs[16];
 	u32	ctrl_regs[16];
-}  __attribute__((packed));
-
-#define SAVE_AREA_BASE offsetof(struct _lowcore, extended_save_area_addr)
-
-#else /* CONFIG_32BIT */
-
-struct save_area {
-	u64	fp_regs[16];
-	u64	gp_regs[16];
-	u8	psw[16];
-	u8	pad1[8];
-	u32	pref_reg;
-	u32	fp_ctrl_reg;
-	u8	pad2[4];
-	u32	tod_reg;
-	u64	timer;
-	u64	clk_cmp;
-	u8	pad3[8];
-	u32	acc_regs[16];
-	u64	ctrl_regs[16];
-}  __attribute__((packed));
-
-#define SAVE_AREA_BASE offsetof(struct _lowcore, floating_pt_save_area)
-
-#endif /* CONFIG_32BIT */
-
-#ifndef __s390x__
-#define LC_ORDER 0
-#else
-#define LC_ORDER 1
-#endif
+} __packed;
 
-#define LC_PAGES (1UL << LC_ORDER)
-
-struct _lowcore
-{
-#ifndef __s390x__
-	/* 0x0000 - 0x01ff: defined by architecture */
+struct _lowcore {
 	psw_t	restart_psw;			/* 0x0000 */
-	__u32	ccw2[4];			/* 0x0008 */
+	psw_t	restart_old_psw;		/* 0x0008 */
+	__u8	pad_0x0010[0x0014-0x0010];	/* 0x0010 */
+	__u32	ipl_parmblock_ptr;		/* 0x0014 */
 	psw_t	external_old_psw;		/* 0x0018 */
 	psw_t	svc_old_psw;			/* 0x0020 */
 	psw_t	program_old_psw;		/* 0x0028 */
@@ -226,7 +68,9 @@
 	__u32	monitor_code;			/* 0x009c */
 	__u8	exc_access_id;			/* 0x00a0 */
 	__u8	per_access_id;			/* 0x00a1 */
-	__u8	pad_0x00a2[0x00b8-0x00a2];	/* 0x00a2 */
+	__u8	op_access_id;			/* 0x00a2 */
+	__u8	ar_access_id;			/* 0x00a3 */
+	__u8	pad_0x00a4[0x00b8-0x00a4];	/* 0x00a4 */
 	__u16	subchannel_id;			/* 0x00b8 */
 	__u16	subchannel_nr;			/* 0x00ba */
 	__u32	io_int_parm;			/* 0x00bc */
@@ -242,8 +86,9 @@
 	__u32	external_damage_code;		/* 0x00f4 */
 	__u32	failing_storage_address;	/* 0x00f8 */
 	__u8	pad_0x00fc[0x0100-0x00fc];	/* 0x00fc */
-	__u32	st_status_fixed_logout[4];	/* 0x0100 */
-	__u8	pad_0x0110[0x0120-0x0110];	/* 0x0110 */
+	psw_t	psw_save_area;			/* 0x0100 */
+	__u32	prefixreg_save_area;		/* 0x0108 */
+	__u8	pad_0x010c[0x0120-0x010c];	/* 0x010c */
 
 	/* CPU register save area: defined by architecture */
 	__u32	access_regs_save_area[16];	/* 0x0120 */
@@ -307,10 +152,32 @@
 
 	/* Align to the top 1k of prefix area */
 	__u8	pad_0x0e08[0x1000-0x0e08];	/* 0x0e08 */
-#else /* !__s390x__ */
-	/* 0x0000 - 0x01ff: defined by architecture */
-	__u32	ccw1[2];			/* 0x0000 */
-	__u32	ccw2[4];			/* 0x0008 */
+} __packed;
+
+#else /* CONFIG_32BIT */
+
+#define LC_ORDER 1
+#define LC_PAGES 2
+
+struct save_area {
+	u64	fp_regs[16];
+	u64	gp_regs[16];
+	u8	psw[16];
+	u8	pad1[8];
+	u32	pref_reg;
+	u32	fp_ctrl_reg;
+	u8	pad2[4];
+	u32	tod_reg;
+	u64	timer;
+	u64	clk_cmp;
+	u8	pad3[8];
+	u32	acc_regs[16];
+	u64	ctrl_regs[16];
+} __packed;
+
+struct _lowcore {
+	__u8	pad_0x0000[0x0014-0x0000];	/* 0x0000 */
+	__u32	ipl_parmblock_ptr;		/* 0x0014 */
 	__u8	pad_0x0018[0x0080-0x0018];	/* 0x0018 */
 	__u32	ext_params;			/* 0x0080 */
 	__u16	cpu_addr;			/* 0x0084 */
@@ -341,7 +208,9 @@
 	__u8	pad_0x00f0[0x00f4-0x00f0];	/* 0x00f0 */
 	__u32	external_damage_code;		/* 0x00f4 */
 	addr_t	failing_storage_address;	/* 0x00f8 */
-	__u8	pad_0x0100[0x0120-0x0100];	/* 0x0100 */
+	__u8	pad_0x0100[0x0110-0x0100];	/* 0x0100 */
+	__u64	breaking_event_addr;		/* 0x0110 */
+	__u8	pad_0x0118[0x0120-0x0118];	/* 0x0118 */
 	psw_t	restart_old_psw;		/* 0x0120 */
 	psw_t	external_old_psw;		/* 0x0130 */
 	psw_t	svc_old_psw;			/* 0x0140 */
@@ -422,7 +291,7 @@
 	/* CPU register save area: defined by architecture */
 	__u64	floating_pt_save_area[16];	/* 0x1200 */
 	__u64	gpregs_save_area[16];		/* 0x1280 */
-	__u32	st_status_fixed_logout[4];	/* 0x1300 */
+	psw_t	psw_save_area;			/* 0x1300 */
 	__u8	pad_0x1310[0x1318-0x1310];	/* 0x1310 */
 	__u32	prefixreg_save_area;		/* 0x1318 */
 	__u32	fpt_creg_save_area;		/* 0x131c */
@@ -436,10 +305,12 @@
 
 	/* align to the top of the prefix area */
 	__u8	pad_0x1400[0x2000-0x1400];	/* 0x1400 */
-#endif /* !__s390x__ */
-} __attribute__((packed)); /* End structure*/
+} __packed;
+
+#endif /* CONFIG_32BIT */
 
 #define S390_lowcore (*((struct _lowcore *) 0))
+
 extern struct _lowcore *lowcore_ptr[];
 
 static inline void set_prefix(__u32 address)
@@ -455,6 +326,4 @@
 	return address;
 }
 
-#endif
-
-#endif
+#endif /* _ASM_S390_LOWCORE_H */
Index: quilt-2.6/arch/s390/include/asm/setup.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/setup.h	2010-02-24 09:44:25.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/setup.h	2010-02-24 09:44:26.000000000 +0100
@@ -14,14 +14,14 @@
 
 #ifdef __KERNEL__
 
-#include <asm/lowcore.h>
-#include <asm/types.h>
-
 #define PARMAREA		0x10400
 #define MEMORY_CHUNKS		256
 
 #ifndef __ASSEMBLY__
 
+#include <asm/lowcore.h>
+#include <asm/types.h>
+
 #ifndef __s390x__
 #define IPL_DEVICE        (*(unsigned long *)  (0x10404))
 #define INITRD_START      (*(unsigned long *)  (0x1040C))
Index: quilt-2.6/arch/s390/include/asm/thread_info.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/thread_info.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/thread_info.h	2010-02-24 09:44:26.000000000 +0100
@@ -73,7 +73,7 @@
 /* how to get the thread information struct from C */
 static inline struct thread_info *current_thread_info(void)
 {
-	return (struct thread_info *)((*(unsigned long *) __LC_KERNEL_STACK)-THREAD_SIZE);
+	return (struct thread_info *)(S390_lowcore.kernel_stack - THREAD_SIZE);
 }
 
 #define THREAD_SIZE_ORDER THREAD_ORDER
Index: quilt-2.6/arch/s390/kernel/asm-offsets.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/asm-offsets.c	2010-02-24 09:44:24.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/asm-offsets.c	2010-02-24 09:44:26.000000000 +0100
@@ -4,8 +4,10 @@
  * and format the required data.
  */
 
-#include <linux/sched.h>
+#define ASM_OFFSETS_C
+
 #include <linux/kbuild.h>
+#include <linux/sched.h>
 #include <asm/vdso.h>
 #include <asm/sigp.h>
 
@@ -22,8 +24,7 @@
 	DEFINE(__THREAD_info, offsetof(struct task_struct, stack));
 	DEFINE(__THREAD_ksp, offsetof(struct task_struct, thread.ksp));
 	DEFINE(__THREAD_per, offsetof(struct task_struct, thread.per_info));
-	DEFINE(__THREAD_mm_segment,
-	       offsetof(struct task_struct, thread.mm_segment));
+	DEFINE(__THREAD_mm_segment, offsetof(struct task_struct, thread.mm_segment));
 	BLANK();
 	DEFINE(__TASK_pid, offsetof(struct task_struct, pid));
 	BLANK();
@@ -60,18 +61,94 @@
 	DEFINE(__VDSO_WTOM_NSEC, offsetof(struct vdso_data, wtom_clock_nsec));
 	DEFINE(__VDSO_TIMEZONE, offsetof(struct vdso_data, tz_minuteswest));
 	DEFINE(__VDSO_ECTG_OK, offsetof(struct vdso_data, ectg_available));
-	DEFINE(__VDSO_ECTG_BASE,
-	       offsetof(struct vdso_per_cpu_data, ectg_timer_base));
-	DEFINE(__VDSO_ECTG_USER,
-	       offsetof(struct vdso_per_cpu_data, ectg_user_time));
+	DEFINE(__VDSO_ECTG_BASE, offsetof(struct vdso_per_cpu_data, ectg_timer_base));
+	DEFINE(__VDSO_ECTG_USER, offsetof(struct vdso_per_cpu_data, ectg_user_time));
 	/* constants used by the vdso */
 	DEFINE(CLOCK_REALTIME, CLOCK_REALTIME);
 	DEFINE(CLOCK_MONOTONIC, CLOCK_MONOTONIC);
 	DEFINE(CLOCK_REALTIME_RES, MONOTONIC_RES_NSEC);
+	BLANK();
 	/* constants for SIGP */
 	DEFINE(__SIGP_STOP, sigp_stop);
 	DEFINE(__SIGP_RESTART, sigp_restart);
 	DEFINE(__SIGP_SENSE, sigp_sense);
 	DEFINE(__SIGP_INITIAL_CPU_RESET, sigp_initial_cpu_reset);
+	BLANK();
+	/* lowcore offsets */
+	DEFINE(__LC_EXT_PARAMS, offsetof(struct _lowcore, ext_params));
+	DEFINE(__LC_CPU_ADDRESS, offsetof(struct _lowcore, cpu_addr));
+	DEFINE(__LC_EXT_INT_CODE, offsetof(struct _lowcore, ext_int_code));
+	DEFINE(__LC_SVC_ILC, offsetof(struct _lowcore, svc_ilc));
+	DEFINE(__LC_SVC_INT_CODE, offsetof(struct _lowcore, svc_code));
+	DEFINE(__LC_PGM_ILC, offsetof(struct _lowcore, pgm_ilc));
+	DEFINE(__LC_PGM_INT_CODE, offsetof(struct _lowcore, pgm_code));
+	DEFINE(__LC_PER_ATMID, offsetof(struct _lowcore, per_perc_atmid));
+	DEFINE(__LC_PER_ADDRESS, offsetof(struct _lowcore, per_address));
+	DEFINE(__LC_PER_ACCESS_ID, offsetof(struct _lowcore, per_access_id));
+	DEFINE(__LC_AR_MODE_ID, offsetof(struct _lowcore, ar_access_id));
+	DEFINE(__LC_SUBCHANNEL_ID, offsetof(struct _lowcore, subchannel_id));
+	DEFINE(__LC_SUBCHANNEL_NR, offsetof(struct _lowcore, subchannel_nr));
+	DEFINE(__LC_IO_INT_PARM, offsetof(struct _lowcore, io_int_parm));
+	DEFINE(__LC_IO_INT_WORD, offsetof(struct _lowcore, io_int_word));
+	DEFINE(__LC_STFL_FAC_LIST, offsetof(struct _lowcore, stfl_fac_list));
+	DEFINE(__LC_MCCK_CODE, offsetof(struct _lowcore, mcck_interruption_code));
+	DEFINE(__LC_DUMP_REIPL, offsetof(struct _lowcore, ipib));
+	BLANK();
+	DEFINE(__LC_RST_NEW_PSW, offsetof(struct _lowcore, restart_psw));
+	DEFINE(__LC_RST_OLD_PSW, offsetof(struct _lowcore, restart_old_psw));
+	DEFINE(__LC_EXT_OLD_PSW, offsetof(struct _lowcore, external_old_psw));
+	DEFINE(__LC_SVC_OLD_PSW, offsetof(struct _lowcore, svc_old_psw));
+	DEFINE(__LC_PGM_OLD_PSW, offsetof(struct _lowcore, program_old_psw));
+	DEFINE(__LC_MCK_OLD_PSW, offsetof(struct _lowcore, mcck_old_psw));
+	DEFINE(__LC_IO_OLD_PSW, offsetof(struct _lowcore, io_old_psw));
+	DEFINE(__LC_EXT_NEW_PSW, offsetof(struct _lowcore, external_new_psw));
+	DEFINE(__LC_SVC_NEW_PSW, offsetof(struct _lowcore, svc_new_psw));
+	DEFINE(__LC_PGM_NEW_PSW, offsetof(struct _lowcore, program_new_psw));
+	DEFINE(__LC_MCK_NEW_PSW, offsetof(struct _lowcore, mcck_new_psw));
+	DEFINE(__LC_IO_NEW_PSW, offsetof(struct _lowcore, io_new_psw));
+	DEFINE(__LC_SAVE_AREA, offsetof(struct _lowcore, save_area));
+	DEFINE(__LC_RETURN_PSW, offsetof(struct _lowcore, return_psw));
+	DEFINE(__LC_RETURN_MCCK_PSW, offsetof(struct _lowcore, return_mcck_psw));
+	DEFINE(__LC_SYNC_ENTER_TIMER, offsetof(struct _lowcore, sync_enter_timer));
+	DEFINE(__LC_ASYNC_ENTER_TIMER, offsetof(struct _lowcore, async_enter_timer));
+	DEFINE(__LC_EXIT_TIMER, offsetof(struct _lowcore, exit_timer));
+	DEFINE(__LC_USER_TIMER, offsetof(struct _lowcore, user_timer));
+	DEFINE(__LC_SYSTEM_TIMER, offsetof(struct _lowcore, system_timer));
+	DEFINE(__LC_STEAL_TIMER, offsetof(struct _lowcore, steal_timer));
+	DEFINE(__LC_LAST_UPDATE_TIMER, offsetof(struct _lowcore, last_update_timer));
+	DEFINE(__LC_LAST_UPDATE_CLOCK, offsetof(struct _lowcore, last_update_clock));
+	DEFINE(__LC_CURRENT, offsetof(struct _lowcore, current_task));
+	DEFINE(__LC_THREAD_INFO, offsetof(struct _lowcore, thread_info));
+	DEFINE(__LC_KERNEL_STACK, offsetof(struct _lowcore, kernel_stack));
+	DEFINE(__LC_ASYNC_STACK, offsetof(struct _lowcore, async_stack));
+	DEFINE(__LC_PANIC_STACK, offsetof(struct _lowcore, panic_stack));
+	DEFINE(__LC_KERNEL_ASCE, offsetof(struct _lowcore, kernel_asce));
+	DEFINE(__LC_USER_ASCE, offsetof(struct _lowcore, user_asce));
+	DEFINE(__LC_USER_EXEC_ASCE, offsetof(struct _lowcore, user_exec_asce));
+	DEFINE(__LC_CPUID, offsetof(struct _lowcore, cpu_id));
+	DEFINE(__LC_INT_CLOCK, offsetof(struct _lowcore, int_clock));
+	DEFINE(__LC_MACHINE_FLAGS, offsetof(struct _lowcore, machine_flags));
+	DEFINE(__LC_FTRACE_FUNC, offsetof(struct _lowcore, ftrace_func));
+	DEFINE(__LC_IRB, offsetof(struct _lowcore, irb));
+	DEFINE(__LC_CPU_TIMER_SAVE_AREA, offsetof(struct _lowcore, cpu_timer_save_area));
+	DEFINE(__LC_CLOCK_COMP_SAVE_AREA, offsetof(struct _lowcore, clock_comp_save_area));
+	DEFINE(__LC_PSW_SAVE_AREA, offsetof(struct _lowcore, psw_save_area));
+	DEFINE(__LC_PREFIX_SAVE_AREA, offsetof(struct _lowcore, prefixreg_save_area));
+	DEFINE(__LC_AREGS_SAVE_AREA, offsetof(struct _lowcore, access_regs_save_area));
+	DEFINE(__LC_FPREGS_SAVE_AREA, offsetof(struct _lowcore, floating_pt_save_area));
+	DEFINE(__LC_GPREGS_SAVE_AREA, offsetof(struct _lowcore, gpregs_save_area));
+	DEFINE(__LC_CREGS_SAVE_AREA, offsetof(struct _lowcore, cregs_save_area));
+#ifdef CONFIG_32BIT
+	DEFINE(__LC_PFAULT_INTPARM, offsetof(struct _lowcore, ext_params));
+	DEFINE(SAVE_AREA_BASE, offsetof(struct _lowcore, extended_save_area_addr));
+#else /* CONFIG_32BIT */
+	DEFINE(__LC_PFAULT_INTPARM, offsetof(struct _lowcore, ext_params2));
+	DEFINE(__LC_EXT_PARAMS2, offsetof(struct _lowcore, ext_params2));
+	DEFINE(SAVE_AREA_BASE, offsetof(struct _lowcore, floating_pt_save_area));
+	DEFINE(__LC_PASTE, offsetof(struct _lowcore, paste));
+	DEFINE(__LC_FP_CREG_SAVE_AREA, offsetof(struct _lowcore, fpt_creg_save_area));
+	DEFINE(__LC_LAST_BREAK, offsetof(struct _lowcore, breaking_event_addr));
+	DEFINE(__LC_VDSO_PER_CPU, offsetof(struct _lowcore, vdso_per_cpu_data));
+#endif /* CONFIG_32BIT */
 	return 0;
 }
Index: quilt-2.6/arch/s390/kernel/base.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/base.S	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/base.S	2010-02-24 09:44:26.000000000 +0100
@@ -6,8 +6,8 @@
  *		 Michael Holzheu <holzheu@de.ibm.com>
  */
 
+#include <asm/asm-offsets.h>
 #include <asm/ptrace.h>
-#include <asm/lowcore.h>
 
 #ifdef CONFIG_64BIT
 
Index: quilt-2.6/arch/s390/kernel/entry64.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/entry64.S	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/entry64.S	2010-02-24 09:44:26.000000000 +0100
@@ -9,11 +9,9 @@
  *		 Heiko Carstens <heiko.carstens@de.ibm.com>
  */
 
-#include <linux/sys.h>
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/cache.h>
-#include <asm/lowcore.h>
 #include <asm/errno.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
Index: quilt-2.6/arch/s390/kernel/entry.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/entry.S	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/entry.S	2010-02-24 09:44:26.000000000 +0100
@@ -13,7 +13,6 @@
 #include <linux/linkage.h>
 #include <linux/init.h>
 #include <asm/cache.h>
-#include <asm/lowcore.h>
 #include <asm/errno.h>
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
Index: quilt-2.6/arch/s390/kernel/ftrace.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ftrace.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/ftrace.c	2010-02-24 09:44:26.000000000 +0100
@@ -13,7 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/types.h>
 #include <trace/syscall.h>
-#include <asm/lowcore.h>
+#include <asm/asm-offsets.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
Index: quilt-2.6/arch/s390/kernel/head.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/head.S	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/head.S	2010-02-24 09:44:26.000000000 +0100
@@ -23,7 +23,6 @@
 
 #include <linux/init.h>
 #include <asm/setup.h>
-#include <asm/lowcore.h>
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
Index: quilt-2.6/arch/s390/kernel/ipl.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/ipl.c	2010-02-24 09:44:26.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/ipl.c	2010-02-24 09:44:26.000000000 +0100
@@ -1917,7 +1917,6 @@
 void __init ipl_save_parameters(void)
 {
 	struct cio_iplinfo iplinfo;
-	unsigned int *ipl_ptr;
 	void *src, *dst;
 
 	if (cio_get_iplinfo(&iplinfo))
@@ -1928,11 +1927,10 @@
 	if (!iplinfo.is_qdio)
 		return;
 	ipl_flags |= IPL_PARMBLOCK_VALID;
-	ipl_ptr = (unsigned int *)__LC_IPL_PARMBLOCK_PTR;
-	src = (void *)(unsigned long)*ipl_ptr;
+	src = (void *)(unsigned long)S390_lowcore.ipl_parmblock_ptr;
 	dst = (void *)IPL_PARMBLOCK_ORIGIN;
 	memmove(dst, src, PAGE_SIZE);
-	*ipl_ptr = IPL_PARMBLOCK_ORIGIN;
+	S390_lowcore.ipl_parmblock_ptr = IPL_PARMBLOCK_ORIGIN;
 }
 
 static LIST_HEAD(rcall);
Index: quilt-2.6/arch/s390/kernel/reipl64.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/reipl64.S	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/reipl64.S	2010-02-24 09:44:26.000000000 +0100
@@ -4,7 +4,7 @@
  *		 Denis Joseph Barrow,
  */
 
-#include <asm/lowcore.h>
+#include <asm/asm-offsets.h>
 
 #
 # do_reipl_asm
Index: quilt-2.6/arch/s390/kernel/reipl.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/reipl.S	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/reipl.S	2010-02-24 09:44:26.000000000 +0100
@@ -6,7 +6,7 @@
  *    Author(s): Holger Smolinski (Holger.Smolinski@de.ibm.com)
  */
 
-#include <asm/lowcore.h>
+#include <asm/asm-offsets.h>
 
 #
 # do_reipl_asm
Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c	2010-02-24 09:44:25.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/setup.c	2010-02-24 09:44:26.000000000 +0100
@@ -396,15 +396,12 @@
 setup_lowcore(void)
 {
 	struct _lowcore *lc;
-	int lc_pages;
 
 	/*
 	 * Setup lowcore for boot cpu
 	 */
-	lc_pages = sizeof(void *) == 8 ? 2 : 1;
-	lc = (struct _lowcore *)
-		__alloc_bootmem(lc_pages * PAGE_SIZE, lc_pages * PAGE_SIZE, 0);
-	memset(lc, 0, lc_pages * PAGE_SIZE);
+	BUILD_BUG_ON(sizeof(struct _lowcore) != LC_PAGES * 4096);
+	lc = __alloc_bootmem(LC_PAGES * PAGE_SIZE, LC_PAGES * PAGE_SIZE, 0);
 	lc->restart_psw.mask = PSW_BASE_BITS | PSW_DEFAULT_KEY;
 	lc->restart_psw.addr =
 		PSW_ADDR_AMODE | (unsigned long) restart_int_handler;
Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c	2010-02-24 09:44:25.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/smp.c	2010-02-24 09:44:26.000000000 +0100
@@ -36,6 +36,7 @@
 #include <linux/cpu.h>
 #include <linux/timex.h>
 #include <linux/bootmem.h>
+#include <asm/asm-offsets.h>
 #include <asm/ipl.h>
 #include <asm/setup.h>
 #include <asm/sigp.h>
@@ -121,7 +122,7 @@
 	sp -= sizeof(struct pt_regs);
 	regs = (struct pt_regs *) sp;
 	memcpy(&regs->gprs, &current_lc->gpregs_save_area, sizeof(regs->gprs));
-	memcpy(&regs->psw, &current_lc->st_status_fixed_logout, sizeof(psw_t));
+	regs->psw = lc->psw_save_area;
 	sp -= STACK_FRAME_OVERHEAD;
 	sf = (struct stack_frame *) sp;
 	sf->back_chain = regs->gprs[15];
Index: quilt-2.6/arch/s390/kernel/switch_cpu64.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/switch_cpu64.S	2010-02-24 09:44:24.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/switch_cpu64.S	2010-02-24 09:44:26.000000000 +0100
@@ -6,7 +6,6 @@
  */
 
 #include <asm/asm-offsets.h>
-#include <asm/lowcore.h>
 #include <asm/ptrace.h>
 
 # smp_switch_to_cpu switches to destination cpu and executes the passed function
Index: quilt-2.6/arch/s390/kernel/switch_cpu.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/switch_cpu.S	2010-02-24 09:44:24.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/switch_cpu.S	2010-02-24 09:44:26.000000000 +0100
@@ -6,7 +6,6 @@
  */
 
 #include <asm/asm-offsets.h>
-#include <asm/lowcore.h>
 #include <asm/ptrace.h>
 
 # smp_switch_to_cpu switches to destination cpu and executes the passed function
Index: quilt-2.6/arch/s390/kernel/vdso.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/vdso.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/vdso.c	2010-02-24 09:44:26.000000000 +0100
@@ -23,6 +23,7 @@
 #include <linux/security.h>
 #include <linux/bootmem.h>
 #include <linux/compat.h>
+#include <asm/asm-offsets.h>
 #include <asm/pgtable.h>
 #include <asm/system.h>
 #include <asm/processor.h>
Index: quilt-2.6/arch/s390/kvm/interrupt.c
===================================================================
--- quilt-2.6.orig/arch/s390/kvm/interrupt.c	2010-02-24 09:44:26.000000000 +0100
+++ quilt-2.6/arch/s390/kvm/interrupt.c	2010-02-24 09:44:26.000000000 +0100
@@ -10,12 +10,12 @@
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  */
 
-#include <asm/lowcore.h>
-#include <asm/uaccess.h>
-#include <linux/hrtimer.h>
 #include <linux/interrupt.h>
 #include <linux/kvm_host.h>
+#include <linux/hrtimer.h>
 #include <linux/signal.h>
+#include <asm/asm-offsets.h>
+#include <asm/uaccess.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
 
@@ -187,8 +187,8 @@
 		if (rc == -EFAULT)
 			exception = 1;
 
-		rc = put_guest_u64(vcpu, __LC_PFAULT_INTPARM,
-			inti->ext.ext_params2);
+		rc = put_guest_u64(vcpu, __LC_EXT_PARAMS2,
+				   inti->ext.ext_params2);
 		if (rc == -EFAULT)
 			exception = 1;
 		break;
Index: quilt-2.6/arch/s390/kvm/kvm-s390.c
===================================================================
--- quilt-2.6.orig/arch/s390/kvm/kvm-s390.c	2010-02-24 09:44:26.000000000 +0100
+++ quilt-2.6/arch/s390/kvm/kvm-s390.c	2010-02-24 09:44:26.000000000 +0100
@@ -23,6 +23,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/timer.h>
+#include <asm/asm-offsets.h>
 #include <asm/lowcore.h>
 #include <asm/pgtable.h>
 #include <asm/nmi.h>
Index: quilt-2.6/arch/s390/mm/fault.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/fault.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/mm/fault.c	2010-02-24 09:44:26.000000000 +0100
@@ -30,6 +30,7 @@
 #include <linux/kprobes.h>
 #include <linux/uaccess.h>
 #include <linux/hugetlb.h>
+#include <asm/asm-offsets.h>
 #include <asm/system.h>
 #include <asm/pgtable.h>
 #include <asm/s390_ext.h>
Index: quilt-2.6/drivers/s390/char/zcore.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/zcore.c	2010-02-24 09:44:24.000000000 +0100
+++ quilt-2.6/drivers/s390/char/zcore.c	2010-02-24 09:44:26.000000000 +0100
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/miscdevice.h>
 #include <linux/debugfs.h>
+#include <asm/asm-offsets.h>
 #include <asm/ipl.h>
 #include <asm/sclp.h>
 #include <asm/setup.h>
Index: quilt-2.6/drivers/s390/cio/ccwreq.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/ccwreq.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/ccwreq.c	2010-02-24 09:44:26.000000000 +0100
@@ -224,8 +224,8 @@
  */
 void ccw_request_handler(struct ccw_device *cdev)
 {
+	struct irb *irb = (struct irb *)&S390_lowcore.irb;
 	struct ccw_request *req = &cdev->private->req;
-	struct irb *irb = (struct irb *) __LC_IRB;
 	enum io_status status;
 	int rc = -EOPNOTSUPP;
 
Index: quilt-2.6/drivers/s390/cio/chsc_sch.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc_sch.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/chsc_sch.c	2010-02-24 09:44:26.000000000 +0100
@@ -51,7 +51,7 @@
 {
 	struct chsc_private *private = sch->private;
 	struct chsc_request *request = private->request;
-	struct irb *irb = (struct irb *)__LC_IRB;
+	struct irb *irb = (struct irb *)&S390_lowcore.irb;
 
 	CHSC_LOG(4, "irb");
 	CHSC_LOG_HEX(4, irb, sizeof(*irb));
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c	2010-02-24 09:44:25.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/cio.c	2010-02-24 09:44:26.000000000 +0100
@@ -625,8 +625,8 @@
 	/*
 	 * Get interrupt information from lowcore
 	 */
-	tpi_info = (struct tpi_info *) __LC_SUBCHANNEL_ID;
-	irb = (struct irb *) __LC_IRB;
+	tpi_info = (struct tpi_info *)&S390_lowcore.subchannel_id;
+	irb = (struct irb *)&S390_lowcore.irb;
 	do {
 		kstat_cpu(smp_processor_id()).irqs[IO_INTERRUPT]++;
 		/*
@@ -682,10 +682,10 @@
 	struct irb *irb;
 	int irq_context;
 
-	tpi_info = (struct tpi_info *) __LC_SUBCHANNEL_ID;
+	tpi_info = (struct tpi_info *)&S390_lowcore.subchannel_id;
 	if (tpi(NULL) != 1)
 		return 0;
-	irb = (struct irb *) __LC_IRB;
+	irb = (struct irb *)&S390_lowcore.irb;
 	/* Store interrupt response block to lowcore. */
 	if (tsch(tpi_info->schid, irb) != 0)
 		/* Not status pending or not operational. */
@@ -885,7 +885,7 @@
 		struct tpi_info ti;
 
 		if (tpi(&ti)) {
-			tsch(ti.schid, (struct irb *)__LC_IRB);
+			tsch(ti.schid, (struct irb *)&S390_lowcore.irb);
 			if (schid_equal(&ti.schid, &schid))
 				return 0;
 		}
@@ -1083,7 +1083,7 @@
 	struct subchannel_id schid;
 	struct schib schib;
 
-	schid = *(struct subchannel_id *)__LC_SUBCHANNEL_ID;
+	schid = *(struct subchannel_id *)&S390_lowcore.subchannel_id;
 	if (!schid.one)
 		return -ENODEV;
 	if (stsch(schid, &schib))
Index: quilt-2.6/drivers/s390/cio/device_fsm.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/device_fsm.c	2010-02-24 09:44:26.000000000 +0100
+++ quilt-2.6/drivers/s390/cio/device_fsm.c	2010-02-24 09:44:26.000000000 +0100
@@ -690,7 +690,7 @@
 	struct irb *irb;
 	int is_cmd;
 
-	irb = (struct irb *) __LC_IRB;
+	irb = (struct irb *)&S390_lowcore.irb;
 	is_cmd = !scsw_is_tm(&irb->scsw);
 	/* Check for unsolicited interrupt. */
 	if (!scsw_is_solicited(&irb->scsw)) {
@@ -755,7 +755,7 @@
 {
 	struct irb *irb;
 
-	irb = (struct irb *) __LC_IRB;
+	irb = (struct irb *)&S390_lowcore.irb;
 	/* Check for unsolicited interrupt. */
 	if (scsw_stctl(&irb->scsw) ==
 	    (SCSW_STCTL_STATUS_PEND | SCSW_STCTL_ALERT_STATUS)) {
Index: quilt-2.6/drivers/s390/kvm/kvm_virtio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/kvm/kvm_virtio.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/drivers/s390/kvm/kvm_virtio.c	2010-02-24 09:44:26.000000000 +0100
@@ -340,11 +340,11 @@
 		return;
 
 	/* The LSB might be overloaded, we have to mask it */
-	vq = (struct virtqueue *) ((*(long *) __LC_PFAULT_INTPARM) & ~1UL);
+	vq = (struct virtqueue *)(S390_lowcore.ext_params2 & ~1UL);
 
 	/* We use the LSB of extparam, to decide, if this interrupt is a config
 	 * change or a "standard" interrupt */
-	config_changed =  (*(int *)  __LC_EXT_PARAMS & 1);
+	config_changed = S390_lowcore.ext_params & 1;
 
 	if (config_changed) {
 		struct virtio_driver *drv;
