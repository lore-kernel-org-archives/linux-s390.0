Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:22108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727387AbhAMJmY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Jan 2021 04:42:24 -0500
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [PATCH 10/14] s390/mm: Add simple ptep shadow function
Date: Wed, 13 Jan 2021 09:41:09 +0000
Message-Id: <20210113094113.133668-11-frankja@linux.ibm.com>
In-Reply-To: <20210113094113.133668-1-frankja@linux.ibm.com>
References: <20210113094113.133668-1-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, david@redhat.com, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com

Let's factor out setting the shadow pte, so we can reuse that function
for later huge to 4k shadows where we don't have a spte or spgste.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h |  1 +
 arch/s390/mm/pgtable.c          | 24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 6d6ad508f9c7..d2c005f35c9c 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1145,6 +1145,7 @@ void ptep_zap_unused(struct mm_struct *mm, unsigned long addr,
 void ptep_zap_key(struct mm_struct *mm, unsigned long addr, pte_t *ptep);
 int ptep_shadow_pte(struct mm_struct *mm, unsigned long saddr,
 		    pte_t *sptep, pte_t *tptep, pte_t pte);
+void ptep_shadow_set(pte_t spte, pte_t *tptep, pte_t pte);
 void ptep_unshadow_pte(struct mm_struct *mm, unsigned long saddr, pte_t *ptep);
 
 unsigned long ptep_get_and_clear_notification_bits(pte_t *ptep);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 16896f936d32..6066c7ef027a 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -645,11 +645,24 @@ int ptep_force_prot(struct mm_struct *mm, unsigned long addr,
 	return 0;
 }
 
+void ptep_shadow_set(pte_t spte, pte_t *tptep, pte_t pte)
+{
+	pte_t tpte;
+	pgste_t tpgste;
+
+	tpgste = pgste_get_lock(tptep);
+	pte_val(tpte) = (pte_val(spte) & PAGE_MASK) |
+		(pte_val(pte) & _PAGE_PROTECT);
+	/* don't touch the storage key - it belongs to parent pgste */
+	tpgste = pgste_set_pte(tptep, tpgste, tpte);
+	pgste_set_unlock(tptep, tpgste);
+}
+
 int ptep_shadow_pte(struct mm_struct *mm, unsigned long saddr,
 		    pte_t *sptep, pte_t *tptep, pte_t pte)
 {
-	pgste_t spgste, tpgste;
-	pte_t spte, tpte;
+	pgste_t spgste;
+	pte_t spte;
 	int rc = -EAGAIN;
 
 	if (!(pte_val(*tptep) & _PAGE_INVALID))
@@ -660,12 +673,7 @@ int ptep_shadow_pte(struct mm_struct *mm, unsigned long saddr,
 	    !((pte_val(spte) & _PAGE_PROTECT) &&
 	      !(pte_val(pte) & _PAGE_PROTECT))) {
 		pgste_val(spgste) |= PGSTE_VSIE_BIT;
-		tpgste = pgste_get_lock(tptep);
-		pte_val(tpte) = (pte_val(spte) & PAGE_MASK) |
-				(pte_val(pte) & _PAGE_PROTECT);
-		/* don't touch the storage key - it belongs to parent pgste */
-		tpgste = pgste_set_pte(tptep, tpgste, tpte);
-		pgste_set_unlock(tptep, tpgste);
+		ptep_shadow_set(spte, tptep, pte);
 		rc = 1;
 	}
 	pgste_set_unlock(sptep, spgste);
-- 
2.27.0
