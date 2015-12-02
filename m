From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 23/23] KVM: s390: remove redudant assigment of error code
Date: Wed,  2 Dec 2015 12:06:24 +0100
Message-ID: <1449054384-76374-24-git-send-email-borntraeger@de.ibm.com>
References: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1449054384-76374-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

rc already contains -ENOMEM, no need to assign it twice.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 77724ce..6857262 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1618,10 +1618,8 @@ struct kvm_vcpu *kvm_arch_vcpu_create(struct kvm *kvm,
 	 */
 	vcpu->arch.guest_fpregs.fprs = kzalloc(sizeof(freg_t) * __NUM_FPRS,
 					       GFP_KERNEL);
-	if (!vcpu->arch.guest_fpregs.fprs) {
-		rc = -ENOMEM;
+	if (!vcpu->arch.guest_fpregs.fprs)
 		goto out_free_sie_block;
-	}
 
 	rc = kvm_vcpu_init(vcpu, kvm, id);
 	if (rc)
-- 
2.3.0
