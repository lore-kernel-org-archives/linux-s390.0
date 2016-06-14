From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 48/52] KVM: s390: pfmf: support conditional-sske facility
Date: Tue, 14 Jun 2016 20:57:25 +0200
Message-ID: <1465930649-181383-49-git-send-email-borntraeger@de.ibm.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We already indicate that facility but don't implement it in our pfmf
interception handler. Let's add a new storage key handling function for
conditionally setting the guest storage key.

As we will reuse this function later on, let's directly implement returning
the old key via parameter and indicating if any change happened via rc.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/pgtable.h |  3 +++
 arch/s390/kvm/priv.c            | 18 ++++++++++++++----
 arch/s390/mm/pgtable.c          | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 91f0e7b..2f6702e 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -893,6 +893,9 @@ void ptep_zap_key(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 bool test_and_clear_guest_dirty(struct mm_struct *mm, unsigned long address);
 int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			  unsigned char key, bool nq);
+int cond_set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
+			       unsigned char key, unsigned char *oldkey,
+			       bool nq, bool mr, bool mc);
 int get_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			  unsigned char *key);
 
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 71fa603..752a1ac 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -654,8 +654,10 @@ static int handle_epsw(struct kvm_vcpu *vcpu)
 
 static int handle_pfmf(struct kvm_vcpu *vcpu)
 {
+	bool mr = false, mc = false, nq;
 	int reg1, reg2;
 	unsigned long start, end;
+	unsigned char key;
 
 	vcpu->stat.instruction_pfmf++;
 
@@ -675,6 +677,15 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 	    !test_kvm_facility(vcpu->kvm, 14))
 		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
 
+	/* Only provide conditional-SSKE support if enabled for the guest */
+	if (vcpu->run->s.regs.gprs[reg1] & PFMF_SK &&
+	    test_kvm_facility(vcpu->kvm, 10)) {
+		mr = vcpu->run->s.regs.gprs[reg1] & PFMF_MR;
+		mc = vcpu->run->s.regs.gprs[reg1] & PFMF_MC;
+	}
+
+	nq = vcpu->run->s.regs.gprs[reg1] & PFMF_NQ;
+	key = vcpu->run->s.regs.gprs[reg1] & PFMF_KEY;
 	start = vcpu->run->s.regs.gprs[reg2] & PAGE_MASK;
 	start = kvm_s390_logical_to_effective(vcpu, start);
 
@@ -723,11 +734,10 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 			if (rc)
 				return rc;
 			down_read(&current->mm->mmap_sem);
-			rc = set_guest_storage_key(current->mm, useraddr,
-					vcpu->run->s.regs.gprs[reg1] & PFMF_KEY,
-					vcpu->run->s.regs.gprs[reg1] & PFMF_NQ);
+			rc = cond_set_guest_storage_key(current->mm, useraddr,
+							key, NULL, nq, mr, mc);
 			up_read(&current->mm->mmap_sem);
-			if (rc)
+			if (rc < 0)
 				return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		}
 
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 3e35298..e791e8b 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -539,6 +539,39 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL(set_guest_storage_key);
 
+/**
+ * Conditionally set a guest storage key (handling csske).
+ * oldkey will be updated when either mr or mc is set and a pointer is given.
+ *
+ * Returns 0 if a guests storage key update wasn't necessary, 1 if the guest
+ * storage key was updated and -EFAULT on access errors.
+ */
+int cond_set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
+			       unsigned char key, unsigned char *oldkey,
+			       bool nq, bool mr, bool mc)
+{
+	unsigned char tmp, mask = _PAGE_ACC_BITS | _PAGE_FP_BIT;
+	int rc;
+
+	/* we can drop the pgste lock between getting and setting the key */
+	if (mr | mc) {
+		rc = get_guest_storage_key(current->mm, addr, &tmp);
+		if (rc)
+			return rc;
+		if (oldkey)
+			*oldkey = tmp;
+		if (!mr)
+			mask |= _PAGE_REFERENCED;
+		if (!mc)
+			mask |= _PAGE_CHANGED;
+		if (!((tmp ^ key) & mask))
+			return 0;
+	}
+	rc = set_guest_storage_key(current->mm, addr, key, nq);
+	return rc < 0 ? rc : 1;
+}
+EXPORT_SYMBOL(cond_set_guest_storage_key);
+
 int get_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 			  unsigned char *key)
 {
-- 
2.5.5
