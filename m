Return-Path: <owner-linux-mm@kvack.org>
From: Dominik Dingel <dingel@linux.vnet.ibm.com>
Subject: [PATCH 4/4] s390/hugetlb: add hugepages_supported define
Date: Fri,  3 Jul 2015 14:46:09 +0200
Message-Id: <1435927569-41132-5-git-send-email-dingel@linux.vnet.ibm.com>
In-Reply-To: <1435927569-41132-1-git-send-email-dingel@linux.vnet.ibm.com>
References: <1435927569-41132-1-git-send-email-dingel@linux.vnet.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-mm@kvack.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On s390 we only can enable hugepages if the underlying hardware/hypervisor
also does support this. Common code now would assume this to be signaled
by setting HPAGE_SHIFT to 0. But on s390, where we only support one
hugepage size, there is a link between HPAGE_SHIFT and pageblock_order.

So instead of setting HPAGE_SHIFT to 0, we will implement the check for the
hardware capability.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
---
 arch/s390/include/asm/hugetlb.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index 0130d03..d9be7c0 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -14,6 +14,7 @@
 
 #define is_hugepage_only_range(mm, addr, len)	0
 #define hugetlb_free_pgd_range			free_pgd_range
+#define hugepages_supported()			(MACHINE_HAS_HPAGE)
 
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pte);
-- 
2.3.8

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
