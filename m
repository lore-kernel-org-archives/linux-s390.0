From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2 1/1] s390/spinlock: Provide vcpu_is_preempted
Date: Thu, 29 Sep 2016 17:51:05 +0200
Message-ID: <1475164265-246160-2-git-send-email-borntraeger@de.ibm.com>
References: <1475164265-246160-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1475164265-246160-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, xen-devel-request@lists.xenproject.org, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, mingo@redhat.com, paulmck@linux.vnet.ibm.com, will.deacon@arm.com, kernellwp@gmail.com, jgross@suse.com, pbonzini@redhat.com, bsingharora@gmail.com, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

this implements the s390 backend for commit
"kernel/sched: introduce vcpu preempted check interface"
by reworking the existing smp_vcpu_scheduled into
arch_vcpu_is_preempted. We can then also get rid of the
local cpu_is_preempted function by moving the
CIF_ENABLED_WAIT test into arch_vcpu_is_preempted.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/spinlock.h |  3 +++
 arch/s390/kernel/smp.c           |  9 +++++++--
 arch/s390/lib/spinlock.c         | 25 ++++++++-----------------
 3 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/arch/s390/include/asm/spinlock.h b/arch/s390/include/asm/spinlock.h
index 63ebf37..e16e02f 100644
--- a/arch/s390/include/asm/spinlock.h
+++ b/arch/s390/include/asm/spinlock.h
@@ -21,6 +21,9 @@ _raw_compare_and_swap(unsigned int *lock, unsigned int old, unsigned int new)
 	return __sync_bool_compare_and_swap(lock, old, new);
 }
 
+bool arch_vcpu_is_preempted(int cpu);
+#define vcpu_is_preempted arch_vcpu_is_preempted
+
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
  * on the local processor, one does not.
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 7b89a75..4aadd16 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -376,10 +376,15 @@ int smp_find_processor_id(u16 address)
 	return -1;
 }
 
-int smp_vcpu_scheduled(int cpu)
+bool arch_vcpu_is_preempted(int cpu)
 {
-	return pcpu_running(pcpu_devices + cpu);
+	if (test_cpu_flag_of(CIF_ENABLED_WAIT, cpu))
+		return false;
+	if (pcpu_running(pcpu_devices + cpu))
+		return false;
+	return true;
 }
+EXPORT_SYMBOL(arch_vcpu_is_preempted);
 
 void smp_yield_cpu(int cpu)
 {
diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
index e5f50a7..e48a48e 100644
--- a/arch/s390/lib/spinlock.c
+++ b/arch/s390/lib/spinlock.c
@@ -37,15 +37,6 @@ static inline void _raw_compare_and_delay(unsigned int *lock, unsigned int old)
 	asm(".insn rsy,0xeb0000000022,%0,0,%1" : : "d" (old), "Q" (*lock));
 }
 
-static inline int cpu_is_preempted(int cpu)
-{
-	if (test_cpu_flag_of(CIF_ENABLED_WAIT, cpu))
-		return 0;
-	if (smp_vcpu_scheduled(cpu))
-		return 0;
-	return 1;
-}
-
 void arch_spin_lock_wait(arch_spinlock_t *lp)
 {
 	unsigned int cpu = SPINLOCK_LOCKVAL;
@@ -62,7 +53,7 @@ void arch_spin_lock_wait(arch_spinlock_t *lp)
 			continue;
 		}
 		/* First iteration: check if the lock owner is running. */
-		if (first_diag && cpu_is_preempted(~owner)) {
+		if (first_diag && arch_vcpu_is_preempted(~owner)) {
 			smp_yield_cpu(~owner);
 			first_diag = 0;
 			continue;
@@ -81,7 +72,7 @@ void arch_spin_lock_wait(arch_spinlock_t *lp)
 		 * yield the CPU unconditionally. For LPAR rely on the
 		 * sense running status.
 		 */
-		if (!MACHINE_IS_LPAR || cpu_is_preempted(~owner)) {
+		if (!MACHINE_IS_LPAR || arch_vcpu_is_preempted(~owner)) {
 			smp_yield_cpu(~owner);
 			first_diag = 0;
 		}
@@ -108,7 +99,7 @@ void arch_spin_lock_wait_flags(arch_spinlock_t *lp, unsigned long flags)
 			continue;
 		}
 		/* Check if the lock owner is running. */
-		if (first_diag && cpu_is_preempted(~owner)) {
+		if (first_diag && arch_vcpu_is_preempted(~owner)) {
 			smp_yield_cpu(~owner);
 			first_diag = 0;
 			continue;
@@ -127,7 +118,7 @@ void arch_spin_lock_wait_flags(arch_spinlock_t *lp, unsigned long flags)
 		 * yield the CPU unconditionally. For LPAR rely on the
 		 * sense running status.
 		 */
-		if (!MACHINE_IS_LPAR || cpu_is_preempted(~owner)) {
+		if (!MACHINE_IS_LPAR || arch_vcpu_is_preempted(~owner)) {
 			smp_yield_cpu(~owner);
 			first_diag = 0;
 		}
@@ -165,7 +156,7 @@ void _raw_read_lock_wait(arch_rwlock_t *rw)
 	owner = 0;
 	while (1) {
 		if (count-- <= 0) {
-			if (owner && cpu_is_preempted(~owner))
+			if (owner && arch_vcpu_is_preempted(~owner))
 				smp_yield_cpu(~owner);
 			count = spin_retry;
 		}
@@ -211,7 +202,7 @@ void _raw_write_lock_wait(arch_rwlock_t *rw, unsigned int prev)
 	owner = 0;
 	while (1) {
 		if (count-- <= 0) {
-			if (owner && cpu_is_preempted(~owner))
+			if (owner && arch_vcpu_is_preempted(~owner))
 				smp_yield_cpu(~owner);
 			count = spin_retry;
 		}
@@ -241,7 +232,7 @@ void _raw_write_lock_wait(arch_rwlock_t *rw)
 	owner = 0;
 	while (1) {
 		if (count-- <= 0) {
-			if (owner && cpu_is_preempted(~owner))
+			if (owner && arch_vcpu_is_preempted(~owner))
 				smp_yield_cpu(~owner);
 			count = spin_retry;
 		}
@@ -285,7 +276,7 @@ void arch_lock_relax(unsigned int cpu)
 {
 	if (!cpu)
 		return;
-	if (MACHINE_IS_LPAR && !cpu_is_preempted(~cpu))
+	if (MACHINE_IS_LPAR && !arch_vcpu_is_preempted(~cpu))
 		return;
 	smp_yield_cpu(~cpu);
 }
-- 
2.5.5
