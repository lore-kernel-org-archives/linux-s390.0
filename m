Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10008 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727997AbgHDJgg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Aug 2020 05:36:36 -0400
From: Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH 2/3] timekeeping/vsyscall: Provide vdso_update_begin/end()
Date: Tue,  4 Aug 2020 11:36:06 +0200
Message-Id: <20200804093607.69841-3-svens@linux.ibm.com>
In-Reply-To: <20200804093607.69841-1-svens@linux.ibm.com>
References: <20200804093607.69841-1-svens@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, hca@linux.ibm.com, Sven Schnelle <svens@linux.ibm.com>

From: Thomas Gleixner <tglx@linutronix.de>

Architectures can have the requirement to add additional architecture
specific data to the VDSO data page which needs to be updated independent
of the timekeeper updates.

To protect these updates vs. concurrent readers and a conflicting update
through timekeeping, provide helper functions to make such updates safe.

vdso_update_begin() takes the timekeeper_lock to protect against a
potential update from timekeeper code and increments the VDSO sequence
count to signal data inconsistency to concurrent readers. vdso_update_end()
makes the sequence count even again to signal data consistency and drops
the timekeeper lock.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 include/vdso/vsyscall.h            |  3 +++
 kernel/time/timekeeping.c          |  2 +-
 kernel/time/timekeeping_internal.h | 11 +++++++---
 kernel/time/vsyscall.c             | 32 ++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/include/vdso/vsyscall.h b/include/vdso/vsyscall.h
index 2c6134e0c23d..b0fdc9c6bf43 100644
--- a/include/vdso/vsyscall.h
+++ b/include/vdso/vsyscall.h
@@ -6,6 +6,9 @@
 
 #include <asm/vdso/vsyscall.h>
 
+unsigned long vdso_update_begin(void);
+void vdso_update_end(unsigned long flags);
+
 #endif /* !__ASSEMBLY__ */
 
 #endif /* __VDSO_VSYSCALL_H */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index d20d489841c8..8459aa87986f 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -50,7 +50,7 @@ static struct {
 	.seq = SEQCNT_ZERO(tk_core.seq),
 };
 
-static DEFINE_RAW_SPINLOCK(timekeeper_lock);
+DEFINE_RAW_SPINLOCK(timekeeper_lock);
 static struct timekeeper shadow_timekeeper;
 
 /**
diff --git a/kernel/time/timekeeping_internal.h b/kernel/time/timekeeping_internal.h
index bcbb52db2256..4ca2787d1642 100644
--- a/kernel/time/timekeeping_internal.h
+++ b/kernel/time/timekeeping_internal.h
@@ -1,12 +1,14 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _TIMEKEEPING_INTERNAL_H
 #define _TIMEKEEPING_INTERNAL_H
-/*
- * timekeeping debug functions
- */
+
 #include <linux/clocksource.h>
+#include <linux/spinlock.h>
 #include <linux/time.h>
 
+/*
+ * timekeeping debug functions
+ */
 #ifdef CONFIG_DEBUG_FS
 extern void tk_debug_account_sleep_time(const struct timespec64 *t);
 #else
@@ -31,4 +33,7 @@ static inline u64 clocksource_delta(u64 now, u64 last, u64 mask)
 }
 #endif
 
+/* Semi public for serialization of non timekeeper VDSO updates. */
+extern raw_spinlock_t timekeeper_lock;
+
 #endif /* _TIMEKEEPING_INTERNAL_H */
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 54ce6eb2ca36..e8806eda6874 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -13,6 +13,8 @@
 #include <vdso/helpers.h>
 #include <vdso/vsyscall.h>
 
+#include "timekeeping_internal.h"
+
 static inline void update_vdso_data(struct vdso_data *vdata,
 				    struct timekeeper *tk)
 {
@@ -127,3 +129,33 @@ void update_vsyscall_tz(void)
 
 	__arch_sync_vdso_data(vdata);
 }
+
+/**
+ * vdso_update_begin - Start of a VDSO update section
+ *
+ * Allows architecture code to safely update the architecture specific VDSO
+ * data.
+ */
+unsigned long vdso_update_begin(void)
+{
+	struct vdso_data *vdata = __arch_get_k_vdso_data();
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&timekeeper_lock, flags);
+	vdso_write_begin(vdata);
+	return flags;
+}
+
+/**
+ * vdso_update_end - End of a VDSO update section
+ *
+ * Pairs with vdso_update_begin().
+ */
+void vdso_update_end(unsigned long flags)
+{
+	struct vdso_data *vdata = __arch_get_k_vdso_data();
+
+	vdso_write_end(vdata);
+	__arch_sync_vdso_data(vdata);
+	raw_spin_unlock_irqrestore(&timekeeper_lock, flags);
+}
-- 
2.17.1
