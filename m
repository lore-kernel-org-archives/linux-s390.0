From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 46/52] KVM: s390: pfmf: MR and MC are ignored without CSSKE
Date: Tue, 14 Jun 2016 20:57:23 +0200
Message-ID: <1465930649-181383-47-git-send-email-borntraeger@de.ibm.com>
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

These two bits are simply ignored when the conditional-SSKE facility is
not installed.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index bfba983..5c926b7 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -675,10 +675,6 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 	    !test_kvm_facility(vcpu->kvm, 14))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	/* No support for conditional-SSKE */
-	if (vcpu->run->s.regs.gprs[reg1] & (PFMF_MR | PFMF_MC))
-		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-
 	start = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
 	start = kvm_s390_logical_to_effective(vcpu, start);
 
-- 
2.5.5
