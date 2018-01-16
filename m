From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 10/12] KVM: s390: activate GISA for emulated interrupts
Date: Tue, 16 Jan 2018 21:02:15 +0100
Message-ID: <20180116200217.211897-11-borntraeger@de.ibm.com>
References: <20180116200217.211897-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180116200217.211897-1-borntraeger@de.ibm.com>
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
 arch/s390/kvm/interrupt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 2f1a5603c366..5215fee30f8a 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2838,7 +2838,7 @@ void kvm_s390_gisa_clear(struct kvm *kvm)
 
 void kvm_s390_gisa_init(struct kvm *kvm)
 {
-	if (1 || !css_general_characteristics.aiv)
+	if (!css_general_characteristics.aiv)
 		kvm->arch.gisa = NULL;
 	else {
 		kvm->arch.gisa = &kvm->arch.sie_page2->gisa;
-- 
2.13.4
