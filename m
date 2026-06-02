Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652793FE34B;
	Tue,  2 Jun 2026 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780422513; cv=none; b=S5+LBhbPRBFC0o+upu2/8BFxvhTPMpXw4dqXhTNh0LiIqt3o1mGG6eaC4TCJ7bJVmEhmL3kMTQLV4xE7rrg83r1CRYY47h0jHHIlu38FbROfElTte1lX1kz6eBkQGDbuLOA6yTmiTnODDJpoVmo91Y/pmQulU1ntwagyyEvDQ2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780422513; c=relaxed/simple;
	bh=MyD4tXwtwOHHqF3bjg9QBCSh9zTJ5ELSPW9qcjxikPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPFpEjT+JQO+umHDUfKoOTmsOc0R13txtmoxpui8h5dPZX1YQDEDo6oxt+cWN4f9eOhCd0DhyJ3j8xVHSh2dUQg+nqns/ko1EPut4qo6Ik6g8BSO8pKZOtyEAi1ttw7E8gySxI5QRqUZbzKlFDLp7GZEQZSz2wdrULVsvA9Yn98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pm4srByV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pm4srByV"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652HRGcv1773281;
	Tue, 2 Jun 2026 17:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=5ucCCHx8yHKQui4AT
	aqYDD6U8kWSeXOErJedUG488zQ=; b=Pm4srByVfi8KZKWSkQMDgMijYohOdnxeP
	prCqZ49+GIuN+kF84sddqAOKDR32zCPbz1ua7YXcYysawi4zHobnI5DiM57vVicl
	McEm36jR4n8ZSZiMssci/vockg1no44RP094E7mZCv3656YhfO5zzy4EpgzwMF7S
	poOuf7kFOT8lmnhuikDIUCQNr7e2lsqr8c78aahIbMRPJMd6KfEKbozfv9qFpie9
	wemUSyyc5EXdC9GBP3rDuEMm4ZZCsUyOxpOt4UUhONewOhbHD4W9KJueTE+nUVvO
	J0yeMPuN4UvADX447p6bHiXyZb1IXIgtRnU0vfWQ4/y/DqhKx/STg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd47a5h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652HdYrf019871;
	Tue, 2 Jun 2026 17:48:26 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwyc4bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 17:48:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652HmKIY48955666
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 17:48:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C02B82004B;
	Tue,  2 Jun 2026 17:48:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A3D3220049;
	Tue,  2 Jun 2026 17:48:20 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 17:48:20 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: pbonzini@redhat.com
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com
Subject: [GIT PULL v1 10/10] KVM: s390: Remove ptep_zap_softleaf_entry()
Date: Tue,  2 Jun 2026 19:48:19 +0200
Message-ID: <20260602174819.255785-11-imbrenda@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE3MCBTYWx0ZWRfX/cGSxHixf1Ew
 Ub1ynmuV807n3v5b5Ivs8DdUTnLeEtypSDzlS8aecvem3kMVzwjlw30axCSgqH523smK7yuMURK
 CZg2EhC94oWNvXlb98jMy2AqhlD5Yyv0ms2XjKIxkNCK4SiTjdyQaQcLg0tys0eQwOiQOnv3ywl
 YBdT1dQkEOcgGJ+VKd9ul1vGTOWa13XFJgwGu8zO3qyMnYiOyu2KA8TNkyFPBBH+nw73pZrEL6f
 tNsgDfCTwArvz7dDXu2HO3dGpQ1/7+rI1E9tUz27RWk8UlDVYzoeESI4N1sK4unx6orsIqbCjyH
 JhE4GI1p6g+6L07vFhIY0JPfJ8oBXeKrXa3zYtNIUn6oG8a5FhGvuIX3MDfUcBVzbaczYhCdCYQ
 LRly3KrSVhbG3cQaUAocjdIcqbgOTieKx4F/0OfqX4srENsVxCFW/9YaqNulB/0J4zvRlCm9zSY
 dzVJQlxKpTUXloYh3Fw==
X-Proofpoint-GUID: 9I6mZMNW5ICR0ainagvjXJBp8jbW89Zr
X-Proofpoint-ORIG-GUID: 9I6mZMNW5ICR0ainagvjXJBp8jbW89Zr
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1f176b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=LFT47s6f9hPNm4szaaUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020170

Migration entries do not need to be removed.

The swap subsystem has been (and still is being) heavily reworked. The
current implementation of ptep_zap_softleaf_entry() has been slowly
modified and is now wrong, since it unconditionally calls
swap_put_entries_direct() for both swap and migration entries.

Remove ptep_zap_softleaf_entry() altogether, merge the path for proper
swap entries directly in the only caller, and ignore migration entries.

Fixes: 200197908dc4 ("KVM: s390: Refactor and split some gmap helpers")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Message-ID: <20260602142356.169458-11-imbrenda@linux.ibm.com>
---
 arch/s390/mm/gmap_helpers.c | 25 +++++--------------------
 1 file changed, 5 insertions(+), 20 deletions(-)

diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index 396207163ca6..1cfe4724fbe2 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -16,24 +16,6 @@
 #include <linux/ksm.h>
 #include <asm/gmap_helpers.h>
 
-/**
- * ptep_zap_softleaf_entry() - discard a software leaf entry.
- * @mm: the mm
- * @entry: the software leaf entry that needs to be zapped
- *
- * Discards the given software leaf entry. If the leaf entry was an actual
- * swap entry (and not a migration entry, for example), the actual swapped
- * page is also discarded from swap.
- */
-static void ptep_zap_softleaf_entry(struct mm_struct *mm, softleaf_t entry)
-{
-	if (softleaf_is_swap(entry))
-		dec_mm_counter(mm, MM_SWAPENTS);
-	else if (softleaf_is_migration(entry))
-		dec_mm_counter(mm, mm_counter(softleaf_to_folio(entry)));
-	swap_put_entries_direct(entry, 1);
-}
-
 /**
  * try_get_locked_pte() - like get_locked_pte(), but atomic and with trylock
  * @mm: the mm
@@ -111,6 +93,7 @@ void gmap_helper_zap_one_page(struct mm_struct *mm, unsigned long vmaddr)
 {
 	struct vm_area_struct *vma;
 	spinlock_t *ptl;	/* Lock for the host (userspace) page table */
+	softleaf_t sl;
 	pte_t *ptep;
 
 	mmap_assert_locked(mm);
@@ -124,8 +107,10 @@ void gmap_helper_zap_one_page(struct mm_struct *mm, unsigned long vmaddr)
 	ptep = try_get_locked_pte(mm, vmaddr, &ptl);
 	if (IS_ERR_OR_NULL(ptep))
 		return;
-	if (pte_swap(*ptep)) {
-		ptep_zap_softleaf_entry(mm, softleaf_from_pte(*ptep));
+	sl = softleaf_from_pte(*ptep);
+	if (pte_swap(*ptep) && softleaf_is_swap(sl)) {
+		dec_mm_counter(mm, MM_SWAPENTS);
+		swap_put_entries_direct(sl, 1);
 		pte_clear(mm, vmaddr, ptep);
 	}
 	pte_unmap_unlock(ptep, ptl);
-- 
2.54.0

