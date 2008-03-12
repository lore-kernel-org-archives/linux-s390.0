Return-Path: <linux-kernel-owner+w=401wt.eu-S1753878AbYCLRdE@vger.kernel.org>
Message-Id: <20080312173216.646695409@de.ibm.com>
References: <20080312173155.703966894@de.ibm.com>
Date: Wed, 12 Mar 2008 18:31:57 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/10] Export stfle.
Content-Disposition: inline; filename=102-stfle-global.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Make stfle visible so other code can call this.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/setup.c  |   11 +++++++++--
 include/asm-s390/system.h |    2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

Index: quilt-2.6/arch/s390/kernel/setup.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/setup.c
+++ quilt-2.6/arch/s390/kernel/setup.c
@@ -687,7 +687,7 @@ static __init unsigned int stfl(void)
 	return S390_lowcore.stfl_fac_list;
 }
 
-static __init int stfle(unsigned long long *list, int doublewords)
+static int __init __stfle(unsigned long long *list, int doublewords)
 {
 	typedef struct { unsigned long long _[doublewords]; } addrtype;
 	register unsigned long __nr asm("0") = doublewords - 1;
@@ -697,6 +697,13 @@ static __init int stfle(unsigned long lo
 	return __nr + 1;
 }
 
+int __init stfle(unsigned long long *list, int doublewords)
+{
+	if (!(stfl() & (1UL << 24)))
+		return -EOPNOTSUPP;
+	return __stfle(list, doublewords);
+}
+
 /*
  * Setup hardware capabilities.
  */
@@ -741,7 +748,7 @@ static void __init setup_hwcaps(void)
 	 *   HWCAP_S390_DFP bit 6.
 	 */
 	if ((elf_hwcap & (1UL << 2)) &&
-	    stfle(&facility_list_extended, 1) > 0) {
+	    __stfle(&facility_list_extended, 1) > 0) {
 		if (facility_list_extended & (1ULL << (64 - 43)))
 			elf_hwcap |= 1UL << 6;
 	}
Index: quilt-2.6/include/asm-s390/system.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/system.h
+++ quilt-2.6/include/asm-s390/system.h
@@ -406,6 +406,8 @@ __set_psw_mask(unsigned long mask)
 #define local_mcck_enable()  __set_psw_mask(psw_kernel_bits)
 #define local_mcck_disable() __set_psw_mask(psw_kernel_bits & ~PSW_MASK_MCHECK)
 
+int stfle(unsigned long long *list, int doublewords);
+
 #ifdef CONFIG_SMP
 
 extern void smp_ctl_set_bit(int cr, int bit);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
