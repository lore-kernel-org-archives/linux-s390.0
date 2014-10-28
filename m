From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 5/9] KVM: s390: sigp: move target cpu checks into dispatcher
Date: Tue, 28 Oct 2014 20:39:55 +0100
Message-ID: <1414525199-53989-6-git-send-email-borntraeger@de.ibm.com>
References: <1414525199-53989-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1414525199-53989-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

All sigp orders targeting one VCPU have to verify that the target is valid and
available.

Let's move the check from the single functions to the dispatcher. The
destination VCPU is directly passed as a pointer - instead of the cpu address of
the target.

Please note that all SIGP orders except SIGP SET ARCHITECTURE - even unknown
ones - will now check for the availability of the target VCPU. This is what the
architecture documentation specifies.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/sigp.c | 139 ++++++++++++++++++---------------------------------
 1 file changed, 48 insertions(+), 91 deletions(-)

diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 5e259bd..660a945 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -20,20 +20,13 @@
 #include "kvm-s390.h"
 #include "trace.h"
 
-static int __sigp_sense(struct kvm_vcpu *vcpu, u16 cpu_addr,
+static int __sigp_sense(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
 			u64 *reg)
 {
 	struct kvm_s390_local_interrupt *li;
-	struct kvm_vcpu *dst_vcpu = NULL;
 	int cpuflags;
 	int rc;
 
-	if (cpu_addr >= KVM_MAX_VCPUS)
-		return SIGP_CC_NOT_OPERATIONAL;
-
-	dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
-	if (!dst_vcpu)
-		return SIGP_CC_NOT_OPERATIONAL;
 	li = &dst_vcpu->arch.local_int;
 
 	cpuflags = atomic_read(li->cpuflags);
@@ -48,44 +41,36 @@ static int __sigp_sense(struct kvm_vcpu *vcpu, u16 cpu_addr,
 		rc = SIGP_CC_STATUS_STORED;
 	}
 
-	VCPU_EVENT(vcpu, 4, "sensed status of cpu %x rc %x", cpu_addr, rc);
+	VCPU_EVENT(vcpu, 4, "sensed status of cpu %x rc %x", dst_vcpu->vcpu_id,
+		   rc);
 	return rc;
 }
 
-static int __sigp_emergency(struct kvm_vcpu *vcpu, u16 cpu_addr)
+static int __sigp_emergency(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu)
 {
 	struct kvm_s390_interrupt s390int = {
 		.type = KVM_S390_INT_EMERGENCY,
 		.parm = vcpu->vcpu_id,
 	};
-	struct kvm_vcpu *dst_vcpu = NULL;
 	int rc = 0;
 
-	if (cpu_addr < KVM_MAX_VCPUS)
-		dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
-	if (!dst_vcpu)
-		return SIGP_CC_NOT_OPERATIONAL;
-
 	rc = kvm_s390_inject_vcpu(dst_vcpu, &s390int);
 	if (!rc)
-		VCPU_EVENT(vcpu, 4, "sent sigp emerg to cpu %x", cpu_addr);
+		VCPU_EVENT(vcpu, 4, "sent sigp emerg to cpu %x",
+			   dst_vcpu->vcpu_id);
 
 	return rc ? rc : SIGP_CC_ORDER_CODE_ACCEPTED;
 }
 
-static int __sigp_conditional_emergency(struct kvm_vcpu *vcpu, u16 cpu_addr,
+static int __sigp_conditional_emergency(struct kvm_vcpu *vcpu,
+					struct kvm_vcpu *dst_vcpu,
 					u16 asn, u64 *reg)
 {
-	struct kvm_vcpu *dst_vcpu = NULL;
 	const u64 psw_int_mask = PSW_MASK_IO | PSW_MASK_EXT;
 	u16 p_asn, s_asn;
 	psw_t *psw;
 	u32 flags;
 
-	if (cpu_addr < KVM_MAX_VCPUS)
-		dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
-	if (!dst_vcpu)
-		return SIGP_CC_NOT_OPERATIONAL;
 	flags = atomic_read(&dst_vcpu->arch.sie_block->cpuflags);
 	psw = &dst_vcpu->arch.sie_block->gpsw;
 	p_asn = dst_vcpu->arch.sie_block->gcr[4] & 0xffff;  /* Primary ASN */
@@ -96,7 +81,7 @@ static int __sigp_conditional_emergency(struct kvm_vcpu *vcpu, u16 cpu_addr,
 	    || (psw->mask & psw_int_mask) != psw_int_mask
 	    || ((flags & CPUSTAT_WAIT) && psw->addr != 0)
 	    || (!(flags & CPUSTAT_WAIT) && (asn == p_asn || asn == s_asn))) {
-		return __sigp_emergency(vcpu, cpu_addr);
+		return __sigp_emergency(vcpu, dst_vcpu);
 	} else {
 		*reg &= 0xffffffff00000000UL;
 		*reg |= SIGP_STATUS_INCORRECT_STATE;
@@ -104,23 +89,19 @@ static int __sigp_conditional_emergency(struct kvm_vcpu *vcpu, u16 cpu_addr,
 	}
 }
 
-static int __sigp_external_call(struct kvm_vcpu *vcpu, u16 cpu_addr)
+static int __sigp_external_call(struct kvm_vcpu *vcpu,
+				struct kvm_vcpu *dst_vcpu)
 {
 	struct kvm_s390_interrupt s390int = {
 		.type = KVM_S390_INT_EXTERNAL_CALL,
 		.parm = vcpu->vcpu_id,
 	};
-	struct kvm_vcpu *dst_vcpu = NULL;
 	int rc;
 
-	if (cpu_addr < KVM_MAX_VCPUS)
-		dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
-	if (!dst_vcpu)
-		return SIGP_CC_NOT_OPERATIONAL;
-
 	rc = kvm_s390_inject_vcpu(dst_vcpu, &s390int);
 	if (!rc)
-		VCPU_EVENT(vcpu, 4, "sent sigp ext call to cpu %x", cpu_addr);
+		VCPU_EVENT(vcpu, 4, "sent sigp ext call to cpu %x",
+			   dst_vcpu->vcpu_id);
 
 	return rc ? rc : SIGP_CC_ORDER_CODE_ACCEPTED;
 }
@@ -160,21 +141,13 @@ out:
 	return rc;
 }
 
-static int __sigp_stop(struct kvm_vcpu *vcpu, u16 cpu_addr, int action)
+static int __sigp_stop(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
+		       int action)
 {
-	struct kvm_vcpu *dst_vcpu = NULL;
 	int rc;
 
-	if (cpu_addr >= KVM_MAX_VCPUS)
-		return SIGP_CC_NOT_OPERATIONAL;
-
-	dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
-	if (!dst_vcpu)
-		return SIGP_CC_NOT_OPERATIONAL;
-
 	rc = __inject_sigp_stop(dst_vcpu, action);
-
-	VCPU_EVENT(vcpu, 4, "sent sigp stop to cpu %x", cpu_addr);
+	VCPU_EVENT(vcpu, 4, "sent sigp stop to cpu %x", dst_vcpu->vcpu_id);
 
 	if ((action & ACTION_STORE_ON_STOP) != 0 && rc == -ESHUTDOWN) {
 		/* If the CPU has already been stopped, we still have
@@ -212,18 +185,13 @@ static int __sigp_set_arch(struct kvm_vcpu *vcpu, u32 parameter)
 	return rc;
 }
 
-static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
-			     u64 *reg)
+static int __sigp_set_prefix(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
+			     u32 address, u64 *reg)
 {
 	struct kvm_s390_local_interrupt *li;
-	struct kvm_vcpu *dst_vcpu = NULL;
 	struct kvm_s390_interrupt_info *inti;
 	int rc;
 
-	if (cpu_addr < KVM_MAX_VCPUS)
-		dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
-	if (!dst_vcpu)
-		return SIGP_CC_NOT_OPERATIONAL;
 	li = &dst_vcpu->arch.local_int;
 
 	/*
@@ -260,24 +228,20 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 	kvm_s390_vcpu_wakeup(dst_vcpu);
 	rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 
-	VCPU_EVENT(vcpu, 4, "set prefix of cpu %02x to %x", cpu_addr, address);
+	VCPU_EVENT(vcpu, 4, "set prefix of cpu %02x to %x", dst_vcpu->vcpu_id,
+		   address);
 out_li:
 	spin_unlock(&li->lock);
 	return rc;
 }
 
-static int __sigp_store_status_at_addr(struct kvm_vcpu *vcpu, u16 cpu_id,
-					u32 addr, u64 *reg)
+static int __sigp_store_status_at_addr(struct kvm_vcpu *vcpu,
+				       struct kvm_vcpu *dst_vcpu,
+				       u32 addr, u64 *reg)
 {
-	struct kvm_vcpu *dst_vcpu = NULL;
 	int flags;
 	int rc;
 
-	if (cpu_id < KVM_MAX_VCPUS)
-		dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_id);
-	if (!dst_vcpu)
-		return SIGP_CC_NOT_OPERATIONAL;
-
 	spin_lock(&dst_vcpu->arch.local_int.lock);
 	flags = atomic_read(dst_vcpu->arch.local_int.cpuflags);
 	spin_unlock(&dst_vcpu->arch.local_int.lock);
@@ -297,19 +261,12 @@ static int __sigp_store_status_at_addr(struct kvm_vcpu *vcpu, u16 cpu_id,
 	return rc;
 }
 
-static int __sigp_sense_running(struct kvm_vcpu *vcpu, u16 cpu_addr,
-				u64 *reg)
+static int __sigp_sense_running(struct kvm_vcpu *vcpu,
+				struct kvm_vcpu *dst_vcpu, u64 *reg)
 {
 	struct kvm_s390_local_interrupt *li;
-	struct kvm_vcpu *dst_vcpu = NULL;
 	int rc;
 
-	if (cpu_addr >= KVM_MAX_VCPUS)
-		return SIGP_CC_NOT_OPERATIONAL;
-
-	dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
-	if (!dst_vcpu)
-		return SIGP_CC_NOT_OPERATIONAL;
 	li = &dst_vcpu->arch.local_int;
 	if (atomic_read(li->cpuflags) & CPUSTAT_RUNNING) {
 		/* running */
@@ -321,26 +278,18 @@ static int __sigp_sense_running(struct kvm_vcpu *vcpu, u16 cpu_addr,
 		rc = SIGP_CC_STATUS_STORED;
 	}
 
-	VCPU_EVENT(vcpu, 4, "sensed running status of cpu %x rc %x", cpu_addr,
-		   rc);
+	VCPU_EVENT(vcpu, 4, "sensed running status of cpu %x rc %x",
+		   dst_vcpu->vcpu_id, rc);
 
 	return rc;
 }
 
 /* Test whether the destination CPU is available and not busy */
-static int sigp_check_callable(struct kvm_vcpu *vcpu, u16 cpu_addr)
+static int sigp_check_callable(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu)
 {
-	struct kvm_s390_local_interrupt *li;
+	struct kvm_s390_local_interrupt *li = &dst_vcpu->arch.local_int;
 	int rc = SIGP_CC_ORDER_CODE_ACCEPTED;
-	struct kvm_vcpu *dst_vcpu = NULL;
 
-	if (cpu_addr >= KVM_MAX_VCPUS)
-		return SIGP_CC_NOT_OPERATIONAL;
-
-	dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
-	if (!dst_vcpu)
-		return SIGP_CC_NOT_OPERATIONAL;
-	li = &dst_vcpu->arch.local_int;
 	spin_lock(&li->lock);
 	if (li->action_bits & ACTION_STOP_ON_STOP)
 		rc = SIGP_CC_BUSY;
@@ -353,53 +302,61 @@ static int handle_sigp_dst(struct kvm_vcpu *vcpu, u8 order_code,
 			   u16 cpu_addr, u32 parameter, u64 *status_reg)
 {
 	int rc;
+	struct kvm_vcpu *dst_vcpu;
+
+	if (cpu_addr >= KVM_MAX_VCPUS)
+		return SIGP_CC_NOT_OPERATIONAL;
+
+	dst_vcpu = kvm_get_vcpu(vcpu->kvm, cpu_addr);
+	if (!dst_vcpu)
+		return SIGP_CC_NOT_OPERATIONAL;
 
 	switch (order_code) {
 	case SIGP_SENSE:
 		vcpu->stat.instruction_sigp_sense++;
-		rc = __sigp_sense(vcpu, cpu_addr, status_reg);
+		rc = __sigp_sense(vcpu, dst_vcpu, status_reg);
 		break;
 	case SIGP_EXTERNAL_CALL:
 		vcpu->stat.instruction_sigp_external_call++;
-		rc = __sigp_external_call(vcpu, cpu_addr);
+		rc = __sigp_external_call(vcpu, dst_vcpu);
 		break;
 	case SIGP_EMERGENCY_SIGNAL:
 		vcpu->stat.instruction_sigp_emergency++;
-		rc = __sigp_emergency(vcpu, cpu_addr);
+		rc = __sigp_emergency(vcpu, dst_vcpu);
 		break;
 	case SIGP_STOP:
 		vcpu->stat.instruction_sigp_stop++;
-		rc = __sigp_stop(vcpu, cpu_addr, ACTION_STOP_ON_STOP);
+		rc = __sigp_stop(vcpu, dst_vcpu, ACTION_STOP_ON_STOP);
 		break;
 	case SIGP_STOP_AND_STORE_STATUS:
 		vcpu->stat.instruction_sigp_stop++;
-		rc = __sigp_stop(vcpu, cpu_addr, ACTION_STORE_ON_STOP |
+		rc = __sigp_stop(vcpu, dst_vcpu, ACTION_STORE_ON_STOP |
 						 ACTION_STOP_ON_STOP);
 		break;
 	case SIGP_STORE_STATUS_AT_ADDRESS:
-		rc = __sigp_store_status_at_addr(vcpu, cpu_addr, parameter,
+		rc = __sigp_store_status_at_addr(vcpu, dst_vcpu, parameter,
 						 status_reg);
 		break;
 	case SIGP_SET_PREFIX:
 		vcpu->stat.instruction_sigp_prefix++;
-		rc = __sigp_set_prefix(vcpu, cpu_addr, parameter, status_reg);
+		rc = __sigp_set_prefix(vcpu, dst_vcpu, parameter, status_reg);
 		break;
 	case SIGP_COND_EMERGENCY_SIGNAL:
-		rc = __sigp_conditional_emergency(vcpu, cpu_addr, parameter,
+		rc = __sigp_conditional_emergency(vcpu, dst_vcpu, parameter,
 						  status_reg);
 		break;
 	case SIGP_SENSE_RUNNING:
 		vcpu->stat.instruction_sigp_sense_running++;
-		rc = __sigp_sense_running(vcpu, cpu_addr, status_reg);
+		rc = __sigp_sense_running(vcpu, dst_vcpu, status_reg);
 		break;
 	case SIGP_START:
-		rc = sigp_check_callable(vcpu, cpu_addr);
+		rc = sigp_check_callable(vcpu, dst_vcpu);
 		if (rc == SIGP_CC_ORDER_CODE_ACCEPTED)
 			rc = -EOPNOTSUPP;    /* Handle START in user space */
 		break;
 	case SIGP_RESTART:
 		vcpu->stat.instruction_sigp_restart++;
-		rc = sigp_check_callable(vcpu, cpu_addr);
+		rc = sigp_check_callable(vcpu, dst_vcpu);
 		if (rc == SIGP_CC_ORDER_CODE_ACCEPTED) {
 			VCPU_EVENT(vcpu, 4,
 				   "sigp restart %x to handle userspace",
-- 
1.9.3
