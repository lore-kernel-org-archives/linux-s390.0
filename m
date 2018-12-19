From: Michael Mueller <mimu@linux.ibm.com>
Subject: [PATCH v5 03/15] KVM: s390: factor out nullify_gisa()
Date: Wed, 19 Dec 2018 20:17:44 +0100
Message-ID: <20181219191756.57973-4-mimu@linux.ibm.com>
References: <20181219191756.57973-1-mimu@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219191756.57973-1-mimu@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM Mailing List <kvm@vger.kernel.org>
Cc: Linux-S390 Mailing List <linux-s390@vger.kernel.org>, linux-kernel@vger.kernel.org, kvm390-list@tuxmaker.boeblingen.de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, Michael Mueller <mimu@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This function will be used by the GISA init and the GISA
clear operation. Thus it gets factored out here.

Signed-off-by: Michael Mueller <mimu@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/interrupt.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 9a3aed608914..c3a8b2fbbcf2 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2884,12 +2884,17 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
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
 	if (!kvm->arch.gisa)
 		return;
-	memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
-	kvm->arch.gisa->next_alert = (u32)(u64)kvm->arch.gisa;
+	nullify_gisa(kvm->arch.gisa);
 	VM_EVENT(kvm, 3, "gisa 0x%pK cleared", kvm->arch.gisa);
 }
 
@@ -2898,8 +2903,8 @@ void kvm_s390_gisa_init(struct kvm *kvm)
 	if (!css_general_characteristics.aiv)
 		return;
 	kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
+	nullify_gisa(kvm->arch.gisa);
 	VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
-	kvm_s390_gisa_clear(kvm);
 }
 
 void kvm_s390_gisa_destroy(struct kvm *kvm)
-- 
2.13.4
