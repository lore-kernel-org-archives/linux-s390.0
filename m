Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D9C3E51EB;
	Thu, 28 May 2026 11:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779968860; cv=none; b=VXP9AnSo4v16mdMdvnEJaPsyvHTap9gKFBw+9B/aR8nEslncrM1TRnhDCEqp+/FGfdlpKt/eJpLlBwkY7OCVGJoJyVZSk0b0rbl1KTm4eo8Uu2kNX16578r6hRVF27ChTvsjwiRnCFtF+CzGpoNfQNDQkukcmopFn5xnWNa/hUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779968860; c=relaxed/simple;
	bh=KcWzFIJyeOz0CyW0ycOf9Nvhktx9m8X2twnvInSZdXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U0GhybHX8a2lt2Y4kTxX6E8pKRq0bx977MVWF7KGv9a4KeAt67kHFrrgvmVqgTakc75alJdLYKCpe176a8ETAmz51qw4wkz3p/J3qrSeqRFjhlGKqwCfggrxbzJne6gLvdObLYTsvRmJGG2B9klBIB0oYBZb5bm1VesjxJKLID0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RhUK8ZRu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RhUK8ZRu"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64RL737E035143;
	Thu, 28 May 2026 11:47:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nJz2rRzMdSggIxrDR
	Oj8YVb/QSZNZw7wjHi+DpMSPCQ=; b=RhUK8ZRunnCIrDcnKpjEuPAMoFSFrhJq+
	5H8lutfaNk1F8Ocr5DOtYTSkHEyaYcOWK7E8FfAo8v/UdmGAIB+WU35u/ZRKW97B
	2pjeHtxRZ9GToqpTS9zPSQ1MNyWoUq4L4VYzfq4tsv4Q6lfU240vAssKBTXV6Wn7
	fkM7jtgrMLq8Q/udGL39dmpAQ+U2kfGUsqSEnzU5c72TO9hrt74Ak06JFqf0RsW1
	zwwtofEU+hLEjUuW7PH4lvqP6BKN4V52uM0WGQnbPCLWhrSB6GbSOCFyl3I80YZ4
	a03HPYV2b89cNEZU6730R4Tu4rZYKLY0SxJu4QK2GUZRT9JXr6KTQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee88bammm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:47:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64SBdGec004692;
	Thu, 28 May 2026 11:47:35 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbyv6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 May 2026 11:47:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64SBlT4U51118572
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 May 2026 11:47:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7E71420040;
	Thu, 28 May 2026 11:47:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E2D02004B;
	Thu, 28 May 2026 11:47:29 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 May 2026 11:47:29 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v1 5/7] KVM: s390: Avoid potentially sleeping while atomic when zapping pages
Date: Thu, 28 May 2026 13:47:25 +0200
Message-ID: <20260528114727.142178-6-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528114727.142178-1-imbrenda@linux.ibm.com>
References: <20260528114727.142178-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDExNyBTYWx0ZWRfX1mzdcBhiOgFS
 UEuY9FQZ2pxeO3uEXqxblV6GJGhI6l/loF0h3Cx0Gd923pSKXIWXYNEhQ9rdfDcxXctWG50Czny
 C9T8RnIszYe0vnFdkAe+sUtCFgHtXPP5ujH10Kmfw2HgdFZr4QFzSa3ZSgRY+GzjUL5n4IlEwjc
 vfs0JwmtIjZtn51NuRTw3Os8InExG3eXe0Yv/F5ZOjdeWl5y4Gw1O6zS5d8oVfD1QfFzw12kBBm
 nN53uqUrJoawERVyMXSoi+yNI8Zbq9ISYASkUrnk69pHpuGVST+s/ho3Iew8ahLsfPngGKf81ab
 h7N6gQ6b9MbePX7pfkNYkOxC1yy9ejM4k4IZYYVCtdjO1MCg+hTHopl9I9G7OLeUzw6hqG7NeJL
 IXY6DHZab+yYJBMJ3ReUKjINNfOBnfLR0Sae+1EsnkdAqEmJS7vdeYZDKkrsLQ8p4S0dl9W8T2h
 orSVgiItPolke3Av8cg==
X-Proofpoint-ORIG-GUID: pgUtLha__K8grtI5k34QSGpGkMkFeo1l
X-Authority-Analysis: v=2.4 cv=IJEyzAvG c=1 sm=1 tr=0 ts=6a182b57 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=nBeMyYop4p2-dv3G0y8A:9
X-Proofpoint-GUID: pgUtLha__K8grtI5k34QSGpGkMkFeo1l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_03,2026-05-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605280117

Factor out try_get_locked_pte(), which behaves similarly to
get_locked_pte(), but does not attempt to allocate missing tables and
performs a spin_trylock() instead of blocking.

The new function is also exported, since it will be used in other
patches.

If intermediate entries are missing, there can be no pte swap entry to
free, so it's safe to ignore them.

This avoids potentially sleeping while atomic.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: e38c884df921 ("KVM: s390: Switch to new gmap")
---
 arch/s390/include/asm/gmap_helpers.h |   1 +
 arch/s390/mm/gmap_helpers.c          | 111 ++++++++++++++++-----------
 2 files changed, 68 insertions(+), 44 deletions(-)

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
index f8789ffcc05c..7ba15f307bb0 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -34,6 +34,66 @@ static void ptep_zap_softleaf_entry(struct mm_struct *mm, softleaf_t entry)
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
+ * function will return NULL. If the ptl lock is contended, NULL is returned.
+ *
+ * In case of success, *@ptl will point to the locked pte lock for the returned
+ * pte, like get_locked_pte() does.
+ *
+ * Context: mmap_lock or vma lock for read or for write needs to be held.
+ * Return: the pointer to the pte corresponding to @addr in @mm, if possible,
+ *         otherwise NULL.
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
+			return NULL;
+		}
+		return ptep;
+	}
+
+	pte_unmap(ptep);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(try_get_locked_pte);
+
 /**
  * gmap_helper_zap_one_page() - discard a page if it was swapped.
  * @mm: the mm
@@ -46,7 +106,7 @@ static void ptep_zap_softleaf_entry(struct mm_struct *mm, softleaf_t entry)
 void gmap_helper_zap_one_page(struct mm_struct *mm, unsigned long vmaddr)
 {
 	struct vm_area_struct *vma;
-	spinlock_t *ptl;
+	spinlock_t *ptl;	/* Lock for the host (userspace) page table */
 	pte_t *ptep;
 
 	mmap_assert_locked(mm);
@@ -57,7 +117,7 @@ void gmap_helper_zap_one_page(struct mm_struct *mm, unsigned long vmaddr)
 		return;
 
 	/* Get pointer to the page table entry */
-	ptep = get_locked_pte(mm, vmaddr, &ptl);
+	ptep = try_get_locked_pte(mm, vmaddr, &ptl);
 	if (unlikely(!ptep))
 		return;
 	if (pte_swap(*ptep)) {
@@ -113,37 +173,9 @@ EXPORT_SYMBOL_GPL(gmap_helper_discard);
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
@@ -156,21 +188,12 @@ void gmap_helper_try_set_pte_unused(struct mm_struct *mm, unsigned long vmaddr)
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
+	if (!ptep)
+		return;
 
-	pte_unmap(ptep);
+	__atomic64_or(_PAGE_UNUSED, (long *)ptep);
+	pte_unmap_unlock(ptep, ptl);
 }
 EXPORT_SYMBOL_GPL(gmap_helper_try_set_pte_unused);
 
-- 
2.54.0

