Return-Path: <linux-kernel-owner+w=401wt.eu-S1762117AbZBYPNc@vger.kernel.org>
Message-Id: <20090225150832.609980062@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:42 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 20/46] split/move machine check handler code
Content-Disposition: inline; filename=119-split-mcck.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Split machine check handler code and move it to cio and kernel code
where it belongs to. No functional change.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/crw.h |   68 +++++
 arch/s390/include/asm/nmi.h |   66 +++++
 arch/s390/kernel/Makefile   |    2 
 arch/s390/kernel/nmi.c      |  383 +++++++++++++++++++++++++++++++
 arch/s390/kernel/process.c  |    2 
 arch/s390/kvm/kvm-s390.c    |    4 
 drivers/s390/Makefile       |    1 
 drivers/s390/cio/Makefile   |    2 
 drivers/s390/cio/chp.c      |    6 
 drivers/s390/cio/chsc.c     |    6 
 drivers/s390/cio/cio.c      |    3 
 drivers/s390/cio/crw.c      |  145 +++++++++++
 drivers/s390/cio/css.c      |    6 
 drivers/s390/s390mach.c     |  537 --------------------------------------------
 drivers/s390/s390mach.h     |  122 ---------
 15 files changed, 677 insertions(+), 676 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/crw.h
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/include/asm/crw.h
@@ -0,0 +1,68 @@
+/*
+ *   Data definitions for channel report processing
+ *    Copyright IBM Corp. 2000,2009
+ *    Author(s): Ingo Adlung <adlung@de.ibm.com>,
+ *		 Martin Schwidefsky <schwidefsky@de.ibm.com>,
+ *		 Cornelia Huck <cornelia.huck@de.ibm.com>,
+ *		 Heiko Carstens <heiko.carstens@de.ibm.com>,
+ */
+
+#ifndef _ASM_S390_CRW_H
+#define _ASM_S390_CRW_H
+
+#include <linux/types.h>
+
+/*
+ * Channel Report Word
+ */
+struct crw {
+	__u32 res1 :  1;   /* reserved zero */
+	__u32 slct :  1;   /* solicited */
+	__u32 oflw :  1;   /* overflow */
+	__u32 chn  :  1;   /* chained */
+	__u32 rsc  :  4;   /* reporting source code */
+	__u32 anc  :  1;   /* ancillary report */
+	__u32 res2 :  1;   /* reserved zero */
+	__u32 erc  :  6;   /* error-recovery code */
+	__u32 rsid : 16;   /* reporting-source ID */
+} __attribute__ ((packed));
+
+typedef void (*crw_handler_t)(struct crw *, struct crw *, int);
+
+extern int crw_register_handler(int rsc, crw_handler_t handler);
+extern void crw_unregister_handler(int rsc);
+extern void crw_handle_channel_report(void);
+
+#define NR_RSCS 16
+
+#define CRW_RSC_MONITOR  0x2  /* monitoring facility */
+#define CRW_RSC_SCH	 0x3  /* subchannel */
+#define CRW_RSC_CPATH	 0x4  /* channel path */
+#define CRW_RSC_CONFIG	 0x9  /* configuration-alert facility */
+#define CRW_RSC_CSS	 0xB  /* channel subsystem */
+
+#define CRW_ERC_EVENT	 0x00 /* event information pending */
+#define CRW_ERC_AVAIL	 0x01 /* available */
+#define CRW_ERC_INIT	 0x02 /* initialized */
+#define CRW_ERC_TERROR	 0x03 /* temporary error */
+#define CRW_ERC_IPARM	 0x04 /* installed parm initialized */
+#define CRW_ERC_TERM	 0x05 /* terminal */
+#define CRW_ERC_PERRN	 0x06 /* perm. error, fac. not init */
+#define CRW_ERC_PERRI	 0x07 /* perm. error, facility init */
+#define CRW_ERC_PMOD	 0x08 /* installed parameters modified */
+
+static inline int stcrw(struct crw *pcrw)
+{
+	int ccode;
+
+	asm volatile(
+		"	stcrw	0(%2)\n"
+		"	ipm	%0\n"
+		"	srl	%0,28\n"
+		: "=d" (ccode), "=m" (*pcrw)
+		: "a" (pcrw)
+		: "cc" );
+	return ccode;
+}
+
+#endif /* _ASM_S390_CRW_H */
Index: quilt-2.6/arch/s390/include/asm/nmi.h
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/include/asm/nmi.h
@@ -0,0 +1,66 @@
+/*
+ *   Machine check handler definitions
+ *
+ *    Copyright IBM Corp. 2000,2009
+ *    Author(s): Ingo Adlung <adlung@de.ibm.com>,
+ *		 Martin Schwidefsky <schwidefsky@de.ibm.com>,
+ *		 Cornelia Huck <cornelia.huck@de.ibm.com>,
+ *		 Heiko Carstens <heiko.carstens@de.ibm.com>,
+ */
+
+#ifndef _ASM_S390_NMI_H
+#define _ASM_S390_NMI_H
+
+#include <linux/types.h>
+
+struct mci {
+	__u32 sd :  1; /* 00 system damage */
+	__u32 pd :  1; /* 01 instruction-processing damage */
+	__u32 sr :  1; /* 02 system recovery */
+	__u32	 :  1; /* 03 */
+	__u32 cd :  1; /* 04 timing-facility damage */
+	__u32 ed :  1; /* 05 external damage */
+	__u32	 :  1; /* 06 */
+	__u32 dg :  1; /* 07 degradation */
+	__u32 w  :  1; /* 08 warning pending */
+	__u32 cp :  1; /* 09 channel-report pending */
+	__u32 sp :  1; /* 10 service-processor damage */
+	__u32 ck :  1; /* 11 channel-subsystem damage */
+	__u32	 :  2; /* 12-13 */
+	__u32 b  :  1; /* 14 backed up */
+	__u32	 :  1; /* 15 */
+	__u32 se :  1; /* 16 storage error uncorrected */
+	__u32 sc :  1; /* 17 storage error corrected */
+	__u32 ke :  1; /* 18 storage-key error uncorrected */
+	__u32 ds :  1; /* 19 storage degradation */
+	__u32 wp :  1; /* 20 psw mwp validity */
+	__u32 ms :  1; /* 21 psw mask and key validity */
+	__u32 pm :  1; /* 22 psw program mask and cc validity */
+	__u32 ia :  1; /* 23 psw instruction address validity */
+	__u32 fa :  1; /* 24 failing storage address validity */
+	__u32	 :  1; /* 25 */
+	__u32 ec :  1; /* 26 external damage code validity */
+	__u32 fp :  1; /* 27 floating point register validity */
+	__u32 gr :  1; /* 28 general register validity */
+	__u32 cr :  1; /* 29 control register validity */
+	__u32	 :  1; /* 30 */
+	__u32 st :  1; /* 31 storage logical validity */
+	__u32 ie :  1; /* 32 indirect storage error */
+	__u32 ar :  1; /* 33 access register validity */
+	__u32 da :  1; /* 34 delayed access exception */
+	__u32	 :  7; /* 35-41 */
+	__u32 pr :  1; /* 42 tod programmable register validity */
+	__u32 fc :  1; /* 43 fp control register validity */
+	__u32 ap :  1; /* 44 ancillary report */
+	__u32	 :  1; /* 45 */
+	__u32 ct :  1; /* 46 cpu timer validity */
+	__u32 cc :  1; /* 47 clock comparator validity */
+	__u32	 : 16; /* 47-63 */
+};
+
+struct pt_regs;
+
+extern void s390_handle_mcck(void);
+extern void s390_do_machine_check(struct pt_regs *regs);
+
+#endif /* _ASM_S390_NMI_H */
Index: quilt-2.6/arch/s390/kernel/Makefile
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/Makefile
+++ quilt-2.6/arch/s390/kernel/Makefile
@@ -22,7 +22,7 @@ CFLAGS_sysinfo.o += -Iinclude/math-emu -
 obj-y	:=  bitmap.o traps.o time.o process.o base.o early.o setup.o \
 	    processor.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o \
 	    s390_ext.o debug.o irq.o ipl.o dis.o diag.o mem_detect.o \
-	    vdso.o vtime.o sysinfo.o
+	    vdso.o vtime.o sysinfo.o nmi.o
 
 obj-y	+= $(if $(CONFIG_64BIT),entry64.o,entry.o)
 obj-y	+= $(if $(CONFIG_64BIT),reipl64.o,reipl.o)
Index: quilt-2.6/arch/s390/kernel/nmi.c
===================================================================
--- /dev/null
+++ quilt-2.6/arch/s390/kernel/nmi.c
@@ -0,0 +1,383 @@
+/*
+ *   Machine check handler
+ *
+ *    Copyright IBM Corp. 2000,2009
+ *    Author(s): Ingo Adlung <adlung@de.ibm.com>,
+ *		 Martin Schwidefsky <schwidefsky@de.ibm.com>,
+ *		 Cornelia Huck <cornelia.huck@de.ibm.com>,
+ *		 Heiko Carstens <heiko.carstens@de.ibm.com>,
+ */
+
+#include <linux/init.h>
+#include <linux/errno.h>
+#include <linux/time.h>
+#include <linux/module.h>
+#include <asm/lowcore.h>
+#include <asm/smp.h>
+#include <asm/etr.h>
+#include <asm/cpu.h>
+#include <asm/nmi.h>
+#include <asm/crw.h>
+
+struct mcck_struct {
+	int kill_task;
+	int channel_report;
+	int warning;
+	unsigned long long mcck_code;
+};
+
+static DEFINE_PER_CPU(struct mcck_struct, cpu_mcck);
+
+static NORET_TYPE void s390_handle_damage(char *msg)
+{
+	smp_send_stop();
+	disabled_wait((unsigned long) __builtin_return_address(0));
+	while (1);
+}
+
+/*
+ * Main machine check handler function. Will be called with interrupts enabled
+ * or disabled and machine checks enabled or disabled.
+ */
+void s390_handle_mcck(void)
+{
+	unsigned long flags;
+	struct mcck_struct mcck;
+
+	/*
+	 * Disable machine checks and get the current state of accumulated
+	 * machine checks. Afterwards delete the old state and enable machine
+	 * checks again.
+	 */
+	local_irq_save(flags);
+	local_mcck_disable();
+	mcck = __get_cpu_var(cpu_mcck);
+	memset(&__get_cpu_var(cpu_mcck), 0, sizeof(struct mcck_struct));
+	clear_thread_flag(TIF_MCCK_PENDING);
+	local_mcck_enable();
+	local_irq_restore(flags);
+
+	if (mcck.channel_report)
+		crw_handle_channel_report();
+
+#ifdef CONFIG_MACHCHK_WARNING
+/*
+ * The warning may remain for a prolonged period on the bare iron.
+ * (actually till the machine is powered off, or until the problem is gone)
+ * So we just stop listening for the WARNING MCH and prevent continuously
+ * being interrupted.  One caveat is however, that we must do this per
+ * processor and cannot use the smp version of ctl_clear_bit().
+ * On VM we only get one interrupt per virtally presented machinecheck.
+ * Though one suffices, we may get one interrupt per (virtual) processor.
+ */
+	if (mcck.warning) {	/* WARNING pending ? */
+		static int mchchk_wng_posted = 0;
+		/*
+		 * Use single machine clear, as we cannot handle smp right now
+		 */
+		__ctl_clear_bit(14, 24);	/* Disable WARNING MCH */
+		if (xchg(&mchchk_wng_posted, 1) == 0)
+			kill_cad_pid(SIGPWR, 1);
+	}
+#endif
+
+	if (mcck.kill_task) {
+		local_irq_enable();
+		printk(KERN_EMERG "mcck: Terminating task because of machine "
+		       "malfunction (code 0x%016llx).\n", mcck.mcck_code);
+		printk(KERN_EMERG "mcck: task: %s, pid: %d.\n",
+		       current->comm, current->pid);
+		do_exit(SIGSEGV);
+	}
+}
+EXPORT_SYMBOL_GPL(s390_handle_mcck);
+
+/*
+ * returns 0 if all registers could be validated
+ * returns 1 otherwise
+ */
+static int notrace s390_revalidate_registers(struct mci *mci)
+{
+	int kill_task;
+	u64 tmpclock;
+	u64 zero;
+	void *fpt_save_area, *fpt_creg_save_area;
+
+	kill_task = 0;
+	zero = 0;
+
+	if (!mci->gr) {
+		/*
+		 * General purpose registers couldn't be restored and have
+		 * unknown contents. Process needs to be terminated.
+		 */
+		kill_task = 1;
+	}
+	if (!mci->fp) {
+		/*
+		 * Floating point registers can't be restored and
+		 * therefore the process needs to be terminated.
+		 */
+		kill_task = 1;
+	}
+#ifndef CONFIG_64BIT
+	asm volatile(
+		"	ld	0,0(%0)\n"
+		"	ld	2,8(%0)\n"
+		"	ld	4,16(%0)\n"
+		"	ld	6,24(%0)"
+		: : "a" (&S390_lowcore.floating_pt_save_area));
+#endif
+
+	if (MACHINE_HAS_IEEE) {
+#ifdef CONFIG_64BIT
+		fpt_save_area = &S390_lowcore.floating_pt_save_area;
+		fpt_creg_save_area = &S390_lowcore.fpt_creg_save_area;
+#else
+		fpt_save_area = (void *) S390_lowcore.extended_save_area_addr;
+		fpt_creg_save_area = fpt_save_area + 128;
+#endif
+		if (!mci->fc) {
+			/*
+			 * Floating point control register can't be restored.
+			 * Task will be terminated.
+			 */
+			asm volatile("lfpc 0(%0)" : : "a" (&zero), "m" (zero));
+			kill_task = 1;
+
+		} else
+			asm volatile("lfpc 0(%0)" : : "a" (fpt_creg_save_area));
+
+		asm volatile(
+			"	ld	0,0(%0)\n"
+			"	ld	1,8(%0)\n"
+			"	ld	2,16(%0)\n"
+			"	ld	3,24(%0)\n"
+			"	ld	4,32(%0)\n"
+			"	ld	5,40(%0)\n"
+			"	ld	6,48(%0)\n"
+			"	ld	7,56(%0)\n"
+			"	ld	8,64(%0)\n"
+			"	ld	9,72(%0)\n"
+			"	ld	10,80(%0)\n"
+			"	ld	11,88(%0)\n"
+			"	ld	12,96(%0)\n"
+			"	ld	13,104(%0)\n"
+			"	ld	14,112(%0)\n"
+			"	ld	15,120(%0)\n"
+			: : "a" (fpt_save_area));
+	}
+	/* Revalidate access registers */
+	asm volatile(
+		"	lam	0,15,0(%0)"
+		: : "a" (&S390_lowcore.access_regs_save_area));
+	if (!mci->ar) {
+		/*
+		 * Access registers have unknown contents.
+		 * Terminating task.
+		 */
+		kill_task = 1;
+	}
+	/* Revalidate control registers */
+	if (!mci->cr) {
+		/*
+		 * Control registers have unknown contents.
+		 * Can't recover and therefore stopping machine.
+		 */
+		s390_handle_damage("invalid control registers.");
+	} else {
+#ifdef CONFIG_64BIT
+		asm volatile(
+			"	lctlg	0,15,0(%0)"
+			: : "a" (&S390_lowcore.cregs_save_area));
+#else
+		asm volatile(
+			"	lctl	0,15,0(%0)"
+			: : "a" (&S390_lowcore.cregs_save_area));
+#endif
+	}
+	/*
+	 * We don't even try to revalidate the TOD register, since we simply
+	 * can't write something sensible into that register.
+	 */
+#ifdef CONFIG_64BIT
+	/*
+	 * See if we can revalidate the TOD programmable register with its
+	 * old contents (should be zero) otherwise set it to zero.
+	 */
+	if (!mci->pr)
+		asm volatile(
+			"	sr	0,0\n"
+			"	sckpf"
+			: : : "0", "cc");
+	else
+		asm volatile(
+			"	l	0,0(%0)\n"
+			"	sckpf"
+			: : "a" (&S390_lowcore.tod_progreg_save_area)
+			: "0", "cc");
+#endif
+	/* Revalidate clock comparator register */
+	asm volatile(
+		"	stck	0(%1)\n"
+		"	sckc	0(%1)"
+		: "=m" (tmpclock) : "a" (&(tmpclock)) : "cc", "memory");
+
+	/* Check if old PSW is valid */
+	if (!mci->wp)
+		/*
+		 * Can't tell if we come from user or kernel mode
+		 * -> stopping machine.
+		 */
+		s390_handle_damage("old psw invalid.");
+
+	if (!mci->ms || !mci->pm || !mci->ia)
+		kill_task = 1;
+
+	return kill_task;
+}
+
+#define MAX_IPD_COUNT	29
+#define MAX_IPD_TIME	(5 * 60 * USEC_PER_SEC) /* 5 minutes */
+
+#define ED_STP_ISLAND	6	/* External damage STP island check */
+#define ED_STP_SYNC	7	/* External damage STP sync check */
+#define ED_ETR_SYNC	12	/* External damage ETR sync check */
+#define ED_ETR_SWITCH	13	/* External damage ETR switch to local */
+
+/*
+ * machine check handler.
+ */
+void notrace s390_do_machine_check(struct pt_regs *regs)
+{
+	static int ipd_count;
+	static DEFINE_SPINLOCK(ipd_lock);
+	static unsigned long long last_ipd;
+	struct mcck_struct *mcck;
+	unsigned long long tmp;
+	struct mci *mci;
+	int umode;
+
+	lockdep_off();
+	s390_idle_check();
+
+	mci = (struct mci *) &S390_lowcore.mcck_interruption_code;
+	mcck = &__get_cpu_var(cpu_mcck);
+	umode = user_mode(regs);
+
+	if (mci->sd) {
+		/* System damage -> stopping machine */
+		s390_handle_damage("received system damage machine check.");
+	}
+	if (mci->pd) {
+		if (mci->b) {
+			/* Processing backup -> verify if we can survive this */
+			u64 z_mcic, o_mcic, t_mcic;
+#ifdef CONFIG_64BIT
+			z_mcic = (1ULL<<63 | 1ULL<<59 | 1ULL<<29);
+			o_mcic = (1ULL<<43 | 1ULL<<42 | 1ULL<<41 | 1ULL<<40 |
+				  1ULL<<36 | 1ULL<<35 | 1ULL<<34 | 1ULL<<32 |
+				  1ULL<<30 | 1ULL<<21 | 1ULL<<20 | 1ULL<<17 |
+				  1ULL<<16);
+#else
+			z_mcic = (1ULL<<63 | 1ULL<<59 | 1ULL<<57 | 1ULL<<50 |
+				  1ULL<<29);
+			o_mcic = (1ULL<<43 | 1ULL<<42 | 1ULL<<41 | 1ULL<<40 |
+				  1ULL<<36 | 1ULL<<35 | 1ULL<<34 | 1ULL<<32 |
+				  1ULL<<30 | 1ULL<<20 | 1ULL<<17 | 1ULL<<16);
+#endif
+			t_mcic = *(u64 *)mci;
+
+			if (((t_mcic & z_mcic) != 0) ||
+			    ((t_mcic & o_mcic) != o_mcic)) {
+				s390_handle_damage("processing backup machine "
+						   "check with damage.");
+			}
+
+			/*
+			 * Nullifying exigent condition, therefore we might
+			 * retry this instruction.
+			 */
+			spin_lock(&ipd_lock);
+			tmp = get_clock();
+			if (((tmp - last_ipd) >> 12) < MAX_IPD_TIME)
+				ipd_count++;
+			else
+				ipd_count = 1;
+			last_ipd = tmp;
+			if (ipd_count == MAX_IPD_COUNT)
+				s390_handle_damage("too many ipd retries.");
+			spin_unlock(&ipd_lock);
+		} else {
+			/* Processing damage -> stopping machine */
+			s390_handle_damage("received instruction processing "
+					   "damage machine check.");
+		}
+	}
+	if (s390_revalidate_registers(mci)) {
+		if (umode) {
+			/*
+			 * Couldn't restore all register contents while in
+			 * user mode -> mark task for termination.
+			 */
+			mcck->kill_task = 1;
+			mcck->mcck_code = *(unsigned long long *) mci;
+			set_thread_flag(TIF_MCCK_PENDING);
+		} else {
+			/*
+			 * Couldn't restore all register contents while in
+			 * kernel mode -> stopping machine.
+			 */
+			s390_handle_damage("unable to revalidate registers.");
+		}
+	}
+	if (mci->cd) {
+		/* Timing facility damage */
+		s390_handle_damage("TOD clock damaged");
+	}
+	if (mci->ed && mci->ec) {
+		/* External damage */
+		if (S390_lowcore.external_damage_code & (1U << ED_ETR_SYNC))
+			etr_sync_check();
+		if (S390_lowcore.external_damage_code & (1U << ED_ETR_SWITCH))
+			etr_switch_to_local();
+		if (S390_lowcore.external_damage_code & (1U << ED_STP_SYNC))
+			stp_sync_check();
+		if (S390_lowcore.external_damage_code & (1U << ED_STP_ISLAND))
+			stp_island_check();
+	}
+	if (mci->se)
+		/* Storage error uncorrected */
+		s390_handle_damage("received storage error uncorrected "
+				   "machine check.");
+	if (mci->ke)
+		/* Storage key-error uncorrected */
+		s390_handle_damage("received storage key-error uncorrected "
+				   "machine check.");
+	if (mci->ds && mci->fa)
+		/* Storage degradation */
+		s390_handle_damage("received storage degradation machine "
+				   "check.");
+	if (mci->cp) {
+		/* Channel report word pending */
+		mcck->channel_report = 1;
+		set_thread_flag(TIF_MCCK_PENDING);
+	}
+	if (mci->w) {
+		/* Warning pending */
+		mcck->warning = 1;
+		set_thread_flag(TIF_MCCK_PENDING);
+	}
+	lockdep_on();
+}
+
+static int __init machine_check_init(void)
+{
+	ctl_set_bit(14, 25);	/* enable external damage MCH */
+	ctl_set_bit(14, 27);	/* enable system recovery MCH */
+#ifdef CONFIG_MACHCHK_WARNING
+	ctl_set_bit(14, 24);	/* enable warning MCH */
+#endif
+	return 0;
+}
+arch_initcall(machine_check_init);
Index: quilt-2.6/arch/s390/kernel/process.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/process.c
+++ quilt-2.6/arch/s390/kernel/process.c
@@ -39,6 +39,7 @@
 #include <asm/processor.h>
 #include <asm/irq.h>
 #include <asm/timer.h>
+#include <asm/nmi.h>
 #include "entry.h"
 
 asmlinkage void ret_from_fork(void) asm ("ret_from_fork");
@@ -68,7 +69,6 @@ unsigned long thread_saved_pc(struct tas
 	return sf->gprs[8];
 }
 
-extern void s390_handle_mcck(void);
 /*
  * The idle loop on a S390...
  */
Index: quilt-2.6/arch/s390/kvm/kvm-s390.c
===================================================================
--- quilt-2.6.orig/arch/s390/kvm/kvm-s390.c
+++ quilt-2.6/arch/s390/kvm/kvm-s390.c
@@ -23,7 +23,7 @@
 #include <linux/timer.h>
 #include <asm/lowcore.h>
 #include <asm/pgtable.h>
-
+#include <asm/nmi.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
 
@@ -440,8 +440,6 @@ int kvm_arch_vcpu_ioctl_set_mpstate(stru
 	return -EINVAL; /* not implemented yet */
 }
 
-extern void s390_handle_mcck(void);
-
 static void __vcpu_run(struct kvm_vcpu *vcpu)
 {
 	memcpy(&vcpu->arch.sie_block->gg14, &vcpu->arch.guest_gprs[14], 16);
Index: quilt-2.6/drivers/s390/cio/chp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chp.c
+++ quilt-2.6/drivers/s390/cio/chp.c
@@ -17,8 +17,8 @@
 #include <linux/errno.h>
 #include <asm/chpid.h>
 #include <asm/sclp.h>
+#include <asm/crw.h>
 
-#include "../s390mach.h"
 #include "cio.h"
 #include "css.h"
 #include "ioasm.h"
@@ -706,12 +706,12 @@ static int __init chp_init(void)
 	struct chp_id chpid;
 	int ret;
 
-	ret = s390_register_crw_handler(CRW_RSC_CPATH, chp_process_crw);
+	ret = crw_register_handler(CRW_RSC_CPATH, chp_process_crw);
 	if (ret)
 		return ret;
 	chp_wq = create_singlethread_workqueue("cio_chp");
 	if (!chp_wq) {
-		s390_unregister_crw_handler(CRW_RSC_CPATH);
+		crw_unregister_handler(CRW_RSC_CPATH);
 		return -ENOMEM;
 	}
 	INIT_WORK(&cfg_work, cfg_func);
Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c
+++ quilt-2.6/drivers/s390/cio/chsc.c
@@ -19,8 +19,8 @@
 #include <asm/cio.h>
 #include <asm/chpid.h>
 #include <asm/chsc.h>
+#include <asm/crw.h>
 
-#include "../s390mach.h"
 #include "css.h"
 #include "cio.h"
 #include "cio_debug.h"
@@ -820,7 +820,7 @@ int __init chsc_alloc_sei_area(void)
 			      "chsc machine checks!\n");
 		return -ENOMEM;
 	}
-	ret = s390_register_crw_handler(CRW_RSC_CSS, chsc_process_crw);
+	ret = crw_register_handler(CRW_RSC_CSS, chsc_process_crw);
 	if (ret)
 		kfree(sei_page);
 	return ret;
@@ -828,7 +828,7 @@ int __init chsc_alloc_sei_area(void)
 
 void __init chsc_free_sei_area(void)
 {
-	s390_unregister_crw_handler(CRW_RSC_CSS);
+	crw_unregister_handler(CRW_RSC_CSS);
 	kfree(sei_page);
 }
 
Index: quilt-2.6/drivers/s390/cio/cio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/cio.c
+++ quilt-2.6/drivers/s390/cio/cio.c
@@ -30,6 +30,8 @@
 #include <asm/isc.h>
 #include <asm/cpu.h>
 #include <asm/fcx.h>
+#include <asm/nmi.h>
+#include <asm/crw.h>
 #include "cio.h"
 #include "css.h"
 #include "chsc.h"
@@ -38,7 +40,6 @@
 #include "blacklist.h"
 #include "cio_debug.h"
 #include "chp.h"
-#include "../s390mach.h"
 
 debug_info_t *cio_debug_msg_id;
 debug_info_t *cio_debug_trace_id;
Index: quilt-2.6/drivers/s390/cio/crw.c
===================================================================
--- /dev/null
+++ quilt-2.6/drivers/s390/cio/crw.c
@@ -0,0 +1,145 @@
+/*
+ *   Channel report handling code
+ *
+ *    Copyright IBM Corp. 2000,2009
+ *    Author(s): Ingo Adlung <adlung@de.ibm.com>,
+ *		 Martin Schwidefsky <schwidefsky@de.ibm.com>,
+ *		 Cornelia Huck <cornelia.huck@de.ibm.com>,
+ *		 Heiko Carstens <heiko.carstens@de.ibm.com>,
+ */
+
+#include <linux/semaphore.h>
+#include <linux/kthread.h>
+#include <linux/init.h>
+#include <asm/crw.h>
+
+static struct semaphore crw_semaphore;
+static crw_handler_t crw_handlers[NR_RSCS];
+
+/**
+ * crw_register_handler() - register a channel report word handler
+ * @rsc: reporting source code to handle
+ * @handler: handler to be registered
+ *
+ * Returns %0 on success and a negative error value otherwise.
+ */
+int crw_register_handler(int rsc, crw_handler_t handler)
+{
+	if ((rsc < 0) || (rsc >= NR_RSCS))
+		return -EINVAL;
+	if (!cmpxchg(&crw_handlers[rsc], NULL, handler))
+		return 0;
+	return -EBUSY;
+}
+
+/**
+ * crw_unregister_handler() - unregister a channel report word handler
+ * @rsc: reporting source code to handle
+ */
+void crw_unregister_handler(int rsc)
+{
+	if ((rsc < 0) || (rsc >= NR_RSCS))
+		return;
+	xchg(&crw_handlers[rsc], NULL);
+	synchronize_sched();
+}
+
+/*
+ * Retrieve CRWs and call function to handle event.
+ */
+static int crw_collect_info(void *unused)
+{
+	struct crw crw[2];
+	int ccode;
+	unsigned int chain;
+	int ignore;
+
+repeat:
+	ignore = down_interruptible(&crw_semaphore);
+	chain = 0;
+	while (1) {
+		if (unlikely(chain > 1)) {
+			struct crw tmp_crw;
+
+			printk(KERN_WARNING"%s: Code does not support more "
+			       "than two chained crws; please report to "
+			       "linux390@de.ibm.com!\n", __func__);
+			ccode = stcrw(&tmp_crw);
+			printk(KERN_WARNING"%s: crw reports slct=%d, oflw=%d, "
+			       "chn=%d, rsc=%X, anc=%d, erc=%X, rsid=%X\n",
+			       __func__, tmp_crw.slct, tmp_crw.oflw,
+			       tmp_crw.chn, tmp_crw.rsc, tmp_crw.anc,
+			       tmp_crw.erc, tmp_crw.rsid);
+			printk(KERN_WARNING"%s: This was crw number %x in the "
+			       "chain\n", __func__, chain);
+			if (ccode != 0)
+				break;
+			chain = tmp_crw.chn ? chain + 1 : 0;
+			continue;
+		}
+		ccode = stcrw(&crw[chain]);
+		if (ccode != 0)
+			break;
+		printk(KERN_DEBUG "crw_info : CRW reports slct=%d, oflw=%d, "
+		       "chn=%d, rsc=%X, anc=%d, erc=%X, rsid=%X\n",
+		       crw[chain].slct, crw[chain].oflw, crw[chain].chn,
+		       crw[chain].rsc, crw[chain].anc, crw[chain].erc,
+		       crw[chain].rsid);
+		/* Check for overflows. */
+		if (crw[chain].oflw) {
+			int i;
+
+			pr_debug("%s: crw overflow detected!\n", __func__);
+			for (i = 0; i < NR_RSCS; i++) {
+				if (crw_handlers[i])
+					crw_handlers[i](NULL, NULL, 1);
+			}
+			chain = 0;
+			continue;
+		}
+		if (crw[0].chn && !chain) {
+			chain++;
+			continue;
+		}
+		if (crw_handlers[crw[chain].rsc])
+			crw_handlers[crw[chain].rsc](&crw[0],
+						     chain ? &crw[1] : NULL,
+						     0);
+		/* chain is always 0 or 1 here. */
+		chain = crw[chain].chn ? chain + 1 : 0;
+	}
+	goto repeat;
+	return 0;
+}
+
+void crw_handle_channel_report(void)
+{
+	up(&crw_semaphore);
+}
+
+/*
+ * Separate initcall needed for semaphore initialization since
+ * crw_handle_channel_report might be called before crw_machine_check_init.
+ */
+static int __init crw_init_semaphore(void)
+{
+	init_MUTEX_LOCKED(&crw_semaphore);
+	return 0;
+}
+pure_initcall(crw_init_semaphore);
+
+/*
+ * Machine checks for the channel subsystem must be enabled
+ * after the channel subsystem is initialized
+ */
+static int __init crw_machine_check_init(void)
+{
+	struct task_struct *task;
+
+	task = kthread_run(crw_collect_info, NULL, "kmcheck");
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+	ctl_set_bit(14, 28);	/* enable channel report MCH */
+	return 0;
+}
+device_initcall(crw_machine_check_init);
Index: quilt-2.6/drivers/s390/cio/css.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/css.c
+++ quilt-2.6/drivers/s390/cio/css.c
@@ -18,8 +18,8 @@
 #include <linux/list.h>
 #include <linux/reboot.h>
 #include <asm/isc.h>
+#include <asm/crw.h>
 
-#include "../s390mach.h"
 #include "css.h"
 #include "cio.h"
 #include "cio_debug.h"
@@ -765,7 +765,7 @@ init_channel_subsystem (void)
 	if (ret)
 		goto out;
 
-	ret = s390_register_crw_handler(CRW_RSC_SCH, css_process_crw);
+	ret = crw_register_handler(CRW_RSC_SCH, css_process_crw);
 	if (ret)
 		goto out;
 
@@ -845,7 +845,7 @@ out_unregister:
 out_bus:
 	bus_unregister(&css_bus_type);
 out:
-	s390_unregister_crw_handler(CRW_RSC_CSS);
+	crw_unregister_handler(CRW_RSC_CSS);
 	chsc_free_sei_area();
 	kfree(slow_subchannel_set);
 	pr_alert("The CSS device driver initialization failed with "
Index: quilt-2.6/drivers/s390/cio/Makefile
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/Makefile
+++ quilt-2.6/drivers/s390/cio/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-y += airq.o blacklist.o chsc.o cio.o css.o chp.o idset.o isc.o scsw.o \
-	fcx.o itcw.o
+	fcx.o itcw.o crw.o
 ccw_device-objs += device.o device_fsm.o device_ops.o
 ccw_device-objs += device_id.o device_pgid.o device_status.o
 obj-y += ccw_device.o cmf.o
Index: quilt-2.6/drivers/s390/Makefile
===================================================================
--- quilt-2.6.orig/drivers/s390/Makefile
+++ quilt-2.6/drivers/s390/Makefile
@@ -2,7 +2,6 @@
 # Makefile for the S/390 specific device drivers
 #
 
-obj-y += s390mach.o
 obj-y += cio/ block/ char/ crypto/ net/ scsi/ kvm/
 
 drivers-y += drivers/s390/built-in.o
Index: quilt-2.6/drivers/s390/s390mach.c
===================================================================
--- quilt-2.6.orig/drivers/s390/s390mach.c
+++ /dev/null
@@ -1,537 +0,0 @@
-/*
- *  drivers/s390/s390mach.c
- *   S/390 machine check handler
- *
- *    Copyright IBM Corp. 2000,2008
- *    Author(s): Ingo Adlung (adlung@de.ibm.com)
- *		 Martin Schwidefsky (schwidefsky@de.ibm.com)
- *		 Cornelia Huck <cornelia.huck@de.ibm.com>
- */
-
-#include <linux/init.h>
-#include <linux/sched.h>
-#include <linux/errno.h>
-#include <linux/workqueue.h>
-#include <linux/time.h>
-#include <linux/device.h>
-#include <linux/kthread.h>
-#include <asm/etr.h>
-#include <asm/lowcore.h>
-#include <asm/cio.h>
-#include <asm/cpu.h>
-#include "s390mach.h"
-
-static struct semaphore m_sem;
-
-static NORET_TYPE void
-s390_handle_damage(char *msg)
-{
-#ifdef CONFIG_SMP
-	smp_send_stop();
-#endif
-	disabled_wait((unsigned long) __builtin_return_address(0));
-	for(;;);
-}
-
-static crw_handler_t crw_handlers[NR_RSCS];
-
-/**
- * s390_register_crw_handler() - register a channel report word handler
- * @rsc: reporting source code to handle
- * @handler: handler to be registered
- *
- * Returns %0 on success and a negative error value otherwise.
- */
-int s390_register_crw_handler(int rsc, crw_handler_t handler)
-{
-	if ((rsc < 0) || (rsc >= NR_RSCS))
-		return -EINVAL;
-	if (!cmpxchg(&crw_handlers[rsc], NULL, handler))
-		return 0;
-	return -EBUSY;
-}
-
-/**
- * s390_unregister_crw_handler() - unregister a channel report word handler
- * @rsc: reporting source code to handle
- */
-void s390_unregister_crw_handler(int rsc)
-{
-	if ((rsc < 0) || (rsc >= NR_RSCS))
-		return;
-	xchg(&crw_handlers[rsc], NULL);
-	synchronize_sched();
-}
-
-/*
- * Retrieve CRWs and call function to handle event.
- */
-static int s390_collect_crw_info(void *param)
-{
-	struct crw crw[2];
-	int ccode;
-	struct semaphore *sem;
-	unsigned int chain;
-	int ignore;
-
-	sem = (struct semaphore *)param;
-repeat:
-	ignore = down_interruptible(sem);
-	chain = 0;
-	while (1) {
-		if (unlikely(chain > 1)) {
-			struct crw tmp_crw;
-
-			printk(KERN_WARNING"%s: Code does not support more "
-			       "than two chained crws; please report to "
-			       "linux390@de.ibm.com!\n", __func__);
-			ccode = stcrw(&tmp_crw);
-			printk(KERN_WARNING"%s: crw reports slct=%d, oflw=%d, "
-			       "chn=%d, rsc=%X, anc=%d, erc=%X, rsid=%X\n",
-			       __func__, tmp_crw.slct, tmp_crw.oflw,
-			       tmp_crw.chn, tmp_crw.rsc, tmp_crw.anc,
-			       tmp_crw.erc, tmp_crw.rsid);
-			printk(KERN_WARNING"%s: This was crw number %x in the "
-			       "chain\n", __func__, chain);
-			if (ccode != 0)
-				break;
-			chain = tmp_crw.chn ? chain + 1 : 0;
-			continue;
-		}
-		ccode = stcrw(&crw[chain]);
-		if (ccode != 0)
-			break;
-		printk(KERN_DEBUG "crw_info : CRW reports slct=%d, oflw=%d, "
-		       "chn=%d, rsc=%X, anc=%d, erc=%X, rsid=%X\n",
-		       crw[chain].slct, crw[chain].oflw, crw[chain].chn,
-		       crw[chain].rsc, crw[chain].anc, crw[chain].erc,
-		       crw[chain].rsid);
-		/* Check for overflows. */
-		if (crw[chain].oflw) {
-			int i;
-
-			pr_debug("%s: crw overflow detected!\n", __func__);
-			for (i = 0; i < NR_RSCS; i++) {
-				if (crw_handlers[i])
-					crw_handlers[i](NULL, NULL, 1);
-			}
-			chain = 0;
-			continue;
-		}
-		if (crw[0].chn && !chain) {
-			chain++;
-			continue;
-		}
-		if (crw_handlers[crw[chain].rsc])
-			crw_handlers[crw[chain].rsc](&crw[0],
-						     chain ? &crw[1] : NULL,
-						     0);
-		/* chain is always 0 or 1 here. */
-		chain = crw[chain].chn ? chain + 1 : 0;
-	}
-	goto repeat;
-	return 0;
-}
-
-struct mcck_struct {
-	int kill_task;
-	int channel_report;
-	int warning;
-	unsigned long long mcck_code;
-};
-
-static DEFINE_PER_CPU(struct mcck_struct, cpu_mcck);
-
-/*
- * Main machine check handler function. Will be called with interrupts enabled
- * or disabled and machine checks enabled or disabled.
- */
-void
-s390_handle_mcck(void)
-{
-	unsigned long flags;
-	struct mcck_struct mcck;
-
-	/*
-	 * Disable machine checks and get the current state of accumulated
-	 * machine checks. Afterwards delete the old state and enable machine
-	 * checks again.
-	 */
-	local_irq_save(flags);
-	local_mcck_disable();
-	mcck = __get_cpu_var(cpu_mcck);
-	memset(&__get_cpu_var(cpu_mcck), 0, sizeof(struct mcck_struct));
-	clear_thread_flag(TIF_MCCK_PENDING);
-	local_mcck_enable();
-	local_irq_restore(flags);
-
-	if (mcck.channel_report)
-		up(&m_sem);
-
-#ifdef CONFIG_MACHCHK_WARNING
-/*
- * The warning may remain for a prolonged period on the bare iron.
- * (actually till the machine is powered off, or until the problem is gone)
- * So we just stop listening for the WARNING MCH and prevent continuously
- * being interrupted.  One caveat is however, that we must do this per
- * processor and cannot use the smp version of ctl_clear_bit().
- * On VM we only get one interrupt per virtally presented machinecheck.
- * Though one suffices, we may get one interrupt per (virtual) processor.
- */
-	if (mcck.warning) {	/* WARNING pending ? */
-		static int mchchk_wng_posted = 0;
-		/*
-		 * Use single machine clear, as we cannot handle smp right now
-		 */
-		__ctl_clear_bit(14, 24);	/* Disable WARNING MCH */
-		if (xchg(&mchchk_wng_posted, 1) == 0)
-			kill_cad_pid(SIGPWR, 1);
-	}
-#endif
-
-	if (mcck.kill_task) {
-		local_irq_enable();
-		printk(KERN_EMERG "mcck: Terminating task because of machine "
-		       "malfunction (code 0x%016llx).\n", mcck.mcck_code);
-		printk(KERN_EMERG "mcck: task: %s, pid: %d.\n",
-		       current->comm, current->pid);
-		do_exit(SIGSEGV);
-	}
-}
-EXPORT_SYMBOL_GPL(s390_handle_mcck);
-
-/*
- * returns 0 if all registers could be validated
- * returns 1 otherwise
- */
-static int
-s390_revalidate_registers(struct mci *mci)
-{
-	int kill_task;
-	u64 tmpclock;
-	u64 zero;
-	void *fpt_save_area, *fpt_creg_save_area;
-
-	kill_task = 0;
-	zero = 0;
-	/* General purpose registers */
-	if (!mci->gr)
-		/*
-		 * General purpose registers couldn't be restored and have
-		 * unknown contents. Process needs to be terminated.
-		 */
-		kill_task = 1;
-
-	/* Revalidate floating point registers */
-	if (!mci->fp)
-		/*
-		 * Floating point registers can't be restored and
-		 * therefore the process needs to be terminated.
-		 */
-		kill_task = 1;
-
-#ifndef CONFIG_64BIT
-	asm volatile(
-		"	ld	0,0(%0)\n"
-		"	ld	2,8(%0)\n"
-		"	ld	4,16(%0)\n"
-		"	ld	6,24(%0)"
-		: : "a" (&S390_lowcore.floating_pt_save_area));
-#endif
-
-	if (MACHINE_HAS_IEEE) {
-#ifdef CONFIG_64BIT
-		fpt_save_area = &S390_lowcore.floating_pt_save_area;
-		fpt_creg_save_area = &S390_lowcore.fpt_creg_save_area;
-#else
-		fpt_save_area = (void *) S390_lowcore.extended_save_area_addr;
-		fpt_creg_save_area = fpt_save_area+128;
-#endif
-		/* Floating point control register */
-		if (!mci->fc) {
-			/*
-			 * Floating point control register can't be restored.
-			 * Task will be terminated.
-			 */
-			asm volatile("lfpc 0(%0)" : : "a" (&zero), "m" (zero));
-			kill_task = 1;
-
-		} else
-			asm volatile("lfpc 0(%0)" : : "a" (fpt_creg_save_area));
-
-		asm volatile(
-			"	ld	0,0(%0)\n"
-			"	ld	1,8(%0)\n"
-			"	ld	2,16(%0)\n"
-			"	ld	3,24(%0)\n"
-			"	ld	4,32(%0)\n"
-			"	ld	5,40(%0)\n"
-			"	ld	6,48(%0)\n"
-			"	ld	7,56(%0)\n"
-			"	ld	8,64(%0)\n"
-			"	ld	9,72(%0)\n"
-			"	ld	10,80(%0)\n"
-			"	ld	11,88(%0)\n"
-			"	ld	12,96(%0)\n"
-			"	ld	13,104(%0)\n"
-			"	ld	14,112(%0)\n"
-			"	ld	15,120(%0)\n"
-			: : "a" (fpt_save_area));
-	}
-
-	/* Revalidate access registers */
-	asm volatile(
-		"	lam	0,15,0(%0)"
-		: : "a" (&S390_lowcore.access_regs_save_area));
-	if (!mci->ar)
-		/*
-		 * Access registers have unknown contents.
-		 * Terminating task.
-		 */
-		kill_task = 1;
-
-	/* Revalidate control registers */
-	if (!mci->cr)
-		/*
-		 * Control registers have unknown contents.
-		 * Can't recover and therefore stopping machine.
-		 */
-		s390_handle_damage("invalid control registers.");
-	else
-#ifdef CONFIG_64BIT
-		asm volatile(
-			"	lctlg	0,15,0(%0)"
-			: : "a" (&S390_lowcore.cregs_save_area));
-#else
-		asm volatile(
-			"	lctl	0,15,0(%0)"
-			: : "a" (&S390_lowcore.cregs_save_area));
-#endif
-
-	/*
-	 * We don't even try to revalidate the TOD register, since we simply
-	 * can't write something sensible into that register.
-	 */
-
-#ifdef CONFIG_64BIT
-	/*
-	 * See if we can revalidate the TOD programmable register with its
-	 * old contents (should be zero) otherwise set it to zero.
-	 */
-	if (!mci->pr)
-		asm volatile(
-			"	sr	0,0\n"
-			"	sckpf"
-			: : : "0", "cc");
-	else
-		asm volatile(
-			"	l	0,0(%0)\n"
-			"	sckpf"
-			: : "a" (&S390_lowcore.tod_progreg_save_area)
-			: "0", "cc");
-#endif
-
-	/* Revalidate clock comparator register */
-	asm volatile(
-		"	stck	0(%1)\n"
-		"	sckc	0(%1)"
-		: "=m" (tmpclock) : "a" (&(tmpclock)) : "cc", "memory");
-
-	/* Check if old PSW is valid */
-	if (!mci->wp)
-		/*
-		 * Can't tell if we come from user or kernel mode
-		 * -> stopping machine.
-		 */
-		s390_handle_damage("old psw invalid.");
-
-	if (!mci->ms || !mci->pm || !mci->ia)
-		kill_task = 1;
-
-	return kill_task;
-}
-
-#define MAX_IPD_COUNT	29
-#define MAX_IPD_TIME	(5 * 60 * USEC_PER_SEC) /* 5 minutes */
-
-/*
- * machine check handler.
- */
-void notrace s390_do_machine_check(struct pt_regs *regs)
-{
-	static DEFINE_SPINLOCK(ipd_lock);
-	static unsigned long long last_ipd;
-	static int ipd_count;
-	unsigned long long tmp;
-	struct mci *mci;
-	struct mcck_struct *mcck;
-	int umode;
-
-	lockdep_off();
-
-	s390_idle_check();
-
-	mci = (struct mci *) &S390_lowcore.mcck_interruption_code;
-	mcck = &__get_cpu_var(cpu_mcck);
-	umode = user_mode(regs);
-
-	if (mci->sd)
-		/* System damage -> stopping machine */
-		s390_handle_damage("received system damage machine check.");
-
-	if (mci->pd) {
-		if (mci->b) {
-			/* Processing backup -> verify if we can survive this */
-			u64 z_mcic, o_mcic, t_mcic;
-#ifdef CONFIG_64BIT
-			z_mcic = (1ULL<<63 | 1ULL<<59 | 1ULL<<29);
-			o_mcic = (1ULL<<43 | 1ULL<<42 | 1ULL<<41 | 1ULL<<40 |
-				  1ULL<<36 | 1ULL<<35 | 1ULL<<34 | 1ULL<<32 |
-				  1ULL<<30 | 1ULL<<21 | 1ULL<<20 | 1ULL<<17 |
-				  1ULL<<16);
-#else
-			z_mcic = (1ULL<<63 | 1ULL<<59 | 1ULL<<57 | 1ULL<<50 |
-				  1ULL<<29);
-			o_mcic = (1ULL<<43 | 1ULL<<42 | 1ULL<<41 | 1ULL<<40 |
-				  1ULL<<36 | 1ULL<<35 | 1ULL<<34 | 1ULL<<32 |
-				  1ULL<<30 | 1ULL<<20 | 1ULL<<17 | 1ULL<<16);
-#endif
-			t_mcic = *(u64 *)mci;
-
-			if (((t_mcic & z_mcic) != 0) ||
-			    ((t_mcic & o_mcic) != o_mcic)) {
-				s390_handle_damage("processing backup machine "
-						   "check with damage.");
-			}
-
-			/*
-			 * Nullifying exigent condition, therefore we might
-			 * retry this instruction.
-			 */
-
-			spin_lock(&ipd_lock);
-
-			tmp = get_clock();
-
-			if (((tmp - last_ipd) >> 12) < MAX_IPD_TIME)
-				ipd_count++;
-			else
-				ipd_count = 1;
-
-			last_ipd = tmp;
-
-			if (ipd_count == MAX_IPD_COUNT)
-				s390_handle_damage("too many ipd retries.");
-
-			spin_unlock(&ipd_lock);
-		}
-		else {
-			/* Processing damage -> stopping machine */
-			s390_handle_damage("received instruction processing "
-					   "damage machine check.");
-		}
-	}
-	if (s390_revalidate_registers(mci)) {
-		if (umode) {
-			/*
-			 * Couldn't restore all register contents while in
-			 * user mode -> mark task for termination.
-			 */
-			mcck->kill_task = 1;
-			mcck->mcck_code = *(unsigned long long *) mci;
-			set_thread_flag(TIF_MCCK_PENDING);
-		}
-		else
-			/*
-			 * Couldn't restore all register contents while in
-			 * kernel mode -> stopping machine.
-			 */
-			s390_handle_damage("unable to revalidate registers.");
-	}
-
-	if (mci->cd) {
-		/* Timing facility damage */
-		s390_handle_damage("TOD clock damaged");
-	}
-
-	if (mci->ed && mci->ec) {
-		/* External damage */
-		if (S390_lowcore.external_damage_code & (1U << ED_ETR_SYNC))
-			etr_sync_check();
-		if (S390_lowcore.external_damage_code & (1U << ED_ETR_SWITCH))
-			etr_switch_to_local();
-		if (S390_lowcore.external_damage_code & (1U << ED_STP_SYNC))
-			stp_sync_check();
-		if (S390_lowcore.external_damage_code & (1U << ED_STP_ISLAND))
-			stp_island_check();
-	}
-
-	if (mci->se)
-		/* Storage error uncorrected */
-		s390_handle_damage("received storage error uncorrected "
-				   "machine check.");
-
-	if (mci->ke)
-		/* Storage key-error uncorrected */
-		s390_handle_damage("received storage key-error uncorrected "
-				   "machine check.");
-
-	if (mci->ds && mci->fa)
-		/* Storage degradation */
-		s390_handle_damage("received storage degradation machine "
-				   "check.");
-
-	if (mci->cp) {
-		/* Channel report word pending */
-		mcck->channel_report = 1;
-		set_thread_flag(TIF_MCCK_PENDING);
-	}
-
-	if (mci->w) {
-		/* Warning pending */
-		mcck->warning = 1;
-		set_thread_flag(TIF_MCCK_PENDING);
-	}
-	lockdep_on();
-}
-
-/*
- * s390_init_machine_check
- *
- * initialize machine check handling
- */
-static int
-machine_check_init(void)
-{
-	init_MUTEX_LOCKED(&m_sem);
-	ctl_set_bit(14, 25);	/* enable external damage MCH */
-	ctl_set_bit(14, 27);    /* enable system recovery MCH */
-#ifdef CONFIG_MACHCHK_WARNING
-	ctl_set_bit(14, 24);	/* enable warning MCH */
-#endif
-	return 0;
-}
-
-/*
- * Initialize the machine check handler really early to be able to
- * catch all machine checks that happen during boot
- */
-arch_initcall(machine_check_init);
-
-/*
- * Machine checks for the channel subsystem must be enabled
- * after the channel subsystem is initialized
- */
-static int __init
-machine_check_crw_init (void)
-{
-	struct task_struct *task;
-
-	task = kthread_run(s390_collect_crw_info, &m_sem, "kmcheck");
-	if (IS_ERR(task))
-		return PTR_ERR(task);
-	ctl_set_bit(14, 28);	/* enable channel report MCH */
-	return 0;
-}
-
-device_initcall (machine_check_crw_init);
Index: quilt-2.6/drivers/s390/s390mach.h
===================================================================
--- quilt-2.6.orig/drivers/s390/s390mach.h
+++ /dev/null
@@ -1,122 +0,0 @@
-/*
- *  drivers/s390/s390mach.h
- *   S/390 data definitions for machine check processing
- *
- *  S390 version
- *    Copyright (C) 2000 IBM Deutschland Entwicklung GmbH, IBM Corporation
- *    Author(s): Ingo Adlung (adlung@de.ibm.com)
- */
-
-#ifndef __s390mach_h
-#define __s390mach_h
-
-#include <asm/types.h>
-
-struct mci {
-	__u32   sd              :  1; /* 00 system damage */
-	__u32   pd              :  1; /* 01 instruction-processing damage */
-	__u32   sr              :  1; /* 02 system recovery */
-	__u32   to_be_defined_1 :  1; /* 03 */
-	__u32   cd              :  1; /* 04 timing-facility damage */
-	__u32   ed              :  1; /* 05 external damage */
-	__u32   to_be_defined_2 :  1; /* 06 */
-	__u32   dg              :  1; /* 07 degradation */
-	__u32   w               :  1; /* 08 warning pending */
-	__u32   cp              :  1; /* 09 channel-report pending */
-	__u32   sp              :  1; /* 10 service-processor damage */
-	__u32   ck              :  1; /* 11 channel-subsystem damage */
-	__u32   to_be_defined_3 :  2; /* 12-13 */
-	__u32   b               :  1; /* 14 backed up */
-	__u32   to_be_defined_4 :  1; /* 15 */
-	__u32   se              :  1; /* 16 storage error uncorrected */
-	__u32   sc              :  1; /* 17 storage error corrected */
-	__u32   ke              :  1; /* 18 storage-key error uncorrected */
-	__u32   ds              :  1; /* 19 storage degradation */
-	__u32   wp              :  1; /* 20 psw mwp validity */
-	__u32   ms              :  1; /* 21 psw mask and key validity */
-	__u32   pm              :  1; /* 22 psw program mask and cc validity */
-	__u32   ia              :  1; /* 23 psw instruction address validity */
-	__u32   fa              :  1; /* 24 failing storage address validity */
-	__u32   to_be_defined_5 :  1; /* 25 */
-	__u32   ec              :  1; /* 26 external damage code validity */
-	__u32   fp              :  1; /* 27 floating point register validity */
-	__u32   gr              :  1; /* 28 general register validity */
-	__u32   cr              :  1; /* 29 control register validity */
-	__u32   to_be_defined_6 :  1; /* 30 */
-	__u32   st              :  1; /* 31 storage logical validity */
-	__u32   ie              :  1; /* 32 indirect storage error */
-	__u32   ar              :  1; /* 33 access register validity */
-	__u32   da              :  1; /* 34 delayed access exception */
-	__u32   to_be_defined_7 :  7; /* 35-41 */
-	__u32   pr              :  1; /* 42 tod programmable register validity */
-	__u32   fc              :  1; /* 43 fp control register validity */
-	__u32   ap              :  1; /* 44 ancillary report */
-	__u32   to_be_defined_8 :  1; /* 45 */
-	__u32   ct              :  1; /* 46 cpu timer validity */
-	__u32   cc              :  1; /* 47 clock comparator validity */
-	__u32	to_be_defined_9 : 16; /* 47-63 */
-};
-
-/*
- * Channel Report Word
- */
-struct crw {
-	__u32 res1    :  1;   /* reserved zero */
-	__u32 slct    :  1;   /* solicited */
-	__u32 oflw    :  1;   /* overflow */
-	__u32 chn     :  1;   /* chained */
-	__u32 rsc     :  4;   /* reporting source code */
-	__u32 anc     :  1;   /* ancillary report */
-	__u32 res2    :  1;   /* reserved zero */
-	__u32 erc     :  6;   /* error-recovery code */
-	__u32 rsid    : 16;   /* reporting-source ID */
-} __attribute__ ((packed));
-
-typedef void (*crw_handler_t)(struct crw *, struct crw *, int);
-
-extern int s390_register_crw_handler(int rsc, crw_handler_t handler);
-extern void s390_unregister_crw_handler(int rsc);
-
-#define NR_RSCS 16
-
-#define CRW_RSC_MONITOR  0x2  /* monitoring facility */
-#define CRW_RSC_SCH      0x3  /* subchannel */
-#define CRW_RSC_CPATH    0x4  /* channel path */
-#define CRW_RSC_CONFIG   0x9  /* configuration-alert facility */
-#define CRW_RSC_CSS      0xB  /* channel subsystem */
-
-#define CRW_ERC_EVENT    0x00 /* event information pending */
-#define CRW_ERC_AVAIL    0x01 /* available */
-#define CRW_ERC_INIT     0x02 /* initialized */
-#define CRW_ERC_TERROR   0x03 /* temporary error */
-#define CRW_ERC_IPARM    0x04 /* installed parm initialized */
-#define CRW_ERC_TERM     0x05 /* terminal */
-#define CRW_ERC_PERRN    0x06 /* perm. error, fac. not init */
-#define CRW_ERC_PERRI    0x07 /* perm. error, facility init */
-#define CRW_ERC_PMOD     0x08 /* installed parameters modified */
-
-static inline int stcrw(struct crw *pcrw )
-{
-	int ccode;
-
-	__asm__ __volatile__(
-		"stcrw 0(%2)\n\t"
-		"ipm %0\n\t"
-		"srl %0,28\n\t"
-		: "=d" (ccode), "=m" (*pcrw)
-		: "a" (pcrw)
-		: "cc" );
-	return ccode;
-}
-
-#define ED_ETR_SYNC	12	/* External damage ETR sync check */
-#define ED_ETR_SWITCH	13	/* External damage ETR switch to local */
-
-#define ED_STP_SYNC	7	/* External damage STP sync check */
-#define ED_STP_ISLAND	6	/* External damage STP island check */
-
-struct pt_regs;
-
-void s390_handle_mcck(void);
-void s390_do_machine_check(struct pt_regs *regs);
-#endif /* __s390mach */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
