From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 12/51] s390/mm: protection exceptions are corrrectly shadowed
Date: Tue, 21 Jun 2016 15:12:50 +0200
Message-ID: <1466514809-146638-13-git-send-email-borntraeger@de.ibm.com>
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

As gmap shadows contains correct protection permissions, protection
exceptons can directly be forwarded to guest 3. If we would encounter
a protection exception while faulting, the next guest 3 run will
automatically handle that for us.

Keep the dat_protection logic in place, as it will be helpful later.

Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 6 +-----
 arch/s390/kvm/gaccess.h | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 5b5eee2..b2783dd 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -1075,7 +1075,6 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
  * kvm_s390_shadow_fault - handle fault on a shadow page table
  * @sg: pointer to the shadow guest address space structure
  * @saddr: faulting address in the shadow gmap
- * @write: =1 map r/w, =0 map r/o
  *
  * Returns: - 0 if the shadow fault was successfully resolved
  *	    - > 0 (pgm exception code) on exceptions while faulting
@@ -1083,7 +1082,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
  *	    - -EFAULT when accessing invalid guest addresses
  *	    - -ENOMEM if out of memory
  */
-int kvm_s390_shadow_fault(struct gmap *sg, unsigned long saddr, int write)
+int kvm_s390_shadow_fault(struct gmap *sg, unsigned long saddr)
 {
 	union vaddress vaddr;
 	union page_table_entry pte;
@@ -1104,9 +1103,6 @@ int kvm_s390_shadow_fault(struct gmap *sg, unsigned long saddr, int write)
 		rc = PGM_PAGE_TRANSLATION;
 	if (!rc && (pte.z || pte.co))
 		rc = PGM_TRANSLATION_SPEC;
-	dat_protection |= pte.p;
-	if (!rc && write && dat_protection)
-		rc = PGM_PROTECTION;
 	if (!rc)
 		rc = gmap_shadow_page(sg, saddr, __pte(pte.val));
 	up_read(&sg->mm->mmap_sem);
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index e5ec473..0d044d0 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -361,6 +361,6 @@ void ipte_unlock(struct kvm_vcpu *vcpu);
 int ipte_lock_held(struct kvm_vcpu *vcpu);
 int kvm_s390_check_low_addr_prot_real(struct kvm_vcpu *vcpu, unsigned long gra);
 
-int kvm_s390_shadow_fault(struct gmap *shadow, unsigned long saddr, int write);
+int kvm_s390_shadow_fault(struct gmap *shadow, unsigned long saddr);
 
 #endif /* __KVM_S390_GACCESS_H */
-- 
2.5.5
