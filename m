Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38243D410C;
	Mon, 15 Jun 2026 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781515073; cv=none; b=lmuvwQlLjKeAnLnhnruBSEgOCkv/0TBtXIdyRUIDfFLPOhNU9qYf9Y0aTqmaKKkbqipg3sJF0TNUFCN7BSQZbj7EvGPHlZBNCTjG/FRZ9NCRHgFFpM9hCqNZ87w+RtvJIi0fWD1S3qPD3r9X8xcLFyitbJpdhVqpERzxjxp/4A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781515073; c=relaxed/simple;
	bh=6ycaXCdvFnQX2N+3t1IOpO9wQr0dlkc8UpEJTedQkfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iuNdAiwXNkcrYnXi7GExR4M0BdnM241DQZCLDpD0PSxtPS3qVTcRBxDjPVnt7nyzKjXyptCjKJ8wwGUNSecbg8o8Qmid0mt/W6Jp395Q+tL8pSFTLU5Ku8Y9h6OmcRyk+PClbc3L9QhaQWQ2Qm1TmkeV/I2SwYfs7XMB4/pAjWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FMDn1eEi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FMDn1eEi"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65F6LdX31590404;
	Mon, 15 Jun 2026 09:17:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=to8EXYD+gtAALUwKT
	MLyVL0YgbpV19kZCrg1sEfWMdI=; b=FMDn1eEioOCoCTzVFUOi76bXrFK4s2NGN
	FPeTjffm9c1rXJ7atkR0AgB20qtt8tits3rEL6MXDiHcUq3Z2+Rw9D0MD0Myj8QM
	8CTSPKlWpUyFlkk6s1NCyKBpZ2P6lZsiCJQNM8Rb7OcaI/Ds4Z/OKt26nni3unzJ
	Ex9GTbXaMPiPXmOqpnxQTMXdBmdw11pUnm+h+4eGlIHoTFdwY72/I4T7WGl4U8P7
	dK6eMBrFMhcnWmBztB7VCQWxikGngX+/E+KtBdXoAWejCZ0liNJ6271nCJMWdtlM
	T6VU6uWkkznffwRKqJkym9YAkfHZPj4UjjJkh7wZV0JeGfbaqsyIw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1v27a7m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 09:17:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65F94dAR012658;
	Mon, 15 Jun 2026 09:17:47 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshwvwyma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 09:17:47 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65F9HiG815925682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 09:17:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB70A20043;
	Mon, 15 Jun 2026 09:17:43 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F34D82004B;
	Mon, 15 Jun 2026 09:17:42 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.31.49])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 09:17:42 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v2 1/1] s390/mm: Fix handling of _PAGE_UNUSED pte bit
Date: Mon, 15 Jun 2026 11:17:41 +0200
Message-ID: <20260615091741.76724-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615091741.76724-1-imbrenda@linux.ibm.com>
References: <20260615091741.76724-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfX5/3AzwAob6uE
 FHdgDB1Gsz9yvkeuGH0GL8+9cCwlmkO4V6zPUs8JLXGs26ZRHd2dN1Ia4tXG/uDF2EMZM2QasY6
 ubZxE9OsmrRMlb7DbgCBY/iEgL2HDjU=
X-Proofpoint-GUID: OwCrguQzOaPwwwuUBAj-pC2qtzkdgssg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA5MiBTYWx0ZWRfX3NHLBWLPiasR
 OZO1BL9wIgiduPSgXzLkkiQk/k7A/8wRW8kHhnjePc8maX71gzRQFmezRr722DM4DW93PgJfVz9
 jizL797orVqiII0F4ln0GWtHlSpCvzAMkt2zJoj4hsUczzyR26/FuGjjajt0ya2Bmu9iFW5oPv1
 5AiYdNvhrWWhlWal6hzp8NlaJChAx6GoTqjQ0bD1yCK+amGRscOzqzXKLLQWjx0SyUBMMRvtot5
 9LE3lyhGIsl1PbVhzJ8wwpU//KfYpBAz73a546uL6T9UEDr7AF+shhvgxoZYOCnm3zOYUwjaJrR
 QhFOL/vkveWUg+iYjCkU3Qa0eij0dJm/kX5iU6hCRi0QrsyEJnPDiClQ6OfvD73f747ozbHl6cy
 p8DEgQfqAaCXN60S4jCrejm5QroXVP+g1hCQr069bCapAzMFvHCLEJc+dnCLq9mHZPfBV36veVY
 XYIBlLY/oZHpYZw/keg==
X-Proofpoint-ORIG-GUID: OwCrguQzOaPwwwuUBAj-pC2qtzkdgssg
X-Authority-Analysis: v=2.4 cv=Dd0nbPtW c=1 sm=1 tr=0 ts=6a2fc33c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=O7K46QZ9Yr9AnS1rMFcA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150092

The _PAGE_UNUSED softbit should not really be lying around. Its sole
purpose is to signal to try_to_unmap_one() and try_to_migrate_one()
that the page can be discarded instead of being moved / swapped.

KVM has no way to know why a page is being unmapped, so it sets the bit
on userspace ptes corresponding to unused guest pages every time they
get unmapped. KVM has no reasonable way to clear the bit once the page
is in use again.

Without appropriate cleanup, the _PAGE_UNUSED bit will linger around
and cause guest corruption when a used page is instead thrown out.

While set_ptes() checks and clears the bit, ptep_xchg_direct(),
ptep_xchg_lazy(), and ptep_modify_prot_commit() did not. This led to
used pages being thrown out as if they were unused, causing guest
corruption.

This patch fixes the issue by introducing the missing checks in the
above functions.

Also fix gmap_helper_try_set_pte_unused() to only set the bit if the
pte is present; the _PAGE_UNUSED bit is only defined for present ptes
and thus should not be set for non-present ptes.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: c98175b7917f ("KVM: s390: Add gmap_helper_set_unused()")
---
 arch/s390/mm/gmap_helpers.c | 4 ++--
 arch/s390/mm/pgtable.c      | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index 1cfe4724fbe2..5a7d6b9790e2 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -180,8 +180,8 @@ void gmap_helper_try_set_pte_unused(struct mm_struct *mm, unsigned long vmaddr)
 	ptep = try_get_locked_pte(mm, vmaddr, &ptl);
 	if (IS_ERR_OR_NULL(ptep))
 		return;
-
-	__atomic64_or(_PAGE_UNUSED, (long *)ptep);
+	if (pte_present(*ptep))
+		__atomic64_or(_PAGE_UNUSED, (long *)ptep);
 	pte_unmap_unlock(ptep, ptl);
 }
 EXPORT_SYMBOL_GPL(gmap_helper_try_set_pte_unused);
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 4acd8b140c4b..2acc79383e7d 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -122,6 +122,8 @@ pte_t ptep_xchg_direct(struct mm_struct *mm, unsigned long addr,
 
 	preempt_disable();
 	old = ptep_flush_direct(mm, addr, ptep, 1);
+	if (pte_present(new))
+		new = clear_pte_bit(new, __pgprot(_PAGE_UNUSED));
 	set_pte(ptep, new);
 	preempt_enable();
 	return old;
@@ -160,6 +162,8 @@ pte_t ptep_xchg_lazy(struct mm_struct *mm, unsigned long addr,
 
 	preempt_disable();
 	old = ptep_flush_lazy(mm, addr, ptep, 1);
+	if (pte_present(new))
+		new = clear_pte_bit(new, __pgprot(_PAGE_UNUSED));
 	set_pte(ptep, new);
 	preempt_enable();
 	return old;
@@ -175,6 +179,8 @@ pte_t ptep_modify_prot_start(struct vm_area_struct *vma, unsigned long addr,
 void ptep_modify_prot_commit(struct vm_area_struct *vma, unsigned long addr,
 			     pte_t *ptep, pte_t old_pte, pte_t pte)
 {
+	if (pte_present(pte))
+		pte = clear_pte_bit(pte, __pgprot(_PAGE_UNUSED));
 	set_pte(ptep, pte);
 }
 
-- 
2.54.0

