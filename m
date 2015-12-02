From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 08/23] KVM: s390: Provide SCA-aware helpers for VCPU add/del
Date: Wed,  2 Dec 2015 12:06:09 +0100
Message-ID: <1449054384-76374-9-git-send-email-borntraeger@de.ibm.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: "Eugene (jno) Dvurechenski" <jno@linux.vnet.ibm.com>

This patch provides SCA-aware helpers to create/delete a VCPU.
This is to prepare for upcoming introduction of Extended SCA support.

Signed-off-by: Eugene (jno) Dvurechenski <jno@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 44 +++++++++++++++++++++++++++++++-------------
 1 file changed, 31 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 5c36c8e..8ddd488 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -283,6 +283,8 @@ static void kvm_s390_sync_dirty_log(struct kvm *kvm,
 }
 
 /* Section: vm related */
+static void sca_del_vcpu(struct kvm_vcpu *vcpu);
+
 /*
  * Get (and clear) the dirty memory log for a memory slot.
  */
@@ -1189,11 +1191,7 @@ void kvm_arch_vcpu_destroy(struct kvm_vcpu *vcpu)
 	kvm_s390_clear_local_irqs(vcpu);
 	kvm_clear_async_pf_completion_queue(vcpu);
 	if (!kvm_is_ucontrol(vcpu->kvm)) {
-		clear_bit(63 - vcpu->vcpu_id,
-			  (unsigned long *) &vcpu->kvm->arch.sca->mcn);
-		if (vcpu->kvm->arch.sca->cpu[vcpu->vcpu_id].sda ==
-		    (__u64) vcpu->arch.sie_block)
-			vcpu->kvm->arch.sca->cpu[vcpu->vcpu_id].sda = 0;
+		sca_del_vcpu(vcpu);
 	}
 	smp_mb();
 
@@ -1249,6 +1247,32 @@ static int __kvm_ucontrol_vcpu_init(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static void sca_del_vcpu(struct kvm_vcpu *vcpu)
+{
+	struct sca_block *sca = vcpu->kvm->arch.sca;
+
+	clear_bit_inv(vcpu->vcpu_id, (unsigned long *) &sca->mcn);
+	if (sca->cpu[vcpu->vcpu_id].sda == (__u64) vcpu->arch.sie_block)
+		sca->cpu[vcpu->vcpu_id].sda = 0;
+}
+
+static void sca_add_vcpu(struct kvm_vcpu *vcpu, struct kvm *kvm,
+			unsigned int id)
+{
+	struct sca_block *sca = kvm->arch.sca;
+
+	if (!sca->cpu[id].sda)
+		sca->cpu[id].sda = (__u64) vcpu->arch.sie_block;
+	vcpu->arch.sie_block->scaoh = (__u32)(((__u64)sca) >> 32);
+	vcpu->arch.sie_block->scaol = (__u32)(__u64)sca;
+	set_bit_inv(id, (unsigned long *) &sca->mcn);
+}
+
+static int sca_can_add_vcpu(struct kvm *kvm, unsigned int id)
+{
+	return id < KVM_MAX_VCPUS;
+}
+
 int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.pfault_token = KVM_S390_PFAULT_TOKEN_INVALID;
@@ -1465,7 +1489,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 	struct sie_page *sie_page;
 	int rc = -EINVAL;
 
-	if (id >= KVM_MAX_VCPUS)
+	if (!sca_can_add_vcpu(kvm, id))
 		goto out;
 
 	rc = -ENOMEM;
@@ -1487,13 +1511,7 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 			WARN_ON_ONCE(1);
 			goto out_free_cpu;
 		}
-		if (!kvm->arch.sca->cpu[id].sda)
-			kvm->arch.sca->cpu[id].sda =
-				(__u64) vcpu->arch.sie_block;
-		vcpu->arch.sie_block->scaoh =
-			(__u32)(((__u64)kvm->arch.sca) >> 32);
-		vcpu->arch.sie_block->scaol = (__u32)(__u64)kvm->arch.sca;
-		set_bit(63 - id, (unsigned long *) &kvm->arch.sca->mcn);
+		sca_add_vcpu(vcpu, kvm, id);
 	}
 
 	spin_lock_init(&vcpu->arch.local_int.lock);
-- 
2.3.0
