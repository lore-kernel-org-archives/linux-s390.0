From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 2/6] KVM: s390: Use helper function to set CC in SIGP handler
Date: Wed, 11 Dec 2013 19:57:45 +0100
Message-ID: <1386788269-20249-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1386788269-20249-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1386788269-20249-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Thomas Huth <thuth@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

We've got a helper function for setting the condition code now,
so let's use it in the SIGP handler, too.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/sigp.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index c370058..bc0d85a 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -435,7 +435,6 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
 	if (rc < 0)
 		return rc;
 
-	vcpu->arch.sie_block->gpsw.mask &= ~(3ul << 44);
-	vcpu->arch.sie_block->gpsw.mask |= (rc & 3ul) << 44;
+	kvm_s390_set_psw_cc(vcpu, rc);
 	return 0;
 }
-- 
1.7.9.5
