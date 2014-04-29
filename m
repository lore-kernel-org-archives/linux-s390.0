From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/6] KVM: s390: Handle MVPG partial execution interception
Date: Tue, 29 Apr 2014 15:36:43 +0200
Message-ID: <1398778608-3887-2-git-send-email-borntraeger@de.ibm.com>
References: <1398778608-3887-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1398778608-3887-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@kernel.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Thomas Huth <thuth@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Huth <thuth@linux.vnet.ibm.com>

When the guest executes the MVPG instruction with DAT disabled,
and the source or destination page is not mapped in the host,
the so-called partial execution interception occurs. We need to
handle this event by setting up a mapping for the corresponding
user pages.

Signed-off-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/intercept.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index 30e1c5e..54313fe 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -1,7 +1,7 @@
 /*
  * in-kernel handling for sie intercepts
  *
- * Copyright IBM Corp. 2008, 2009
+ * Copyright IBM Corp. 2008, 2014
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License (version 2 only)
@@ -234,6 +234,58 @@ static int handle_instruction_and_prog(struct kvm_vcpu *vcpu)
 	return rc2;
 }
 
+/**
+ * Handle MOVE PAGE partial execution interception.
+ *
+ * This interception can only happen for guests with DAT disabled and
+ * addresses that are currently not mapped in the host. Thus we try to
+ * set up the mappings for the corresponding user pages here (or throw
+ * addressing exceptions in case of illegal guest addresses).
+ */
+static int handle_mvpg_pei(struct kvm_vcpu *vcpu)
+{
+	unsigned long hostaddr, srcaddr, dstaddr;
+	psw_t *psw = &vcpu->arch.sie_block->gpsw;
+	struct mm_struct *mm = current->mm;
+	int reg1, reg2, rc;
+
+	kvm_s390_get_regs_rre(vcpu, &reg1, &reg2);
+	srcaddr = kvm_s390_real_to_abs(vcpu, vcpu->run->s.regs.gprs[reg2]);
+	dstaddr = kvm_s390_real_to_abs(vcpu, vcpu->run->s.regs.gprs[reg1]);
+
+	/* Make sure that the source is paged-in */
+	hostaddr = gmap_fault(srcaddr, vcpu->arch.gmap);
+	if (IS_ERR_VALUE(hostaddr))
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	down_read(&mm->mmap_sem);
+	rc = get_user_pages(current, mm, hostaddr, 1, 0, 0, NULL, NULL);
+	up_read(&mm->mmap_sem);
+	if (rc < 0)
+		return rc;
+
+	/* Make sure that the destination is paged-in */
+	hostaddr = gmap_fault(dstaddr, vcpu->arch.gmap);
+	if (IS_ERR_VALUE(hostaddr))
+		return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
+	down_read(&mm->mmap_sem);
+	rc = get_user_pages(current, mm, hostaddr, 1, 1, 0, NULL, NULL);
+	up_read(&mm->mmap_sem);
+	if (rc < 0)
+		return rc;
+
+	psw->addr = __rewind_psw(*psw, 4);
+
+	return 0;
+}
+
+static int handle_partial_execution(struct kvm_vcpu *vcpu)
+{
+	if (vcpu->arch.sie_block->ipa == 0xb254)	/* MVPG */
+		return handle_mvpg_pei(vcpu);
+
+	return -EOPNOTSUPP;
+}
+
 static const intercept_handler_t intercept_funcs[] = {
 	[0x00 >> 2] = handle_noop,
 	[0x04 >> 2] = handle_instruction,
@@ -245,6 +297,7 @@ static const intercept_handler_t intercept_funcs[] = {
 	[0x1C >> 2] = kvm_s390_handle_wait,
 	[0x20 >> 2] = handle_validity,
 	[0x28 >> 2] = handle_stop,
+	[0x38 >> 2] = handle_partial_execution,
 };
 
 int kvm_handle_sie_intercept(struct kvm_vcpu *vcpu)
-- 
1.8.4.2
