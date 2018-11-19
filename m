From: Michael Mueller <mimu@linux.ibm.com>
Date: Mon, 19 Nov 2018 17:25:32 +0000
Subject: [PATCH v2 08/12] KVM: s390: factor out __find_vcpu_for_floating_irq()
Message-Id: <20181119172536.52649-9-mimu@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This function will be used as well to find a suitable vcpu
to wakeup in GIB alert interruption context.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
---
 arch/s390/kvm/interrupt.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index fc9eae499319..8676596f6b5c 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1719,18 +1719,14 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	return 0;
 }
 
-/*
- * Find a destination VCPU for a floating irq and kick it.
- */
-static void __floating_irq_kick(struct kvm *kvm, u64 type)
+static struct kvm_vcpu *__find_vcpu_for_floating_irq(struct kvm *kvm)
 {
 	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
-	struct kvm_vcpu *dst_vcpu;
 	int sigcpu, online_vcpus, nr_tries = 0;
 
 	online_vcpus = atomic_read(&kvm->online_vcpus);
 	if (!online_vcpus)
-		return;
+		return NULL;
 
 	/* find idle VCPUs first, then round robin */
 	sigcpu = find_first_bit(fi->idle_mask, online_vcpus);
@@ -1740,10 +1736,22 @@ static void __floating_irq_kick(struct kvm *kvm, u64 type)
 			fi->next_rr_cpu = (fi->next_rr_cpu + 1) % online_vcpus;
 			/* avoid endless loops if all vcpus are stopped */
 			if (nr_tries++ >= online_vcpus)
-				return;
+				return NULL;
 		} while (is_vcpu_stopped(kvm_get_vcpu(kvm, sigcpu)));
 	}
-	dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
+	return kvm_get_vcpu(kvm, sigcpu);
+}
+
+/*
+ * Find a destination VCPU for a floating irq and kick it.
+ */
+static void __floating_irq_kick(struct kvm *kvm, u64 type)
+{
+	struct kvm_vcpu *dst_vcpu;
+
+	dst_vcpu = __find_vcpu_for_floating_irq(kvm);
+	if (!dst_vcpu)
+		return;
 
 	/* make the VCPU drop out of the SIE, or wake it up if sleeping */
 	switch (type) {
-- 
2.13.4
