From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 13/51] s390/mm: take ipte_lock during shadow faults
Date: Tue, 21 Jun 2016 15:12:51 +0200
Message-ID: <1466514809-146638-14-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's take the ipte_lock while working on guest 2 provided page table, just
like the other gaccess functions.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 11 ++++++++++-
 arch/s390/kvm/gaccess.h |  3 ++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index b2783dd..e70f916 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1073,6 +1073,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 
 /**
  * kvm_s390_shadow_fault - handle fault on a shadow page table
+ * @vcpu: virtual cpu
  * @sg: pointer to the shadow guest address space structure
  * @saddr: faulting address in the shadow gmap
  *
@@ -1082,7 +1083,8 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
  *	    - -EFAULT when accessing invalid guest addresses
  *	    - -ENOMEM if out of memory
  */
-int kvm_s390_shadow_fault(struct gmap *sg, unsigned long saddr)
+int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
+			  unsigned long saddr)
 {
 	union vaddress vaddr;
 	union page_table_entry pte;
@@ -1091,6 +1093,12 @@ int kvm_s390_shadow_fault(struct gmap *sg, unsigned long saddr)
 	int rc;
 
 	down_read(&sg->mm->mmap_sem);
+	/*
+	 * We don't want any guest-2 tables to change - so the parent
+	 * tables/pointers we read stay valid - unshadowing is however
+	 * always possible - only guest_table_lock protects us.
+	 */
+	ipte_lock(vcpu);
 
 	rc = gmap_shadow_pgt_lookup(sg, saddr, &pgt, &dat_protection);
 	if (rc)
@@ -1105,6 +1113,7 @@ int kvm_s390_shadow_fault(struct gmap *sg, unsigned long saddr)
 		rc = PGM_TRANSLATION_SPEC;
 	if (!rc)
 		rc = gmap_shadow_page(sg, saddr, __pte(pte.val));
+	ipte_unlock(vcpu);
 	up_read(&sg->mm->mmap_sem);
 	return rc;
 }
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index 0d044d0..8756569 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -361,6 +361,7 @@ void ipte_unlock(struct kvm_vcpu *vcpu);
 int ipte_lock_held(struct kvm_vcpu *vcpu);
 int kvm_s390_check_low_addr_prot_real(struct kvm_vcpu *vcpu, unsigned long gra);
 
-int kvm_s390_shadow_fault(struct gmap *shadow, unsigned long saddr);
+int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *shadow,
+			  unsigned long saddr);
 
 #endif /* __KVM_S390_GACCESS_H */
-- 
2.5.5
