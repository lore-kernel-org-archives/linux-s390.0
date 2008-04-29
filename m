Return-Path: <linux-kernel-owner+w=401wt.eu-S1765511AbYD2OUk@vger.kernel.org>
Message-Id: <20080429140251.724650722@de.ibm.com>
References: <20080429140117.631962807@de.ibm.com>
Date: Tue, 29 Apr 2008 16:01:30 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 13/15] Convert machine feature detection code to C.
Content-Disposition: inline; filename=013-feature-detection.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>
From: Carsten Otte <cotte@de.ibm.com>

This lets us use defines for the magic bits in machine flags instead
of using plain numbers all over the place.
In addition on newer machines features/facilities are indicated by the
result of the stfl instruction. So we use these bits instead of trying
to execute new instructions and check wether we get an exception or
not.
Also the mvpg instruction is always available when in zArch mode,
whereas the idte instruction is only available in zArch mode. This
results in some minor optimizations.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Carsten Otte <cotte@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/early.c  |  109 ++++++++++++++++++++++++++++++++++++++++++++--
 arch/s390/kernel/head31.S |   61 -------------------------
 arch/s390/kernel/head64.S |   62 --------------------------
 arch/s390/kernel/setup.c  |    2 
 include/asm-s390/setup.h  |   33 +++++++++----
 include/asm-s390/smp.h    |    6 --
 include/asm-s390/system.h |    8 +++
 7 files changed, 140 insertions(+), 141 deletions(-)

Index: quilt-2.6/arch/s390/kernel/early.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/early.c
+++ quilt-2.6/arch/s390/kernel/early.c
@@ -139,15 +139,15 @@ static noinline __init void detect_machi
 
 	/* Running under z/VM ? */
 	if (cpuinfo->cpu_id.version == 0xff)
-		machine_flags |= 1;
+		machine_flags |= MACHINE_FLAG_VM;
 
 	/* Running on a P/390 ? */
 	if (cpuinfo->cpu_id.machine == 0x7490)
-		machine_flags |= 4;
+		machine_flags |= MACHINE_FLAG_P390;
 
 	/* Running under KVM ? */
 	if (cpuinfo->cpu_id.version == 0xfe)
-		machine_flags |= 64;
+		machine_flags |= MACHINE_FLAG_KVM;
 }
 
 #ifdef CONFIG_64BIT
@@ -268,6 +268,103 @@ static noinline __init void setup_lowcor
 	s390_base_pgm_handler_fn = early_pgm_check_handler;
 }
 
+static __init void detect_mvpg(void)
+{
+#ifndef CONFIG_64BIT
+	int rc;
+
+	asm volatile(
+		"	la	0,0\n"
+		"	mvpg	%2,%2\n"
+		"0:	la	%0,0\n"
+		"1:\n"
+		EX_TABLE(0b,1b)
+		: "=d" (rc) : "0" (-EOPNOTSUPP), "a" (0) : "memory", "cc", "0");
+	if (!rc)
+		machine_flags |= MACHINE_FLAG_MVPG;
+#endif
+}
+
+static __init void detect_ieee(void)
+{
+#ifndef CONFIG_64BIT
+	int rc, tmp;
+
+	asm volatile(
+		"	efpc	%1,0\n"
+		"0:	la	%0,0\n"
+		"1:\n"
+		EX_TABLE(0b,1b)
+		: "=d" (rc), "=d" (tmp): "0" (-EOPNOTSUPP) : "cc");
+	if (!rc)
+		machine_flags |= MACHINE_FLAG_IEEE;
+#endif
+}
+
+static __init void detect_csp(void)
+{
+#ifndef CONFIG_64BIT
+	int rc;
+
+	asm volatile(
+		"	la	0,0\n"
+		"	la	1,0\n"
+		"	la	2,4\n"
+		"	csp	0,2\n"
+		"0:	la	%0,0\n"
+		"1:\n"
+		EX_TABLE(0b,1b)
+		: "=d" (rc) : "0" (-EOPNOTSUPP) : "cc", "0", "1", "2");
+	if (!rc)
+		machine_flags |= MACHINE_FLAG_CSP;
+#endif
+}
+
+static __init void detect_diag9c(void)
+{
+	unsigned int cpu_address;
+	int rc;
+
+	cpu_address = stap();
+	asm volatile(
+		"	diag	%2,0,0x9c\n"
+		"0:	la	%0,0\n"
+		"1:\n"
+		EX_TABLE(0b,1b)
+		: "=d" (rc) : "0" (-EOPNOTSUPP), "d" (cpu_address) : "cc");
+	if (!rc)
+		machine_flags |= MACHINE_FLAG_DIAG9C;
+}
+
+static __init void detect_diag44(void)
+{
+#ifdef CONFIG_64BIT
+	int rc;
+
+	asm volatile(
+		"	diag	0,0,0x44\n"
+		"0:	la	%0,0\n"
+		"1:\n"
+		EX_TABLE(0b,1b)
+		: "=d" (rc) : "0" (-EOPNOTSUPP) : "cc");
+	if (!rc)
+		machine_flags |= MACHINE_FLAG_DIAG44;
+#endif
+}
+
+static __init void detect_machine_facilities(void)
+{
+#ifdef CONFIG_64BIT
+	unsigned int facilities;
+
+	facilities = stfl();
+	if (facilities & (1 << 28))
+		machine_flags |= MACHINE_FLAG_IDTE;
+	if (facilities & (1 << 4))
+		machine_flags |= MACHINE_FLAG_MVCOS;
+#endif
+}
+
 /*
  * Save ipl parameters, clear bss memory, initialize storage keys
  * and create a kernel NSS at startup if the SAVESYS= parm is defined
@@ -285,6 +382,12 @@ void __init startup_init(void)
 	create_kernel_nss();
 	sort_main_extable();
 	setup_lowcore_early();
+	detect_mvpg();
+	detect_ieee();
+	detect_csp();
+	detect_diag9c();
+	detect_diag44();
+	detect_machine_facilities();
 	sclp_read_info_early();
 	sclp_facilities_detect();
 	memsize = sclp_memory_detect();
Index: quilt-2.6/arch/s390/kernel/head31.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/head31.S
+++ quilt-2.6/arch/s390/kernel/head31.S
@@ -57,61 +57,6 @@ startup_continue:
 #
 	l	%r14,.Lstartup_init-.LPG1(%r13)
 	basr	%r14,%r14
-
-	l	%r12,.Lmflags-.LPG1(%r13) # get address of machine_flags
-#
-# find out if we have an IEEE fpu
-#
-	mvc	__LC_PGM_NEW_PSW(8),.Lpcfpu-.LPG1(%r13)
-	efpc	%r0,0			# test IEEE extract fpc instruction
-	oi	3(%r12),2		# set IEEE fpu flag
-.Lchkfpu:
-
-#
-# find out if we have the CSP instruction
-#
-       mvc	 __LC_PGM_NEW_PSW(8),.Lpccsp-.LPG1(%r13)
-       la	 %r0,0
-       lr	%r1,%r0
-       la	%r2,4
-       csp	%r0,%r2			# Test CSP instruction
-       oi	3(%r12),8		# set CSP flag
-.Lchkcsp:
-
-#
-# find out if we have the MVPG instruction
-#
-       mvc	__LC_PGM_NEW_PSW(8),.Lpcmvpg-.LPG1(%r13)
-       sr	%r0,%r0
-       la	%r1,0
-       la	%r2,0
-       mvpg	%r1,%r2			# Test CSP instruction
-       oi	3(%r12),16		# set MVPG flag
-.Lchkmvpg:
-
-#
-# find out if we have the IDTE instruction
-#
-	mvc	__LC_PGM_NEW_PSW(8),.Lpcidte-.LPG1(%r13)
-	.long	0xb2b10000		# store facility list
-	tm	0xc8,0x08		# check bit for clearing-by-ASCE
-	bno	.Lchkidte-.LPG1(%r13)
-	lhi	%r1,2094
-	lhi	%r2,0
-	.long	0xb98e2001
-	oi	3(%r12),0x80		# set IDTE flag
-.Lchkidte:
-
-#
-# find out if the diag 0x9c is available
-#
-	mvc	__LC_PGM_NEW_PSW(8),.Lpcdiag9c-.LPG1(%r13)
-	stap	__LC_CPUID+4		# store cpu address
-	lh	%r1,__LC_CPUID+4
-	diag	%r1,0,0x9c		# test diag 0x9c
-	oi	2(%r12),1		# set diag9c flag
-.Lchkdiag9c:
-
 	lpsw  .Lentry-.LPG1(13)		# jump to _stext in primary-space,
 					# virtual and never return ...
 	.align	8
@@ -132,13 +77,7 @@ startup_continue:
 	.long	0			# cr13: home space segment table
 	.long	0xc0000000		# cr14: machine check handling off
 	.long	0			# cr15: linkage stack operations
-.Lpcfpu:.long	0x00080000,0x80000000 + .Lchkfpu
-.Lpccsp:.long	0x00080000,0x80000000 + .Lchkcsp
-.Lpcmvpg:.long	0x00080000,0x80000000 + .Lchkmvpg
-.Lpcidte:.long	0x00080000,0x80000000 + .Lchkidte
-.Lpcdiag9c:.long 0x00080000,0x80000000 + .Lchkdiag9c
 .Lmchunk:.long	memory_chunk
-.Lmflags:.long	machine_flags
 .Lbss_bgn:  .long __bss_start
 .Lbss_end:  .long _end
 .Lparmaddr: .long PARMAREA
Index: quilt-2.6/arch/s390/kernel/head64.S
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/head64.S
+++ quilt-2.6/arch/s390/kernel/head64.S
@@ -125,68 +125,6 @@ startup_continue:
 # and create a kernel NSS if the SAVESYS= parm is defined
 #
 	brasl	%r14,startup_init
-					# set program check new psw mask
-	mvc	__LC_PGM_NEW_PSW(8),.Lpcmsk-.LPG1(%r13)
-	larl	%r12,machine_flags
-#
-# find out if we have the MVPG instruction
-#
-	la	%r1,0f-.LPG1(%r13)	# set program check address
-	stg	%r1,__LC_PGM_NEW_PSW+8
-	sgr	%r0,%r0
-	lghi	%r1,0
-	lghi	%r2,0
-	mvpg	%r1,%r2 		# test MVPG instruction
-	oi	7(%r12),16		# set MVPG flag
-0:
-
-#
-# find out if the diag 0x44 works in 64 bit mode
-#
-	la	%r1,0f-.LPG1(%r13)	# set program check address
-	stg	%r1,__LC_PGM_NEW_PSW+8
-	diag	0,0,0x44		# test diag 0x44
-	oi	7(%r12),32		# set diag44 flag
-0:
-
-#
-# find out if we have the IDTE instruction
-#
-	la	%r1,0f-.LPG1(%r13)	# set program check address
-	stg	%r1,__LC_PGM_NEW_PSW+8
-	.long	0xb2b10000		# store facility list
-	tm	0xc8,0x08		# check bit for clearing-by-ASCE
-	bno	0f-.LPG1(%r13)
-	lhi	%r1,2048
-	lhi	%r2,0
-	.long	0xb98e2001
-	oi	7(%r12),0x80		# set IDTE flag
-0:
-
-#
-# find out if the diag 0x9c is available
-#
-	la	%r1,0f-.LPG1(%r13)	# set program check address
-	stg	%r1,__LC_PGM_NEW_PSW+8
-	stap	__LC_CPUID+4		# store cpu address
-	lh	%r1,__LC_CPUID+4
-	diag	%r1,0,0x9c		# test diag 0x9c
-	oi	6(%r12),1		# set diag9c flag
-0:
-
-#
-# find out if we have the MVCOS instruction
-#
-	la	%r1,0f-.LPG1(%r13)	# set program check address
-	stg	%r1,__LC_PGM_NEW_PSW+8
-	.short	0xc800			# mvcos 0(%r0),0(%r0),%r0
-	.short	0x0000
-	.short	0x0000
-0:	tm	0x8f,0x13		# special-operation exception?
-	bno	1f-.LPG1(%r13)		# if yes, MVCOS is present
-	oi	6(%r12),2		# set MVCOS flag
-1:
-
 	lpswe	.Lentry-.LPG1(13)	# jump to _stext in primary-space,
 					# virtual and never return ...
 	.align	16
Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -73,7 +73,7 @@ EXPORT_SYMBOL(uaccess);
 unsigned int console_mode = 0;
 unsigned int console_devno = -1;
 unsigned int console_irq = -1;
-unsigned long machine_flags = 0;
+unsigned long machine_flags;
 unsigned long elf_hwcap = 0;
 char elf_platform[ELF_PLATFORM_SIZE];
 
Index: quilt-2.6/include/asm-s390/setup.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/setup.h
+++ quilt-2.6/include/asm-s390/setup.h
@@ -59,23 +59,36 @@ extern unsigned int s390_noexec;
  */
 extern unsigned long machine_flags;
 
-#define MACHINE_IS_VM		(machine_flags & 1)
-#define MACHINE_IS_P390		(machine_flags & 4)
-#define MACHINE_HAS_MVPG	(machine_flags & 16)
-#define MACHINE_IS_KVM		(machine_flags & 64)
-#define MACHINE_HAS_IDTE	(machine_flags & 128)
-#define MACHINE_HAS_DIAG9C	(machine_flags & 256)
+#define MACHINE_FLAG_VM		(1UL << 0)
+#define MACHINE_FLAG_IEEE	(1UL << 1)
+#define MACHINE_FLAG_P390	(1UL << 2)
+#define MACHINE_FLAG_CSP	(1UL << 3)
+#define MACHINE_FLAG_MVPG	(1UL << 4)
+#define MACHINE_FLAG_DIAG44	(1UL << 5)
+#define MACHINE_FLAG_IDTE	(1UL << 6)
+#define MACHINE_FLAG_DIAG9C	(1UL << 7)
+#define MACHINE_FLAG_MVCOS	(1UL << 8)
+#define MACHINE_FLAG_KVM	(1UL << 9)
+
+#define MACHINE_IS_VM		(machine_flags & MACHINE_FLAG_VM)
+#define MACHINE_IS_KVM		(machine_flags & MACHINE_FLAG_KVM)
+#define MACHINE_IS_P390		(machine_flags & MACHINE_FLAG_P390)
+#define MACHINE_HAS_DIAG9C	(machine_flags & MACHINE_FLAG_DIAG9C)
 
 #ifndef __s390x__
-#define MACHINE_HAS_IEEE	(machine_flags & 2)
-#define MACHINE_HAS_CSP		(machine_flags & 8)
+#define MACHINE_HAS_IEEE	(machine_flags & MACHINE_FLAG_IEEE)
+#define MACHINE_HAS_CSP		(machine_flags & MACHINE_FLAG_CSP)
+#define MACHINE_HAS_IDTE	(0)
 #define MACHINE_HAS_DIAG44	(1)
+#define MACHINE_HAS_MVPG	(machine_flags & MACHINE_FLAG_MVPG)
 #define MACHINE_HAS_MVCOS	(0)
 #else /* __s390x__ */
 #define MACHINE_HAS_IEEE	(1)
 #define MACHINE_HAS_CSP		(1)
-#define MACHINE_HAS_DIAG44	(machine_flags & 32)
-#define MACHINE_HAS_MVCOS	(machine_flags & 512)
+#define MACHINE_HAS_IDTE	(machine_flags & MACHINE_FLAG_IDTE)
+#define MACHINE_HAS_DIAG44	(machine_flags & MACHINE_FLAG_DIAG44)
+#define MACHINE_HAS_MVPG	(1)
+#define MACHINE_HAS_MVCOS	(machine_flags & MACHINE_FLAG_MVCOS)
 #endif /* __s390x__ */
 
 #define MACHINE_HAS_SCLP	(!MACHINE_IS_P390)
Index: quilt-2.6/include/asm-s390/smp.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/smp.h
+++ quilt-2.6/include/asm-s390/smp.h
@@ -19,6 +19,7 @@
 #include <asm/lowcore.h>
 #include <asm/sigp.h>
 #include <asm/ptrace.h>
+#include <asm/system.h>
 
 /*
   s390 specific smp.c headers
@@ -53,10 +54,7 @@ extern void machine_power_off_smp(void);
 
 static inline __u16 hard_smp_processor_id(void)
 {
-        __u16 cpu_address;
- 
-	asm volatile("stap %0" : "=m" (cpu_address));
-        return cpu_address;
+	return stap();
 }
 
 /*
Index: quilt-2.6/include/asm-s390/system.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/system.h
+++ quilt-2.6/include/asm-s390/system.h
@@ -432,6 +432,14 @@ static inline unsigned int stfl(void)
 	return S390_lowcore.stfl_fac_list;
 }
 
+static inline unsigned short stap(void)
+{
+	unsigned short cpu_address;
+
+	asm volatile("stap %0" : "=m" (cpu_address));
+	return cpu_address;
+}
+
 extern void (*_machine_restart)(char *command);
 extern void (*_machine_halt)(void);
 extern void (*_machine_power_off)(void);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
