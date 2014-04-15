From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 20/47] KVM: s390: convert kvm_s390_store_status_unloaded()
Date: Tue, 15 Apr 2014 14:00:23 +0200
Message-ID: <1397563250-3089-21-git-send-email-borntraeger@de.ibm.com>
References: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1397563250-3089-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Convert kvm_s390_store_status_unloaded() to new guest access functions.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 95 ++++++++++++++++--------------------------------
 1 file changed, 31 insertions(+), 64 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 6cee19c..ae7c126 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1249,83 +1249,50 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	return rc;
 }
 
-static int __guestcopy(struct kvm_vcpu *vcpu, u64 guestdest, void *from,
-		       unsigned long n, int prefix)
-{
-	if (prefix)
-		return copy_to_guest(vcpu, guestdest, from, n);
-	else
-		return copy_to_guest_absolute(vcpu, guestdest, from, n);
-}
-
 /*
  * store status at address
  * we use have two special cases:
  * KVM_S390_STORE_STATUS_NOADDR: -> 0x1200 on 64 bit
  * KVM_S390_STORE_STATUS_PREFIXED: -> prefix
  */
-int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr)
+int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long gpa)
 {
 	unsigned char archmode = 1;
-	int prefix;
 	u64 clkcomp;
+	int rc;
 
-	if (addr == KVM_S390_STORE_STATUS_NOADDR) {
-		if (copy_to_guest_absolute(vcpu, 163ul, &archmode, 1))
+	if (gpa == KVM_S390_STORE_STATUS_NOADDR) {
+		if (write_guest_abs(vcpu, 163, &archmode, 1))
 			return -EFAULT;
-		addr = SAVE_AREA_BASE;
-		prefix = 0;
-	} else if (addr == KVM_S390_STORE_STATUS_PREFIXED) {
-		if (copy_to_guest(vcpu, 163ul, &archmode, 1))
+		gpa = SAVE_AREA_BASE;
+	} else if (gpa == KVM_S390_STORE_STATUS_PREFIXED) {
+		if (write_guest_real(vcpu, 163, &archmode, 1))
 			return -EFAULT;
-		addr = SAVE_AREA_BASE;
-		prefix = 1;
-	} else
-		prefix = 0;
-
-	if (__guestcopy(vcpu, addr + offsetof(struct save_area, fp_regs),
-			vcpu->arch.guest_fpregs.fprs, 128, prefix))
-		return -EFAULT;
-
-	if (__guestcopy(vcpu, addr + offsetof(struct save_area, gp_regs),
-			vcpu->run->s.regs.gprs, 128, prefix))
-		return -EFAULT;
-
-	if (__guestcopy(vcpu, addr + offsetof(struct save_area, psw),
-			&vcpu->arch.sie_block->gpsw, 16, prefix))
-		return -EFAULT;
-
-	if (__guestcopy(vcpu, addr + offsetof(struct save_area, pref_reg),
-			&vcpu->arch.sie_block->prefix, 4, prefix))
-		return -EFAULT;
-
-	if (__guestcopy(vcpu,
-			addr + offsetof(struct save_area, fp_ctrl_reg),
-			&vcpu->arch.guest_fpregs.fpc, 4, prefix))
-		return -EFAULT;
-
-	if (__guestcopy(vcpu, addr + offsetof(struct save_area, tod_reg),
-			&vcpu->arch.sie_block->todpr, 4, prefix))
-		return -EFAULT;
-
-	if (__guestcopy(vcpu, addr + offsetof(struct save_area, timer),
-			&vcpu->arch.sie_block->cputm, 8, prefix))
-		return -EFAULT;
-
+		gpa = kvm_s390_real_to_abs(vcpu, SAVE_AREA_BASE);
+	}
+	rc = write_guest_abs(vcpu, gpa + offsetof(struct save_area, fp_regs),
+			     vcpu->arch.guest_fpregs.fprs, 128);
+	rc |= write_guest_abs(vcpu, gpa + offsetof(struct save_area, gp_regs),
+			      vcpu->run->s.regs.gprs, 128);
+	rc |= write_guest_abs(vcpu, gpa + offsetof(struct save_area, psw),
+			      &vcpu->arch.sie_block->gpsw, 16);
+	rc |= write_guest_abs(vcpu, gpa + offsetof(struct save_area, pref_reg),
+			      &vcpu->arch.sie_block->prefix, 4);
+	rc |= write_guest_abs(vcpu,
+			      gpa + offsetof(struct save_area, fp_ctrl_reg),
+			      &vcpu->arch.guest_fpregs.fpc, 4);
+	rc |= write_guest_abs(vcpu, gpa + offsetof(struct save_area, tod_reg),
+			      &vcpu->arch.sie_block->todpr, 4);
+	rc |= write_guest_abs(vcpu, gpa + offsetof(struct save_area, timer),
+			      &vcpu->arch.sie_block->cputm, 8);
 	clkcomp = vcpu->arch.sie_block->ckc >> 8;
-	if (__guestcopy(vcpu, addr + offsetof(struct save_area, clk_cmp),
-			&clkcomp, 8, prefix))
-		return -EFAULT;
-
-	if (__guestcopy(vcpu, addr + offsetof(struct save_area, acc_regs),
-			&vcpu->run->s.regs.acrs, 64, prefix))
-		return -EFAULT;
-
-	if (__guestcopy(vcpu,
-			addr + offsetof(struct save_area, ctrl_regs),
-			&vcpu->arch.sie_block->gcr, 128, prefix))
-		return -EFAULT;
-	return 0;
+	rc |= write_guest_abs(vcpu, gpa + offsetof(struct save_area, clk_cmp),
+			      &clkcomp, 8);
+	rc |= write_guest_abs(vcpu, gpa + offsetof(struct save_area, acc_regs),
+			      &vcpu->run->s.regs.acrs, 64);
+	rc |= write_guest_abs(vcpu, gpa + offsetof(struct save_area, ctrl_regs),
+			      &vcpu->arch.sie_block->gcr, 128);
+	return rc ? -EFAULT : 0;
 }
 
 int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr)
-- 
1.8.4.2
