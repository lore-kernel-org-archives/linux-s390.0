From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] KVM: s390/mm: fix up indentation of set_guest_storage_key
Date: Wed, 27 Aug 2014 12:20:02 +0200
Message-ID: <1409134802-62477-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, ben@decadent.org.uk, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

commit ab3f285f227f ("KVM: s390/mm: try a cow on read only pages for
key ops")' misaligned a code block. Let's fixup the indentation.

Reported-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/mm/pgtable.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 5404a62..1570dbd 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -994,13 +994,13 @@ retry:
 	}
 	if (!(pte_val(*ptep) & _PAGE_INVALID) &&
 	     (pte_val(*ptep) & _PAGE_PROTECT)) {
-			pte_unmap_unlock(*ptep, ptl);
-			if (fixup_user_fault(current, mm, addr, FAULT_FLAG_WRITE)) {
-				up_read(&mm->mmap_sem);
-				return -EFAULT;
-			}
-			goto retry;
+		pte_unmap_unlock(*ptep, ptl);
+		if (fixup_user_fault(current, mm, addr, FAULT_FLAG_WRITE)) {
+			up_read(&mm->mmap_sem);
+			return -EFAULT;
 		}
+		goto retry;
+	}
 
 	new = old = pgste_get_lock(ptep);
 	pgste_val(new) &= ~(PGSTE_GR_BIT | PGSTE_GC_BIT |
-- 
1.8.4.2
