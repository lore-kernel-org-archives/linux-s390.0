Return-Path: <SRS0=A1VX=SJ=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Thomas Huth <thuth@redhat.com>
Subject: [PATCH] s390/mm: Silence compiler warning when compiling without CONFIG_PGSTE
Date: Sun,  7 Apr 2019 14:55:09 +0200
Message-Id: <20190407125509.6380-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
Cc: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

If CONFIG_PGSTE is not set (e.g. when compiling without KVM), GCC complains:

  CC      arch/s390/mm/pgtable.o
arch/s390/mm/pgtable.c:413:15: warning: ‘pmd_alloc_map’ defined but not
 used [-Wunused-function]
 static pmd_t *pmd_alloc_map(struct mm_struct *mm, unsigned long addr)
               ^~~~~~~~~~~~~

Wrap the function with "#ifdef CONFIG_PGSTE" to silence the warning.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/s390/mm/pgtable.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 8485d6dc2754..9ebd01219812 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -410,6 +410,7 @@ static inline pmd_t pmdp_flush_lazy(struct mm_struct *mm,
 	return old;
 }
 
+#ifdef CONFIG_PGSTE
 static pmd_t *pmd_alloc_map(struct mm_struct *mm, unsigned long addr)
 {
 	pgd_t *pgd;
@@ -427,6 +428,7 @@ static pmd_t *pmd_alloc_map(struct mm_struct *mm, unsigned long addr)
 	pmd = pmd_alloc(mm, pud, addr);
 	return pmd;
 }
+#endif
 
 pmd_t pmdp_xchg_direct(struct mm_struct *mm, unsigned long addr,
 		       pmd_t *pmdp, pmd_t new)
-- 
2.21.0
