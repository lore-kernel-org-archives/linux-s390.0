From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 05/12] KVM: s390: Improved MVPG partial execution handler
Date: Fri, 16 May 2014 16:09:41 +0200
Message-ID: <1400249388-3969-6-git-send-email-borntraeger@de.ibm.com>
References: <1400249388-3969-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1400249388-3969-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

Use the new helper function kvm_arch_fault_in_page() for faulting-in
the guest pages and only inject addressing errors when we've really
hit a bad address (and return other error codes to userspace instead).

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index ddc69f5..147b87f 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -292,33 +292,26 @@ static int handle_external_interrupt(struct kvm_vcpu *vcpu)
  */
 static int handle_mvpg_pei(struct kvm_vcpu *vcpu)
 {
-	unsigned long hostaddr, srcaddr, dstaddr;
 	psw_t *psw = &vcpu->arch.sie_block->gpsw;
-	struct mm_struct *mm = current->mm;
+	unsigned long srcaddr, dstaddr;
 	int reg1, reg2, rc;
 
 	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
-	srcaddr = kvm_s390_real_to_abs(vcpu, vcpu->run->s.regs.gprs[reg2]);
-	dstaddr = kvm_s390_real_to_abs(vcpu, vcpu->run->s.regs.gprs[reg1]);
 
 	/* Make sure that the source is paged-in */
-	hostaddr = gmap_fault(srcaddr, vcpu->arch.gmap);
-	if (IS_ERR_VALUE(hostaddr))
+	srcaddr = kvm_s390_real_to_abs(vcpu, vcpu->run->s.regs.gprs[reg2]);
+	if (kvm_is_error_gpa(vcpu->kvm, srcaddr))
 		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-	down_read(&mm->mmap_sem);
-	rc = get_user_pages(current, mm, hostaddr, 1, 0, 0, NULL, NULL);
-	up_read(&mm->mmap_sem);
-	if (rc < 0)
+	rc = kvm_arch_fault_in_page(vcpu, srcaddr, 0);
+	if (rc != 0)
 		return rc;
 
 	/* Make sure that the destination is paged-in */
-	hostaddr = gmap_fault(dstaddr, vcpu->arch.gmap);
-	if (IS_ERR_VALUE(hostaddr))
+	dstaddr = kvm_s390_real_to_abs(vcpu, vcpu->run->s.regs.gprs[reg1]);
+	if (kvm_is_error_gpa(vcpu->kvm, dstaddr))
 		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
-	down_read(&mm->mmap_sem);
-	rc = get_user_pages(current, mm, hostaddr, 1, 1, 0, NULL, NULL);
-	up_read(&mm->mmap_sem);
-	if (rc < 0)
+	rc = kvm_arch_fault_in_page(vcpu, dstaddr, 1);
+	if (rc != 0)
 		return rc;
 
 	psw->addr = __rewind_psw(*psw, 4);
-- 
1.8.4.2
