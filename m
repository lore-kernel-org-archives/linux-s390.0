Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B28C3FDBFD;
	Tue,  2 Jun 2026 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422512; cv=none; b=f8WvRxu7/RENbR2CdWKLnEYJ7DQevKz+sjDc8jw5I6fGaMUCZhtIFRt1qAjKQ9Unq08zRP9tDSQiqFRsOC2DpZ9/tZ5QfQHpT9uF3Nf5icZgGgA6PKPRG8b1/za2jXUrH1Kyf/yWHrmrEFhwllD6W6v+I04WX2TeYDzjR9xChEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422512; c=relaxed/simple;
	bh=v4NWr+b7HRVRLhMyJmkjMlbKAJKdf2+NQjtG+FjiNs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPcJg/d/8N/loRZDU/L3DT8reXIdMFuwuu4sO9GM4kYrgtdhQNbGG66q9zY5ZrKF7OfCd65Zk3mMiLFdxLjk97gK+gl5V0YwKqYSDcN+rLvuWVw747wQRP2GwNNHz/uOIrJXyeUhUCmJJIh/kLqy8OGKfxXNf+XZZu8GT3VZ+aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q8TarF/I; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q8TarF/I"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652Hlv1S2061758;
	Tue, 2 Jun 2026 17:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=qsNAgTggVMUQZKzmf
	ufaqxfN3+MRtC4U6H5q//zXa+g=; b=q8TarF/I2MNEu/kXMo8uxxAEWII3S6t2B
	Ul3DwSdK9h1/efDJBhb3WZfNlT6AJEHrHqN8wK9Nx8bwhzQ1kXb+WrEQDNMYl+Y4
	K15vib8aZGAKgvLWRdByyQgPNOEg32d348tcZTdbYSpt3m0VQvmFOR1YmidIe8g5
	TwU0FoknljBNiOWG5k1+IyS+nfTph1osj6bz+2RXmwFJlAgKuutRcUnvBh9yN/9A
	oL3fR7Xh9qcqeRXyJGriQya7xyIskwLg6M7dhCP/tAwsUcae9Fhdq/Ue1Lm52LDO
	qw24OL3YPWcOPz77+T2XaDoYcR+GPLpoAMwDpjvqCkpWEnFxKM7oQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4y76m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652HdWtV027977;
	Tue, 2 Jun 2026 17:48:25 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k4ejy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:25 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652HmJ2230278230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 17:48:19 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5CE520040;
	Tue,  2 Jun 2026 17:48:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A91372004D;
	Tue,  2 Jun 2026 17:48:19 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 17:48:19 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 03/10] KVM: s390: Avoid potentially sleeping while atomic when zapping pages
Date: Tue,  2 Jun 2026 19:48:12 +0200
Message-ID: <20260602174819.255785-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602174819.255785-1-imbrenda@linux.ibm.com>
References: <20260602174819.255785-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: kfRhxIF3zVx_YFZrPHPvLIobXhfK3pSb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE3MCBTYWx0ZWRfX3jy5bTvjJuzu
 K52s0Vff2g371yy55mWX7hdBAJA7tk3O1tmWW7S5OUCatLSbNCvsYfO8oexAHM5gn3eu2sH1/YH
 JlMh0fzDsemkqYX/pBdjostTKy/cpaxWJBtrLfvVEMhVhb1rgk4v4sA8SltgZh9Db8Iz+MOpPP+
 qYpdcGA/uPppKZtXnbvlnVBVLWwdJglSwXkfVFV5fVuoc3BQVT4B4o7BLYcpRhBo1huI+CAO2q7
 j8JdlzxknoLhGfxF66sa6Pc4g2uCKzGhKvkLabuMrvFJBOeFpc/0N3o0gzzQ3Opoo5BuxfXIskv
 3zhigM65ehjMk0mwmHpmPBK8zeuWzOgN2pPH+m5ImppuIWguau/c1/Qpd98BpBK4WmlFJqvwarF
 CIlZrei8oRqd9Us8bGnfG5ZnhLBB7GzN3uFjbLmTbqECE8ZF4Yq+PFBCv3oF5Xm9Fb6QFR2PmRQ
 xvozJr7+HP3zy6y9zJg==
X-Proofpoint-ORIG-GUID: kfRhxIF3zVx_YFZrPHPvLIobXhfK3pSb
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1f176b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=nBeMyYop4p2-dv3G0y8A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020170

Factor out try_get_locked_pte(), which behaves similarly to
get_locked_pte(), but does not attempt to allocate missing tables and
performs a spin_trylock() instead of blocking.

The new function is also exported, since it will be used in other
patches.

If intermediate entries are missing, there can be no pte swap entry to
free, so it's safe to ignore them.

This avoids potentially sleeping while atomic.

Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260602142356.169458-4-imbrenda@linux.ibm.com>
---
 arch/s390/include/asm/gmap_helpers.h |   1 +
 arch/s390/mm/gmap_helpers.c          | 117 ++++++++++++++++-----------
 2 files changed, 73 insertions(+), 45 deletions(-)

diff --git a/arch/s390/include/asm/gmap_helpers.h b/arch/s390/include/asm/gmap_helpers.h
index 2d3ae421077e..d2b616604a46 100644
--- a/arch/s390/include/asm/gmap_helpers.h
+++ b/arch/s390/include/asm/gmap_helpers.h
@@ -12,5 +12,6 @@ void gmap_helper_zap_one_page(struct mm_struct *mm, unsigned long vmaddr);
 void gmap_helper_discard(struct mm_struct *mm, unsigned long vmaddr, unsigned long end);
 int gmap_helper_disable_cow_sharing(void);
 void gmap_helper_try_set_pte_unused(struct mm_struct *mm, unsigned long vmaddr);
+pte_t *try_get_locked_pte(struct mm_struct *mm, unsigned long addr, spinlock_t **ptl);
 
 #endif /* _ASM_S390_GMAP_HELPERS_H */
diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index f8789ffcc05c..396207163ca6 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -34,6 +34,70 @@ static void ptep_zap_softleaf_entry(struct mm_struct *mm, softleaf_t entry)
 	swap_put_entries_direct(entry, 1);
 }
 
+/**
+ * try_get_locked_pte() - like get_locked_pte(), but atomic and with trylock
+ * @mm: the mm
+ * @vmaddr: the userspace virtual address whose pte is to be found
+ * @ptl: will be set to the pointer to the lock used to lock the pte in case
+ *       of success.
+ *
+ * This function returns the pointer to the pte corresponding to @addr in @mm,
+ * similarly to get_locked_pte(). Unlike get_locked_pte(), no attempt is made
+ * to allocate missing page tables. If a missing or large entry is found, the
+ * function will return NULL. If the ptl lock is contended, %-EAGAIN is
+ * returned.
+ *
+ * In case of success, *@ptl will point to the locked pte lock for the returned
+ * pte, like get_locked_pte() does.
+ *
+ * Context: mmap_lock or vma lock for read or for write needs to be held.
+ * Return:
+ * * %NULL if the pte cannot be reached.
+ * * %-EAGAIN if the pte can be reached, but cannot be locked.
+ * * the pointer to the pte corresponding to @addr in @mm, if it can be reached
+ *   and locked.
+ */
+pte_t *try_get_locked_pte(struct mm_struct *mm, unsigned long vmaddr, spinlock_t **ptl)
+{
+	pmd_t *pmdp, pmd, pmdval;
+	pud_t *pudp, pud;
+	p4d_t *p4dp, p4d;
+	pgd_t *pgdp, pgd;
+	pte_t *ptep;
+
+	pgdp = pgd_offset(mm, vmaddr);
+	pgd = pgdp_get(pgdp);
+	if (pgd_none(pgd) || !pgd_present(pgd))
+		return NULL;
+	p4dp = p4d_offset(pgdp, vmaddr);
+	p4d = p4dp_get(p4dp);
+	if (p4d_none(p4d) || !p4d_present(p4d))
+		return NULL;
+	pudp = pud_offset(p4dp, vmaddr);
+	pud = pudp_get(pudp);
+	if (pud_none(pud) || pud_leaf(pud) || !pud_present(pud))
+		return NULL;
+	pmdp = pmd_offset(pudp, vmaddr);
+	pmd = pmdp_get_lockless(pmdp);
+	if (pmd_none(pmd) || pmd_leaf(pmd) || !pmd_present(pmd))
+		return NULL;
+	ptep = pte_offset_map_rw_nolock(mm, pmdp, vmaddr, &pmdval, ptl);
+	if (!ptep)
+		return NULL;
+
+	if (spin_trylock(*ptl)) {
+		if (unlikely(!pmd_same(pmdval, pmdp_get_lockless(pmdp)))) {
+			pte_unmap_unlock(ptep, *ptl);
+			return ERR_PTR(-EAGAIN);
+		}
+		return ptep;
+	}
+
+	pte_unmap(ptep);
+	return ERR_PTR(-EAGAIN);
+}
+EXPORT_SYMBOL_GPL(try_get_locked_pte);
+
 /**
  * gmap_helper_zap_one_page() - discard a page if it was swapped.
  * @mm: the mm
@@ -46,7 +110,7 @@ static void ptep_zap_softleaf_entry(struct mm_struct *mm, softleaf_t entry)
 void gmap_helper_zap_one_page(struct mm_struct *mm, unsigned long vmaddr)
 {
 	struct vm_area_struct *vma;
-	spinlock_t *ptl;
+	spinlock_t *ptl;	/* Lock for the host (userspace) page table */
 	pte_t *ptep;
 
 	mmap_assert_locked(mm);
@@ -57,8 +121,8 @@ void gmap_helper_zap_one_page(struct mm_struct *mm, unsigned long vmaddr)
 		return;
 
 	/* Get pointer to the page table entry */
-	ptep = get_locked_pte(mm, vmaddr, &ptl);
-	if (unlikely(!ptep))
+	ptep = try_get_locked_pte(mm, vmaddr, &ptl);
+	if (IS_ERR_OR_NULL(ptep))
 		return;
 	if (pte_swap(*ptep)) {
 		ptep_zap_softleaf_entry(mm, softleaf_from_pte(*ptep));
@@ -113,37 +177,9 @@ EXPORT_SYMBOL_GPL(gmap_helper_discard);
  */
 void gmap_helper_try_set_pte_unused(struct mm_struct *mm, unsigned long vmaddr)
 {
-	pmd_t *pmdp, pmd, pmdval;
-	pud_t *pudp, pud;
-	p4d_t *p4dp, p4d;
-	pgd_t *pgdp, pgd;
 	spinlock_t *ptl;	/* Lock for the host (userspace) page table */
 	pte_t *ptep;
 
-	pgdp = pgd_offset(mm, vmaddr);
-	pgd = pgdp_get(pgdp);
-	if (pgd_none(pgd) || !pgd_present(pgd))
-		return;
-
-	p4dp = p4d_offset(pgdp, vmaddr);
-	p4d = p4dp_get(p4dp);
-	if (p4d_none(p4d) || !p4d_present(p4d))
-		return;
-
-	pudp = pud_offset(p4dp, vmaddr);
-	pud = pudp_get(pudp);
-	if (pud_none(pud) || pud_leaf(pud) || !pud_present(pud))
-		return;
-
-	pmdp = pmd_offset(pudp, vmaddr);
-	pmd = pmdp_get_lockless(pmdp);
-	if (pmd_none(pmd) || pmd_leaf(pmd) || !pmd_present(pmd))
-		return;
-
-	ptep = pte_offset_map_rw_nolock(mm, pmdp, vmaddr, &pmdval, &ptl);
-	if (!ptep)
-		return;
-
 	/*
 	 * Several paths exists that takes the ptl lock and then call the
 	 * mmu_notifier, which takes the mmu_lock. The unmap path, instead,
@@ -156,21 +192,12 @@ void gmap_helper_try_set_pte_unused(struct mm_struct *mm, unsigned long vmaddr)
 	 * If the lock is contended the bit is not set and the deadlock is
 	 * avoided.
 	 */
-	if (spin_trylock(ptl)) {
-		/*
-		 * Make sure the pte we are touching is still the correct
-		 * one. In theory this check should not be needed, but
-		 * better safe than sorry.
-		 * Disabling interrupts or holding the mmap lock is enough to
-		 * guarantee that no concurrent updates to the page tables
-		 * are possible.
-		 */
-		if (likely(pmd_same(pmdval, pmdp_get_lockless(pmdp))))
-			__atomic64_or(_PAGE_UNUSED, (long *)ptep);
-		spin_unlock(ptl);
-	}
+	ptep = try_get_locked_pte(mm, vmaddr, &ptl);
+	if (IS_ERR_OR_NULL(ptep))
+		return;
 
-	pte_unmap(ptep);
+	__atomic64_or(_PAGE_UNUSED, (long *)ptep);
+	pte_unmap_unlock(ptep, ptl);
 }
 EXPORT_SYMBOL_GPL(gmap_helper_try_set_pte_unused);
 
-- 
2.54.0

