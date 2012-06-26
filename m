From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 5/6] KVM: s390: use sigp condition code defines
Date: Tue, 26 Jun 2012 16:06:40 +0200
Message-ID: <1340719601-11867-6-git-send-email-cornelia.huck@de.ibm.com>
References: <1340719601-11867-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1340719601-11867-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Just use the defines instead of using plain numbers and adding
a comment behind each line.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/sigp.c |   58 +++++++++++++++++++++++++-------------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index ca544d5..97c9f36 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -26,19 +26,19 @@ static int __sigp_sense(struct kvm_vcpu *vcpu, u16 cpu_addr,
 	int rc;
 
 	if (cpu_addr >= KVM_MAX_VCPUS)
-		return 3; /* not operational */
+		return SIGP_CC_NOT_OPERATIONAL;
 
 	spin_lock(&fi->lock);
 	if (fi->local_int[cpu_addr] == NULL)
-		rc = 3; /* not operational */
+		rc = SIGP_CC_NOT_OPERATIONAL;
 	else if (!(atomic_read(fi->local_int[cpu_addr]->cpuflags)
 		  & CPUSTAT_STOPPED)) {
 		*reg &= 0xffffffff00000000UL;
-		rc = 1; /* status stored */
+		rc = SIGP_CC_STATUS_STORED;
 	} else {
 		*reg &= 0xffffffff00000000UL;
 		*reg |= SIGP_STATUS_STOPPED;
-		rc = 1; /* status stored */
+		rc = SIGP_CC_STATUS_STORED;
 	}
 	spin_unlock(&fi->lock);
 
@@ -54,7 +54,7 @@ static int __sigp_emergency(struct kvm_vcpu *vcpu, u16 cpu_addr)
 	int rc;
 
 	if (cpu_addr >= KVM_MAX_VCPUS)
-		return 3; /* not operational */
+		return SIGP_CC_NOT_OPERATIONAL;
 
 	inti = kzalloc(sizeof(*inti), GFP_KERNEL);
 	if (!inti)
@@ -66,7 +66,7 @@ static int __sigp_emergency(struct kvm_vcpu *vcpu, u16 cpu_addr)
 	spin_lock(&fi->lock);
 	li = fi->local_int[cpu_addr];
 	if (li == NULL) {
-		rc = 3; /* not operational */
+		rc = SIGP_CC_NOT_OPERATIONAL;
 		kfree(inti);
 		goto unlock;
 	}
@@ -77,7 +77,7 @@ static int __sigp_emergency(struct kvm_vcpu *vcpu, u16 cpu_addr)
 	if (waitqueue_active(&li->wq))
 		wake_up_interruptible(&li->wq);
 	spin_unlock_bh(&li->lock);
-	rc = 0; /* order accepted */
+	rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 	VCPU_EVENT(vcpu, 4, "sent sigp emerg to cpu %x", cpu_addr);
 unlock:
 	spin_unlock(&fi->lock);
@@ -92,7 +92,7 @@ static int __sigp_external_call(struct kvm_vcpu *vcpu, u16 cpu_addr)
 	int rc;
 
 	if (cpu_addr >= KVM_MAX_VCPUS)
-		return 3; /* not operational */
+		return SIGP_CC_NOT_OPERATIONAL;
 
 	inti = kzalloc(sizeof(*inti), GFP_KERNEL);
 	if (!inti)
@@ -104,7 +104,7 @@ static int __sigp_external_call(struct kvm_vcpu *vcpu, u16 cpu_addr)
 	spin_lock(&fi->lock);
 	li = fi->local_int[cpu_addr];
 	if (li == NULL) {
-		rc = 3; /* not operational */
+		rc = SIGP_CC_NOT_OPERATIONAL;
 		kfree(inti);
 		goto unlock;
 	}
@@ -115,7 +115,7 @@ static int __sigp_external_call(struct kvm_vcpu *vcpu, u16 cpu_addr)
 	if (waitqueue_active(&li->wq))
 		wake_up_interruptible(&li->wq);
 	spin_unlock_bh(&li->lock);
-	rc = 0; /* order accepted */
+	rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 	VCPU_EVENT(vcpu, 4, "sent sigp ext call to cpu %x", cpu_addr);
 unlock:
 	spin_unlock(&fi->lock);
@@ -143,7 +143,7 @@ static int __inject_sigp_stop(struct kvm_s390_local_interrupt *li, int action)
 out:
 	spin_unlock_bh(&li->lock);
 
-	return 0; /* order accepted */
+	return SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
 static int __sigp_stop(struct kvm_vcpu *vcpu, u16 cpu_addr, int action)
@@ -153,12 +153,12 @@ static int __sigp_stop(struct kvm_vcpu *vcpu, u16 cpu_addr, int action)
 	int rc;
 
 	if (cpu_addr >= KVM_MAX_VCPUS)
-		return 3; /* not operational */
+		return SIGP_CC_NOT_OPERATIONAL;
 
 	spin_lock(&fi->lock);
 	li = fi->local_int[cpu_addr];
 	if (li == NULL) {
-		rc = 3; /* not operational */
+		rc = SIGP_CC_NOT_OPERATIONAL;
 		goto unlock;
 	}
 
@@ -182,11 +182,11 @@ static int __sigp_set_arch(struct kvm_vcpu *vcpu, u32 parameter)
 
 	switch (parameter & 0xff) {
 	case 0:
-		rc = 3; /* not operational */
+		rc = SIGP_CC_NOT_OPERATIONAL;
 		break;
 	case 1:
 	case 2:
-		rc = 0; /* order accepted */
+		rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 		break;
 	default:
 		rc = -EOPNOTSUPP;
@@ -209,12 +209,12 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 	   copy_from_guest_absolute(vcpu, &tmp, address + PAGE_SIZE, 1)) {
 		*reg &= 0xffffffff00000000UL;
 		*reg |= SIGP_STATUS_INVALID_PARAMETER;
-		return 1; /* invalid parameter */
+		return SIGP_CC_STATUS_STORED;
 	}
 
 	inti = kzalloc(sizeof(*inti), GFP_KERNEL);
 	if (!inti)
-		return 2; /* busy */
+		return SIGP_CC_BUSY;
 
 	spin_lock(&fi->lock);
 	if (cpu_addr < KVM_MAX_VCPUS)
@@ -223,7 +223,7 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 	if (li == NULL) {
 		*reg &= 0xffffffff00000000UL;
 		*reg |= SIGP_STATUS_INCORRECT_STATE;
-		rc = 1; /* incorrect state */
+		rc = SIGP_CC_STATUS_STORED;
 		kfree(inti);
 		goto out_fi;
 	}
@@ -233,7 +233,7 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 	if (!(atomic_read(li->cpuflags) & CPUSTAT_STOPPED)) {
 		*reg &= 0xffffffff00000000UL;
 		*reg |= SIGP_STATUS_INCORRECT_STATE;
-		rc = 1; /* incorrect state */
+		rc = SIGP_CC_STATUS_STORED;
 		kfree(inti);
 		goto out_li;
 	}
@@ -245,7 +245,7 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 	atomic_set(&li->active, 1);
 	if (waitqueue_active(&li->wq))
 		wake_up_interruptible(&li->wq);
-	rc = 0; /* order accepted */
+	rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 
 	VCPU_EVENT(vcpu, 4, "set prefix of cpu %02x to %x", cpu_addr, address);
 out_li:
@@ -262,21 +262,21 @@ static int __sigp_sense_running(struct kvm_vcpu *vcpu, u16 cpu_addr,
 	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
 
 	if (cpu_addr >= KVM_MAX_VCPUS)
-		return 3; /* not operational */
+		return SIGP_CC_NOT_OPERATIONAL;
 
 	spin_lock(&fi->lock);
 	if (fi->local_int[cpu_addr] == NULL)
-		rc = 3; /* not operational */
+		rc = SIGP_CC_NOT_OPERATIONAL;
 	else {
 		if (atomic_read(fi->local_int[cpu_addr]->cpuflags)
 		    & CPUSTAT_RUNNING) {
 			/* running */
-			rc = 0;
+			rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 		} else {
 			/* not running */
 			*reg &= 0xffffffff00000000UL;
 			*reg |= SIGP_STATUS_NOT_RUNNING;
-			rc = 1;
+			rc = SIGP_CC_STATUS_STORED;
 		}
 	}
 	spin_unlock(&fi->lock);
@@ -289,23 +289,23 @@ static int __sigp_sense_running(struct kvm_vcpu *vcpu, u16 cpu_addr,
 
 static int __sigp_restart(struct kvm_vcpu *vcpu, u16 cpu_addr)
 {
-	int rc = 0;
 	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
 	struct kvm_s390_local_interrupt *li;
+	int rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 
 	if (cpu_addr >= KVM_MAX_VCPUS)
-		return 3; /* not operational */
+		return SIGP_CC_NOT_OPERATIONAL;
 
 	spin_lock(&fi->lock);
 	li = fi->local_int[cpu_addr];
 	if (li == NULL) {
-		rc = 3; /* not operational */
+		rc = SIGP_CC_NOT_OPERATIONAL;
 		goto out;
 	}
 
 	spin_lock_bh(&li->lock);
 	if (li->action_bits & ACTION_STOP_ON_STOP)
-		rc = 2; /* busy */
+		rc = SIGP_CC_BUSY;
 	else
 		VCPU_EVENT(vcpu, 4, "sigp restart %x to handle userspace",
 			cpu_addr);
@@ -380,7 +380,7 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
 	case SIGP_RESTART:
 		vcpu->stat.instruction_sigp_restart++;
 		rc = __sigp_restart(vcpu, cpu_addr);
-		if (rc == 2) /* busy */
+		if (rc == SIGP_CC_BUSY)
 			break;
 		/* user space must know about restart */
 	default:
-- 
1.7.10.4
