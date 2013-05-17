From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 8/8] s390: fix gmap_ipte_notifier vs. software dirty pages
Date: Fri, 17 May 2013 14:41:38 +0200
Message-ID: <1368794498-2051-9-git-send-email-borntraeger@de.ibm.com>
References: <1368794498-2051-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1368794498-2051-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On heavy paging load some guest cpus started to loop in gmap_ipte_notify.
This was visible as stalled cpus inside the guest. The gmap_ipte_notifier
tries to map a user page and then made sure that the pte is valid and
writable. Turns out that with the software change bit tracking the pte
can become read-only (and only software writable) if the page is clean.
Since we loop in this code, the page would stay clean and, therefore,
be never writable again.
Let us just use fixup_user_fault, that guarantees to call handle_mm_fault.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/mm/pgtable.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 5ca7568..1e0c438 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -677,8 +677,7 @@ int gmap_ipte_notify(struct gmap *gmap, unsigned long start, unsigned long len)
 			break;
 		}
 		/* Get the page mapped */
-		if (get_user_pages(current, gmap->mm, addr, 1, 1, 0,
-				   NULL, NULL) != 1) {
+		if (fixup_user_fault(current, gmap->mm, addr, FAULT_FLAG_WRITE)) {
 			rc = -EFAULT;
 			break;
 		}
-- 
1.8.1.4
