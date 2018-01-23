From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 4/4] KVM: s390: introduce and use kvm_s390_test_cpuflags()
Date: Tue, 23 Jan 2018 18:05:31 +0100
Message-ID: <20180123170531.13687-5-david@redhat.com>
References: <20180123170531.13687-1-david@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180123170531.13687-1-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Use it just like kvm_s390_set_cpuflags() and kvm_s390_clear_cpuflags().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/interrupt.c |  2 +-
 arch/s390/kvm/kvm-s390.c  |  2 +-
 arch/s390/kvm/kvm-s390.h  |  7 ++++++-
 arch/s390/kvm/priv.c      |  4 ++--
 arch/s390/kvm/sigp.c      | 14 +++++---------
 5 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 8687aed9a268..4b483b48436a 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -36,7 +36,7 @@ static int sca_ext_call_pending(struct kvm_vcpu *vcpu, int *src_id)
 {
 	int c, scn;
 
-	if (!(atomic_read(&vcpu->arch.sie_block->cpuflags) & CPUSTAT_ECALL_PEND))
+	if (!kvm_s390_test_cpuflags(vcpu, CPUSTAT_ECALL_PEND))
 		return 0;
 
 	BUG_ON(!kvm_s390_use_sca_entries());
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d27a247799f0..0bd0e284e355 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2905,7 +2905,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 
 static bool ibs_enabled(struct kvm_vcpu *vcpu)
 {
-	return atomic_read(&vcpu->arch.sie_block->cpuflags) & CPUSTAT_IBS;
+	return kvm_s390_test_cpuflags(vcpu, CPUSTAT_IBS);
 }
 
 static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index f727313a706f..f110fa96807e 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -57,9 +57,14 @@ static inline void kvm_s390_clear_cpuflags(struct kvm_vcpu *vcpu, u32 flags)
 	atomic_andnot(flags, &vcpu->arch.sie_block->cpuflags);
 }
 
+static inline bool kvm_s390_test_cpuflags(struct kvm_vcpu *vcpu, u32 flags)
+{
+	return (atomic_read(&vcpu->arch.sie_block->cpuflags) & flags) == flags;
+}
+
 static inline int is_vcpu_stopped(struct kvm_vcpu *vcpu)
 {
-	return atomic_read(&vcpu->arch.sie_block->cpuflags) & CPUSTAT_STOPPED;
+	return kvm_s390_test_cpuflags(vcpu, CPUSTAT_STOPPED);
 }
 
 static inline int is_vcpu_idle(struct kvm_vcpu *vcpu)
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index de4b13eca3ab..c11528faabf1 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -203,13 +203,13 @@ int kvm_s390_skey_check_enable(struct kvm_vcpu *vcpu)
 
 	trace_kvm_s390_skey_related_inst(vcpu);
 	if (!(sie_block->ictl & (ICTL_ISKE | ICTL_SSKE | ICTL_RRBE)) &&
-	    !(atomic_read(&sie_block->cpuflags) & CPUSTAT_KSS))
+	    !kvm_s390_test_cpuflags(vcpu, CPUSTAT_KSS))
 		return rc;
 
 	rc = s390_enable_skey();
 	VCPU_EVENT(vcpu, 3, "enabling storage keys for guest: %d", rc);
 	if (!rc) {
-		if (atomic_read(&sie_block->cpuflags) & CPUSTAT_KSS)
+		if (kvm_s390_test_cpuflags(vcpu, CPUSTAT_KSS))
 			kvm_s390_clear_cpuflags(vcpu, CPUSTAT_KSS);
 		else
 			sie_block->ictl &= ~(ICTL_ISKE | ICTL_SSKE |
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 5cafd1e2651b..683036c1c92a 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -20,19 +20,18 @@
 static int __sigp_sense(struct kvm_vcpu *vcpu, struct kvm_vcpu *dst_vcpu,
 			u64 *reg)
 {
-	int cpuflags;
+	const bool stopped = kvm_s390_test_cpuflags(dst_vcpu, CPUSTAT_STOPPED);
 	int rc;
 	int ext_call_pending;
 
-	cpuflags = atomic_read(&dst_vcpu->arch.sie_block->cpuflags);
 	ext_call_pending = kvm_s390_ext_call_pending(dst_vcpu);
-	if (!(cpuflags & CPUSTAT_STOPPED) && !ext_call_pending)
+	if (!stopped && !ext_call_pending)
 		rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 	else {
 		*reg &= 0xffffffff00000000UL;
 		if (ext_call_pending)
 			*reg |= SIGP_STATUS_EXT_CALL_PENDING;
-		if (cpuflags & CPUSTAT_STOPPED)
+		if (stopped)
 			*reg |= SIGP_STATUS_STOPPED;
 		rc = SIGP_CC_STATUS_STORED;
 	}
@@ -205,11 +204,9 @@ static int __sigp_store_status_at_addr(struct kvm_vcpu *vcpu,
 				       struct kvm_vcpu *dst_vcpu,
 				       u32 addr, u64 *reg)
 {
-	int flags;
 	int rc;
 
-	flags = atomic_read(&dst_vcpu->arch.sie_block->cpuflags);
-	if (!(flags & CPUSTAT_STOPPED)) {
+	if (!kvm_s390_test_cpuflags(dst_vcpu, CPUSTAT_STOPPED)) {
 		*reg &= 0xffffffff00000000UL;
 		*reg |= SIGP_STATUS_INCORRECT_STATE;
 		return SIGP_CC_STATUS_STORED;
@@ -236,8 +233,7 @@ static int __sigp_sense_running(struct kvm_vcpu *vcpu,
 		return SIGP_CC_STATUS_STORED;
 	}
 
-	if (atomic_read(&dst_vcpu->arch.sie_block->cpuflags) &
-	    CPUSTAT_RUNNING) {
+	if (kvm_s390_test_cpuflags(dst_vcpu, CPUSTAT_RUNNING)) {
 		/* running */
 		rc = SIGP_CC_ORDER_CODE_ACCEPTED;
 	} else {
-- 
2.14.3
