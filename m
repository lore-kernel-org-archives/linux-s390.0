From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 4/6] KVM: s390: check the given debug flags, not the set ones
Date: Fri, 30 May 2014 11:00:10 +0200
Message-ID: <1401440412-20472-5-git-send-email-borntraeger@de.ibm.com>
References: <1401440412-20472-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1401440412-20472-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch fixes a minor bug when updating the guest debug settings.
We should check the given debug flags, not the already set ones.
Doesn't do any harm but too many (for now unused) flags could be set internally
without error.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e519860..06d1888 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -950,7 +950,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	vcpu->guest_debug = 0;
 	kvm_s390_clear_bp_data(vcpu);
 
-	if (vcpu->guest_debug & ~VALID_GUESTDBG_FLAGS)
+	if (dbg->control & ~VALID_GUESTDBG_FLAGS)
 		return -EINVAL;
 
 	if (dbg->control & KVM_GUESTDBG_ENABLE) {
-- 
1.8.4.2
