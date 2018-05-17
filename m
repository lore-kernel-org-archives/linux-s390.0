Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 17 May 2018 08:21:24 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.17-rc6
Message-Id: <20180517082124.72b85c3a@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

A few more additional changes for 4.17:

 * A fix for the vfio ccw translation code

 * Update an incorrect email address in the MAINTAINERS file

 * Fix a division by zero oops in the cpum_sf code found by trinity

 * Two fixes for the error handling of the qdio code

 * Several spectre related patches to convert all left-over indirect branches
   in the kernel to expoline branches

 * Update defconfigs to avoid warnings due to the netfilter Kconfig changes

 * Avoid several compiler warnings in the kexec_file code for s390

Halil Pasic (1):
      vfio: ccw: fix cleanup if cp_prefetch fails

Harald Freudenberger (1):
      MAINTAINERS: update s390 zcrypt maintainers email address

Hendrik Brueckner (1):
      s390/cpum_sf: ensure sample frequency of perf event attributes is non-zero

Julian Wiedmann (2):
      s390/qdio: fix access to uninitialized qdio_q fields
      s390/qdio: don't release memory in qdio_setup_irq()

Martin Schwidefsky (9):
      s390: move expoline assembler macros to a header
      s390/crc32-vx: use expoline for indirect branches
      s390/lib: use expoline for indirect branches
      s390/ftrace: use expoline for indirect branches
      s390/kernel: use expoline for indirect branches
      s390: move spectre sysfs attribute code
      s390: remove indirect branch from do_softirq_own_stack
      s390: extend expoline to BC instructions
      s390: use expoline thunks in the BPF JIT

Sebastian Ott (2):
      s390: update defconfigs
      s390/kexec_file: add declaration of purgatory related globals

 MAINTAINERS                             |   2 +-
 arch/s390/configs/debug_defconfig       |   9 +-
 arch/s390/configs/performance_defconfig |   8 +-
 arch/s390/crypto/crc32be-vx.S           |   5 +-
 arch/s390/crypto/crc32le-vx.S           |   4 +-
 arch/s390/include/asm/nospec-insn.h     | 196 ++++++++++++++++++++++++++++++++
 arch/s390/include/asm/purgatory.h       |   6 +
 arch/s390/kernel/Makefile               |   1 +
 arch/s390/kernel/asm-offsets.c          |   1 +
 arch/s390/kernel/base.S                 |  24 ++--
 arch/s390/kernel/entry.S                | 105 ++++-------------
 arch/s390/kernel/irq.c                  |   5 +-
 arch/s390/kernel/mcount.S               |  14 ++-
 arch/s390/kernel/nospec-branch.c        |  44 ++++---
 arch/s390/kernel/nospec-sysfs.c         |  21 ++++
 arch/s390/kernel/perf_cpum_sf.c         |   4 +
 arch/s390/kernel/reipl.S                |   7 +-
 arch/s390/kernel/swsusp.S               |  10 +-
 arch/s390/lib/mem.S                     |  19 ++--
 arch/s390/net/bpf_jit.S                 |  16 ++-
 arch/s390/net/bpf_jit_comp.c            |  63 +++++++++-
 drivers/s390/cio/qdio_setup.c           |  12 +-
 drivers/s390/cio/vfio_ccw_cp.c          |  13 ++-
 23 files changed, 422 insertions(+), 167 deletions(-)
 create mode 100644 arch/s390/include/asm/nospec-insn.h
 create mode 100644 arch/s390/kernel/nospec-sysfs.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dd66ae9..2ad3306 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12239,7 +12239,7 @@ F:	Documentation/s390/vfio-ccw.txt
 F:	include/uapi/linux/vfio_ccw.h
 
 S390 ZCRYPT DRIVER
-M:	Harald Freudenberger <freude@de.ibm.com>
+M:	Harald Freudenberger <freude@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 W:	http://www.ibm.com/developerworks/linux/linux390/
 S:	Supported
diff --git a/arch/s390/configs/debug_defconfig b/arch/s390/configs/debug_defconfig
index 6176fe9..941d8cc 100644
--- a/arch/s390/configs/debug_defconfig
+++ b/arch/s390/configs/debug_defconfig
@@ -261,9 +261,9 @@ CONFIG_IP_VS_NQ=m
 CONFIG_IP_VS_FTP=m
 CONFIG_IP_VS_PE_SIP=m
 CONFIG_NF_CONNTRACK_IPV4=m
-CONFIG_NF_TABLES_IPV4=m
+CONFIG_NF_TABLES_IPV4=y
 CONFIG_NFT_CHAIN_ROUTE_IPV4=m
-CONFIG_NF_TABLES_ARP=m
+CONFIG_NF_TABLES_ARP=y
 CONFIG_NFT_CHAIN_NAT_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
@@ -284,7 +284,7 @@ CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
-CONFIG_NF_TABLES_IPV6=m
+CONFIG_NF_TABLES_IPV6=y
 CONFIG_NFT_CHAIN_ROUTE_IPV6=m
 CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
@@ -305,7 +305,7 @@ CONFIG_IP6_NF_RAW=m
 CONFIG_IP6_NF_SECURITY=m
 CONFIG_IP6_NF_NAT=m
 CONFIG_IP6_NF_TARGET_MASQUERADE=m
-CONFIG_NF_TABLES_BRIDGE=m
+CONFIG_NF_TABLES_BRIDGE=y
 CONFIG_RDS=m
 CONFIG_RDS_RDMA=m
 CONFIG_RDS_TCP=m
@@ -604,7 +604,6 @@ CONFIG_DETECT_HUNG_TASK=y
 CONFIG_WQ_WATCHDOG=y
 CONFIG_PANIC_ON_OOPS=y
 CONFIG_DEBUG_TIMEKEEPING=y
-CONFIG_DEBUG_WW_MUTEX_SLOWPATH=y
 CONFIG_PROVE_LOCKING=y
 CONFIG_LOCK_STAT=y
 CONFIG_DEBUG_LOCKDEP=y
diff --git a/arch/s390/configs/performance_defconfig b/arch/s390/configs/performance_defconfig
index c105bcc..eb6f75f 100644
--- a/arch/s390/configs/performance_defconfig
+++ b/arch/s390/configs/performance_defconfig
@@ -259,9 +259,9 @@ CONFIG_IP_VS_NQ=m
 CONFIG_IP_VS_FTP=m
 CONFIG_IP_VS_PE_SIP=m
 CONFIG_NF_CONNTRACK_IPV4=m
-CONFIG_NF_TABLES_IPV4=m
+CONFIG_NF_TABLES_IPV4=y
 CONFIG_NFT_CHAIN_ROUTE_IPV4=m
-CONFIG_NF_TABLES_ARP=m
+CONFIG_NF_TABLES_ARP=y
 CONFIG_NFT_CHAIN_NAT_IPV4=m
 CONFIG_IP_NF_IPTABLES=m
 CONFIG_IP_NF_MATCH_AH=m
@@ -282,7 +282,7 @@ CONFIG_IP_NF_ARPTABLES=m
 CONFIG_IP_NF_ARPFILTER=m
 CONFIG_IP_NF_ARP_MANGLE=m
 CONFIG_NF_CONNTRACK_IPV6=m
-CONFIG_NF_TABLES_IPV6=m
+CONFIG_NF_TABLES_IPV6=y
 CONFIG_NFT_CHAIN_ROUTE_IPV6=m
 CONFIG_NFT_CHAIN_NAT_IPV6=m
 CONFIG_IP6_NF_IPTABLES=m
@@ -303,7 +303,7 @@ CONFIG_IP6_NF_RAW=m
 CONFIG_IP6_NF_SECURITY=m
 CONFIG_IP6_NF_NAT=m
 CONFIG_IP6_NF_TARGET_MASQUERADE=m
-CONFIG_NF_TABLES_BRIDGE=m
+CONFIG_NF_TABLES_BRIDGE=y
 CONFIG_RDS=m
 CONFIG_RDS_RDMA=m
 CONFIG_RDS_TCP=m
diff --git a/arch/s390/crypto/crc32be-vx.S b/arch/s390/crypto/crc32be-vx.S
index e8077f0..2bf01ba 100644
--- a/arch/s390/crypto/crc32be-vx.S
+++ b/arch/s390/crypto/crc32be-vx.S
@@ -13,6 +13,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/nospec-insn.h>
 #include <asm/vx-insn.h>
 
 /* Vector register range containing CRC-32 constants */
@@ -67,6 +68,8 @@
 
 .previous
 
+	GEN_BR_THUNK %r14
+
 .text
 /*
  * The CRC-32 function(s) use these calling conventions:
@@ -203,6 +206,6 @@ ENTRY(crc32_be_vgfm_16)
 
 .Ldone:
 	VLGVF	%r2,%v2,3
-	br	%r14
+	BR_EX	%r14
 
 .previous
diff --git a/arch/s390/crypto/crc32le-vx.S b/arch/s390/crypto/crc32le-vx.S
index d8c67a58..7d6f568 100644
--- a/arch/s390/crypto/crc32le-vx.S
+++ b/arch/s390/crypto/crc32le-vx.S
@@ -14,6 +14,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/nospec-insn.h>
 #include <asm/vx-insn.h>
 
 /* Vector register range containing CRC-32 constants */
@@ -76,6 +77,7 @@
 
 .previous
 
+	GEN_BR_THUNK %r14
 
 .text
 
@@ -264,6 +266,6 @@ crc32_le_vgfm_generic:
 
 .Ldone:
 	VLGVF	%r2,%v2,2
-	br	%r14
+	BR_EX	%r14
 
 .previous
diff --git a/arch/s390/include/asm/nospec-insn.h b/arch/s390/include/asm/nospec-insn.h
new file mode 100644
index 0000000..a01f811
--- /dev/null
+++ b/arch/s390/include/asm/nospec-insn.h
@@ -0,0 +1,196 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_NOSPEC_ASM_H
+#define _ASM_S390_NOSPEC_ASM_H
+
+#include <asm/alternative-asm.h>
+#include <asm/asm-offsets.h>
+#include <asm/dwarf.h>
+
+#ifdef __ASSEMBLY__
+
+#ifdef CONFIG_EXPOLINE
+
+_LC_BR_R1 = __LC_BR_R1
+
+/*
+ * The expoline macros are used to create thunks in the same format
+ * as gcc generates them. The 'comdat' section flag makes sure that
+ * the various thunks are merged into a single copy.
+ */
+	.macro __THUNK_PROLOG_NAME name
+	.pushsection .text.\name,"axG",@progbits,\name,comdat
+	.globl \name
+	.hidden \name
+	.type \name,@function
+\name:
+	CFI_STARTPROC
+	.endm
+
+	.macro __THUNK_EPILOG
+	CFI_ENDPROC
+	.popsection
+	.endm
+
+	.macro __THUNK_PROLOG_BR r1,r2
+	__THUNK_PROLOG_NAME __s390x_indirect_jump_r\r2\()use_r\r1
+	.endm
+
+	.macro __THUNK_PROLOG_BC d0,r1,r2
+	__THUNK_PROLOG_NAME __s390x_indirect_branch_\d0\()_\r2\()use_\r1
+	.endm
+
+	.macro __THUNK_BR r1,r2
+	jg	__s390x_indirect_jump_r\r2\()use_r\r1
+	.endm
+
+	.macro __THUNK_BC d0,r1,r2
+	jg	__s390x_indirect_branch_\d0\()_\r2\()use_\r1
+	.endm
+
+	.macro __THUNK_BRASL r1,r2,r3
+	brasl	\r1,__s390x_indirect_jump_r\r3\()use_r\r2
+	.endm
+
+	.macro	__DECODE_RR expand,reg,ruse
+	.set __decode_fail,1
+	.irp r1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	.ifc \reg,%r\r1
+	.irp r2,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	.ifc \ruse,%r\r2
+	\expand \r1,\r2
+	.set __decode_fail,0
+	.endif
+	.endr
+	.endif
+	.endr
+	.if __decode_fail == 1
+	.error "__DECODE_RR failed"
+	.endif
+	.endm
+
+	.macro	__DECODE_RRR expand,rsave,rtarget,ruse
+	.set __decode_fail,1
+	.irp r1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	.ifc \rsave,%r\r1
+	.irp r2,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	.ifc \rtarget,%r\r2
+	.irp r3,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	.ifc \ruse,%r\r3
+	\expand \r1,\r2,\r3
+	.set __decode_fail,0
+	.endif
+	.endr
+	.endif
+	.endr
+	.endif
+	.endr
+	.if __decode_fail == 1
+	.error "__DECODE_RRR failed"
+	.endif
+	.endm
+
+	.macro	__DECODE_DRR expand,disp,reg,ruse
+	.set __decode_fail,1
+	.irp r1,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	.ifc \reg,%r\r1
+	.irp r2,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
+	.ifc \ruse,%r\r2
+	\expand \disp,\r1,\r2
+	.set __decode_fail,0
+	.endif
+	.endr
+	.endif
+	.endr
+	.if __decode_fail == 1
+	.error "__DECODE_DRR failed"
+	.endif
+	.endm
+
+	.macro __THUNK_EX_BR reg,ruse
+	# Be very careful when adding instructions to this macro!
+	# The ALTERNATIVE replacement code has a .+10 which targets
+	# the "br \reg" after the code has been patched.
+#ifdef CONFIG_HAVE_MARCH_Z10_FEATURES
+	exrl	0,555f
+	j	.
+#else
+	.ifc \reg,%r1
+	ALTERNATIVE "ex %r0,_LC_BR_R1", ".insn ril,0xc60000000000,0,.+10", 35
+	j	.
+	.else
+	larl	\ruse,555f
+	ex	0,0(\ruse)
+	j	.
+	.endif
+#endif
+555:	br	\reg
+	.endm
+
+	.macro __THUNK_EX_BC disp,reg,ruse
+#ifdef CONFIG_HAVE_MARCH_Z10_FEATURES
+	exrl	0,556f
+	j	.
+#else
+	larl	\ruse,556f
+	ex	0,0(\ruse)
+	j	.
+#endif
+556:	b	\disp(\reg)
+	.endm
+
+	.macro GEN_BR_THUNK reg,ruse=%r1
+	__DECODE_RR __THUNK_PROLOG_BR,\reg,\ruse
+	__THUNK_EX_BR \reg,\ruse
+	__THUNK_EPILOG
+	.endm
+
+	.macro GEN_B_THUNK disp,reg,ruse=%r1
+	__DECODE_DRR __THUNK_PROLOG_BC,\disp,\reg,\ruse
+	__THUNK_EX_BC \disp,\reg,\ruse
+	__THUNK_EPILOG
+	.endm
+
+	.macro BR_EX reg,ruse=%r1
+557:	__DECODE_RR __THUNK_BR,\reg,\ruse
+	.pushsection .s390_indirect_branches,"a",@progbits
+	.long	557b-.
+	.popsection
+	.endm
+
+	 .macro B_EX disp,reg,ruse=%r1
+558:	__DECODE_DRR __THUNK_BC,\disp,\reg,\ruse
+	.pushsection .s390_indirect_branches,"a",@progbits
+	.long	558b-.
+	.popsection
+	.endm
+
+	.macro BASR_EX rsave,rtarget,ruse=%r1
+559:	__DECODE_RRR __THUNK_BRASL,\rsave,\rtarget,\ruse
+	.pushsection .s390_indirect_branches,"a",@progbits
+	.long	559b-.
+	.popsection
+	.endm
+
+#else
+	.macro GEN_BR_THUNK reg,ruse=%r1
+	.endm
+
+	.macro GEN_B_THUNK disp,reg,ruse=%r1
+	.endm
+
+	 .macro BR_EX reg,ruse=%r1
+	br	\reg
+	.endm
+
+	 .macro B_EX disp,reg,ruse=%r1
+	b	\disp(\reg)
+	.endm
+
+	.macro BASR_EX rsave,rtarget,ruse=%r1
+	basr	\rsave,\rtarget
+	.endm
+#endif
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_S390_NOSPEC_ASM_H */
diff --git a/arch/s390/include/asm/purgatory.h b/arch/s390/include/asm/purgatory.h
index e297bcf..6090670 100644
--- a/arch/s390/include/asm/purgatory.h
+++ b/arch/s390/include/asm/purgatory.h
@@ -13,5 +13,11 @@
 
 int verify_sha256_digest(void);
 
+extern u64 kernel_entry;
+extern u64 kernel_type;
+
+extern u64 crash_start;
+extern u64 crash_size;
+
 #endif	/* __ASSEMBLY__ */
 #endif /* _S390_PURGATORY_H_ */
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 84ea622..f92dd8e 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -65,6 +65,7 @@ obj-y	+= nospec-branch.o
 
 extra-y				+= head.o head64.o vmlinux.lds
 
+obj-$(CONFIG_SYSFS)		+= nospec-sysfs.o
 CFLAGS_REMOVE_nospec-branch.o	+= $(CC_FLAGS_EXPOLINE)
 
 obj-$(CONFIG_MODULES)		+= module.o
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index eb2a5c0..11aea74 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -181,6 +181,7 @@ int main(void)
 	OFFSET(__LC_MACHINE_FLAGS, lowcore, machine_flags);
 	OFFSET(__LC_PREEMPT_COUNT, lowcore, preempt_count);
 	OFFSET(__LC_GMAP, lowcore, gmap);
+	OFFSET(__LC_BR_R1, lowcore, br_r1_trampoline);
 	/* software defined ABI-relevant lowcore locations 0xe00 - 0xe20 */
 	OFFSET(__LC_DUMP_REIPL, lowcore, ipib);
 	/* hardware defined lowcore locations 0x1000 - 0x18ff */
diff --git a/arch/s390/kernel/base.S b/arch/s390/kernel/base.S
index f6c5600..b65874b 100644
--- a/arch/s390/kernel/base.S
+++ b/arch/s390/kernel/base.S
@@ -9,18 +9,22 @@
 
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-insn.h>
 #include <asm/ptrace.h>
 #include <asm/sigp.h>
 
+	GEN_BR_THUNK %r9
+	GEN_BR_THUNK %r14
+
 ENTRY(s390_base_mcck_handler)
 	basr	%r13,0
 0:	lg	%r15,__LC_PANIC_STACK	# load panic stack
 	aghi	%r15,-STACK_FRAME_OVERHEAD
 	larl	%r1,s390_base_mcck_handler_fn
-	lg	%r1,0(%r1)
-	ltgr	%r1,%r1
+	lg	%r9,0(%r1)
+	ltgr	%r9,%r9
 	jz	1f
-	basr	%r14,%r1
+	BASR_EX	%r14,%r9
 1:	la	%r1,4095
 	lmg	%r0,%r15,__LC_GPREGS_SAVE_AREA-4095(%r1)
 	lpswe	__LC_MCK_OLD_PSW
@@ -37,10 +41,10 @@ ENTRY(s390_base_ext_handler)
 	basr	%r13,0
 0:	aghi	%r15,-STACK_FRAME_OVERHEAD
 	larl	%r1,s390_base_ext_handler_fn
-	lg	%r1,0(%r1)
-	ltgr	%r1,%r1
+	lg	%r9,0(%r1)
+	ltgr	%r9,%r9
 	jz	1f
-	basr	%r14,%r1
+	BASR_EX	%r14,%r9
 1:	lmg	%r0,%r15,__LC_SAVE_AREA_ASYNC
 	ni	__LC_EXT_OLD_PSW+1,0xfd	# clear wait state bit
 	lpswe	__LC_EXT_OLD_PSW
@@ -57,10 +61,10 @@ ENTRY(s390_base_pgm_handler)
 	basr	%r13,0
 0:	aghi	%r15,-STACK_FRAME_OVERHEAD
 	larl	%r1,s390_base_pgm_handler_fn
-	lg	%r1,0(%r1)
-	ltgr	%r1,%r1
+	lg	%r9,0(%r1)
+	ltgr	%r9,%r9
 	jz	1f
-	basr	%r14,%r1
+	BASR_EX	%r14,%r9
 	lmg	%r0,%r15,__LC_SAVE_AREA_SYNC
 	lpswe	__LC_PGM_OLD_PSW
 1:	lpswe	disabled_wait_psw-0b(%r13)
@@ -117,7 +121,7 @@ ENTRY(diag308_reset)
 	larl	%r4,.Lcontinue_psw	# Restore PSW flags
 	lpswe	0(%r4)
 .Lcontinue:
-	br	%r14
+	BR_EX	%r14
 .align 16
 .Lrestart_psw:
 	.long	0x00080000,0x80000000 + .Lrestart_part2
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 3f22f13..f03402e 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -28,6 +28,7 @@
 #include <asm/setup.h>
 #include <asm/nmi.h>
 #include <asm/export.h>
+#include <asm/nospec-insn.h>
 
 __PT_R0      =	__PT_GPRS
 __PT_R1      =	__PT_GPRS + 8
@@ -183,67 +184,9 @@ _LPP_OFFSET	= __LC_LPP
 		    "jnz .+8; .long 0xb2e8d000", 82
 	.endm
 
-#ifdef CONFIG_EXPOLINE
-
-	.macro GEN_BR_THUNK name,reg,tmp
-	.section .text.\name,"axG",@progbits,\name,comdat
-	.globl \name
-	.hidden \name
-	.type \name,@function
-\name:
-	CFI_STARTPROC
-#ifdef CONFIG_HAVE_MARCH_Z10_FEATURES
-	exrl	0,0f
-#else
-	larl	\tmp,0f
-	ex	0,0(\tmp)
-#endif
-	j	.
-0:	br	\reg
-	CFI_ENDPROC
-	.endm
-
-	GEN_BR_THUNK __s390x_indirect_jump_r1use_r9,%r9,%r1
-	GEN_BR_THUNK __s390x_indirect_jump_r1use_r14,%r14,%r1
-	GEN_BR_THUNK __s390x_indirect_jump_r11use_r14,%r14,%r11
-
-	.macro BASR_R14_R9
-0:	brasl	%r14,__s390x_indirect_jump_r1use_r9
-	.pushsection .s390_indirect_branches,"a",@progbits
-	.long	0b-.
-	.popsection
-	.endm
-
-	.macro BR_R1USE_R14
-0:	jg	__s390x_indirect_jump_r1use_r14
-	.pushsection .s390_indirect_branches,"a",@progbits
-	.long	0b-.
-	.popsection
-	.endm
-
-	.macro BR_R11USE_R14
-0:	jg	__s390x_indirect_jump_r11use_r14
-	.pushsection .s390_indirect_branches,"a",@progbits
-	.long	0b-.
-	.popsection
-	.endm
-
-#else	/* CONFIG_EXPOLINE */
-
-	.macro BASR_R14_R9
-	basr	%r14,%r9
-	.endm
-
-	.macro BR_R1USE_R14
-	br	%r14
-	.endm
-
-	.macro BR_R11USE_R14
-	br	%r14
-	.endm
-
-#endif /* CONFIG_EXPOLINE */
-
+	GEN_BR_THUNK %r9
+	GEN_BR_THUNK %r14
+	GEN_BR_THUNK %r14,%r11
 
 	.section .kprobes.text, "ax"
 .Ldummy:
@@ -260,7 +203,7 @@ _LPP_OFFSET	= __LC_LPP
 ENTRY(__bpon)
 	.globl __bpon
 	BPON
-	BR_R1USE_R14
+	BR_EX	%r14
 
 /*
  * Scheduler resume function, called by switch_to
@@ -284,7 +227,7 @@ ENTRY(__switch_to)
 	mvc	__LC_CURRENT_PID(4,%r0),0(%r3)	# store pid of next
 	lmg	%r6,%r15,__SF_GPRS(%r15)	# load gprs of next task
 	ALTERNATIVE "", ".insn s,0xb2800000,_LPP_OFFSET", 40
-	BR_R1USE_R14
+	BR_EX	%r14
 
 .L__critical_start:
 
@@ -351,7 +294,7 @@ sie_exit:
 	xgr	%r5,%r5
 	lmg	%r6,%r14,__SF_GPRS(%r15)	# restore kernel registers
 	lg	%r2,__SF_SIE_REASON(%r15)	# return exit reason code
-	BR_R1USE_R14
+	BR_EX	%r14
 .Lsie_fault:
 	lghi	%r14,-EFAULT
 	stg	%r14,__SF_SIE_REASON(%r15)	# set exit reason code
@@ -410,7 +353,7 @@ ENTRY(system_call)
 	lgf	%r9,0(%r8,%r10)			# get system call add.
 	TSTMSK	__TI_flags(%r12),_TIF_TRACE
 	jnz	.Lsysc_tracesys
-	BASR_R14_R9				# call sys_xxxx
+	BASR_EX	%r14,%r9			# call sys_xxxx
 	stg	%r2,__PT_R2(%r11)		# store return value
 
 .Lsysc_return:
@@ -595,7 +538,7 @@ ENTRY(system_call)
 	lmg	%r3,%r7,__PT_R3(%r11)
 	stg	%r7,STACK_FRAME_OVERHEAD(%r15)
 	lg	%r2,__PT_ORIG_GPR2(%r11)
-	BASR_R14_R9			# call sys_xxx
+	BASR_EX	%r14,%r9		# call sys_xxx
 	stg	%r2,__PT_R2(%r11)	# store return value
 .Lsysc_tracenogo:
 	TSTMSK	__TI_flags(%r12),_TIF_TRACE
@@ -619,7 +562,7 @@ ENTRY(ret_from_fork)
 	lmg	%r9,%r10,__PT_R9(%r11)	# load gprs
 ENTRY(kernel_thread_starter)
 	la	%r2,0(%r10)
-	BASR_R14_R9
+	BASR_EX	%r14,%r9
 	j	.Lsysc_tracenogo
 
 /*
@@ -701,7 +644,7 @@ ENTRY(pgm_check_handler)
 	je	.Lpgm_return
 	lgf	%r9,0(%r10,%r1)		# load address of handler routine
 	lgr	%r2,%r11		# pass pointer to pt_regs
-	BASR_R14_R9			# branch to interrupt-handler
+	BASR_EX	%r14,%r9		# branch to interrupt-handler
 .Lpgm_return:
 	LOCKDEP_SYS_EXIT
 	tm	__PT_PSW+1(%r11),0x01	# returning to user ?
@@ -1019,7 +962,7 @@ ENTRY(psw_idle)
 	stpt	__TIMER_IDLE_ENTER(%r2)
 .Lpsw_idle_lpsw:
 	lpswe	__SF_EMPTY(%r15)
-	BR_R1USE_R14
+	BR_EX	%r14
 .Lpsw_idle_end:
 
 /*
@@ -1061,7 +1004,7 @@ ENTRY(save_fpu_regs)
 .Lsave_fpu_regs_done:
 	oi	__LC_CPU_FLAGS+7,_CIF_FPU
 .Lsave_fpu_regs_exit:
-	BR_R1USE_R14
+	BR_EX	%r14
 .Lsave_fpu_regs_end:
 EXPORT_SYMBOL(save_fpu_regs)
 
@@ -1107,7 +1050,7 @@ load_fpu_regs:
 .Lload_fpu_regs_done:
 	ni	__LC_CPU_FLAGS+7,255-_CIF_FPU
 .Lload_fpu_regs_exit:
-	BR_R1USE_R14
+	BR_EX	%r14
 .Lload_fpu_regs_end:
 
 .L__critical_end:
@@ -1322,7 +1265,7 @@ cleanup_critical:
 	jl	0f
 	clg	%r9,BASED(.Lcleanup_table+104)	# .Lload_fpu_regs_end
 	jl	.Lcleanup_load_fpu_regs
-0:	BR_R11USE_R14
+0:	BR_EX	%r14
 
 	.align	8
 .Lcleanup_table:
@@ -1358,7 +1301,7 @@ cleanup_critical:
 	ni	__SIE_PROG0C+3(%r9),0xfe	# no longer in SIE
 	lctlg	%c1,%c1,__LC_USER_ASCE		# load primary asce
 	larl	%r9,sie_exit			# skip forward to sie_exit
-	BR_R11USE_R14
+	BR_EX	%r14
 #endif
 
 .Lcleanup_system_call:
@@ -1412,7 +1355,7 @@ cleanup_critical:
 	stg	%r15,56(%r11)		# r15 stack pointer
 	# set new psw address and exit
 	larl	%r9,.Lsysc_do_svc
-	BR_R11USE_R14
+	BR_EX	%r14,%r11
 .Lcleanup_system_call_insn:
 	.quad	system_call
 	.quad	.Lsysc_stmg
@@ -1424,7 +1367,7 @@ cleanup_critical:
 
 .Lcleanup_sysc_tif:
 	larl	%r9,.Lsysc_tif
-	BR_R11USE_R14
+	BR_EX	%r14,%r11
 
 .Lcleanup_sysc_restore:
 	# check if stpt has been executed
@@ -1441,14 +1384,14 @@ cleanup_critical:
 	mvc	0(64,%r11),__PT_R8(%r9)
 	lmg	%r0,%r7,__PT_R0(%r9)
 1:	lmg	%r8,%r9,__LC_RETURN_PSW
-	BR_R11USE_R14
+	BR_EX	%r14,%r11
 .Lcleanup_sysc_restore_insn:
 	.quad	.Lsysc_exit_timer
 	.quad	.Lsysc_done - 4
 
 .Lcleanup_io_tif:
 	larl	%r9,.Lio_tif
-	BR_R11USE_R14
+	BR_EX	%r14,%r11
 
 .Lcleanup_io_restore:
 	# check if stpt has been executed
@@ -1462,7 +1405,7 @@ cleanup_critical:
 	mvc	0(64,%r11),__PT_R8(%r9)
 	lmg	%r0,%r7,__PT_R0(%r9)
 1:	lmg	%r8,%r9,__LC_RETURN_PSW
-	BR_R11USE_R14
+	BR_EX	%r14,%r11
 .Lcleanup_io_restore_insn:
 	.quad	.Lio_exit_timer
 	.quad	.Lio_done - 4
@@ -1515,17 +1458,17 @@ cleanup_critical:
 	# prepare return psw
 	nihh	%r8,0xfcfd		# clear irq & wait state bits
 	lg	%r9,48(%r11)		# return from psw_idle
-	BR_R11USE_R14
+	BR_EX	%r14,%r11
 .Lcleanup_idle_insn:
 	.quad	.Lpsw_idle_lpsw
 
 .Lcleanup_save_fpu_regs:
 	larl	%r9,save_fpu_regs
-	BR_R11USE_R14
+	BR_EX	%r14,%r11
 
 .Lcleanup_load_fpu_regs:
 	larl	%r9,load_fpu_regs
-	BR_R11USE_R14
+	BR_EX	%r14,%r11
 
 /*
  * Integer constants
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index 94f2099..3d17c41 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -176,10 +176,9 @@ void do_softirq_own_stack(void)
 		new -= STACK_FRAME_OVERHEAD;
 		((struct stack_frame *) new)->back_chain = old;
 		asm volatile("   la    15,0(%0)\n"
-			     "   basr  14,%2\n"
+			     "   brasl 14,__do_softirq\n"
 			     "   la    15,0(%1)\n"
-			     : : "a" (new), "a" (old),
-			         "a" (__do_softirq)
+			     : : "a" (new), "a" (old)
 			     : "0", "1", "2", "3", "4", "5", "14",
 			       "cc", "memory" );
 	} else {
diff --git a/arch/s390/kernel/mcount.S b/arch/s390/kernel/mcount.S
index 82df7d8..27110f3 100644
--- a/arch/s390/kernel/mcount.S
+++ b/arch/s390/kernel/mcount.S
@@ -9,13 +9,17 @@
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
 #include <asm/ftrace.h>
+#include <asm/nospec-insn.h>
 #include <asm/ptrace.h>
 #include <asm/export.h>
 
+	GEN_BR_THUNK %r1
+	GEN_BR_THUNK %r14
+
 	.section .kprobes.text, "ax"
 
 ENTRY(ftrace_stub)
-	br	%r14
+	BR_EX	%r14
 
 #define STACK_FRAME_SIZE  (STACK_FRAME_OVERHEAD + __PT_SIZE)
 #define STACK_PTREGS	  (STACK_FRAME_OVERHEAD)
@@ -23,7 +27,7 @@ ENTRY(ftrace_stub)
 #define STACK_PTREGS_PSW  (STACK_PTREGS + __PT_PSW)
 
 ENTRY(_mcount)
-	br	%r14
+	BR_EX	%r14
 
 EXPORT_SYMBOL(_mcount)
 
@@ -53,7 +57,7 @@ ENTRY(ftrace_caller)
 #endif
 	lgr	%r3,%r14
 	la	%r5,STACK_PTREGS(%r15)
-	basr	%r14,%r1
+	BASR_EX	%r14,%r1
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 # The j instruction gets runtime patched to a nop instruction.
 # See ftrace_enable_ftrace_graph_caller.
@@ -68,7 +72,7 @@ ftrace_graph_caller_end:
 #endif
 	lg	%r1,(STACK_PTREGS_PSW+8)(%r15)
 	lmg	%r2,%r15,(STACK_PTREGS_GPRS+2*8)(%r15)
-	br	%r1
+	BR_EX	%r1
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 
@@ -81,6 +85,6 @@ ENTRY(return_to_handler)
 	aghi	%r15,STACK_FRAME_OVERHEAD
 	lgr	%r14,%r2
 	lmg	%r2,%r5,32(%r15)
-	br	%r14
+	BR_EX	%r14
 
 #endif
diff --git a/arch/s390/kernel/nospec-branch.c b/arch/s390/kernel/nospec-branch.c
index 46d49a1..8ad6a71 100644
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/module.h>
 #include <linux/device.h>
-#include <linux/cpu.h>
 #include <asm/nospec-branch.h>
 
 static int __init nobp_setup_early(char *str)
@@ -44,24 +43,6 @@ static int __init nospec_report(void)
 }
 arch_initcall(nospec_report);
 
-#ifdef CONFIG_SYSFS
-ssize_t cpu_show_spectre_v1(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
-}
-
-ssize_t cpu_show_spectre_v2(struct device *dev,
-			    struct device_attribute *attr, char *buf)
-{
-	if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable)
-		return sprintf(buf, "Mitigation: execute trampolines\n");
-	if (__test_facility(82, S390_lowcore.alt_stfle_fac_list))
-		return sprintf(buf, "Mitigation: limited branch prediction.\n");
-	return sprintf(buf, "Vulnerable\n");
-}
-#endif
-
 #ifdef CONFIG_EXPOLINE
 
 int nospec_disable = IS_ENABLED(CONFIG_EXPOLINE_OFF);
@@ -112,7 +93,6 @@ static void __init_or_module __nospec_revert(s32 *start, s32 *end)
 	s32 *epo;
 
 	/* Second part of the instruction replace is always a nop */
-	memcpy(insnbuf + 2, (char[]) { 0x47, 0x00, 0x00, 0x00 }, 4);
 	for (epo = start; epo < end; epo++) {
 		instr = (u8 *) epo + *epo;
 		if (instr[0] == 0xc0 && (instr[1] & 0x0f) == 0x04)
@@ -133,18 +113,34 @@ static void __init_or_module __nospec_revert(s32 *start, s32 *end)
 			br = thunk + (*(int *)(thunk + 2)) * 2;
 		else
 			continue;
-		if (br[0] != 0x07 || (br[1] & 0xf0) != 0xf0)
+		/* Check for unconditional branch 0x07f? or 0x47f???? */
+		if ((br[0] & 0xbf) != 0x07 || (br[1] & 0xf0) != 0xf0)
 			continue;
+
+		memcpy(insnbuf + 2, (char[]) { 0x47, 0x00, 0x07, 0x00 }, 4);
 		switch (type) {
 		case BRCL_EXPOLINE:
-			/* brcl to thunk, replace with br + nop */
 			insnbuf[0] = br[0];
 			insnbuf[1] = (instr[1] & 0xf0) | (br[1] & 0x0f);
+			if (br[0] == 0x47) {
+				/* brcl to b, replace with bc + nopr */
+				insnbuf[2] = br[2];
+				insnbuf[3] = br[3];
+			} else {
+				/* brcl to br, replace with bcr + nop */
+			}
 			break;
 		case BRASL_EXPOLINE:
-			/* brasl to thunk, replace with basr + nop */
-			insnbuf[0] = 0x0d;
 			insnbuf[1] = (instr[1] & 0xf0) | (br[1] & 0x0f);
+			if (br[0] == 0x47) {
+				/* brasl to b, replace with bas + nopr */
+				insnbuf[0] = 0x4d;
+				insnbuf[2] = br[2];
+				insnbuf[3] = br[3];
+			} else {
+				/* brasl to br, replace with basr + nop */
+				insnbuf[0] = 0x0d;
+			}
 			break;
 		}
 
diff --git a/arch/s390/kernel/nospec-sysfs.c b/arch/s390/kernel/nospec-sysfs.c
new file mode 100644
index 0000000..8affad5
--- /dev/null
+++ b/arch/s390/kernel/nospec-sysfs.c
@@ -0,0 +1,21 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/device.h>
+#include <linux/cpu.h>
+#include <asm/facility.h>
+#include <asm/nospec-branch.h>
+
+ssize_t cpu_show_spectre_v1(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "Mitigation: __user pointer sanitization\n");
+}
+
+ssize_t cpu_show_spectre_v2(struct device *dev,
+			    struct device_attribute *attr, char *buf)
+{
+	if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable)
+		return sprintf(buf, "Mitigation: execute trampolines\n");
+	if (__test_facility(82, S390_lowcore.alt_stfle_fac_list))
+		return sprintf(buf, "Mitigation: limited branch prediction\n");
+	return sprintf(buf, "Vulnerable\n");
+}
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index 1c9ddd7..0292d68 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -753,6 +753,10 @@ static int __hw_perf_event_init(struct perf_event *event)
 	 */
 	rate = 0;
 	if (attr->freq) {
+		if (!attr->sample_freq) {
+			err = -EINVAL;
+			goto out;
+		}
 		rate = freq_to_sample_rate(&si, attr->sample_freq);
 		rate = hw_limit_rate(&si, rate);
 		attr->freq = 0;
diff --git a/arch/s390/kernel/reipl.S b/arch/s390/kernel/reipl.S
index 73cc375..7f14adf 100644
--- a/arch/s390/kernel/reipl.S
+++ b/arch/s390/kernel/reipl.S
@@ -7,8 +7,11 @@
 
 #include <linux/linkage.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-insn.h>
 #include <asm/sigp.h>
 
+	GEN_BR_THUNK %r9
+
 #
 # Issue "store status" for the current CPU to its prefix page
 # and call passed function afterwards
@@ -67,9 +70,9 @@ ENTRY(store_status)
 	st	%r4,0(%r1)
 	st	%r5,4(%r1)
 	stg	%r2,8(%r1)
-	lgr	%r1,%r2
+	lgr	%r9,%r2
 	lgr	%r2,%r3
-	br	%r1
+	BR_EX	%r9
 
 	.section .bss
 	.align	8
diff --git a/arch/s390/kernel/swsusp.S b/arch/s390/kernel/swsusp.S
index e991871..a049a7b 100644
--- a/arch/s390/kernel/swsusp.S
+++ b/arch/s390/kernel/swsusp.S
@@ -13,6 +13,7 @@
 #include <asm/ptrace.h>
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
+#include <asm/nospec-insn.h>
 #include <asm/sigp.h>
 
 /*
@@ -24,6 +25,8 @@
  * (see below) in the resume process.
  * This function runs with disabled interrupts.
  */
+	GEN_BR_THUNK %r14
+
 	.section .text
 ENTRY(swsusp_arch_suspend)
 	stmg	%r6,%r15,__SF_GPRS(%r15)
@@ -103,7 +106,7 @@ ENTRY(swsusp_arch_suspend)
 	spx	0x318(%r1)
 	lmg	%r6,%r15,STACK_FRAME_OVERHEAD + __SF_GPRS(%r15)
 	lghi	%r2,0
-	br	%r14
+	BR_EX	%r14
 
 /*
  * Restore saved memory image to correct place and restore register context.
@@ -197,11 +200,10 @@ pgm_check_entry:
 	larl	%r15,init_thread_union
 	ahi	%r15,1<<(PAGE_SHIFT+THREAD_SIZE_ORDER)
 	larl	%r2,.Lpanic_string
-	larl	%r3,sclp_early_printk
 	lghi	%r1,0
 	sam31
 	sigp	%r1,%r0,SIGP_SET_ARCHITECTURE
-	basr	%r14,%r3
+	brasl	%r14,sclp_early_printk
 	larl	%r3,.Ldisabled_wait_31
 	lpsw	0(%r3)
 4:
@@ -267,7 +269,7 @@ restore_registers:
 	/* Return 0 */
 	lmg	%r6,%r15,STACK_FRAME_OVERHEAD + __SF_GPRS(%r15)
 	lghi	%r2,0
-	br	%r14
+	BR_EX	%r14
 
 	.section .data..nosave,"aw",@progbits
 	.align	8
diff --git a/arch/s390/lib/mem.S b/arch/s390/lib/mem.S
index 495c9c4..2311f15 100644
--- a/arch/s390/lib/mem.S
+++ b/arch/s390/lib/mem.S
@@ -7,6 +7,9 @@
 
 #include <linux/linkage.h>
 #include <asm/export.h>
+#include <asm/nospec-insn.h>
+
+	GEN_BR_THUNK %r14
 
 /*
  * void *memmove(void *dest, const void *src, size_t n)
@@ -33,14 +36,14 @@ ENTRY(memmove)
 .Lmemmove_forward_remainder:
 	larl	%r5,.Lmemmove_mvc
 	ex	%r4,0(%r5)
-	br	%r14
+	BR_EX	%r14
 .Lmemmove_reverse:
 	ic	%r0,0(%r4,%r3)
 	stc	%r0,0(%r4,%r1)
 	brctg	%r4,.Lmemmove_reverse
 	ic	%r0,0(%r4,%r3)
 	stc	%r0,0(%r4,%r1)
-	br	%r14
+	BR_EX	%r14
 .Lmemmove_mvc:
 	mvc	0(1,%r1),0(%r3)
 EXPORT_SYMBOL(memmove)
@@ -77,7 +80,7 @@ ENTRY(memset)
 .Lmemset_clear_remainder:
 	larl	%r3,.Lmemset_xc
 	ex	%r4,0(%r3)
-	br	%r14
+	BR_EX	%r14
 .Lmemset_fill:
 	cghi	%r4,1
 	lgr	%r1,%r2
@@ -95,10 +98,10 @@ ENTRY(memset)
 	stc	%r3,0(%r1)
 	larl	%r5,.Lmemset_mvc
 	ex	%r4,0(%r5)
-	br	%r14
+	BR_EX	%r14
 .Lmemset_fill_exit:
 	stc	%r3,0(%r1)
-	br	%r14
+	BR_EX	%r14
 .Lmemset_xc:
 	xc	0(1,%r1),0(%r1)
 .Lmemset_mvc:
@@ -121,7 +124,7 @@ ENTRY(memcpy)
 .Lmemcpy_remainder:
 	larl	%r5,.Lmemcpy_mvc
 	ex	%r4,0(%r5)
-	br	%r14
+	BR_EX	%r14
 .Lmemcpy_loop:
 	mvc	0(256,%r1),0(%r3)
 	la	%r1,256(%r1)
@@ -159,10 +162,10 @@ ENTRY(__memset\bits)
 	\insn	%r3,0(%r1)
 	larl	%r5,.L__memset_mvc\bits
 	ex	%r4,0(%r5)
-	br	%r14
+	BR_EX	%r14
 .L__memset_exit\bits:
 	\insn	%r3,0(%r2)
-	br	%r14
+	BR_EX	%r14
 .L__memset_mvc\bits:
 	mvc	\bytes(1,%r1),0(%r1)
 .endm
diff --git a/arch/s390/net/bpf_jit.S b/arch/s390/net/bpf_jit.S
index 25bb464..9f79486 100644
--- a/arch/s390/net/bpf_jit.S
+++ b/arch/s390/net/bpf_jit.S
@@ -9,6 +9,7 @@
  */
 
 #include <linux/linkage.h>
+#include <asm/nospec-insn.h>
 #include "bpf_jit.h"
 
 /*
@@ -54,7 +55,7 @@ ENTRY(sk_load_##NAME##_pos);						\
 	clg	%r3,STK_OFF_HLEN(%r15);	/* Offset + SIZE > hlen? */	\
 	jh	sk_load_##NAME##_slow;					\
 	LOAD	%r14,-SIZE(%r3,%r12);	/* Get data from skb */		\
-	b	OFF_OK(%r6);		/* Return */			\
+	B_EX	OFF_OK,%r6;		/* Return */			\
 									\
 sk_load_##NAME##_slow:;							\
 	lgr	%r2,%r7;		/* Arg1 = skb pointer */	\
@@ -64,11 +65,14 @@ sk_load_##NAME##_slow:;							\
 	brasl	%r14,skb_copy_bits;	/* Get data from skb */		\
 	LOAD	%r14,STK_OFF_TMP(%r15);	/* Load from temp bufffer */	\
 	ltgr	%r2,%r2;		/* Set cc to (%r2 != 0) */	\
-	br	%r6;			/* Return */
+	BR_EX	%r6;			/* Return */
 
 sk_load_common(word, 4, llgf)	/* r14 = *(u32 *) (skb->data+offset) */
 sk_load_common(half, 2, llgh)	/* r14 = *(u16 *) (skb->data+offset) */
 
+	GEN_BR_THUNK %r6
+	GEN_B_THUNK OFF_OK,%r6
+
 /*
  * Load 1 byte from SKB (optimized version)
  */
@@ -80,7 +84,7 @@ ENTRY(sk_load_byte_pos)
 	clg	%r3,STK_OFF_HLEN(%r15)	# Offset >= hlen?
 	jnl	sk_load_byte_slow
 	llgc	%r14,0(%r3,%r12)	# Get byte from skb
-	b	OFF_OK(%r6)		# Return OK
+	B_EX	OFF_OK,%r6		# Return OK
 
 sk_load_byte_slow:
 	lgr	%r2,%r7			# Arg1 = skb pointer
@@ -90,7 +94,7 @@ sk_load_byte_slow:
 	brasl	%r14,skb_copy_bits	# Get data from skb
 	llgc	%r14,STK_OFF_TMP(%r15)	# Load result from temp buffer
 	ltgr	%r2,%r2			# Set cc to (%r2 != 0)
-	br	%r6			# Return cc
+	BR_EX	%r6			# Return cc
 
 #define sk_negative_common(NAME, SIZE, LOAD)				\
 sk_load_##NAME##_slow_neg:;						\
@@ -104,7 +108,7 @@ sk_load_##NAME##_slow_neg:;						\
 	jz	bpf_error;						\
 	LOAD	%r14,0(%r2);		/* Get data from pointer */	\
 	xr	%r3,%r3;		/* Set cc to zero */		\
-	br	%r6;			/* Return cc */
+	BR_EX	%r6;			/* Return cc */
 
 sk_negative_common(word, 4, llgf)
 sk_negative_common(half, 2, llgh)
@@ -113,4 +117,4 @@ sk_negative_common(byte, 1, llgc)
 bpf_error:
 # force a return 0 from jit handler
 	ltgr	%r15,%r15	# Set condition code
-	br	%r6
+	BR_EX	%r6
diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 78a19c9..dd2bcf0 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -25,6 +25,8 @@
 #include <linux/bpf.h>
 #include <asm/cacheflush.h>
 #include <asm/dis.h>
+#include <asm/facility.h>
+#include <asm/nospec-branch.h>
 #include <asm/set_memory.h>
 #include "bpf_jit.h"
 
@@ -41,6 +43,8 @@ struct bpf_jit {
 	int base_ip;		/* Base address for literal pool */
 	int ret0_ip;		/* Address of return 0 */
 	int exit_ip;		/* Address of exit */
+	int r1_thunk_ip;	/* Address of expoline thunk for 'br %r1' */
+	int r14_thunk_ip;	/* Address of expoline thunk for 'br %r14' */
 	int tail_call_start;	/* Tail call start offset */
 	int labels[1];		/* Labels for local jumps */
 };
@@ -250,6 +254,19 @@ static inline void reg_set_seen(struct bpf_jit *jit, u32 b1)
 	REG_SET_SEEN(b2);					\
 })
 
+#define EMIT6_PCREL_RILB(op, b, target)				\
+({								\
+	int rel = (target - jit->prg) / 2;			\
+	_EMIT6(op | reg_high(b) << 16 | rel >> 16, rel & 0xffff);	\
+	REG_SET_SEEN(b);					\
+})
+
+#define EMIT6_PCREL_RIL(op, target)				\
+({								\
+	int rel = (target - jit->prg) / 2;			\
+	_EMIT6(op | rel >> 16, rel & 0xffff);			\
+})
+
 #define _EMIT6_IMM(op, imm)					\
 ({								\
 	unsigned int __imm = (imm);				\
@@ -469,8 +486,45 @@ static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
 	EMIT4(0xb9040000, REG_2, BPF_REG_0);
 	/* Restore registers */
 	save_restore_regs(jit, REGS_RESTORE, stack_depth);
+	if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable) {
+		jit->r14_thunk_ip = jit->prg;
+		/* Generate __s390_indirect_jump_r14 thunk */
+		if (test_facility(35)) {
+			/* exrl %r0,.+10 */
+			EMIT6_PCREL_RIL(0xc6000000, jit->prg + 10);
+		} else {
+			/* larl %r1,.+14 */
+			EMIT6_PCREL_RILB(0xc0000000, REG_1, jit->prg + 14);
+			/* ex 0,0(%r1) */
+			EMIT4_DISP(0x44000000, REG_0, REG_1, 0);
+		}
+		/* j . */
+		EMIT4_PCREL(0xa7f40000, 0);
+	}
 	/* br %r14 */
 	_EMIT2(0x07fe);
+
+	if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable &&
+	    (jit->seen & SEEN_FUNC)) {
+		jit->r1_thunk_ip = jit->prg;
+		/* Generate __s390_indirect_jump_r1 thunk */
+		if (test_facility(35)) {
+			/* exrl %r0,.+10 */
+			EMIT6_PCREL_RIL(0xc6000000, jit->prg + 10);
+			/* j . */
+			EMIT4_PCREL(0xa7f40000, 0);
+			/* br %r1 */
+			_EMIT2(0x07f1);
+		} else {
+			/* larl %r1,.+14 */
+			EMIT6_PCREL_RILB(0xc0000000, REG_1, jit->prg + 14);
+			/* ex 0,S390_lowcore.br_r1_tampoline */
+			EMIT4_DISP(0x44000000, REG_0, REG_0,
+				   offsetof(struct lowcore, br_r1_trampoline));
+			/* j . */
+			EMIT4_PCREL(0xa7f40000, 0);
+		}
+	}
 }
 
 /*
@@ -966,8 +1020,13 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
 		/* lg %w1,<d(imm)>(%l) */
 		EMIT6_DISP_LH(0xe3000000, 0x0004, REG_W1, REG_0, REG_L,
 			      EMIT_CONST_U64(func));
-		/* basr %r14,%w1 */
-		EMIT2(0x0d00, REG_14, REG_W1);
+		if (IS_ENABLED(CC_USING_EXPOLINE) && !nospec_disable) {
+			/* brasl %r14,__s390_indirect_jump_r1 */
+			EMIT6_PCREL_RILB(0xc0050000, REG_14, jit->r1_thunk_ip);
+		} else {
+			/* basr %r14,%w1 */
+			EMIT2(0x0d00, REG_14, REG_W1);
+		}
 		/* lgr %b0,%r2: load return value into %b0 */
 		EMIT4(0xb9040000, BPF_REG_0, REG_2);
 		if ((jit->seen & SEEN_SKB) &&
diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
index 439991d..4c14ce4 100644
--- a/drivers/s390/cio/qdio_setup.c
+++ b/drivers/s390/cio/qdio_setup.c
@@ -141,7 +141,7 @@ static int __qdio_allocate_qs(struct qdio_q **irq_ptr_qs, int nr_queues)
 	int i;
 
 	for (i = 0; i < nr_queues; i++) {
-		q = kmem_cache_alloc(qdio_q_cache, GFP_KERNEL);
+		q = kmem_cache_zalloc(qdio_q_cache, GFP_KERNEL);
 		if (!q)
 			return -ENOMEM;
 
@@ -456,7 +456,6 @@ int qdio_setup_irq(struct qdio_initialize *init_data)
 {
 	struct ciw *ciw;
 	struct qdio_irq *irq_ptr = init_data->cdev->private->qdio_data;
-	int rc;
 
 	memset(&irq_ptr->qib, 0, sizeof(irq_ptr->qib));
 	memset(&irq_ptr->siga_flag, 0, sizeof(irq_ptr->siga_flag));
@@ -493,16 +492,14 @@ int qdio_setup_irq(struct qdio_initialize *init_data)
 	ciw = ccw_device_get_ciw(init_data->cdev, CIW_TYPE_EQUEUE);
 	if (!ciw) {
 		DBF_ERROR("%4x NO EQ", irq_ptr->schid.sch_no);
-		rc = -EINVAL;
-		goto out_err;
+		return -EINVAL;
 	}
 	irq_ptr->equeue = *ciw;
 
 	ciw = ccw_device_get_ciw(init_data->cdev, CIW_TYPE_AQUEUE);
 	if (!ciw) {
 		DBF_ERROR("%4x NO AQ", irq_ptr->schid.sch_no);
-		rc = -EINVAL;
-		goto out_err;
+		return -EINVAL;
 	}
 	irq_ptr->aqueue = *ciw;
 
@@ -512,9 +509,6 @@ int qdio_setup_irq(struct qdio_initialize *init_data)
 	init_data->cdev->handler = qdio_int_handler;
 	spin_unlock_irq(get_ccwdev_lock(irq_ptr->cdev));
 	return 0;
-out_err:
-	qdio_release_memory(irq_ptr);
-	return rc;
 }
 
 void qdio_print_subchannel_info(struct qdio_irq *irq_ptr,
diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 2c75507..dce92b2 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -715,6 +715,10 @@ void cp_free(struct channel_program *cp)
  * and stores the result to ccwchain list. @cp must have been
  * initialized by a previous call with cp_init(). Otherwise, undefined
  * behavior occurs.
+ * For each chain composing the channel program:
+ * - On entry ch_len holds the count of CCWs to be translated.
+ * - On exit ch_len is adjusted to the count of successfully translated CCWs.
+ * This allows cp_free to find in ch_len the count of CCWs to free in a chain.
  *
  * The S/390 CCW Translation APIS (prefixed by 'cp_') are introduced
  * as helpers to do ccw chain translation inside the kernel. Basically
@@ -749,11 +753,18 @@ int cp_prefetch(struct channel_program *cp)
 		for (idx = 0; idx < len; idx++) {
 			ret = ccwchain_fetch_one(chain, idx, cp);
 			if (ret)
-				return ret;
+				goto out_err;
 		}
 	}
 
 	return 0;
+out_err:
+	/* Only cleanup the chain elements that were actually translated. */
+	chain->ch_len = idx;
+	list_for_each_entry_continue(chain, &cp->ccwchain_list, next) {
+		chain->ch_len = 0;
+	}
+	return ret;
 }
 
 /**
