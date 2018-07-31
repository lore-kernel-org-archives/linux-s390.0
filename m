From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 08:44:01 +0000
Subject: [GIT PULL 15/19] KVM: s390: Add skey emulation fault handling
Message-Id: <20180731084405.28953-16-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.ibm.com>

When doing skey emulation for huge guests, we now need to fault in
pmds, as we don't have PGSTES anymore to store them when we do not
have valid table entries.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/kvm/kvm-s390.c |  15 ++++--
 arch/s390/kvm/priv.c     | 105 ++++++++++++++++++++++++++-------------
 2 files changed, 83 insertions(+), 37 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4cff5e31ca36..662f4d8046db 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1551,6 +1551,7 @@ static long kvm_s390_set_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
 	uint8_t *keys;
 	uint64_t hva;
 	int srcu_idx, i, r = 0;
+	bool unlocked;
 
 	if (args->flags != 0)
 		return -EINVAL;
@@ -1575,9 +1576,11 @@ static long kvm_s390_set_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
 	if (r)
 		goto out;
 
+	i = 0;
 	down_read(&current->mm->mmap_sem);
 	srcu_idx = srcu_read_lock(&kvm->srcu);
-	for (i = 0; i < args->count; i++) {
+        while (i < args->count) {
+		unlocked = false;
 		hva = gfn_to_hva(kvm, args->start_gfn + i);
 		if (kvm_is_error_hva(hva)) {
 			r = -EFAULT;
@@ -1591,8 +1594,14 @@ static long kvm_s390_set_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
 		}
 
 		r = set_guest_storage_key(current->mm, hva, keys[i], 0);
-		if (r)
-			break;
+		if (r) {
+			r = fixup_user_fault(current, current->mm, hva,
+					     FAULT_FLAG_WRITE, &unlocked);
+			if (r)
+				break;
+		}
+		if (!r)
+			i++;
 	}
 	srcu_read_unlock(&kvm->srcu, srcu_idx);
 	up_read(&current->mm->mmap_sem);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index eb0eb60c7be6..cfc5a62329f6 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -246,9 +246,10 @@ static int try_handle_skey(struct kvm_vcpu *vcpu)
 
 static int handle_iske(struct kvm_vcpu *vcpu)
 {
-	unsigned long addr;
+	unsigned long gaddr, vmaddr;
 	unsigned char key;
 	int reg1, reg2;
+	bool unlocked;
 	int rc;
 
 	vcpu->stat.instruction_iske++;
@@ -262,18 +263,28 @@ static int handle_iske(struct kvm_vcpu *vcpu)
 
 	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
 
-	addr = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
-	addr = kvm_s390_logical_to_effective(vcpu, addr);
-	addr = kvm_s390_real_to_abs(vcpu, addr);
-	addr = gfn_to_hva(vcpu->kvm, gpa_to_gfn(addr));
-	if (kvm_is_error_hva(addr))
+	gaddr = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
+	gaddr = kvm_s390_logical_to_effective(vcpu, gaddr);
+	gaddr = kvm_s390_real_to_abs(vcpu, gaddr);
+	vmaddr = gfn_to_hva(vcpu->kvm, gpa_to_gfn(gaddr));
+	if (kvm_is_error_hva(vmaddr))
 		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-
+retry:
+	unlocked = false;
 	down_read(&current->mm->mmap_sem);
-	rc = get_guest_storage_key(current->mm, addr, &key);
-	up_read(&current->mm->mmap_sem);
+	rc = get_guest_storage_key(current->mm, vmaddr, &key);
+
+	if (rc) {
+		rc = fixup_user_fault(current, current->mm, vmaddr,
+				      FAULT_FLAG_WRITE, &unlocked);
+		if (!rc) {
+			up_read(&current->mm->mmap_sem);
+			goto retry;
+		}
+	}
 	if (rc)
 		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	up_read(&current->mm->mmap_sem);
 	vcpu->run->s.regs.gprs[reg1] &= ~0xff;
 	vcpu->run->s.regs.gprs[reg1] |= key;
 	return 0;
@@ -281,8 +292,9 @@ static int handle_iske(struct kvm_vcpu *vcpu)
 
 static int handle_rrbe(struct kvm_vcpu *vcpu)
 {
-	unsigned long addr;
+	unsigned long vmaddr, gaddr;
 	int reg1, reg2;
+	bool unlocked;
 	int rc;
 
 	vcpu->stat.instruction_rrbe++;
@@ -296,19 +308,27 @@ static int handle_rrbe(struct kvm_vcpu *vcpu)
 
 	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
 
-	addr = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
-	addr = kvm_s390_logical_to_effective(vcpu, addr);
-	addr = kvm_s390_real_to_abs(vcpu, addr);
-	addr = gfn_to_hva(vcpu->kvm, gpa_to_gfn(addr));
-	if (kvm_is_error_hva(addr))
+	gaddr = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
+	gaddr = kvm_s390_logical_to_effective(vcpu, gaddr);
+	gaddr = kvm_s390_real_to_abs(vcpu, gaddr);
+	vmaddr = gfn_to_hva(vcpu->kvm, gpa_to_gfn(gaddr));
+	if (kvm_is_error_hva(vmaddr))
 		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-
+retry:
+	unlocked = false;
 	down_read(&current->mm->mmap_sem);
-	rc = reset_guest_reference_bit(current->mm, addr);
-	up_read(&current->mm->mmap_sem);
+	rc = reset_guest_reference_bit(current->mm, vmaddr);
+	if (rc < 0) {
+		rc = fixup_user_fault(current, current->mm, vmaddr,
+				      FAULT_FLAG_WRITE, &unlocked);
+		if (!rc) {
+			up_read(&current->mm->mmap_sem);
+			goto retry;
+		}
+	}
 	if (rc < 0)
 		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-
+	up_read(&current->mm->mmap_sem);
 	kvm_s390_set_psw_cc(vcpu, rc);
 	return 0;
 }
@@ -323,6 +343,7 @@ static int handle_sske(struct kvm_vcpu *vcpu)
 	unsigned long start, end;
 	unsigned char key, oldkey;
 	int reg1, reg2;
+	bool unlocked;
 	int rc;
 
 	vcpu->stat.instruction_sske++;
@@ -355,19 +376,28 @@ static int handle_sske(struct kvm_vcpu *vcpu)
 	}
 
 	while (start != end) {
-		unsigned long addr = gfn_to_hva(vcpu->kvm, gpa_to_gfn(start));
+		unsigned long vmaddr = gfn_to_hva(vcpu->kvm, gpa_to_gfn(start));
+		unlocked = false;
 
-		if (kvm_is_error_hva(addr))
+		if (kvm_is_error_hva(vmaddr))
 			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
 		down_read(&current->mm->mmap_sem);
-		rc = cond_set_guest_storage_key(current->mm, addr, key, &oldkey,
+		rc = cond_set_guest_storage_key(current->mm, vmaddr, key, &oldkey,
 						m3 & SSKE_NQ, m3 & SSKE_MR,
 						m3 & SSKE_MC);
-		up_read(&current->mm->mmap_sem);
-		if (rc < 0)
+
+		if (rc < 0) {
+			rc = fixup_user_fault(current, current->mm, vmaddr,
+					      FAULT_FLAG_WRITE, &unlocked);
+			rc = !rc ? -EAGAIN : rc;
+		}
+		if (rc == -EFAULT)
 			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-		start += PAGE_SIZE;
+
+		up_read(&current->mm->mmap_sem);
+		if (rc >= 0)
+			start += PAGE_SIZE;
 	}
 
 	if (m3 & (SSKE_MC | SSKE_MR)) {
@@ -948,15 +978,16 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 	}
 
 	while (start != end) {
-		unsigned long useraddr;
+		unsigned long vmaddr;
+		bool unlocked = false;
 
 		/* Translate guest address to host address */
-		useraddr = gfn_to_hva(vcpu->kvm, gpa_to_gfn(start));
-		if (kvm_is_error_hva(useraddr))
+		vmaddr = gfn_to_hva(vcpu->kvm, gpa_to_gfn(start));
+		if (kvm_is_error_hva(vmaddr))
 			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 
 		if (vcpu->run->s.regs.gprs[reg1] & PFMF_CF) {
-			if (clear_user((void __user *)useraddr, PAGE_SIZE))
+			if (clear_user((void __user *)vmaddr, PAGE_SIZE))
 				return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		}
 
@@ -966,14 +997,20 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 			if (rc)
 				return rc;
 			down_read(&current->mm->mmap_sem);
-			rc = cond_set_guest_storage_key(current->mm, useraddr,
+			rc = cond_set_guest_storage_key(current->mm, vmaddr,
 							key, NULL, nq, mr, mc);
-			up_read(&current->mm->mmap_sem);
-			if (rc < 0)
+			if (rc < 0) {
+				rc = fixup_user_fault(current, current->mm, vmaddr,
+						      FAULT_FLAG_WRITE, &unlocked);
+				rc = !rc ? -EAGAIN : rc;
+			}
+			if (rc == -EFAULT)
 				return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-		}
 
-		start += PAGE_SIZE;
+			up_read(&current->mm->mmap_sem);
+			if (rc >= 0)
+				start += PAGE_SIZE;
+		}
 	}
 	if (vcpu->run->s.regs.gprs[reg1] & PFMF_FSC) {
 		if (psw_bits(vcpu->arch.sie_block->gpsw).eaba == PSW_BITS_AMODE_64BIT) {
-- 
2.17.0
