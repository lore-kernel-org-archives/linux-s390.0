Return-Path: <linux-kernel-owner+w=401wt.eu-S1031404AbXEDQzv@vger.kernel.org>
Message-Id: <20070504165242.971424674@de.ibm.com>
References: <20070504165016.908033855@de.ibm.com>
Date: Fri, 04 May 2007 18:50:25 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 9/9] add hardware capability support (ELF_HWCAP).
Content-Disposition: inline; filename=100-hwcap.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/setup.c   |  109 +++++++++++++++++++++++++++++++++++++++++++++
 include/asm-s390/elf.h     |    7 ++
 include/asm-s390/lowcore.h |   10 ++--
 3 files changed, 120 insertions(+), 6 deletions(-)

Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c	2007-05-04 18:50:14.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/setup.c	2007-05-04 18:50:16.000000000 +0200
@@ -74,6 +74,8 @@
 unsigned int console_devno = -1;
 unsigned int console_irq = -1;
 unsigned long machine_flags = 0;
+unsigned long elf_hwcap = 0;
+char elf_platform[ELF_PLATFORM_SIZE];
 
 struct mem_chunk __initdata memory_chunk[MEMORY_CHUNKS];
 volatile int __cpu_logical_map[NR_CPUS]; /* logical cpu to cpu address */
@@ -749,6 +751,98 @@
 #endif
 }
 
+static __init unsigned int stfl(void)
+{
+	asm volatile(
+		"	.insn	s,0xb2b10000,0(0)\n" /* stfl */
+		"0:\n"
+		EX_TABLE(0b,0b));
+	return S390_lowcore.stfl_fac_list;
+}
+
+static __init int stfle(unsigned long long *list, int doublewords)
+{
+	typedef struct { unsigned long long _[doublewords]; } addrtype;
+	register unsigned long __nr asm("0") = doublewords - 1;
+
+	asm volatile(".insn s,0xb2b00000,%0" /* stfle */
+		     : "=m" (*(addrtype *) list), "+d" (__nr) : : "cc");
+	return __nr + 1;
+}
+
+/*
+ * Setup hardware capabilities.
+ */
+static void __init setup_hwcaps(void)
+{
+	static const int stfl_bits[6] = { 0, 2, 7, 17, 19, 21 };
+	struct cpuinfo_S390 *cpuinfo = &S390_lowcore.cpu_data;
+	unsigned long long facility_list_extended;
+	unsigned int facility_list;
+	int i;
+
+	facility_list = stfl();
+	/*
+	 * The store facility list bits numbers as found in the principles
+	 * of operation are numbered with bit 1UL<<31 as number 0 to
+	 * bit 1UL<<0 as number 31.
+	 *   Bit 0: instructions named N3, "backported" to esa-mode
+	 *   Bit 2: z/Architecture mode is active
+	 *   Bit 7: the store-facility-list-extended facility is installed
+	 *   Bit 17: the message-security assist is installed
+	 *   Bit 19: the long-displacement facility is installed
+	 *   Bit 21: the extended-immediate facility is installed
+	 * These get translated to:
+	 *   HWCAP_S390_ESAN3 bit 0, HWCAP_S390_ZARCH bit 1,
+	 *   HWCAP_S390_STFLE bit 2, HWCAP_S390_MSA bit 3,
+	 *   HWCAP_S390_LDISP bit 4, and HWCAP_S390_EIMM bit 5.
+	 */
+	for (i = 0; i < 6; i++)
+		if (facility_list & (1UL << (31 - stfl_bits[i])))
+			elf_hwcap |= 1UL << i;
+
+	/*
+	 * Check for additional facilities with store-facility-list-extended.
+	 * stfle stores doublewords (8 byte) with bit 1ULL<<63 as bit 0
+	 * and 1ULL<<0 as bit 63. Bits 0-31 contain the same information
+	 * as stored by stfl, bits 32-xxx contain additional facilities.
+	 * How many facility words are stored depends on the number of
+	 * doublewords passed to the instruction. The additional facilites
+	 * are:
+	 *   Bit 43: decimal floating point facility is installed
+	 * translated to:
+	 *   HWCAP_S390_DFP bit 6.
+	 */
+	if ((elf_hwcap & (1UL << 2)) &&
+	    stfle(&facility_list_extended, 1) > 0) {
+		if (facility_list_extended & (1ULL << (64 - 43)))
+			elf_hwcap |= 1UL << 6;
+	}
+
+	switch (cpuinfo->cpu_id.machine) {
+	case 0x9672:
+#if !defined(CONFIG_64BIT)
+	default:	/* Use "g5" as default for 31 bit kernels. */
+#endif
+		strcpy(elf_platform, "g5");
+		break;
+	case 0x2064:
+	case 0x2066:
+#if defined(CONFIG_64BIT)
+	default:	/* Use "z900" as default for 64 bit kernels. */
+#endif
+		strcpy(elf_platform, "z900");
+		break;
+	case 0x2084:
+	case 0x2086:
+		strcpy(elf_platform, "z990");
+		break;
+	case 0x2094:
+		strcpy(elf_platform, "z9-109");
+		break;
+	}
+}
+
 /*
  * Setup function called from init/main.c just after the banner
  * was printed.
@@ -805,6 +899,11 @@
 	smp_setup_cpu_possible_map();
 
 	/*
+	 * Setup capabilities (ELF_HWCAP & ELF_PLATFORM).
+	 */
+	setup_hwcaps();
+
+	/*
 	 * Create kernel page tables and switch to virtual addressing.
 	 */
         paging_init();
@@ -839,8 +938,12 @@
 
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
+	static const char *hwcap_str[7] = {
+		"esan3", "zarch", "stfle", "msa", "ldisp", "eimm", "dfp"
+	};
         struct cpuinfo_S390 *cpuinfo;
 	unsigned long n = (unsigned long) v - 1;
+	int i;
 
 	s390_adjust_jiffies();
 	preempt_disable();
@@ -850,7 +953,13 @@
 			       "bogomips per cpu: %lu.%02lu\n",
 			       num_online_cpus(), loops_per_jiffy/(500000/HZ),
 			       (loops_per_jiffy/(5000/HZ))%100);
+		seq_puts(m, "features\t: ");
+		for (i = 0; i < 7; i++)
+			if (hwcap_str[i] && (elf_hwcap & (1UL << i)))
+				seq_printf(m, "%s ", hwcap_str[i]);
+		seq_puts(m, "\n");
 	}
+
 	if (cpu_online(n)) {
 #ifdef CONFIG_SMP
 		if (smp_processor_id() == n)
Index: quilt-2.6/include/asm-s390/elf.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/elf.h	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/include/asm-s390/elf.h	2007-05-04 18:50:16.000000000 +0200
@@ -188,7 +188,8 @@
 /* This yields a mask that user programs can use to figure out what
    instruction set this CPU supports. */
 
-#define ELF_HWCAP (0)
+extern unsigned long elf_hwcap;
+#define ELF_HWCAP (elf_hwcap)
 
 /* This yields a string that ld.so will use to load implementation
    specific libraries for optimization.  This is more specific in
@@ -197,7 +198,9 @@
    For the moment, we have only optimizations for the Intel generations,
    but that could change... */
 
-#define ELF_PLATFORM (NULL)
+#define ELF_PLATFORM_SIZE 8
+extern char elf_platform[];
+#define ELF_PLATFORM (elf_platform)
 
 #ifndef __s390x__
 #define SET_PERSONALITY(ex, ibcs2) set_personality((ibcs2)?PER_SVR4:PER_LINUX)
Index: quilt-2.6/include/asm-s390/lowcore.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/lowcore.h	2007-05-04 18:48:36.000000000 +0200
+++ quilt-2.6/include/asm-s390/lowcore.h	2007-05-04 18:50:16.000000000 +0200
@@ -229,17 +229,19 @@
 	__u16        subchannel_nr;            /* 0x0ba */
 	__u32        io_int_parm;              /* 0x0bc */
 	__u32        io_int_word;              /* 0x0c0 */
-        __u8         pad3[0xD4-0xC4];          /* 0x0c4 */
+	__u8	     pad3[0xc8-0xc4];	       /* 0x0c4 */
+	__u32	     stfl_fac_list;	       /* 0x0c8 */
+	__u8	     pad4[0xd4-0xcc];	       /* 0x0cc */
 	__u32        extended_save_area_addr;  /* 0x0d4 */
 	__u32        cpu_timer_save_area[2];   /* 0x0d8 */
 	__u32        clock_comp_save_area[2];  /* 0x0e0 */
 	__u32        mcck_interruption_code[2]; /* 0x0e8 */
-	__u8         pad4[0xf4-0xf0];          /* 0x0f0 */
+	__u8	     pad5[0xf4-0xf0];	       /* 0x0f0 */
 	__u32        external_damage_code;     /* 0x0f4 */
 	__u32        failing_storage_address;  /* 0x0f8 */
-	__u8         pad5[0x100-0xfc];         /* 0x0fc */
+	__u8	     pad6[0x100-0xfc];	       /* 0x0fc */
 	__u32        st_status_fixed_logout[4];/* 0x100 */
-	__u8         pad6[0x120-0x110];        /* 0x110 */
+	__u8	     pad7[0x120-0x110];        /* 0x110 */
 	__u32        access_regs_save_area[16];/* 0x120 */
 	__u32        floating_pt_save_area[8]; /* 0x160 */
 	__u32        gpregs_save_area[16];     /* 0x180 */

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
