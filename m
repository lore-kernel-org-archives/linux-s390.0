From: David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 3/4] KVM: s390: introduce and use kvm_s390_clear_cpuflags()
Date: Tue, 23 Jan 2018 18:05:30 +0100
Message-ID: <20180123170531.13687-4-david@redhat.com>
References: <20180123170531.13687-1-david@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180123170531.13687-1-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Use it just like kvm_s390_set_cpuflags().

Suggested-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/interrupt.c |  8 ++++----
 arch/s390/kvm/kvm-s390.c  | 11 +++++------
 arch/s390/kvm/kvm-s390.h  |  5 +++++
 arch/s390/kvm/priv.c      |  2 +-
 arch/s390/kvm/vsie.c      |  2 +-
 5 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 404a127b1921..8687aed9a268 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -111,7 +111,7 @@ static void sca_clear_ext_call(struct kvm_vcpu *vcpu)
 
 	if (!kvm_s390_use_sca_entries())
 		return;
-	atomic_andnot(CPUSTAT_ECALL_PEND, &vcpu->arch.sie_block->cpuflags);
+	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_ECALL_PEND);
 	read_lock(&vcpu->kvm->arch.sca_lock);
 	if (vcpu->kvm->arch.use_esca) {
 		struct esca_block *sca = vcpu->kvm->arch.sca;
@@ -283,14 +283,14 @@ static void __set_cpu_idle(struct kvm_vcpu *vcpu)
 
 static void __unset_cpu_idle(struct kvm_vcpu *vcpu)
 {
-	atomic_andnot(CPUSTAT_WAIT, &vcpu->arch.sie_block->cpuflags);
+	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_WAIT);
 	clear_bit(vcpu->vcpu_id, vcpu->kvm->arch.float_int.idle_mask);
 }
 
 static void __reset_intercept_indicators(struct kvm_vcpu *vcpu)
 {
-	atomic_andnot(CPUSTAT_IO_INT | CPUSTAT_EXT_INT | CPUSTAT_STOP_INT,
-		    &vcpu->arch.sie_block->cpuflags);
+	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_IO_INT | CPUSTAT_EXT_INT |
+				      CPUSTAT_STOP_INT);
 	vcpu->arch.sie_block->lctl = 0x0000;
 	vcpu->arch.sie_block->ictl &= ~(ICTL_LPSW | ICTL_STCTL | ICTL_PINT);
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 5680b12add68..d27a247799f0 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2327,7 +2327,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	vcpu->cpu = -1;
 	if (vcpu->arch.cputm_enabled && !is_vcpu_idle(vcpu))
 		__stop_cpu_timer_accounting(vcpu);
-	atomic_andnot(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
+	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_RUNNING);
 	vcpu->arch.enabled_gmap = gmap_get_enabled();
 	gmap_disable(vcpu->arch.enabled_gmap);
 
@@ -2845,14 +2845,14 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 		if (dbg->control & KVM_GUESTDBG_USE_HW_BP)
 			rc = kvm_s390_import_bp_data(vcpu, dbg);
 	} else {
-		atomic_andnot(CPUSTAT_P, &vcpu->arch.sie_block->cpuflags);
+		kvm_s390_clear_cpuflags(vcpu, CPUSTAT_P);
 		vcpu->arch.guestdbg.last_bp = 0;
 	}
 
 	if (rc) {
 		vcpu->guest_debug = 0;
 		kvm_s390_clear_bp_data(vcpu);
-		atomic_andnot(CPUSTAT_P, &vcpu->arch.sie_block->cpuflags);
+		kvm_s390_clear_cpuflags(vcpu, CPUSTAT_P);
 	}
 
 out:
@@ -2949,8 +2949,7 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 	if (kvm_check_request(KVM_REQ_DISABLE_IBS, vcpu)) {
 		if (ibs_enabled(vcpu)) {
 			trace_kvm_s390_enable_disable_ibs(vcpu->vcpu_id, 0);
-			atomic_andnot(CPUSTAT_IBS,
-					  &vcpu->arch.sie_block->cpuflags);
+			kvm_s390_clear_cpuflags(vcpu, CPUSTAT_IBS);
 		}
 		goto retry;
 	}
@@ -3600,7 +3599,7 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 		__disable_ibs_on_all_vcpus(vcpu->kvm);
 	}
 
-	atomic_andnot(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
+	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_STOPPED);
 	/*
 	 * Another VCPU might have used IBS while we were offline.
 	 * Let's play safe and flush the VCPU at startup.
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index a9f2c8d1833d..f727313a706f 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -52,6 +52,11 @@ static inline void kvm_s390_set_cpuflags(struct kvm_vcpu *vcpu, u32 flags)
 	atomic_or(flags, &vcpu->arch.sie_block->cpuflags);
 }
 
+static inline void kvm_s390_clear_cpuflags(struct kvm_vcpu *vcpu, u32 flags)
+{
+	atomic_andnot(flags, &vcpu->arch.sie_block->cpuflags);
+}
+
 static inline int is_vcpu_stopped(struct kvm_vcpu *vcpu)
 {
 	return atomic_read(&vcpu->arch.sie_block->cpuflags) & CPUSTAT_STOPPED;
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 572496c688cc..de4b13eca3ab 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -210,7 +210,7 @@ int kvm_s390_skey_check_enable(struct kvm_vcpu *vcpu)
 	VCPU_EVENT(vcpu, 3, "enabling storage keys for guest: %d", rc);
 	if (!rc) {
 		if (atomic_read(&sie_block->cpuflags) & CPUSTAT_KSS)
-			atomic_andnot(CPUSTAT_KSS, &sie_block->cpuflags);
+			kvm_s390_clear_cpuflags(vcpu, CPUSTAT_KSS);
 		else
 			sie_block->ictl &= ~(ICTL_ISKE | ICTL_SSKE |
 					     ICTL_RRBE);
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 902b5befb691..35c94b6632db 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -916,7 +916,7 @@ static void register_shadow_scb(struct kvm_vcpu *vcpu,
  */
 static void unregister_shadow_scb(struct kvm_vcpu *vcpu)
 {
-	atomic_andnot(CPUSTAT_WAIT, &vcpu->arch.sie_block->cpuflags);
+	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_WAIT);
 	WRITE_ONCE(vcpu->arch.vsie_block, NULL);
 }
 
-- 
2.14.3
