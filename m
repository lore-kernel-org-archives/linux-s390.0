Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56258 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727919AbgHDJgg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Aug 2020 05:36:36 -0400
From: Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 1/3] vdso: allow to add architecture-specific vdso data
Date: Tue,  4 Aug 2020 11:36:05 +0200
Message-Id: <20200804093607.69841-2-svens@linux.ibm.com>
In-Reply-To: <20200804093607.69841-1-svens@linux.ibm.com>
References: <20200804093607.69841-1-svens@linux.ibm.com>
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
 include/vdso/datapage.h | 7 +++++++
 2 files changed, 10 insertions(+)

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
index 7955c56d6b3c..74e730238ce6 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -19,6 +19,10 @@
 #include <vdso/time32.h>
 #include <vdso/time64.h>
 
+#ifdef CONFIG_ARCH_HAS_VDSO_DATA
+#include <asm/vdso/data.h>
+#endif
+
 #define VDSO_BASES	(CLOCK_TAI + 1)
 #define VDSO_HRES	(BIT(CLOCK_REALTIME)		| \
 			 BIT(CLOCK_MONOTONIC)		| \
@@ -97,6 +101,9 @@ struct vdso_data {
 	s32			tz_dsttime;
 	u32			hrtimer_res;
 	u32			__unused;
+#ifdef CONFIG_ARCH_HAS_VDSO_DATA
+	struct arch_vdso_data arch;
+#endif
 };
 
 /*
-- 
2.17.1
