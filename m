From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 06/11] KVM: s390: fix and enforce return code handling for irq injections
Date: Mon, 25 Mar 2013 17:22:53 +0100
Message-ID: <1364228578-20528-7-git-send-email-cornelia.huck@de.ibm.com>
References: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1364228578-20528-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

kvm_s390_inject_program_int() and friends may fail if no memory is available.
This must be reported to the calling functions, so that this gets passed
down to user space which should fix the situation.
Alternatively we end up with guest state corruption.

So fix this and enforce return value checking by adding a __must_check
annotation to all of these function prototypes.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 12 +++----
 arch/s390/kvm/kvm-s390.c  |  3 +-
 arch/s390/kvm/kvm-s390.h  | 12 +++----
 arch/s390/kvm/priv.c      | 83 +++++++++++++++--------------------------------
 4 files changed, 37 insertions(+), 73 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index c6ba4df..b7d1b2e 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -45,10 +45,8 @@ static int handle_lctlg(struct kvm_vcpu *vcpu)
 	do {
 		rc = get_guest(vcpu, vcpu->arch.sie_block->gcr[reg],
 			       (u64 __user *) useraddr);
-		if (rc) {
-			kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-			break;
-		}
+		if (rc)
+			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		useraddr += 8;
 		if (reg == reg3)
 			break;
@@ -79,10 +77,8 @@ static int handle_lctl(struct kvm_vcpu *vcpu)
 	reg = reg1;
 	do {
 		rc = get_guest(vcpu, val, (u32 __user *) useraddr);
-		if (rc) {
-			kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-			break;
-		}
+		if (rc)
+			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		vcpu->arch.sie_block->gcr[reg] &= 0xffffffff00000000ul;
 		vcpu->arch.sie_block->gcr[reg] |= val;
 		useraddr += 4;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index f241e33..d05a59c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -633,8 +633,7 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 		} else {
 			VCPU_EVENT(vcpu, 3, "%s", "fault in sie instruction");
 			trace_kvm_s390_sie_fault(vcpu);
-			kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-			rc = 0;
+			rc = kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		}
 	}
 	VCPU_EVENT(vcpu, 6, "exit sie icptcode %d",
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 4d89d64..efc14f6 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -110,12 +110,12 @@ enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer);
 void kvm_s390_tasklet(unsigned long parm);
 void kvm_s390_deliver_pending_interrupts(struct kvm_vcpu *vcpu);
 void kvm_s390_deliver_pending_machine_checks(struct kvm_vcpu *vcpu);
-int kvm_s390_inject_vm(struct kvm *kvm,
-		struct kvm_s390_interrupt *s390int);
-int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
-		struct kvm_s390_interrupt *s390int);
-int kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code);
-int kvm_s390_inject_sigp_stop(struct kvm_vcpu *vcpu, int action);
+int __must_check kvm_s390_inject_vm(struct kvm *kvm,
+				    struct kvm_s390_interrupt *s390int);
+int __must_check kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
+				      struct kvm_s390_interrupt *s390int);
+int __must_check kvm_s390_inject_program_int(struct kvm_vcpu *vcpu, u16 code);
+int __must_check kvm_s390_inject_sigp_stop(struct kvm_vcpu *vcpu, int action);
 struct kvm_s390_interrupt_info *kvm_s390_get_io_int(struct kvm *kvm,
 						    u64 cr6, u64 schid);
 
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 05d186c..23a8370 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -36,31 +36,24 @@ static int handle_set_prefix(struct kvm_vcpu *vcpu)
 	operand2 = kvm_s390_get_base_disp_s(vcpu);
 
 	/* must be word boundary */
-	if (operand2 & 3) {
-		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-		goto out;
-	}
+	if (operand2 & 3)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	/* get the value */
-	if (get_guest(vcpu, address, (u32 __user *) operand2)) {
-		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-		goto out;
-	}
+	if (get_guest(vcpu, address, (u32 __user *) operand2))
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
 	address = address & 0x7fffe000u;
 
 	/* make sure that the new value is valid memory */
 	if (copy_from_guest_absolute(vcpu, &tmp, address, 1) ||
-	   (copy_from_guest_absolute(vcpu, &tmp, address + PAGE_SIZE, 1))) {
-		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-		goto out;
-	}
+	   (copy_from_guest_absolute(vcpu, &tmp, address + PAGE_SIZE, 1)))
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
 	kvm_s390_set_prefix(vcpu, address);
 
 	VCPU_EVENT(vcpu, 5, "setting prefix to %x", address);
 	trace_kvm_s390_handle_prefix(vcpu, 1, address);
-out:
 	return 0;
 }
 
@@ -74,49 +67,37 @@ static int handle_store_prefix(struct kvm_vcpu *vcpu)
 	operand2 = kvm_s390_get_base_disp_s(vcpu);
 
 	/* must be word boundary */
-	if (operand2 & 3) {
-		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-		goto out;
-	}
+	if (operand2 & 3)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
 	address = vcpu->arch.sie_block->prefix;
 	address = address & 0x7fffe000u;
 
 	/* get the value */
-	if (put_guest(vcpu, address, (u32 __user *)operand2)) {
-		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-		goto out;
-	}
+	if (put_guest(vcpu, address, (u32 __user *)operand2))
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
 	VCPU_EVENT(vcpu, 5, "storing prefix to %x", address);
 	trace_kvm_s390_handle_prefix(vcpu, 0, address);
-out:
 	return 0;
 }
 
 static int handle_store_cpu_address(struct kvm_vcpu *vcpu)
 {
 	u64 useraddr;
-	int rc;
 
 	vcpu->stat.instruction_stap++;
 
 	useraddr = kvm_s390_get_base_disp_s(vcpu);
 
-	if (useraddr & 1) {
-		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-		goto out;
-	}
+	if (useraddr & 1)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	rc = put_guest(vcpu, vcpu->vcpu_id, (u16 __user *)useraddr);
-	if (rc) {
-		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-		goto out;
-	}
+	if (put_guest(vcpu, vcpu->vcpu_id, (u16 __user *)useraddr))
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
 	VCPU_EVENT(vcpu, 5, "storing cpu address to %llx", useraddr);
 	trace_kvm_s390_handle_stap(vcpu, useraddr);
-out:
 	return 0;
 }
 
@@ -135,10 +116,8 @@ static int handle_tpi(struct kvm_vcpu *vcpu)
 	int cc;
 
 	addr = kvm_s390_get_base_disp_s(vcpu);
-	if (addr & 3) {
-		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-		goto out;
-	}
+	if (addr & 3)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 	cc = 0;
 	inti = kvm_s390_get_io_int(vcpu->kvm, vcpu->run->s.regs.crs[6], 0);
 	if (!inti)
@@ -167,7 +146,6 @@ no_interrupt:
 	/* Set condition code and we're done. */
 	vcpu->arch.sie_block->gpsw.mask &= ~(3ul << 44);
 	vcpu->arch.sie_block->gpsw.mask |= (cc & 3ul) << 44;
-out:
 	return 0;
 }
 
@@ -237,12 +215,9 @@ static int handle_stfl(struct kvm_vcpu *vcpu)
 	rc = copy_to_guest(vcpu, offsetof(struct _lowcore, stfl_fac_list),
 			   &facility_list, sizeof(facility_list));
 	if (rc)
-		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-	else {
-		VCPU_EVENT(vcpu, 5, "store facility list value %x",
-			   facility_list);
-		trace_kvm_s390_handle_stfl(vcpu, facility_list);
-	}
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	VCPU_EVENT(vcpu, 5, "store facility list value %x", facility_list);
+	trace_kvm_s390_handle_stfl(vcpu, facility_list);
 	return 0;
 }
 
@@ -317,25 +292,18 @@ static int handle_lpswe(struct kvm_vcpu *vcpu)
 static int handle_stidp(struct kvm_vcpu *vcpu)
 {
 	u64 operand2;
-	int rc;
 
 	vcpu->stat.instruction_stidp++;
 
 	operand2 = kvm_s390_get_base_disp_s(vcpu);
 
-	if (operand2 & 7) {
-		kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
-		goto out;
-	}
+	if (operand2 & 7)
+		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
-	rc = put_guest(vcpu, vcpu->arch.stidp_data, (u64 __user *)operand2);
-	if (rc) {
-		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-		goto out;
-	}
+	if (put_guest(vcpu, vcpu->arch.stidp_data, (u64 __user *)operand2))
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
 	VCPU_EVENT(vcpu, 5, "%s", "store cpu id");
-out:
 	return 0;
 }
 
@@ -377,6 +345,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 	int sel2 = vcpu->run->s.regs.gprs[1] & 0xffff;
 	u64 operand2;
 	unsigned long mem;
+	int rc = 0;
 
 	vcpu->stat.instruction_stsi++;
 	VCPU_EVENT(vcpu, 4, "stsi: fc: %x sel1: %x sel2: %x", fc, sel1, sel2);
@@ -412,7 +381,7 @@ static int handle_stsi(struct kvm_vcpu *vcpu)
 	}
 
 	if (copy_to_guest_absolute(vcpu, operand2, (void *) mem, PAGE_SIZE)) {
-		kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+		rc = kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		goto out_mem;
 	}
 	trace_kvm_s390_handle_stsi(vcpu, fc, sel1, sel2, operand2);
@@ -425,7 +394,7 @@ out_mem:
 out_fail:
 	/* condition code 3 */
 	vcpu->arch.sie_block->gpsw.mask |= 3ul << 44;
-	return 0;
+	return rc;
 }
 
 static const intercept_handler_t b2_handlers[256] = {
-- 
1.7.12.4
