Return-Path: <linux-kernel-owner+w=401wt.eu-S1764329AbYD2OTU@vger.kernel.org>
Message-Id: <20080429140251.242590024@de.ibm.com>
References: <20080429140117.631962807@de.ibm.com>
Date: Tue, 29 Apr 2008 16:01:28 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 11/15] Move stfl to system.h and delete duplicated version.
Content-Disposition: inline; filename=011-stfl.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/setup.c  |    9 ---------
 arch/s390/kvm/priv.c      |   11 +----------
 include/asm-s390/system.h |   10 ++++++++++
 3 files changed, 11 insertions(+), 19 deletions(-)

Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -683,15 +683,6 @@ setup_memory(void)
 #endif
 }
 
-static __init unsigned int stfl(void)
-{
-	asm volatile(
-		"	.insn	s,0xb2b10000,0(0)\n" /* stfl */
-		"0:\n"
-		EX_TABLE(0b,0b));
-	return S390_lowcore.stfl_fac_list;
-}
-
 static int __init __stfle(unsigned long long *list, int doublewords)
 {
 	typedef struct { unsigned long long _[doublewords]; } addrtype;
Index: quilt-2.6/arch/s390/kvm/priv.c
===================================================================
--- quilt-2.6.orig/arch/s390/kvm/priv.c
+++ quilt-2.6/arch/s390/kvm/priv.c
@@ -151,18 +151,9 @@ static int handle_chsc(struct kvm_vcpu *
 	return 0;
 }
 
-static unsigned int kvm_stfl(void)
-{
-	asm volatile(
-		"	.insn	s,0xb2b10000,0(0)\n" /* stfl */
-		"0:\n"
-		EX_TABLE(0b, 0b));
-	return S390_lowcore.stfl_fac_list;
-}
-
 static int handle_stfl(struct kvm_vcpu *vcpu)
 {
-	unsigned int facility_list = kvm_stfl();
+	unsigned int facility_list = stfl();
 	int rc;
 
 	vcpu->stat.instruction_stfl++;
Index: quilt-2.6/include/asm-s390/system.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/system.h
+++ quilt-2.6/include/asm-s390/system.h
@@ -16,6 +16,7 @@
 #include <asm/ptrace.h>
 #include <asm/setup.h>
 #include <asm/processor.h>
+#include <asm/lowcore.h>
 
 #ifdef __KERNEL__
 
@@ -422,6 +423,15 @@ extern void smp_ctl_clear_bit(int cr, in
 
 #endif /* CONFIG_SMP */
 
+static inline unsigned int stfl(void)
+{
+	asm volatile(
+		"	.insn	s,0xb2b10000,0(0)\n" /* stfl */
+		"0:\n"
+		EX_TABLE(0b,0b));
+	return S390_lowcore.stfl_fac_list;
+}
+
 extern void (*_machine_restart)(char *command);
 extern void (*_machine_halt)(void);
 extern void (*_machine_power_off)(void);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
