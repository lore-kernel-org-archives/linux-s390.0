Return-Path: <owner-linux-mm@kvack.org>
From: Dominik Dingel <dingel@linux.vnet.ibm.com>
Subject: [PATCH 1/2] mm: fixup_userfault returns VM_FAULT_RETRY if asked
Date: Thu, 19 Nov 2015 00:49:57 +0100
Message-Id: <1447890598-56860-2-git-send-email-dingel@linux.vnet.ibm.com>
In-Reply-To: <1447890598-56860-1-git-send-email-dingel@linux.vnet.ibm.com>
References: <1447890598-56860-1-git-send-email-dingel@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: linux-s390@vger.kernel.org, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Andrea Arcangeli <aarcange@redhat.com>, David Rientjes <rientjes@google.com>, Eric B Munson <emunson@akamai.com>, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>, Mel Gorman <mgorman@suse.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

When calling fixup_userfault with FAULT_FLAG_ALLOW_RETRY, fixup_userfault
didn't care about VM_FAULT_RETRY and returned 0. If the VM_FAULT_RETRY flag is
set we will return the complete result of handle_mm_fault.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
---
 mm/gup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/gup.c b/mm/gup.c
index deafa2c..2af3b31 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -609,6 +609,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
 			return -EFAULT;
 		BUG();
 	}
+	if (ret & VM_FAULT_RETRY)
+		return ret;
 	if (tsk) {
 		if (ret & VM_FAULT_MAJOR)
 			tsk->maj_flt++;
-- 
2.3.9

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
