From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 41/52] s390/mm: set and get guest storage key mmap locking
Date: Tue, 14 Jun 2016 20:57:18 +0200
Message-ID: <1465930649-181383-42-git-send-email-borntraeger@de.ibm.com>
References: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465930649-181383-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Move the mmap semaphore locking out of set_guest_storage_key
and get_guest_storage_key. This makes the two functions more
like the other ptep_xxx operations and allows to avoid repeated
semaphore operations if multiple keys are read or written.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 26 ++++++++++++++++----------
 arch/s390/kvm/priv.c     |  7 +++++--
 arch/s390/mm/pgtable.c   | 15 +++------------
 3 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9d0e4d0..d0156d7 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1050,26 +1050,30 @@ static long kvm_s390_get_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
 	if (!keys)
 		return -ENOMEM;
 
+	down_read(&current->mm->mmap_sem);
 	for (i = 0; i < args->count; i++) {
 		hva = gfn_to_hva(kvm, args->start_gfn + i);
 		if (kvm_is_error_hva(hva)) {
 			r = -EFAULT;
-			goto out;
+			break;
 		}
 
 		curkey = get_guest_storage_key(current->mm, hva);
 		if (IS_ERR_VALUE(curkey)) {
 			r = curkey;
-			goto out;
+			break;
 		}
 		keys[i] = curkey;
 	}
+	up_read(&current->mm->mmap_sem);
+
+	if (!r) {
+		r = copy_to_user((uint8_t __user *)args->skeydata_addr, keys,
+				 sizeof(uint8_t) * args->count);
+		if (r)
+			r = -EFAULT;
+	}
 
-	r = copy_to_user((uint8_t __user *)args->skeydata_addr, keys,
-			 sizeof(uint8_t) * args->count);
-	if (r)
-		r = -EFAULT;
-out:
 	kvfree(keys);
 	return r;
 }
@@ -1106,24 +1110,26 @@ static long kvm_s390_set_skeys(struct kvm *kvm, struct kvm_s390_skeys *args)
 	if (r)
 		goto out;
 
+	down_read(&current->mm->mmap_sem);
 	for (i = 0; i < args->count; i++) {
 		hva = gfn_to_hva(kvm, args->start_gfn + i);
 		if (kvm_is_error_hva(hva)) {
 			r = -EFAULT;
-			goto out;
+			break;
 		}
 
 		/* Lowest order bit is reserved */
 		if (keys[i] & 0x01) {
 			r = -EINVAL;
-			goto out;
+			break;
 		}
 
 		r = set_guest_storage_key(current->mm, hva,
 					  (unsigned long)keys[i], 0);
 		if (r)
-			goto out;
+			break;
 	}
+	up_read(&current->mm->mmap_sem);
 out:
 	kvfree(keys);
 	return r;
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 95916fa..c6deed7 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -728,9 +728,12 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
 
 			if (rc)
 				return rc;
-			if (set_guest_storage_key(current->mm, useraddr,
+			down_read(&current->mm->mmap_sem);
+			rc = set_guest_storage_key(current->mm, useraddr,
 					vcpu->run->s.regs.gprs[reg1] & PFMF_KEY,
-					vcpu->run->s.regs.gprs[reg1] & PFMF_NQ))
+					vcpu->run->s.regs.gprs[reg1] & PFMF_NQ);
+			up_read(&current->mm->mmap_sem);
+			if (rc)
 				return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
 		}
 
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 2a23ca9..7612a7c 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -506,12 +506,9 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 	pgste_t old, new;
 	pte_t *ptep;
 
-	down_read(&mm->mmap_sem);
 	ptep = get_locked_pte(mm, addr, &ptl);
-	if (unlikely(!ptep)) {
-		up_read(&mm->mmap_sem);
+	if (unlikely(!ptep))
 		return -EFAULT;
-	}
 
 	new = old = pgste_get_lock(ptep);
 	pgste_val(new) &= ~(PGSTE_GR_BIT | PGSTE_GC_BIT |
@@ -538,7 +535,6 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 
 	pgste_set_unlock(ptep, new);
 	pte_unmap_unlock(ptep, ptl);
-	up_read(&mm->mmap_sem);
 	return 0;
 }
 EXPORT_SYMBOL(set_guest_storage_key);
@@ -550,14 +546,11 @@ unsigned long get_guest_storage_key(struct mm_struct *mm, unsigned long addr)
 	pgste_t pgste;
 	pte_t *ptep;
 
-	down_read(&mm->mmap_sem);
 	ptep = get_locked_pte(mm, addr, &ptl);
-	if (unlikely(!ptep)) {
-		up_read(&mm->mmap_sem);
+	if (unlikely(!ptep))
 		return -EFAULT;
-	}
-	pgste = pgste_get_lock(ptep);
 
+	pgste = pgste_get_lock(ptep);
 	if (pte_val(*ptep) & _PAGE_INVALID) {
 		key  = (pgste_val(pgste) & PGSTE_ACC_BITS) >> 56;
 		key |= (pgste_val(pgste) & PGSTE_FP_BIT) >> 56;
@@ -572,10 +565,8 @@ unsigned long get_guest_storage_key(struct mm_struct *mm, unsigned long addr)
 		if (pgste_val(pgste) & PGSTE_GC_BIT)
 			key |= _PAGE_CHANGED;
 	}
-
 	pgste_set_unlock(ptep, pgste);
 	pte_unmap_unlock(ptep, ptl);
-	up_read(&mm->mmap_sem);
 	return key;
 }
 EXPORT_SYMBOL(get_guest_storage_key);
-- 
2.5.5
