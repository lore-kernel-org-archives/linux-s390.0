From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 15/15] KVM: s390/mm: remove outdated gmap data structures
Date: Tue, 26 Aug 2014 10:28:27 +0200
Message-ID: <1409041707-39938-16-git-send-email-borntraeger@de.ibm.com>
References: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The radix tree rework removed all code that uses the gmap_rmap
and gmap_pgtable data structures. Remove these outdated definitions.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 7705180..0242588 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -814,29 +814,6 @@ struct gmap {
 };
 
 /**
- * struct gmap_rmap - reverse mapping for segment table entries
- * @gmap: pointer to the gmap_struct
- * @entry: pointer to a segment table entry
- * @vmaddr: virtual address in the guest address space
- */
-struct gmap_rmap {
-	struct list_head list;
-	struct gmap *gmap;
-	unsigned long *entry;
-	unsigned long vmaddr;
-};
-
-/**
- * struct gmap_pgtable - gmap information attached to a page table
- * @vmaddr: address of the 1MB segment in the process virtual memory
- * @mapper: list of segment table entries mapping a page table
- */
-struct gmap_pgtable {
-	unsigned long vmaddr;
-	struct list_head mapper;
-};
-
-/**
  * struct gmap_notifier - notify function block for page invalidation
  * @notifier_call: address of callback function
  */
-- 
1.8.4.2
