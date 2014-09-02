From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/2] KVM: s390/mm: Fix guest storage key corruption in ptep_set_access_flags
Date: Tue,  2 Sep 2014 10:58:45 +0200
Message-ID: <1409648325-2926-3-git-send-email-borntraeger@de.ibm.com>
References: <1409648325-2926-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1409648325-2926-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, stable@vger.kernel.org, #@tuxmaker.boeblingen.de.ibm.com, v3.12+@tuxmaker.boeblingen.de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

commit 0944fe3f4a32 ("s390/mm: implement software referenced bits")
triggered another paging/storage key corruption. There is an
unhandled invalid->valid pte change where we have to set the real
storage key from the pgste.
When doing paging a guest page might be swapcache or swap and when
faulted in it might be read-only and due to a parallel scan old.
An do_wp_page will make it writeable and young. Due to software
reference tracking this page was invalid and now becomes valid.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: stable@vger.kernel.org # v3.12+
---
 arch/s390/include/asm/pgtable.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 32686e8..5efb2fe 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1331,6 +1331,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
 	ptep_flush_direct(vma->vm_mm, address, ptep);
 
 	if (mm_has_pgste(vma->vm_mm)) {
+		pgste_set_key(ptep, pgste, entry, vma->vm_mm);
 		pgste = pgste_set_pte(ptep, pgste, entry);
 		pgste_set_unlock(ptep, pgste);
 	} else
-- 
1.8.4.2
