From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 03/10] KVM: s390: enable PFMFI only if guest has EDAT1
Date: Mon,  9 May 2016 14:26:43 +0200
Message-ID: <1462796804-13750-2-git-send-email-borntraeger@de.ibm.com>
References: <1462796804-13750-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1462796804-13750-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Alexander Yarygin <yarygin@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Only enable PFMF interpretation if the necessary facility (EDAT1) is
available, otherwise the pfmf handler in priv.c will inject an exception

Reviewed-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 668c087..13b3f5e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1649,7 +1649,8 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	if (test_kvm_facility(vcpu->kvm, 50) && test_kvm_facility(vcpu->kvm, 73))
 		vcpu->arch.sie_block->ecb |= 0x10;
 
-	vcpu->arch.sie_block->ecb2  = 8;
+	if (test_kvm_facility(vcpu->kvm, 8))
+		vcpu->arch.sie_block->ecb2 |= 0x08;
 	vcpu->arch.sie_block->eca   = 0xC1002000U;
 	if (sclp.has_siif)
 		vcpu->arch.sie_block->eca |= 1;
-- 
2.5.5
