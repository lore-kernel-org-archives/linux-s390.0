From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4/8] KVM: s390: Lock kvm->srcu at the appropriate places
Date: Thu, 12 Sep 2013 10:33:45 +0200
Message-ID: <1378974829-46578-5-git-send-email-borntraeger@de.ibm.com>
References: <1378974829-46578-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1378974829-46578-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Thomas Huth <thuth@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

The kvm->srcu lock has to be held while accessing the memory of
guests and during certain other actions. This patch now adds
the locks to the __vcpu_run function so that all affected code
is protected now (and additionally to the KVM_S390_STORE_STATUS
ioctl, which can be called out-of-band and needs a separate lock).

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/diag.c      |  4 +---
 arch/s390/kvm/interrupt.c |  3 +++
 arch/s390/kvm/kvm-s390.c  | 12 ++++++++++++
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 3a74d8a..78d967f 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -107,14 +107,13 @@ static int __diag_ipl_functions(struct kvm_vcpu *vcpu)
 
 static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
 {
-	int ret, idx;
+	int ret;
 
 	/* No virtio-ccw notification? Get out quickly. */
 	if (!vcpu->kvm->arch.css_support ||
 	    (vcpu->run->s.regs.gprs[1] != KVM_S390_VIRTIO_CCW_NOTIFY))
 		return -EOPNOTSUPP;
 
-	idx = srcu_read_lock(&vcpu->kvm->srcu);
 	/*
 	 * The layout is as follows:
 	 * - gpr 2 contains the subchannel id (passed as addr)
@@ -125,7 +124,6 @@ static int __diag_virtio_hypercall(struct kvm_vcpu *vcpu)
 				      vcpu->run->s.regs.gprs[2],
 				      8, &vcpu->run->s.regs.gprs[3],
 				      vcpu->run->s.regs.gprs[4]);
-	srcu_read_unlock(&vcpu->kvm->srcu, idx);
 
 	/*
 	 * Return cookie in gpr 2, but don't overwrite the register if the
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 7f35cb3..e7323cd 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -436,6 +436,7 @@ int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
 	hrtimer_start(&vcpu->arch.ckc_timer, ktime_set (0, sltime) , HRTIMER_MODE_REL);
 	VCPU_EVENT(vcpu, 5, "enabled wait via clock comparator: %llx ns", sltime);
 no_timer:
+	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
 	spin_lock(&vcpu->arch.local_int.float_int->lock);
 	spin_lock_bh(&vcpu->arch.local_int.lock);
 	add_wait_queue(&vcpu->wq, &wait);
@@ -455,6 +456,8 @@ no_timer:
 	remove_wait_queue(&vcpu->wq, &wait);
 	spin_unlock_bh(&vcpu->arch.local_int.lock);
 	spin_unlock(&vcpu->arch.local_int.float_int->lock);
+	vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
+
 	hrtimer_try_to_cancel(&vcpu->arch.ckc_timer);
 	return 0;
 }
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8eec7ab..1e4e7b9 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -752,11 +752,18 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 {
 	int rc, exit_reason;
 
+	/*
+	 * We try to hold kvm->srcu during most of vcpu_run (except when run-
+	 * ning the guest), so that memslots (and other stuff) are protected
+	 */
+	vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
+
 	do {
 		rc = vcpu_pre_run(vcpu);
 		if (rc)
 			break;
 
+		srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
 		/*
 		 * As PF_VCPU will be used in fault handler, between
 		 * guest_enter and guest_exit should be no uaccess.
@@ -767,10 +774,12 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 		exit_reason = sie64a(vcpu->arch.sie_block,
 				     vcpu->run->s.regs.gprs);
 		kvm_guest_exit();
+		vcpu->srcu_idx = srcu_read_lock(&vcpu->kvm->srcu);
 
 		rc = vcpu_post_run(vcpu, exit_reason);
 	} while (!signal_pending(current) && !rc);
 
+	srcu_read_unlock(&vcpu->kvm->srcu, vcpu->srcu_idx);
 	return rc;
 }
 
@@ -968,6 +977,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 {
 	struct kvm_vcpu *vcpu = filp->private_data;
 	void __user *argp = (void __user *)arg;
+	int idx;
 	long r;
 
 	switch (ioctl) {
@@ -981,7 +991,9 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		break;
 	}
 	case KVM_S390_STORE_STATUS:
+		idx = srcu_read_lock(&vcpu->kvm->srcu);
 		r = kvm_s390_vcpu_store_status(vcpu, arg);
+		srcu_read_unlock(&vcpu->kvm->srcu, idx);
 		break;
 	case KVM_S390_SET_INITIAL_PSW: {
 		psw_t psw;
-- 
1.8.3.1
