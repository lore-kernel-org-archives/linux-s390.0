Return-Path: <owner-linux-mm@kvack.org>
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH] mm: warn only once if page table misaccounting is detected
Date: Tue, 27 Nov 2018 09:36:03 +0100
Message-Id: <20181127083603.39041-1-heiko.carstens@de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-mm@kvack.org, Heiko Carstens <heiko.carstens@de.ibm.com>, "Kirill A . Shutemov" <kirill@shutemov.name>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Use pr_alert_once() instead of pr_alert() if page table misaccounting
has been detected.

If this happens once it is very likely that there will be numerous
other occurrence as well, which would flood dmesg and the console with
hardly any added information. Therefore print the warning only once.

Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 kernel/fork.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 07cddff89c7b..c887e9eba89f 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -647,8 +647,8 @@ static void check_mm(struct mm_struct *mm)
 	}
 
 	if (mm_pgtables_bytes(mm))
-		pr_alert("BUG: non-zero pgtables_bytes on freeing mm: %ld\n",
-				mm_pgtables_bytes(mm));
+		pr_alert_once("BUG: non-zero pgtables_bytes on freeing mm: %ld\n",
+			      mm_pgtables_bytes(mm));
 
 #if defined(CONFIG_TRANSPARENT_HUGEPAGE) && !USE_SPLIT_PMD_PTLOCKS
 	VM_BUG_ON_MM(mm->pmd_huge_pte, mm);
-- 
2.16.4
