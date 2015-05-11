From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 6/9] KVM: s390: provide functions for blocking all CPUs
Date: Mon, 11 May 2015 10:44:34 +0200
Message-ID: <1431333877-28700-7-git-send-email-borntraeger@de.ibm.com>
References: <1431333877-28700-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1431333877-28700-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Some updates to the control blocks need to be done in a way that
ensures that no CPU is within SIE. Provide wrappers around the
s390_vcpu_block functions and adopt the TOD migration code to
update in a guaranteed fashion. Also rename these functions to
have the kvm_s390_ prefix as everything else.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 10 +++++-----
 arch/s390/kvm/kvm-s390.h | 23 +++++++++++++++++++++--
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9bc57af..6bc69ab 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -454,10 +454,10 @@ static int kvm_s390_set_tod_low(struct kvm *kvm, struct kvm_device_attr *attr)
 
 	mutex_lock(&kvm->lock);
 	kvm->arch.epoch = gtod - host_tod;
-	kvm_for_each_vcpu(vcpu_idx, cur_vcpu, kvm) {
+	kvm_s390_vcpu_block_all(kvm);
+	kvm_for_each_vcpu(vcpu_idx, cur_vcpu, kvm)
 		cur_vcpu->arch.sie_block->epoch = kvm->arch.epoch;
-		exit_sie(cur_vcpu);
-	}
+	kvm_s390_vcpu_unblock_all(kvm);
 	mutex_unlock(&kvm->lock);
 	return 0;
 }
@@ -1414,12 +1414,12 @@ int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 	return kvm_s390_vcpu_has_irq(vcpu, 0);
 }
 
-void s390_vcpu_block(struct kvm_vcpu *vcpu)
+void kvm_s390_vcpu_block(struct kvm_vcpu *vcpu)
 {
 	atomic_set_mask(PROG_BLOCK_SIE, &vcpu->arch.sie_block->prog20);
 }
 
-void s390_vcpu_unblock(struct kvm_vcpu *vcpu)
+void kvm_s390_vcpu_unblock(struct kvm_vcpu *vcpu)
 {
 	atomic_clear_mask(PROG_BLOCK_SIE, &vcpu->arch.sie_block->prog20);
 }
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 8edca85..c570478 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -211,8 +211,8 @@ int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr);
 int kvm_s390_vcpu_store_adtl_status(struct kvm_vcpu *vcpu, unsigned long addr);
 void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu);
-void s390_vcpu_block(struct kvm_vcpu *vcpu);
-void s390_vcpu_unblock(struct kvm_vcpu *vcpu);
+void kvm_s390_vcpu_block(struct kvm_vcpu *vcpu);
+void kvm_s390_vcpu_unblock(struct kvm_vcpu *vcpu);
 void exit_sie(struct kvm_vcpu *vcpu);
 void kvm_s390_sync_request(int req, struct kvm_vcpu *vcpu);
 int kvm_s390_vcpu_setup_cmma(struct kvm_vcpu *vcpu);
@@ -228,6 +228,25 @@ int kvm_s390_handle_diag(struct kvm_vcpu *vcpu);
 int kvm_s390_inject_prog_irq(struct kvm_vcpu *vcpu,
 			     struct kvm_s390_pgm_info *pgm_info);
 
+static inline void kvm_s390_vcpu_block_all(struct kvm *kvm)
+{
+	int i;
+	struct kvm_vcpu *vcpu;
+
+	WARN_ON(!mutex_is_locked(&kvm->lock));
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		kvm_s390_vcpu_block(vcpu);
+}
+
+static inline void kvm_s390_vcpu_unblock_all(struct kvm *kvm)
+{
+	int i;
+	struct kvm_vcpu *vcpu;
+
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		kvm_s390_vcpu_unblock(vcpu);
+}
+
 /**
  * kvm_s390_inject_prog_cond - conditionally inject a program check
  * @vcpu: virtual cpu
-- 
2.3.0
