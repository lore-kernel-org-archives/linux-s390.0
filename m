From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/9] KVM: s390: Cleanup usage of current->mm in set_guest_storage_key
Date: Tue, 28 Oct 2014 20:39:52 +0100
Message-ID: <1414525199-53989-3-git-send-email-borntraeger@de.ibm.com>
References: <1414525199-53989-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1414525199-53989-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, "Jason J. Herne" <jjherne@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: "Jason J. Herne" <jjherne@us.ibm.com>

In set_guest_storage_key, we really want to reference the mm struct given as
a parameter to the function. So replace the current->mm reference with the
mm struct passed in by the caller.

Signed-off-by: Jason J. Herne <jjherne@us.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/mm/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 1b79ca6..cfecc24 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -936,7 +936,7 @@ int set_guest_storage_key(struct mm_struct *mm, unsigned long addr,
 
 	down_read(&mm->mmap_sem);
 retry:
-	ptep = get_locked_pte(current->mm, addr, &ptl);
+	ptep = get_locked_pte(mm, addr, &ptl);
 	if (unlikely(!ptep)) {
 		up_read(&mm->mmap_sem);
 		return -EFAULT;
-- 
1.9.3
