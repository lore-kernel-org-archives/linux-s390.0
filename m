From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/5] KVM: s390: fix pfmf intercept handler
Date: Thu, 19 Nov 2015 15:09:23 +0100
Message-ID: <1447942166-66514-3-git-send-email-borntraeger@de.ibm.com>
References: <1447942166-66514-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1447942166-66514-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The pfmf intercept handler should check if the EDAT 1 facility
is installed in the guest, not if it is installed in the host.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 77191b8..d76b51c 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -660,7 +660,7 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 
 	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
 
-	if (!MACHINE_HAS_PFMF)
+	if (!test_kvm_facility(vcpu->kvm, 8))
 		return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
 
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_PSTATE)
-- 
2.3.0
