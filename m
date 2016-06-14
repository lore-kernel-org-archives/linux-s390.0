From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 36/52] KVM: s390: enable host-protection-interruption only with ESOP
Date: Tue, 14 Jun 2016 20:57:13 +0200
Message-ID: <1465930649-181383-37-git-send-email-borntraeger@de.ibm.com>
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

host-protection-interruption control was introduced with ESOP. So let's
enable it only if we have ESOP and add an explanatory comment why
we can live without it.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ad93b40..4e764fa 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1837,7 +1837,9 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 
 	kvm_s390_vcpu_setup_model(vcpu);
 
-	vcpu->arch.sie_block->ecb = 0x02;
+	/* pgste_set_pte has special handling for !MACHINE_HAS_ESOP */
+	if (MACHINE_HAS_ESOP)
+		vcpu->arch.sie_block->ecb |= 0x02;
 	if (test_kvm_facility(vcpu->kvm, 9))
 		vcpu->arch.sie_block->ecb |= 0x04;
 	if (test_kvm_facility(vcpu->kvm, 50) && test_kvm_facility(vcpu->kvm, 73))
-- 
2.5.5
