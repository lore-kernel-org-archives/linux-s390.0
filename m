Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:19414 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728548AbgIGSEk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Sep 2020 14:04:40 -0400
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: [RFC PATCH v2 3/3] mm: make generic pXd_addr_end() macros inline functions
Date: Mon,  7 Sep 2020 20:00:58 +0200
Message-Id: <20200907180058.64880-4-gerald.schaefer@linux.ibm.com>
In-Reply-To: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>, linux-arch <linux-arch@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Russell King <linux@armlinux.org.uk>, Mike Rapoport <rppt@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Arnd Bergmann <arnd@arndb.de>, Andrey Ryabinin <aryabinin@virtuozzo.com>, linux-x86 <x86@kernel.org>, linux-arm <linux-arm-kernel@lists.infradead.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, linux-sparc <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>

From: Alexander Gordeev <agordeev@linux.ibm.com>

Since pXd_addr_end() macros take pXd page-table entry as a
parameter it makes sense to check the entry type on compile.
Even though most archs do not make use of page-table entries
in pXd_addr_end() calls, checking the type in traversal code
paths could help to avoid subtle bugs.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 include/linux/pgtable.h | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 67ebc22cf83d..d9e7d16c2263 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -656,31 +656,35 @@ static inline int arch_unmap_one(struct mm_struct *mm,
  */
 
 #ifndef pgd_addr_end
-#define pgd_addr_end(pgd, addr, end)					\
-({	unsigned long __boundary = ((addr) + PGDIR_SIZE) & PGDIR_MASK;	\
-	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
-})
+#define pgd_addr_end pgd_addr_end
+static inline unsigned long pgd_addr_end(pgd_t pgd, unsigned long addr, unsigned long end)
+{	unsigned long __boundary = (addr + PGDIR_SIZE) & PGDIR_MASK;
+	return (__boundary - 1 < end - 1) ? __boundary : end;
+}
 #endif
 
 #ifndef p4d_addr_end
-#define p4d_addr_end(p4d, addr, end)					\
-({	unsigned long __boundary = ((addr) + P4D_SIZE) & P4D_MASK;	\
-	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
-})
+#define p4d_addr_end p4d_addr_end
+static inline unsigned long p4d_addr_end(p4d_t p4d, unsigned long addr, unsigned long end)
+{	unsigned long __boundary = (addr + P4D_SIZE) & P4D_MASK;
+	return (__boundary - 1 < end - 1) ? __boundary : end;
+}
 #endif
 
 #ifndef pud_addr_end
-#define pud_addr_end(pud, addr, end)					\
-({	unsigned long __boundary = ((addr) + PUD_SIZE) & PUD_MASK;	\
-	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
-})
+#define pud_addr_end pud_addr_end
+static inline unsigned long pud_addr_end(pud_t pud, unsigned long addr, unsigned long end)
+{	unsigned long __boundary = (addr + PUD_SIZE) & PUD_MASK;
+	return (__boundary - 1 < end - 1) ? __boundary : end;
+}
 #endif
 
 #ifndef pmd_addr_end
-#define pmd_addr_end(pmd, addr, end)					\
-({	unsigned long __boundary = ((addr) + PMD_SIZE) & PMD_MASK;	\
-	(__boundary - 1 < (end) - 1)? __boundary: (end);		\
-})
+#define pmd_addr_end pmd_addr_end
+static inline unsigned long pmd_addr_end(pmd_t pmd, unsigned long addr, unsigned long end)
+{	unsigned long __boundary = (addr + PMD_SIZE) & PMD_MASK;
+	return (__boundary - 1 < end - 1) ? __boundary : end;
+}
 #endif
 
 /*
-- 
2.17.1
