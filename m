From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 08:43:47 +0000
Subject: [GIT PULL 01/19] KVM: s390: Replace clear_user with kvm_clear_guest
Message-Id: <20180731084405.28953-2-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.ibm.com>

kvm_clear_guest also does the dirty tracking for us, which we want to
have.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/priv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index eb0eb60c7be6..c4da375553e8 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -956,7 +956,7 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
 		if (vcpu->run->s.regs.gprs[reg1] & PFMF_CF) {
-			if (clear_user((void __user *)useraddr, PAGE_SIZE))
+			if (kvm_clear_guest(vcpu->kvm, start, PAGE_SIZE))
 				return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		}
 
-- 
2.17.0
