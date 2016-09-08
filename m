From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 04/11] KVM: s390: fix delivery of vector regs during machine checks
Date: Thu,  8 Sep 2016 14:00:16 +0200
Message-ID: <1473336023-15522-5-git-send-email-borntraeger@de.ibm.com>
References: <1473336023-15522-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1473336023-15522-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Vector registers are only to be stored if the facility is available
and if the guest has set up the machine check extended save area.

If anything goes wrong while writing the vector registers, the vector
registers are to be marked as invalid. Please note that we are allowed
to write the registers although they are marked as invalid.

Machine checks and "store status" SIGP orders are two different concepts,
let's correctly separate these. As the SIGP part is completely handled in
user space, we can drop it.

This patch is based on a patch from Cornelia Huck.

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 15 +++++++++++++--
 arch/s390/kvm/kvm-s390.c  | 32 --------------------------------
 arch/s390/kvm/kvm-s390.h  |  3 ---
 3 files changed, 13 insertions(+), 37 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 84d6dc6..c0ef625 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -25,6 +25,7 @@
 #include <asm/isc.h>
 #include <asm/gmap.h>
 #include <asm/switch_to.h>
+#include <asm/nmi.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
 #include "trace-s390.h"
@@ -406,8 +407,10 @@ static int __write_machine_check(struct kvm_vcpu *vcpu,
 {
 	unsigned long ext_sa_addr;
 	freg_t fprs[NUM_FPRS];
+	union mci mci;
 	int rc;
 
+	mci.val = mchk->mcic;
 	/* take care of lazy register loading via vcpu load/put */
 	save_fpu_regs();
 	save_access_regs(vcpu->run->s.regs.acrs);
@@ -415,7 +418,15 @@ static int __write_machine_check(struct kvm_vcpu *vcpu,
 	/* Extended save area */
 	rc = read_guest_lc(vcpu, __LC_VX_SAVE_AREA_ADDR, &ext_sa_addr,
 			    sizeof(unsigned long));
-	rc |= kvm_s390_vcpu_store_adtl_status(vcpu, ext_sa_addr);
+	/* Only bits 0-53 are used for address formation */
+	ext_sa_addr &= ~0x3ffUL;
+	if (!rc && mci.vr && ext_sa_addr && test_kvm_facility(vcpu->kvm, 129)) {
+		if (write_guest_abs(vcpu, ext_sa_addr, vcpu->run->s.regs.vrs,
+				    512))
+			mci.vr = 0;
+	} else {
+		mci.vr = 0;
+	}
 
 	/* General interruption information */
 	rc |= put_guest_lc(vcpu, 1, (u8 __user *) __LC_AR_MODE_ID);
@@ -423,7 +434,7 @@ static int __write_machine_check(struct kvm_vcpu *vcpu,
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, __LC_MCK_NEW_PSW,
 			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
-	rc |= put_guest_lc(vcpu, mchk->mcic, (u64 __user *) __LC_MCCK_CODE);
+	rc |= put_guest_lc(vcpu, mci.val, (u64 __user *) __LC_MCCK_CODE);
 
 	/* Register-save areas */
 	if (MACHINE_HAS_VX) {
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f142215..dead20a 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2837,38 +2837,6 @@ int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr)
 	return kvm_s390_store_status_unloaded(vcpu, addr);
 }
 
-/*
- * store additional status at address
- */
-int kvm_s390_store_adtl_status_unloaded(struct kvm_vcpu *vcpu,
-					unsigned long gpa)
-{
-	/* Only bits 0-53 are used for address formation */
-	if (!(gpa & ~0x3ff))
-		return 0;
-
-	return write_guest_abs(vcpu, gpa & ~0x3ff,
-			       (void *)&vcpu->run->s.regs.vrs, 512);
-}
-
-int kvm_s390_vcpu_store_adtl_status(struct kvm_vcpu *vcpu, unsigned long addr)
-{
-	if (!test_kvm_facility(vcpu->kvm, 129))
-		return 0;
-
-	/*
-	 * The guest VXRS are in the host VXRs due to the lazy
-	 * copying in vcpu load/put. We can simply call save_fpu_regs()
-	 * to save the current register state because we are in the
-	 * middle of a load/put cycle.
-	 *
-	 * Let's update our copies before we save it into the save area.
-	 */
-	save_fpu_regs();
-
-	return kvm_s390_store_adtl_status_unloaded(vcpu, addr);
-}
-
 static void __disable_ibs_on_vcpu(struct kvm_vcpu *vcpu)
 {
 	kvm_check_request(KVM_REQ_ENABLE_IBS, vcpu);
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index b843286..c3d4f16 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -273,10 +273,7 @@ int handle_sthyi(struct kvm_vcpu *vcpu);
 void kvm_s390_set_tod_clock(struct kvm *kvm, u64 tod);
 long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable);
 int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr);
-int kvm_s390_store_adtl_status_unloaded(struct kvm_vcpu *vcpu,
-					unsigned long addr);
 int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr);
-int kvm_s390_vcpu_store_adtl_status(struct kvm_vcpu *vcpu, unsigned long addr);
 void kvm_s390_vcpu_start(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_stop(struct kvm_vcpu *vcpu);
 void kvm_s390_vcpu_block(struct kvm_vcpu *vcpu);
-- 
2.5.5
