From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 29/52] KVM: s390: enable ib only if available
Date: Tue, 14 Jun 2016 20:57:06 +0200
Message-ID: <1465930649-181383-30-git-send-email-borntraeger@de.ibm.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's enable intervention bypass only if the facility is acutally
available.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 2a23955..340fb40 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1845,7 +1845,9 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 
 	if (test_kvm_facility(vcpu->kvm, 8))
 		vcpu->arch.sie_block->ecb2 |= 0x08;
-	vcpu->arch.sie_block->eca   = 0xC1002000U;
+	vcpu->arch.sie_block->eca = 0x81002000U;
+	if (sclp.has_ib)
+		vcpu->arch.sie_block->eca |= 0x40000000U;
 	if (sclp.has_siif)
 		vcpu->arch.sie_block->eca |= 1;
 	if (sclp.has_sigpif)
-- 
2.5.5
