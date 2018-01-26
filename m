From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 09/22] KVM: s390: introduce and use kvm_s390_clear_cpuflags()
Date: Fri, 26 Jan 2018 16:53:21 +0100
Message-ID: <20180126155334.52956-10-borntraeger@de.ibm.com>
References: <20180126155334.52956-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180126155334.52956-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <david@redhat.com>

Use it just like kvm_s390_set_cpuflags().

Suggested-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180123170531.13687-4-david@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c |  8 ++++----
 arch/s390/kvm/kvm-s390.c  | 11 +++++------
 arch/s390/kvm/kvm-s390.h  |  5 +++++
 arch/s390/kvm/priv.c      |  2 +-
 arch/s390/kvm/vsie.c      |  2 +-
 5 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 404a127b1921a..8687aed9a268f 100644
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
index 9dc996acb52cf..3eb97c4212cf6 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2340,7 +2340,7 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	vcpu->cpu = -1;
 	if (vcpu->arch.cputm_enabled && !is_vcpu_idle(vcpu))
 		__stop_cpu_timer_accounting(vcpu);
-	atomic_andnot(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
+	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_RUNNING);
 	vcpu->arch.enabled_gmap = gmap_get_enabled();
 	gmap_disable(vcpu->arch.enabled_gmap);
 
@@ -2827,14 +2827,14 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
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
 
 	return rc;
@@ -2919,8 +2919,7 @@ static int kvm_s390_handle_requests(struct kvm_vcpu *vcpu)
 	if (kvm_check_request(KVM_REQ_DISABLE_IBS, vcpu)) {
 		if (ibs_enabled(vcpu)) {
 			trace_kvm_s390_enable_disable_ibs(vcpu->vcpu_id, 0);
-			atomic_andnot(CPUSTAT_IBS,
-					  &vcpu->arch.sie_block->cpuflags);
+			kvm_s390_clear_cpuflags(vcpu, CPUSTAT_IBS);
 		}
 		goto retry;
 	}
@@ -3564,7 +3563,7 @@ void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu)
 		__disable_ibs_on_all_vcpus(vcpu->kvm);
 	}
 
-	atomic_andnot(CPUSTAT_STOPPED, &vcpu->arch.sie_block->cpuflags);
+	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_STOPPED);
 	/*
 	 * Another VCPU might have used IBS while we were offline.
 	 * Let's play safe and flush the VCPU at startup.
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index a9f2c8d1833dd..f727313a706f9 100644
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
index dea0217922d6f..8205223f73322 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -216,7 +216,7 @@ int kvm_s390_skey_check_enable(struct kvm_vcpu *vcpu)
 	VCPU_EVENT(vcpu, 3, "enabling storage keys for guest: %d", rc);
 	if (!rc) {
 		if (atomic_read(&sie_block->cpuflags) & CPUSTAT_KSS)
-			atomic_andnot(CPUSTAT_KSS, &sie_block->cpuflags);
+			kvm_s390_clear_cpuflags(vcpu, CPUSTAT_KSS);
 		else
 			sie_block->ictl &= ~(ICTL_ISKE | ICTL_SSKE |
 					     ICTL_RRBE);
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 87b3416390636..6d494ed5907ee 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -935,7 +935,7 @@ static void register_shadow_scb(struct kvm_vcpu *vcpu,
  */
 static void unregister_shadow_scb(struct kvm_vcpu *vcpu)
 {
-	atomic_andnot(CPUSTAT_WAIT, &vcpu->arch.sie_block->cpuflags);
+	kvm_s390_clear_cpuflags(vcpu, CPUSTAT_WAIT);
 	WRITE_ONCE(vcpu->arch.vsie_block, NULL);
 }
 
-- 
2.13.4
