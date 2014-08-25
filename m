From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] KVM: s390: Fix user triggerable bug in dead code
Date: Mon, 25 Aug 2014 15:10:10 +0200
Message-ID: <1408972211-27122-2-git-send-email-borntraeger@de.ibm.com>
References: <1408972211-27122-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1408972211-27122-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, stable@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

In the early days, we had some special handling for the
KVM_EXIT_S390_SIEIC exit, but this was gone in 2009 with commit
d7b0b5eb3000 (KVM: s390: Make psw available on all exits, not
just a subset).

Now this switch statement is just a sanity check for userspace
not messing with the kvm_run structure. Unfortunately, this
allows userspace to trigger a kernel BUG. Let's just remove
this switch statement.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: stable@vger.kernel.org
---
 arch/s390/kvm/kvm-s390.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ce81eb2..81b0e11 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1317,19 +1317,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		return -EINVAL;
 	}
 
-	switch (kvm_run->exit_reason) {
-	case KVM_EXIT_S390_SIEIC:
-	case KVM_EXIT_UNKNOWN:
-	case KVM_EXIT_INTR:
-	case KVM_EXIT_S390_RESET:
-	case KVM_EXIT_S390_UCONTROL:
-	case KVM_EXIT_S390_TSCH:
-	case KVM_EXIT_DEBUG:
-		break;
-	default:
-		BUG();
-	}
-
 	vcpu->arch.sie_block->gpsw.mask = kvm_run->psw_mask;
 	vcpu->arch.sie_block->gpsw.addr = kvm_run->psw_addr;
 	if (kvm_run->kvm_dirty_regs & KVM_SYNC_PREFIX) {
-- 
1.8.4.2
