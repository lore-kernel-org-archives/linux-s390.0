Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084450.200868700@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:45 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 15/32] [PATCH] spinlock: check virtual cpu running status
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=114-spinlock-sigp-sense-running.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Gerald Schaefer <gerald.schaefer@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

This patch introduces a new function that checks the running status
of a cpu in a hypervisor. This status is not virtualized, so the check
is only correct if running in an LPAR. On acquiring a spinlock, if the
cpu holding the lock is scheduled by the hypervisor, we do a busy wait
on the lock. If it is not scheduled, we yield over to that cpu.

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/sigp.h |   40 ++++++++++++++----------------
 arch/s390/include/asm/smp.h  |   24 ++++++++++++++++++
 arch/s390/lib/spinlock.c     |   57 +++++++++++++++++++++++++++++--------------
 3 files changed, 82 insertions(+), 39 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/sigp.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/sigp.h	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/sigp.h	2010-02-24 09:44:25.000000000 +0100
@@ -31,32 +31,31 @@
 
 typedef enum
 {
-	sigp_unassigned=0x0,
-	sigp_sense,
-	sigp_external_call,
-	sigp_emergency_signal,
-	sigp_start,
-	sigp_stop,
-	sigp_restart,
-	sigp_unassigned1,
-	sigp_unassigned2,
-	sigp_stop_and_store_status,
-	sigp_unassigned3,
-	sigp_initial_cpu_reset,
-	sigp_cpu_reset,
-	sigp_set_prefix,
-	sigp_store_status_at_address,
-	sigp_store_extended_status_at_address
+	sigp_sense = 1,
+	sigp_external_call = 2,
+	sigp_emergency_signal = 3,
+	sigp_start = 4,
+	sigp_stop = 5,
+	sigp_restart = 6,
+	sigp_stop_and_store_status = 9,
+	sigp_initial_cpu_reset = 11,
+	sigp_cpu_reset = 12,
+	sigp_set_prefix = 13,
+	sigp_store_status_at_address = 14,
+	sigp_store_extended_status_at_address = 15,
+	sigp_set_architecture = 18,
+	sigp_conditional_emergency_signal = 19,
+	sigp_sense_running = 21,
 } sigp_order_code;
 
 typedef __u32 sigp_status_word;
 
 typedef enum
 {
-        sigp_order_code_accepted=0,
-	sigp_status_stored,
-	sigp_busy,
-	sigp_not_operational
+	sigp_order_code_accepted = 0,
+	sigp_status_stored = 1,
+	sigp_busy = 2,
+	sigp_not_operational = 3,
 } sigp_ccode;
 
 
@@ -70,7 +69,6 @@
 	ec_schedule=0,
 	ec_call_function,
 	ec_call_function_single,
-	ec_bit_last
 } ec_bit_sig;
 
 /*
Index: quilt-2.6/arch/s390/include/asm/smp.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/smp.h	2010-02-24 09:44:24.000000000 +0100
+++ quilt-2.6/arch/s390/include/asm/smp.h	2010-02-24 09:44:25.000000000 +0100
@@ -36,6 +36,28 @@
 			      int from, int to);
 extern void smp_restart_cpu(void);
 
+/*
+ * returns 1 if (virtual) cpu is scheduled
+ * returns 0 otherwise
+ */
+static inline int smp_vcpu_scheduled(int cpu)
+{
+	__u32 status = 0;
+
+	switch (signal_processor_ps(&status, 0, cpu, sigp_sense_running)) {
+	case sigp_status_stored:
+		/* Check for running status */
+		if (status & 0x400)
+			return 0;
+		break;
+	case sigp_not_operational:
+		return 0;
+	default:
+		break;
+	}
+	return 1;
+}
+
 #else /* CONFIG_SMP */
 
 static inline void smp_switch_to_ipl_cpu(void (*func)(void *), void *data)
@@ -43,6 +65,8 @@
 	func(data);
 }
 
+#define smp_vcpu_scheduled	(1)
+
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_HOTPLUG_CPU
Index: quilt-2.6/arch/s390/lib/spinlock.c
===================================================================
--- quilt-2.6.orig/arch/s390/lib/spinlock.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/lib/spinlock.c	2010-02-24 09:44:25.000000000 +0100
@@ -43,16 +43,24 @@
 {
 	int count = spin_retry;
 	unsigned int cpu = ~smp_processor_id();
+	unsigned int owner;
 
 	while (1) {
-		if (count-- <= 0) {
-			unsigned int owner = lp->owner_cpu;
-			if (owner != 0)
-				_raw_yield_cpu(~owner);
-			count = spin_retry;
+		owner = lp->owner_cpu;
+		if (!owner || smp_vcpu_scheduled(~owner)) {
+			for (count = spin_retry; count > 0; count--) {
+				if (arch_spin_is_locked(lp))
+					continue;
+				if (_raw_compare_and_swap(&lp->owner_cpu, 0,
+							  cpu) == 0)
+					return;
+			}
+			if (MACHINE_IS_LPAR)
+				continue;
 		}
-		if (arch_spin_is_locked(lp))
-			continue;
+		owner = lp->owner_cpu;
+		if (owner)
+			_raw_yield_cpu(~owner);
 		if (_raw_compare_and_swap(&lp->owner_cpu, 0, cpu) == 0)
 			return;
 	}
@@ -63,17 +71,27 @@
 {
 	int count = spin_retry;
 	unsigned int cpu = ~smp_processor_id();
+	unsigned int owner;
 
 	local_irq_restore(flags);
 	while (1) {
-		if (count-- <= 0) {
-			unsigned int owner = lp->owner_cpu;
-			if (owner != 0)
-				_raw_yield_cpu(~owner);
-			count = spin_retry;
+		owner = lp->owner_cpu;
+		if (!owner || smp_vcpu_scheduled(~owner)) {
+			for (count = spin_retry; count > 0; count--) {
+				if (arch_spin_is_locked(lp))
+					continue;
+				local_irq_disable();
+				if (_raw_compare_and_swap(&lp->owner_cpu, 0,
+							  cpu) == 0)
+					return;
+				local_irq_restore(flags);
+			}
+			if (MACHINE_IS_LPAR)
+				continue;
 		}
-		if (arch_spin_is_locked(lp))
-			continue;
+		owner = lp->owner_cpu;
+		if (owner)
+			_raw_yield_cpu(~owner);
 		local_irq_disable();
 		if (_raw_compare_and_swap(&lp->owner_cpu, 0, cpu) == 0)
 			return;
@@ -100,8 +118,11 @@
 void arch_spin_relax(arch_spinlock_t *lock)
 {
 	unsigned int cpu = lock->owner_cpu;
-	if (cpu != 0)
-		_raw_yield_cpu(~cpu);
+	if (cpu != 0) {
+		if (MACHINE_IS_VM || MACHINE_IS_KVM ||
+		    !smp_vcpu_scheduled(~cpu))
+			_raw_yield_cpu(~cpu);
+	}
 }
 EXPORT_SYMBOL(arch_spin_relax);
 
