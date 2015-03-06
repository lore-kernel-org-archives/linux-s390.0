From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 19/20] KVM: s390: Machine Check
Date: Fri,  6 Mar 2015 14:16:51 +0100
Message-ID: <1425647812-61838-20-git-send-email-borntraeger@de.ibm.com>
References: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425647812-61838-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Eric Farman <farman@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Eric Farman <farman@linux.vnet.ibm.com>

Store additional status in the machine check handler, in order to
collect status (such as vector registers) that is not defined by
store status.

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kernel/asm-offsets.c |  1 +
 arch/s390/kvm/interrupt.c      |  4 ++++
 arch/s390/kvm/kvm-s390.c       | 29 +++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.h       |  3 +++
 4 files changed, 37 insertions(+)

diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index e07e916..8dc4db1 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -171,6 +171,7 @@ int main(void)
 #else /* CONFIG_32BIT */
 	DEFINE(__LC_DATA_EXC_CODE, offsetof(struct _lowcore, data_exc_code));
 	DEFINE(__LC_MCCK_FAIL_STOR_ADDR, offsetof(struct _lowcore, failing_storage_address));
+	DEFINE(__LC_VX_SAVE_AREA_ADDR, offsetof(struct _lowcore, vector_save_area_addr));
 	DEFINE(__LC_EXT_PARAMS2, offsetof(struct _lowcore, ext_params2));
 	DEFINE(SAVE_AREA_BASE, offsetof(struct _lowcore, floating_pt_save_area));
 	DEFINE(__LC_PASTE, offsetof(struct _lowcore, paste));
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 036d375..2afec60 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -351,6 +351,7 @@ static int __must_check __deliver_machine_check(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	struct kvm_s390_mchk_info mchk;
+	unsigned long adtl_status_addr;
 	int rc;
 
 	spin_lock(&li->lock);
@@ -371,6 +372,9 @@ static int __must_check __deliver_machine_check(struct kvm_vcpu *vcpu)
 					 mchk.cr14, mchk.mcic);
 
 	rc  = kvm_s390_vcpu_store_status(vcpu, KVM_S390_STORE_STATUS_PREFIXED);
+	rc |= read_guest_lc(vcpu, __LC_VX_SAVE_AREA_ADDR,
+			    &adtl_status_addr, sizeof(unsigned long));
+	rc |= kvm_s390_vcpu_store_adtl_status(vcpu, adtl_status_addr);
 	rc |= put_guest_lc(vcpu, mchk.mcic,
 			   (u64 __user *) __LC_MCCK_CODE);
 	rc |= put_guest_lc(vcpu, mchk.failing_storage_address,
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index c0ae03a..0c045cf 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2031,6 +2031,35 @@ int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr)
 	return kvm_s390_store_status_unloaded(vcpu, addr);
 }
 
+/*
+ * store additional status at address
+ */
+int kvm_s390_store_adtl_status_unloaded(struct kvm_vcpu *vcpu,
+					unsigned long gpa)
+{
+	/* Only bits 0-53 are used for address formation */
+	if (!(gpa & ~0x3ff))
+		return 0;
+
+	return write_guest_abs(vcpu, gpa & ~0x3ff,
+			       (void *)&vcpu->run->s.regs.vrs, 512);
+}
+
+int kvm_s390_vcpu_store_adtl_status(struct kvm_vcpu *vcpu, unsigned long addr)
+{
+	if (!test_kvm_facility(vcpu->kvm, 129))
+		return 0;
+
+	/*
+	 * The guest VXRS are in the host VXRs due to the lazy
+	 * copying in vcpu load/put. Let's update our copies before we save
+	 * it into the save area.
+	 */
+	save_vx_regs((__vector128 *)&vcpu->run->s.regs.vrs);
+
+	return kvm_s390_store_adtl_status_unloaded(vcpu, addr);
+}
+
 static void __disable_ibs_on_vcpu(struct kvm_vcpu *vcpu)
 {
 	kvm_check_request(KVM_REQ_ENABLE_IBS, vcpu);
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 6995a30..fda3f31 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -177,7 +177,10 @@ int kvm_s390_handle_sigp_pei(struct kvm_vcpu *vcpu);
 /* implemented in kvm-s390.c */
 long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable);
 int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr);
+int kvm_s390_store_adtl_status_unloaded(struct kvm_vcpu *vcpu,
+					unsigned long addr);
 int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr);
+int kvm_s390_vcpu_store_adtl_status(struct kvm_vcpu *vcpu, unsigned long addr);
 void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu);
 void s390_vcpu_block(struct kvm_vcpu *vcpu);
-- 
2.3.0
