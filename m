From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 03/11] KVM: s390: split store status and machine check handling
Date: Thu,  8 Sep 2016 14:00:15 +0200
Message-ID: <1473336023-15522-4-git-send-email-borntraeger@de.ibm.com>
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

Store status writes the prefix which is not to be done by a machine check.
Also, the psw is stored and later on overwritten by the failing-storage
address, which looks strange at first sight.

Store status and machine check handling look similar, but they are actually
two different things.

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 6e9442a..84d6dc6 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -24,6 +24,7 @@
 #include <asm/sclp.h>
 #include <asm/isc.h>
 #include <asm/gmap.h>
+#include <asm/switch_to.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
 #include "trace-s390.h"
@@ -404,14 +405,20 @@ static int __write_machine_check(struct kvm_vcpu *vcpu,
 				 struct kvm_s390_mchk_info *mchk)
 {
 	unsigned long ext_sa_addr;
+	freg_t fprs[NUM_FPRS];
 	int rc;
 
+	/* take care of lazy register loading via vcpu load/put */
+	save_fpu_regs();
+	save_access_regs(vcpu->run->s.regs.acrs);
+
 	/* Extended save area */
 	rc = read_guest_lc(vcpu, __LC_VX_SAVE_AREA_ADDR, &ext_sa_addr,
 			    sizeof(unsigned long));
 	rc |= kvm_s390_vcpu_store_adtl_status(vcpu, ext_sa_addr);
 
 	/* General interruption information */
+	rc |= put_guest_lc(vcpu, 1, (u8 __user *) __LC_AR_MODE_ID);
 	rc |= write_guest_lc(vcpu, __LC_MCK_OLD_PSW,
 			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
 	rc |= read_guest_lc(vcpu, __LC_MCK_NEW_PSW,
@@ -419,7 +426,27 @@ static int __write_machine_check(struct kvm_vcpu *vcpu,
 	rc |= put_guest_lc(vcpu, mchk->mcic, (u64 __user *) __LC_MCCK_CODE);
 
 	/* Register-save areas */
-	rc |= kvm_s390_vcpu_store_status(vcpu, KVM_S390_STORE_STATUS_PREFIXED);
+	if (MACHINE_HAS_VX) {
+		convert_vx_to_fp(fprs, (__vector128 *) vcpu->run->s.regs.vrs);
+		rc |= write_guest_lc(vcpu, __LC_FPREGS_SAVE_AREA, fprs, 128);
+	} else {
+		rc |= write_guest_lc(vcpu, __LC_FPREGS_SAVE_AREA,
+				     vcpu->run->s.regs.fprs, 128);
+	}
+	rc |= write_guest_lc(vcpu, __LC_GPREGS_SAVE_AREA,
+			     vcpu->run->s.regs.gprs, 128);
+	rc |= put_guest_lc(vcpu, current->thread.fpu.fpc,
+			   (u32 __user *) __LC_FP_CREG_SAVE_AREA);
+	rc |= put_guest_lc(vcpu, vcpu->arch.sie_block->todpr,
+			   (u32 __user *) __LC_TOD_PROGREG_SAVE_AREA);
+	rc |= put_guest_lc(vcpu, kvm_s390_get_cpu_timer(vcpu),
+			   (u64 __user *) __LC_CPU_TIMER_SAVE_AREA);
+	rc |= put_guest_lc(vcpu, vcpu->arch.sie_block->ckc >> 8,
+			   (u64 __user *) __LC_CLOCK_COMP_SAVE_AREA);
+	rc |= write_guest_lc(vcpu, __LC_AREGS_SAVE_AREA,
+			     &vcpu->run->s.regs.acrs, 64);
+	rc |= write_guest_lc(vcpu, __LC_CREGS_SAVE_AREA,
+			     &vcpu->arch.sie_block->gcr, 128);
 
 	/* Extended interruption information */
 	rc |= put_guest_lc(vcpu, mchk->failing_storage_address,
-- 
2.5.5
