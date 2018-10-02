From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 02 Oct 2018 07:06:42 +0000
Subject: [GIT PULL 15/28] KVM: s390: Clear Crypto Control Block when using vSIE
Message-Id: <20181002070655.224110-16-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.ibm.com>

When we clear the Crypto Control Block (CRYCB) used by a guest
level 2, the vSIE shadow CRYCB for guest level 3 must be updated
before the guest uses it.

We achieve this by using the KVM_REQ_VSIE_RESTART synchronous
request for each vCPU belonging to the guest to force the reload
of the shadow CRYCB before rerunning the guest level 3.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
Message-Id: <20180925231641.4954-16-akrowiak@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 75aa5aa4a926..c94ef2d0dbe4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2043,6 +2043,8 @@ void kvm_arch_crypto_clear_masks(struct kvm *kvm)
 	memset(&kvm->arch.crypto.crycb->apcb1, 0,
 	       sizeof(kvm->arch.crypto.crycb->apcb1));
 
+	/* recreate the shadow crycb for each vcpu */
+	kvm_s390_sync_request_broadcast(kvm, KVM_REQ_VSIE_RESTART);
 	kvm_s390_vcpu_unblock_all(kvm);
 	mutex_unlock(&kvm->lock);
 }
-- 
2.17.0
