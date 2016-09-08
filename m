From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 02/11] KVM: s390: factor out actual delivery of machine checks
Date: Thu,  8 Sep 2016 14:00:14 +0200
Message-ID: <1473336023-15522-3-git-send-email-borntraeger@de.ibm.com>
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

Let's factor this out to prepare for bigger changes. Reorder to calls to
match the logical order given in the PoP.

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 54 +++++++++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 23 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 24524c0..6e9442a 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -400,12 +400,40 @@ static int __must_check __deliver_pfault_init(struct kvm_vcpu *vcpu)
 	return rc ? -EFAULT : 0;
 }
 
+static int __write_machine_check(struct kvm_vcpu *vcpu,
+				 struct kvm_s390_mchk_info *mchk)
+{
+	unsigned long ext_sa_addr;
+	int rc;
+
+	/* Extended save area */
+	rc = read_guest_lc(vcpu, __LC_VX_SAVE_AREA_ADDR, &ext_sa_addr,
+			    sizeof(unsigned long));
+	rc |= kvm_s390_vcpu_store_adtl_status(vcpu, ext_sa_addr);
+
+	/* General interruption information */
+	rc |= write_guest_lc(vcpu, __LC_MCK_OLD_PSW,
+			     &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= read_guest_lc(vcpu, __LC_MCK_NEW_PSW,
+			    &vcpu->arch.sie_block->gpsw, sizeof(psw_t));
+	rc |= put_guest_lc(vcpu, mchk->mcic, (u64 __user *) __LC_MCCK_CODE);
+
+	/* Register-save areas */
+	rc |= kvm_s390_vcpu_store_status(vcpu, KVM_S390_STORE_STATUS_PREFIXED);
+
+	/* Extended interruption information */
+	rc |= put_guest_lc(vcpu, mchk->failing_storage_address,
+			   (u64 __user *) __LC_MCCK_FAIL_STOR_ADDR);
+	rc |= write_guest_lc(vcpu, __LC_PSW_SAVE_AREA, &mchk->fixed_logout,
+			     sizeof(mchk->fixed_logout));
+	return rc ? -EFAULT : 0;
+}
+
 static int __must_check __deliver_machine_check(struct kvm_vcpu *vcpu)
 {
 	struct kvm_s390_float_interrupt *fi = &vcpu->kvm->arch.float_int;
 	struct kvm_s390_local_interrupt *li = &vcpu->arch.local_int;
 	struct kvm_s390_mchk_info mchk = {};
-	unsigned long adtl_status_addr;
 	int deliver = 0;
 	int rc = 0;
 
@@ -446,29 +474,9 @@ static int __must_check __deliver_machine_check(struct kvm_vcpu *vcpu)
 		trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
 						 KVM_S390_MCHK,
 						 mchk.cr14, mchk.mcic);
-
-		rc  = kvm_s390_vcpu_store_status(vcpu,
-						 KVM_S390_STORE_STATUS_PREFIXED);
-		rc |= read_guest_lc(vcpu, __LC_VX_SAVE_AREA_ADDR,
-				    &adtl_status_addr,
-				    sizeof(unsigned long));
-		rc |= kvm_s390_vcpu_store_adtl_status(vcpu,
-						      adtl_status_addr);
-		rc |= put_guest_lc(vcpu, mchk.mcic,
-				   (u64 __user *) __LC_MCCK_CODE);
-		rc |= put_guest_lc(vcpu, mchk.failing_storage_address,
-				   (u64 __user *) __LC_MCCK_FAIL_STOR_ADDR);
-		rc |= write_guest_lc(vcpu, __LC_PSW_SAVE_AREA,
-				     &mchk.fixed_logout,
-				     sizeof(mchk.fixed_logout));
-		rc |= write_guest_lc(vcpu, __LC_MCK_OLD_PSW,
-				     &vcpu->arch.sie_block->gpsw,
-				     sizeof(psw_t));
-		rc |= read_guest_lc(vcpu, __LC_MCK_NEW_PSW,
-				    &vcpu->arch.sie_block->gpsw,
-				    sizeof(psw_t));
+		rc = __write_machine_check(vcpu, &mchk);
 	}
-	return rc ? -EFAULT : 0;
+	return rc;
 }
 
 static int __must_check __deliver_restart(struct kvm_vcpu *vcpu)
-- 
2.5.5
