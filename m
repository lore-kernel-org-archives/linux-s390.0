From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 2/2] KVM: enable kvm_vcpu_kick/wake_up for s390
Date: Fri, 17 Feb 2017 14:10:07 +0100
Message-ID: <1487337007-91063-3-git-send-email-borntraeger@de.ibm.com>
References: <1487337007-91063-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1487337007-91063-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

while we still need to provide our private version of kick and wakeup
to synchronize with some special cases, we can still enable the common
code variant.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 12 ++++++++++--
 virt/kvm/kvm_main.c      |  2 --
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 7cfd0dd..fa20686 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2485,8 +2485,14 @@ static void kvm_gmap_notifier(struct gmap *gmap, unsigned long start,
 
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 {
-	/* kvm common code refers to this, but never calls it */
-	BUG();
+	/*
+	 * STOP indication is resetted when delivering interrupts. This
+	 * is done before we handle requests, so we only "loose" this
+	 * when we are still going to handle requests. In that case
+	 * we no longer need that STOP indication.
+	 */
+	__set_cpuflag(vcpu, CPUSTAT_STOP_INT);
+	kvm_s390_vsie_kick(vcpu);
 	return 0;
 }
 
@@ -3064,6 +3070,7 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 	 */
 	vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 
+	vcpu->mode = IN_GUEST_MODE;
 	do {
 		rc = vcpu_pre_run(vcpu);
 		if (rc)
@@ -3088,6 +3095,7 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 
 		rc = vcpu_post_run(vcpu, exit_reason);
 	} while (!signal_pending(current) && !guestdbg_exit_pending(vcpu) && !rc);
+	vcpu->mode = OUTSIDE_GUEST_MODE;
 
 	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
 	return rc;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 482612b..f80e08a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2205,7 +2205,6 @@ void kvm_vcpu_block(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_block);
 
-#ifndef CONFIG_S390
 void kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
 {
 	struct swait_queue_head *wqp;
@@ -2235,7 +2234,6 @@ void kvm_vcpu_kick(struct kvm_vcpu *vcpu)
 	put_cpu();
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_kick);
-#endif /* !CONFIG_S390 */
 
 int kvm_vcpu_yield_to(struct kvm_vcpu *target)
 {
-- 
2.7.4
