From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 22 Feb 2019 11:42:16 +0000
Subject: [GIT PULL 05/18] KVM: s390: coding style kvm_s390_gisa_init/clear()
Message-Id: <1550835749-26436-6-git-send-email-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.ibm.com>

The change helps to reduce line length and
increases code readability.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
Message-Id: <20190131085247.13826-5-mimu@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 2a3eb9f..005dbe7 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2885,20 +2885,20 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
 
 void kvm_s390_gisa_clear(struct kvm *kvm)
 {
-	if (kvm->arch.gisa) {
-		memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
-		kvm->arch.gisa->next_alert = (u32)(u64)kvm->arch.gisa;
-		VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
-	}
+	if (!kvm->arch.gisa)
+		return;
+	memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
+	kvm->arch.gisa->next_alert = (u32)(u64)kvm->arch.gisa;
+	VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
 }
 
 void kvm_s390_gisa_init(struct kvm *kvm)
 {
-	if (css_general_characteristics.aiv) {
-		kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
-		VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
-		kvm_s390_gisa_clear(kvm);
-	}
+	if (!css_general_characteristics.aiv)
+		return;
+	kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
+	kvm_s390_gisa_clear(kvm);
+	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
 }
 
 void kvm_s390_gisa_destroy(struct kvm *kvm)
-- 
2.7.4
