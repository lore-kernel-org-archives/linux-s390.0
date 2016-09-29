From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] s390x/spinlock: Provide vcpu_is_preempted globally
Date: Thu, 29 Sep 2016 13:54:16 +0200
Message-ID: <1475150056-58774-1-git-send-email-borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Peter Zijlstra <peterz@infradead.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: kernellwp@gmail.com, linux-s390@vger.kernel.org, benh@kernel.crashing.org, jgross@suse.com, kvm@vger.kernel.org, Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>, will.deacon@arm.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, mingo@redhat.com, paulus@samba.org, mpe@ellerman.id.au, xen-devel-request@lists.xenproject.org, pbonzini@redhat.com, paulmck@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

this implements the s390 backend for commit
"kernel/sched: introduce vcpu preempted check interface"
by simply reusing the existing cpu_is_preempted function.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
Martin, Heiko,

this patch is a minimal change by not touching all existing users of
cpu_is_preempted in spinlock.c. If you want it differently, let me
know.


 arch/s390/include/asm/spinlock.h | 7 +++++++
 arch/s390/lib/spinlock.c         | 3 ++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/spinlock.h b/arch/s390/include/asm/spinlock.h
index 63ebf37..6e82986 100644
--- a/arch/s390/include/asm/spinlock.h
+++ b/arch/s390/include/asm/spinlock.h
@@ -21,6 +21,13 @@ _raw_compare_and_swap(unsigned int *lock, unsigned int old, unsigned int new)
 	return __sync_bool_compare_and_swap(lock, old, new);
 }
 
+int arch_vcpu_is_preempted(int cpu);
+#define vcpu_is_preempted cpu_is_preempted
+static inline bool cpu_is_preempted(int cpu)
+{
+	return arch_vcpu_is_preempted(cpu);
+}
+
 /*
  * Simple spin lock operations.  There are two variants, one clears IRQ's
  * on the local processor, one does not.
diff --git a/arch/s390/lib/spinlock.c b/arch/s390/lib/spinlock.c
index e5f50a7..9f473c8 100644
--- a/arch/s390/lib/spinlock.c
+++ b/arch/s390/lib/spinlock.c
@@ -37,7 +37,7 @@ static inline void _raw_compare_and_delay(unsigned int *lock, unsigned int old)
 	asm(".insn rsy,0xeb0000000022,%0,0,%1" : : "d" (old), "Q" (*lock));
 }
 
-static inline int cpu_is_preempted(int cpu)
+int arch_vcpu_is_preempted(int cpu)
 {
 	if (test_cpu_flag_of(CIF_ENABLED_WAIT, cpu))
 		return 0;
@@ -45,6 +45,7 @@ static inline int cpu_is_preempted(int cpu)
 		return 0;
 	return 1;
 }
+EXPORT_SYMBOL(arch_vcpu_is_preempted);
 
 void arch_spin_lock_wait(arch_spinlock_t *lp)
 {
-- 
2.5.5
