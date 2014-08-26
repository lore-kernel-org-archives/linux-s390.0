From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 04/15] KVM: s390: clear kvm_dirty_regs when dropping to user space
Date: Tue, 26 Aug 2014 10:28:16 +0200
Message-ID: <1409041707-39938-5-git-send-email-borntraeger@de.ibm.com>
References: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We should make sure that all kvm_dirty_regs bits are cleared before dropping
to user space. Until now, some would remain pending.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 81b0e11..f00d0b0 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1319,15 +1319,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 
 	vcpu->arch.sie_block->gpsw.mask = kvm_run->psw_mask;
 	vcpu->arch.sie_block->gpsw.addr = kvm_run->psw_addr;
-	if (kvm_run->kvm_dirty_regs & KVM_SYNC_PREFIX) {
-		kvm_run->kvm_dirty_regs &= ~KVM_SYNC_PREFIX;
+	if (kvm_run->kvm_dirty_regs & KVM_SYNC_PREFIX)
 		kvm_s390_set_prefix(vcpu, kvm_run->s.regs.prefix);
-	}
 	if (kvm_run->kvm_dirty_regs & KVM_SYNC_CRS) {
-		kvm_run->kvm_dirty_regs &= ~KVM_SYNC_CRS;
 		memcpy(&vcpu->arch.sie_block->gcr, &kvm_run->s.regs.crs, 128);
 		kvm_s390_set_prefix(vcpu, kvm_run->s.regs.prefix);
 	}
+	kvm_run->kvm_dirty_regs = 0;
 
 	might_fault();
 	rc = __vcpu_run(vcpu);
-- 
1.8.4.2
