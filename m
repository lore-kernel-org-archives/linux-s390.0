From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 20/22] KVM: s390: activate GISA for emulated interrupts
Date: Fri, 26 Jan 2018 16:53:32 +0100
Message-ID: <20180126155334.52956-21-borntraeger@de.ibm.com>
References: <20180126155334.52956-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180126155334.52956-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

If the AIV facility is available, a GISA will be used to manage emulated
adapter interrupts.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index f2dc86884ea42..488ecc7ea2a18 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -2842,7 +2842,13 @@ void kvm_s390_gisa_clear(struct kvm *kvm)
 
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
2.13.4
