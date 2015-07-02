Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 2 Jul 2015 15:52:03 +0000
From: Joseph Myers <joseph@codesourcery.com>
Subject: [PATCH 5/8] s390/math-emu: Move s390 from math-emu-old to math-emu
Message-ID: <alpine.DEB.2.10.1507021550520.29415@digraph.polyomino.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, mpe@ellerman.id.au, stli@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Joseph Myers <joseph@codesourcery.com>

This patch moves s390 from math-emu-old to math-emu, updating it for
the API changes.  Thanks to Stefan Liebler <stli@linux.vnet.ibm.com>
in <https://sourceware.org/ml/libc-alpha/2015-04/msg00154.html> for
the sysinfo.c changes.

Signed-off-by: Joseph Myers <joseph@codesourcery.com>

---

diff --git a/arch/s390/include/asm/sfp-machine.h b/arch/s390/include/asm/sfp-machine.h
index 4e16aed..67f9eed 100644
--- a/arch/s390/include/asm/sfp-machine.h
+++ b/arch/s390/include/asm/sfp-machine.h
@@ -38,6 +38,13 @@
 #define _FP_MUL_MEAT_Q(R,X,Y)					\
   _FP_MUL_MEAT_4_wide(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
 
+#define _FP_MUL_MEAT_DW_S(R,X,Y)				\
+  _FP_MUL_MEAT_DW_1_wide(_FP_WFRACBITS_S,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_DW_D(R,X,Y)				\
+  _FP_MUL_MEAT_DW_2_wide(_FP_WFRACBITS_D,R,X,Y,umul_ppmm)
+#define _FP_MUL_MEAT_DW_Q(R,X,Y)				\
+  _FP_MUL_MEAT_DW_4_wide(_FP_WFRACBITS_Q,R,X,Y,umul_ppmm)
+
 #define _FP_DIV_MEAT_S(R,X,Y)	_FP_DIV_MEAT_1_udiv(S,R,X,Y)
 #define _FP_DIV_MEAT_D(R,X,Y)	_FP_DIV_MEAT_2_udiv(D,R,X,Y)
 #define _FP_DIV_MEAT_Q(R,X,Y)	_FP_DIV_MEAT_4_udiv(Q,R,X,Y)
@@ -50,6 +57,7 @@
 #define _FP_NANSIGN_Q		0
 
 #define _FP_KEEPNANFRACP 1
+#define _FP_QNANNEGATEDP 0
 
 /*
  * If one NaN is signaling and the other is not,
@@ -139,4 +147,6 @@
 /* We write the results always */
 #define FP_INHIBIT_RESULTS 0
 
+#define _FP_TININESS_AFTER_ROUNDING 0
+
 #endif
diff --git a/arch/s390/kernel/sysinfo.c b/arch/s390/kernel/sysinfo.c
index c7d8df7..f963474 100644
--- a/arch/s390/kernel/sysinfo.c
+++ b/arch/s390/kernel/sysinfo.c
@@ -19,8 +19,8 @@
 
 /* Sigh, math-emu. Don't ask. */
 #include <asm/sfp-util.h>
-#include <math-emu-old/soft-fp.h>
-#include <math-emu-old/single.h>
+#include <math-emu/soft-fp.h>
+#include <math-emu/single.h>
 
 int topology_max_mnest;
 
@@ -418,6 +418,7 @@ void s390_adjust_jiffies(void)
 	FP_DECL_S(SA); FP_DECL_S(SB); FP_DECL_S(SR);
 	FP_DECL_EX;
 	unsigned int capability;
+	int mode = 0;
 
 	info = (void *) get_zeroed_page(GFP_KERNEL);
 	if (!info)
@@ -436,11 +437,15 @@ void s390_adjust_jiffies(void)
 		 * point division .. math-emu here we come :-)
 		 */
 		FP_UNPACK_SP(SA, &fmil);
-		if ((info->capability >> 23) == 0)
-			FP_FROM_INT_S(SB, (long) info->capability, 64, long);
+		if ((info->capability >> 23) == 0) {
+			long r = info->capability;
+			FP_FROM_INT_S(SB, r, 64, unsigned long);
+		}
 		else
-			FP_UNPACK_SP(SB, &info->capability);
+			FP_UNPACK_RAW_SP(SB, &info->capability);
+		_FP_UNPACK_CANONICAL(S, 1, SB);
 		FP_DIV_S(SR, SA, SB);
+		_FP_PACK_CANONICAL(S, 1, SR);
 		FP_TO_INT_S(capability, SR, 32, 0);
 	} else
 		/*


-- 
Joseph S. Myers
joseph@codesourcery.com
