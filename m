From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 07/15] KVM: s390: implement KVM_REQ_TLB_FLUSH and make use of it
Date: Tue, 26 Aug 2014 10:28:19 +0200
Message-ID: <1409041707-39938-8-git-send-email-borntraeger@de.ibm.com>
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

Use the KVM_REQ_TLB_FLUSH request in order to trigger tlb flushes instead
of manipulating the SIE control block whenever we need it. Also trigger it for
a control register sync directly instead of (ab)using kvm_s390_set_prefix().

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 10 ++++++++--
 arch/s390/kvm/kvm-s390.h |  2 +-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ab7cd64..56193be 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1051,6 +1051,11 @@ retry:
 		goto retry;
 	}
 
+	if (kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu)) {
+		vcpu->arch.sie_block->ihcpu = 0xffff;
+		goto retry;
+	}
+
 	if (kvm_check_request(KVM_REQ_ENABLE_IBS, vcpu)) {
 		if (!ibs_enabled(vcpu)) {
 			trace_kvm_s390_enable_disable_ibs(vcpu->vcpu_id, 1);
@@ -1306,7 +1311,8 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		kvm_s390_set_prefix(vcpu, kvm_run->s.regs.prefix);
 	if (kvm_run->kvm_dirty_regs & KVM_SYNC_CRS) {
 		memcpy(&vcpu->arch.sie_block->gcr, &kvm_run->s.regs.crs, 128);
-		kvm_s390_set_prefix(vcpu, kvm_run->s.regs.prefix);
+		/* some control register changes require a tlb flush */
+		kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 	}
 	if (kvm_run->kvm_dirty_regs & KVM_SYNC_ARCH0) {
 		vcpu->arch.sie_block->cputm = kvm_run->s.regs.cputm;
@@ -1519,7 +1525,7 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 	 * Another VCPU might have used IBS while we were offline.
 	 * Let's play safe and flush the VCPU at startup.
 	 */
-	vcpu->arch.sie_block->ihcpu  = 0xffff;
+	kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 	spin_unlock(&vcpu->kvm->arch.start_stop_lock);
 	return;
 }
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 894fa46..54c25fd 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -70,7 +70,7 @@ static inline u32 kvm_s390_get_prefix(struct kvm_vcpu *vcpu)
 static inline void kvm_s390_set_prefix(struct kvm_vcpu *vcpu, u32 prefix)
 {
 	vcpu->arch.sie_block->prefix = prefix >> GUEST_PREFIX_SHIFT;
-	vcpu->arch.sie_block->ihcpu  = 0xffff;
+	kvm_make_request(KVM_REQ_TLB_FLUSH, vcpu);
 	kvm_make_request(KVM_REQ_MMU_RELOAD, vcpu);
 }
 
-- 
1.8.4.2
