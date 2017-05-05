Return-Path: <owner-linux-mm@kvack.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [v3 7/9] x86: teach x86 not to zero struct pages memory
Date: Fri,  5 May 2017 13:03:14 -0400
Message-Id: <1494003796-748672-8-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
References: <1494003796-748672-1-git-send-email-pasha.tatashin@oracle.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, heiko.carstens@de.ibm.com, davem@davemloft.net
List-ID: <linux-s390.vger.kernel.org>

If we are using deferred struct page initialization feature, most of
"struct page"es are getting initialized after other CPUs are started, and
hence we are benefiting from doing this job in parallel. However, we are
still zeroing all the memory that is allocated for "struct pages" using the
boot CPU.  This patch solves this problem, by deferring zeroing "struct
pages" to only when they are initialized on x86 platforms.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/x86/mm/init_64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 839e5d4..332a21e 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -1276,7 +1276,7 @@ static int __meminit vmemmap_populate_hugepages(unsigned long start,
 			void *p;
 
 			p = __vmemmap_alloc_block_buf(PMD_SIZE, node, altmap,
-						      true);
+						      VMEMMAP_ZERO);
 			if (p) {
 				pte_t entry;
 
-- 
1.7.1

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
