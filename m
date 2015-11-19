From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/5] KVM: s390: enable SIMD only when no VCPUs were created
Date: Thu, 19 Nov 2015 15:09:22 +0100
Message-ID: <1447942166-66514-2-git-send-email-borntraeger@de.ibm.com>
References: <1447942166-66514-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1447942166-66514-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We should never allow to enable/disable any facilities for the guest
when other VCPUs were already created.

kvm_arch_vcpu_(load|put) relies on SIMD not changing during runtime.
If somebody would create and run VCPUs and then decides to enable
SIMD, undefined behaviour could be possible (e.g. vector save area
not being set up).

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: stable@vger.kernel.org # 4.1+
---
 arch/s390/kvm/kvm-s390.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8fe2f1c..8465892 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -342,12 +342,16 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		r = 0;
 		break;
 	case KVM_CAP_S390_VECTOR_REGISTERS:
-		if (MACHINE_HAS_VX) {
+		mutex_lock(&kvm->lock);
+		if (atomic_read(&kvm->online_vcpus)) {
+			r = -EBUSY;
+		} else if (MACHINE_HAS_VX) {
 			set_kvm_facility(kvm->arch.model.fac->mask, 129);
 			set_kvm_facility(kvm->arch.model.fac->list, 129);
 			r = 0;
 		} else
 			r = -EINVAL;
+		mutex_unlock(&kvm->lock);
 		VM_EVENT(kvm, 3, "ENABLE: CAP_S390_VECTOR_REGISTERS %s",
 			 r ? "(not available)" : "(success)");
 		break;
-- 
2.3.0
