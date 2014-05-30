From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/6] KVM: s390: Enable DAT support for TPROT handler
Date: Fri, 30 May 2014 11:00:08 +0200
Message-ID: <1401440412-20472-3-git-send-email-borntraeger@de.ibm.com>
References: <1401440412-20472-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1401440412-20472-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

The TPROT instruction can be used to check the accessability of storage
for any kind of logical addresses. So far, our handler only supported
real addresses. This patch now also enables support for addresses that
have to be translated via DAT first. And while we're at it, change the
code to use the common KVM function gfn_to_hva_prot() to check for the
validity and writability of the memory page.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/kvm/gaccess.c |  4 ++--
 arch/s390/kvm/gaccess.h |  2 ++
 arch/s390/kvm/priv.c    | 56 +++++++++++++++++++++++++++++--------------------
 3 files changed, 37 insertions(+), 25 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 5f73826..4653ac6 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -292,7 +292,7 @@ static void ipte_unlock_siif(struct kvm_vcpu *vcpu)
 		wake_up(&vcpu->kvm->arch.ipte_wq);
 }
 
-static void ipte_lock(struct kvm_vcpu *vcpu)
+void ipte_lock(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.sie_block->eca & 1)
 		ipte_lock_siif(vcpu);
@@ -300,7 +300,7 @@ static void ipte_lock(struct kvm_vcpu *vcpu)
 		ipte_lock_simple(vcpu);
 }
 
-static void ipte_unlock(struct kvm_vcpu *vcpu)
+void ipte_unlock(struct kvm_vcpu *vcpu)
 {
 	if (vcpu->arch.sie_block->eca & 1)
 		ipte_unlock_siif(vcpu);
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 2d37a46..0149cf1 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -327,6 +327,8 @@ int read_guest_real(struct kvm_vcpu *vcpu, unsigned long gra, void *data,
 	return access_guest_real(vcpu, gra, data, len, 0);
 }
 
+void ipte_lock(struct kvm_vcpu *vcpu);
+void ipte_unlock(struct kvm_vcpu *vcpu);
 int ipte_lock_held(struct kvm_vcpu *vcpu);
 int kvm_s390_check_low_addr_protection(struct kvm_vcpu *vcpu, unsigned long ga);
 
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 6296159..f89c1cd 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -930,8 +930,9 @@ int kvm_s390_handle_eb(struct kvm_vcpu *vcpu)
 static int handle_tprot(struct kvm_vcpu *vcpu)
 {
 	u64 address1, address2;
-	struct vm_area_struct *vma;
-	unsigned long user_address;
+	unsigned long hva, gpa;
+	int ret = 0, cc = 0;
+	bool writable;
 
 	vcpu->stat.instruction_tprot++;
 
@@ -942,32 +943,41 @@ static int handle_tprot(struct kvm_vcpu *vcpu)
 
 	/* we only handle the Linux memory detection case:
 	 * access key == 0
-	 * guest DAT == off
 	 * everything else goes to userspace. */
 	if (address2 & 0xf0)
 		return -EOPNOTSUPP;
 	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_DAT)
-		return -EOPNOTSUPP;
-
-	down_read(&current->mm->mmap_sem);
-	user_address = __gmap_translate(address1, vcpu->arch.gmap);
-	if (IS_ERR_VALUE(user_address))
-		goto out_inject;
-	vma = find_vma(current->mm, user_address);
-	if (!vma)
-		goto out_inject;
-	vcpu->arch.sie_block->gpsw.mask &= ~(3ul << 44);
-	if (!(vma->vm_flags & VM_WRITE) && (vma->vm_flags & VM_READ))
-		vcpu->arch.sie_block->gpsw.mask |= (1ul << 44);
-	if (!(vma->vm_flags & VM_WRITE) && !(vma->vm_flags & VM_READ))
-		vcpu->arch.sie_block->gpsw.mask |= (2ul << 44);
-
-	up_read(&current->mm->mmap_sem);
-	return 0;
+		ipte_lock(vcpu);
+	ret = guest_translate_address(vcpu, address1, &gpa, 1);
+	if (ret == PGM_PROTECTION) {
+		/* Write protected? Try again with read-only... */
+		cc = 1;
+		ret = guest_translate_address(vcpu, address1, &gpa, 0);
+	}
+	if (ret) {
+		if (ret == PGM_ADDRESSING || ret == PGM_TRANSLATION_SPEC) {
+			ret = kvm_s390_inject_program_int(vcpu, ret);
+		} else if (ret > 0) {
+			/* Translation not available */
+			kvm_s390_set_psw_cc(vcpu, 3);
+			ret = 0;
+		}
+		goto out_unlock;
+	}
 
-out_inject:
-	up_read(&current->mm->mmap_sem);
-	return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	hva = gfn_to_hva_prot(vcpu->kvm, gpa_to_gfn(gpa), &writable);
+	if (kvm_is_error_hva(hva)) {
+		ret = kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	} else {
+		if (!writable)
+			cc = 1;		/* Write not permitted ==> read-only */
+		kvm_s390_set_psw_cc(vcpu, cc);
+		/* Note: CC2 only occurs for storage keys (not supported yet) */
+	}
+out_unlock:
+	if (vcpu->arch.sie_block->gpsw.mask & PSW_MASK_DAT)
+		ipte_unlock(vcpu);
+	return ret;
 }
 
 int kvm_s390_handle_e5(struct kvm_vcpu *vcpu)
-- 
1.8.4.2
