Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389047AbgE1L5h (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 28 May 2020 07:57:37 -0400
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 10/17] s390/mm: fix set_huge_pte_at() for empty ptes
Date: Thu, 28 May 2020 07:57:17 -0400
Message-Id: <20200528115724.1406376-10-sashal@kernel.org>
In-Reply-To: <20200528115724.1406376-1-sashal@kernel.org>
References: <20200528115724.1406376-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Gerald Schaefer <gerald.schaefer@de.ibm.com>

[ Upstream commit ac8372f3b4e41015549b331a4f350224661e7fc6 ]

On s390, the layout of normal and large ptes (i.e. pmds/puds) differs.
Therefore, set_huge_pte_at() does a conversion from a normal pte to
the corresponding large pmd/pud. So, when converting an empty pte, this
should result in an empty pmd/pud, which would return true for
pmd/pud_none().

However, after conversion we also mark the pmd/pud as large, and
therefore present. For empty ptes, this will result in an empty pmd/pud
that is also marked as large, and pmd/pud_none() would not return true.

There is currently no issue with this behaviour, as set_huge_pte_at()
does not seem to be called for empty ptes. It would be valid though, so
let's fix this by not marking empty ptes as large in set_huge_pte_at().

This was found by testing a patch from from Anshuman Khandual, which is
currently discussed on LKML ("mm/debug: Add more arch page table helper
tests").

Signed-off-by: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/mm/hugetlbpage.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index 5674710a4841..7dfae86afa47 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -159,10 +159,13 @@ void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		rste &= ~_SEGMENT_ENTRY_NOEXEC;
 
 	/* Set correct table type for 2G hugepages */
-	if ((pte_val(*ptep) & _REGION_ENTRY_TYPE_MASK) == _REGION_ENTRY_TYPE_R3)
-		rste |= _REGION_ENTRY_TYPE_R3 | _REGION3_ENTRY_LARGE;
-	else
+	if ((pte_val(*ptep) & _REGION_ENTRY_TYPE_MASK) == _REGION_ENTRY_TYPE_R3) {
+		if (likely(pte_present(pte)))
+			rste |= _REGION3_ENTRY_LARGE;
+		rste |= _REGION_ENTRY_TYPE_R3;
+	} else if (likely(pte_present(pte)))
 		rste |= _SEGMENT_ENTRY_LARGE;
+
 	clear_huge_pte_skeys(mm, rste);
 	pte_val(*ptep) = rste;
 }
-- 
2.25.1
