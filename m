Return-Path: <linux-kernel-owner+w=401wt.eu-S935460AbXJSRWH@vger.kernel.org>
Message-Id: <20071019171945.385571103@de.ibm.com>
References: <20071019171857.430999834@de.ibm.com>
Date: Fri, 19 Oct 2007 19:19:05 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 08/10] Introduce follow_table in uaccess_pt.c
Content-Disposition: inline; filename=008-mm-follow.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Define and use follow_table inline in uaccess_pt.c to simplify
the code.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

---

 arch/s390/lib/uaccess_pt.c |   85 +++++++++++----------------------------------
 1 file changed, 22 insertions(+), 63 deletions(-)

Index: quilt-2.6/arch/s390/lib/uaccess_pt.c
===================================================================
--- quilt-2.6.orig/arch/s390/lib/uaccess_pt.c
+++ quilt-2.6/arch/s390/lib/uaccess_pt.c
@@ -15,6 +15,22 @@
 #include <asm/futex.h>
 #include "uaccess.h"
 
+static inline pte_t *follow_table(struct mm_struct *mm, unsigned long addr)
+{
+	pgd_t *pgd;
+	pmd_t *pmd;
+
+	pgd = pgd_offset(mm, addr);
+	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
+		return NULL;
+
+	pmd = pmd_offset(pgd, addr);
+	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
+		return NULL;
+
+	return pte_offset_map(pmd, addr);
+}
+
 static int __handle_fault(struct mm_struct *mm, unsigned long address,
 			  int write_access)
 {
@@ -85,8 +101,6 @@ static size_t __user_copy_pt(unsigned lo
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long offset, pfn, done, size;
-	pgd_t *pgd;
-	pmd_t *pmd;
 	pte_t *pte;
 	void *from, *to;
 
@@ -94,15 +108,7 @@ static size_t __user_copy_pt(unsigned lo
 retry:
 	spin_lock(&mm->page_table_lock);
 	do {
-		pgd = pgd_offset(mm, uaddr);
-		if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
-			goto fault;
-
-		pmd = pmd_offset(pgd, uaddr);
-		if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
-			goto fault;
-
-		pte = pte_offset_map(pmd, uaddr);
+		pte = follow_table(mm, uaddr);
 		if (!pte || !pte_present(*pte) ||
 		    (write_user && !pte_write(*pte)))
 			goto fault;
@@ -142,22 +148,12 @@ static unsigned long __dat_user_addr(uns
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long pfn, ret;
-	pgd_t *pgd;
-	pmd_t *pmd;
 	pte_t *pte;
 	int rc;
 
 	ret = 0;
 retry:
-	pgd = pgd_offset(mm, uaddr);
-	if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
-		goto fault;
-
-	pmd = pmd_offset(pgd, uaddr);
-	if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
-		goto fault;
-
-	pte = pte_offset_map(pmd, uaddr);
+	pte = follow_table(mm, uaddr);
 	if (!pte || !pte_present(*pte))
 		goto fault;
 
@@ -229,8 +225,6 @@ static size_t strnlen_user_pt(size_t cou
 	unsigned long uaddr = (unsigned long) src;
 	struct mm_struct *mm = current->mm;
 	unsigned long offset, pfn, done, len;
-	pgd_t *pgd;
-	pmd_t *pmd;
 	pte_t *pte;
 	size_t len_str;
 
@@ -240,15 +234,7 @@ static size_t strnlen_user_pt(size_t cou
 retry:
 	spin_lock(&mm->page_table_lock);
 	do {
-		pgd = pgd_offset(mm, uaddr);
-		if (pgd_none(*pgd) || unlikely(pgd_bad(*pgd)))
-			goto fault;
-
-		pmd = pmd_offset(pgd, uaddr);
-		if (pmd_none(*pmd) || unlikely(pmd_bad(*pmd)))
-			goto fault;
-
-		pte = pte_offset_map(pmd, uaddr);
+		pte = follow_table(mm, uaddr);
 		if (!pte || !pte_present(*pte))
 			goto fault;
 
@@ -308,8 +294,6 @@ static size_t copy_in_user_pt(size_t n, 
 		      uaddr, done, size;
 	unsigned long uaddr_from = (unsigned long) from;
 	unsigned long uaddr_to = (unsigned long) to;
-	pgd_t *pgd_from, *pgd_to;
-	pmd_t *pmd_from, *pmd_to;
 	pte_t *pte_from, *pte_to;
 	int write_user;
 
@@ -317,39 +301,14 @@ static size_t copy_in_user_pt(size_t n, 
 retry:
 	spin_lock(&mm->page_table_lock);
 	do {
-		pgd_from = pgd_offset(mm, uaddr_from);
-		if (pgd_none(*pgd_from) || unlikely(pgd_bad(*pgd_from))) {
-			uaddr = uaddr_from;
-			write_user = 0;
-			goto fault;
-		}
-		pgd_to = pgd_offset(mm, uaddr_to);
-		if (pgd_none(*pgd_to) || unlikely(pgd_bad(*pgd_to))) {
-			uaddr = uaddr_to;
-			write_user = 1;
-			goto fault;
-		}
-
-		pmd_from = pmd_offset(pgd_from, uaddr_from);
-		if (pmd_none(*pmd_from) || unlikely(pmd_bad(*pmd_from))) {
-			uaddr = uaddr_from;
-			write_user = 0;
-			goto fault;
-		}
-		pmd_to = pmd_offset(pgd_to, uaddr_to);
-		if (pmd_none(*pmd_to) || unlikely(pmd_bad(*pmd_to))) {
-			uaddr = uaddr_to;
-			write_user = 1;
-			goto fault;
-		}
-
-		pte_from = pte_offset_map(pmd_from, uaddr_from);
+		pte_from = follow_table(mm, uaddr_from);
 		if (!pte_from || !pte_present(*pte_from)) {
 			uaddr = uaddr_from;
 			write_user = 0;
 			goto fault;
 		}
-		pte_to = pte_offset_map(pmd_to, uaddr_to);
+
+		pte_to = follow_table(mm, uaddr_to);
 		if (!pte_to || !pte_present(*pte_to) || !pte_write(*pte_to)) {
 			uaddr = uaddr_to;
 			write_user = 1;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
