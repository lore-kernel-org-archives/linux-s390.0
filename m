From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v3 10/12] KVM: s390: activate GISA for emulated interrupts
Date: Thu, 25 Jan 2018 18:06:08 +0100
Message-ID: <20180125170608.38276-5-borntraeger@de.ibm.com>
References: <20180125170608.38276-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180125170608.38276-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

If the AIV facility is available, a GISA will be used to manage emulated
adapter interrupts.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 1a561ad..ec4b7bf 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2840,7 +2840,13 @@ void kvm_s390_gisa_clear(struct kvm *kvm)
 
 void kvm_s390_gisa_init(struct kvm *kvm)
 {
-	/* not implemented yet */
+	if (!css_general_characteristics.aiv)
+		kvm->arch.gisa = NULL;
+	else {
+		kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
+		VM_EVENT(kvm, 3, "gisa 0x%pK initialized", kvm->arch.gisa);
+		kvm_s390_gisa_clear(kvm);
+	}
 }
 
 void kvm_s390_gisa_destroy(struct kvm *kvm)
-- 
2.9.4
