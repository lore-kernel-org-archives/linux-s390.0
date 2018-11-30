From: Michael Mueller <mimu@linux.ibm.com>
Date: Fri, 30 Nov 2018 14:32:09 +0000
Subject: [PATCH v4 04/10] KVM: s390: factor out nullify_gisa()
Message-Id: <20181130143215.69496-5-mimu@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This function will be used by the GIB alert handler and during
the GISA clear operation. Thus it gets factored out here.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/interrupt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 5d20a0ce8a30..97e5da9a0814 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2886,11 +2886,16 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
 	return n;
 }
 
+static void nullify_gisa(struct kvm_s390_gisa *gisa)
+{
+	memset(gisa, 0, sizeof(struct kvm_s390_gisa));
+	gisa->next_alert = (u32)(u64)gisa;
+}
+
 void kvm_s390_gisa_clear(struct kvm *kvm)
 {
 	if (kvm->arch.gisa) {
-		memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
-		kvm->arch.gisa->next_alert = (u32)(u64)kvm->arch.gisa;
+		nullify_gisa(kvm->arch.gisa);
 		VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
 	}
 }
-- 
2.13.4
