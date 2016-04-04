From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/1] s390/mm/kvm: fix mis-merge in gmap handling
Date: Mon,  4 Apr 2016 09:41:32 +0200
Message-ID: <1459755692-126047-2-git-send-email-borntraeger@de.ibm.com>
References: <1459755692-126047-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1459755692-126047-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

commit 1e133ab296f3 ("s390/mm: split arch/s390/mm/pgtable.c") dropped
some changes from commit a3a92c31bf0b ("KVM: s390: fix mismatch
between user and in-kernel guest limit") - this breaks KVM for some
memory sizes (kvm-s390: failed to commit memory region) like
exactly 2GB.

Cc: Dominik Dingel <dingel@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/mm/gmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 69247b4..cace818 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -23,7 +23,7 @@
 /**
  * gmap_alloc - allocate a guest address space
  * @mm: pointer to the parent mm_struct
- * @limit: maximum size of the gmap address space
+ * @limit: maximum address of the gmap address space
  *
  * Returns a guest address space structure.
  */
@@ -292,7 +292,7 @@ int gmap_map_segment(struct gmap *gmap, unsigned long from,
 	if ((from | to | len) & (PMD_SIZE - 1))
 		return -EINVAL;
 	if (len == 0 || from + len < from || to + len < to ||
-	    from + len > TASK_MAX_SIZE || to + len > gmap->asce_end)
+	    from + len - 1 > TASK_MAX_SIZE || to + len - 1 > gmap->asce_end)
 		return -EINVAL;
 
 	flush = 0;
-- 
2.5.5
