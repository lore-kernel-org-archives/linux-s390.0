From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 8/9] KVM: s390: factor out and optimize floating irq VCPU kick
Date: Mon, 11 May 2015 10:44:36 +0200
Message-ID: <1431333877-28700-9-git-send-email-borntraeger@de.ibm.com>
References: <1431333877-28700-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1431333877-28700-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch factors out the search for a floating irq destination
VCPU as well as the kicking of the found VCPU. The search is optimized
in the following ways:

1. stopped VCPUs can't take any floating interrupts, so try to find an
   operating one. We have to take care of the special case where all
   VCPUs are stopped and we don't have any valid destination.

2. use online_vcpus, not KVM_MAX_VCPU. This speeds up the search
   especially if KVM_MAX_VCPU is increased one day. As these VCPU
   objects are initialized prior to increasing online_vcpus, we can be
   sure that they exist.

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Reviewed-by: Jens Freimann <jfrei@linux.vnet.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 74 +++++++++++++++++++++++++++++------------------
 1 file changed, 46 insertions(+), 28 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index acf4a4e..322ef9c 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -1337,12 +1337,54 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	return 0;
 }
 
-static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
+/*
+ * Find a destination VCPU for a floating irq and kick it.
+ */
+static void __floating_irq_kick(struct kvm *kvm, u64 type)
 {
+	struct kvm_s390_float_interrupt *fi = &kvm->arch.float_int;
 	struct kvm_s390_local_interrupt *li;
+	struct kvm_vcpu *dst_vcpu;
+	int sigcpu, online_vcpus, nr_tries = 0;
+
+	online_vcpus = atomic_read(&kvm->online_vcpus);
+	if (!online_vcpus)
+		return;
+
+	/* find idle VCPUs first, then round robin */
+	sigcpu = find_first_bit(fi->idle_mask, online_vcpus);
+	if (sigcpu == online_vcpus) {
+		do {
+			sigcpu = fi->next_rr_cpu;
+			fi->next_rr_cpu = (fi->next_rr_cpu + 1) % online_vcpus;
+			/* avoid endless loops if all vcpus are stopped */
+			if (nr_tries++ >= online_vcpus)
+				return;
+		} while (is_vcpu_stopped(kvm_get_vcpu(kvm, sigcpu)));
+	}
+	dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
+
+	/* make the VCPU drop out of the SIE, or wake it up if sleeping */
+	li = &dst_vcpu->arch.local_int;
+	spin_lock(&li->lock);
+	switch (type) {
+	case KVM_S390_MCHK:
+		atomic_set_mask(CPUSTAT_STOP_INT, li->cpuflags);
+		break;
+	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
+		atomic_set_mask(CPUSTAT_IO_INT, li->cpuflags);
+		break;
+	default:
+		atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
+		break;
+	}
+	spin_unlock(&li->lock);
+	kvm_s390_vcpu_wakeup(dst_vcpu);
+}
+
+static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
+{
 	struct kvm_s390_float_interrupt *fi;
-	struct kvm_vcpu *dst_vcpu = NULL;
-	int sigcpu;
 	u64 type = READ_ONCE(inti->type);
 	int rc;
 
@@ -1370,32 +1412,8 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	if (rc)
 		return rc;
 
-	sigcpu = find_first_bit(fi->idle_mask, KVM_MAX_VCPUS);
-	if (sigcpu == KVM_MAX_VCPUS) {
-		do {
-			sigcpu = fi->next_rr_cpu++;
-			if (sigcpu == KVM_MAX_VCPUS)
-				sigcpu = fi->next_rr_cpu = 0;
-		} while (kvm_get_vcpu(kvm, sigcpu) == NULL);
-	}
-	dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
-	li = &dst_vcpu->arch.local_int;
-	spin_lock(&li->lock);
-	switch (type) {
-	case KVM_S390_MCHK:
-		atomic_set_mask(CPUSTAT_STOP_INT, li->cpuflags);
-		break;
-	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
-		atomic_set_mask(CPUSTAT_IO_INT, li->cpuflags);
-		break;
-	default:
-		atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
-		break;
-	}
-	spin_unlock(&li->lock);
-	kvm_s390_vcpu_wakeup(kvm_get_vcpu(kvm, sigcpu));
+	__floating_irq_kick(kvm, type);
 	return 0;
-
 }
 
 int kvm_s390_inject_vm(struct kvm *kvm,
-- 
2.3.0
