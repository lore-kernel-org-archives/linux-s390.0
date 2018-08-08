From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: [PATCH v8 19/22] KVM: s390: Clear Crypto Control Block when using vSIE
Date: Wed,  8 Aug 2018 10:44:29 -0400
Message-ID: <1533739472-7172-20-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1533739472-7172-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, akrowiak@linux.vnet.ibm.com, frankja@linux.ibm.com, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Pierre Morel <pmorel@linux.ibm.com>

When we clear the Crypto Control Block (CRYCB) used by a guest
level 2, the vSIE shadow CRYCB for guest level 3 must be updated
before the guest uses it.

We achieve this by using the KVM_REQ_VSIE_RESTART synchronous
request for each vCPU belonging to the guest to force the reload
of the shadow CRYCB before rerunning the guest level 3.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0d03249..9203f0b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1921,6 +1921,9 @@ static void kvm_s390_set_crycb_format(struct kvm *kvm)
 
 void kvm_arch_crypto_clear_masks(struct kvm *kvm)
 {
+	int i;
+	struct kvm_vcpu *vcpu;
+
 	mutex_lock(&kvm->lock);
 	kvm_s390_vcpu_block_all(kvm);
 
@@ -1929,6 +1932,10 @@ void kvm_arch_crypto_clear_masks(struct kvm *kvm)
 	memset(&kvm->arch.crypto.crycb->apcb1, 0,
 	       sizeof(kvm->arch.crypto.crycb->apcb1));
 
+	/* recreate the shadow crycb for each vcpu */
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		kvm_s390_sync_request(KVM_REQ_VSIE_RESTART, vcpu);
+
 	kvm_s390_vcpu_unblock_all(kvm);
 	mutex_unlock(&kvm->lock);
 }
-- 
1.7.1
