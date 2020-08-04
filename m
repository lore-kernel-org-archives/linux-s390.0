Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22050 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729516AbgHDPBo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Aug 2020 11:01:44 -0400
From: Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3 1/3] vdso: allow to add architecture-specific vdso data
Date: Tue,  4 Aug 2020 17:01:22 +0200
Message-Id: <20200804150124.41692-2-svens@linux.ibm.com>
In-Reply-To: <20200804150124.41692-1-svens@linux.ibm.com>
References: <20200804150124.41692-1-svens@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>

Add the possibility to add architecture specific vDSO
data to struct vdso_data. This is useful if the arch specific
user space VDSO code needs additional data during execution.
If CONFIG_ARCH_HAS_VDSO_DATA is defined, the generic code will
include asm/vdso/data.h which should contain 'struct arch_vdso_data'.
This structure will be embedded in the generic vDSO data.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 arch/Kconfig            | 3 +++
 include/vdso/datapage.h | 9 +++++++++
 2 files changed, 12 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 8cc35dc556c7..e1017ce979e2 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -979,6 +979,9 @@ config HAVE_SPARSE_SYSCALL_NR
 	  entries at 4000, 5000 and 6000 locations. This option turns on syscall
 	  related optimizations for a given architecture.
 
+config ARCH_HAS_VDSO_DATA
+	bool
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 7955c56d6b3c..a11e89e2f547 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,6 +19,12 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
 
+#ifdef CONFIG_ARCH_HAS_VDSO_DATA
+#include <asm/vdso/data.h>
+#else
+struct arch_vdso_data {};
+#endif
+
 #define VDSO_BASES	(CLOCK_TAI + 1)
 #define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
 			 BIT(CLOCK_MONOTONIC)		| \
@@ -64,6 +70,7 @@ struct vdso_timestamp {
  * @tz_dsttime:		type of DST correction
  * @hrtimer_res:	hrtimer resolution
  * @__unused:		unused
+ * @arch_data:		architecture specific data
  *
  * vdso_data will be accessed by 64 bit and compat code at the same time
  * so we should be careful before modifying this structure.
@@ -97,6 +104,8 @@ struct vdso_data {
 	s32			tz_dsttime;
 	u32			hrtimer_res;
 	u32			__unused;
+
+	struct arch_vdso_data	arch_data;
 };
 
 /*
-- 
2.17.1
