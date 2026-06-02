Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18123ED3AF;
	Tue,  2 Jun 2026 14:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780410249; cv=none; b=dq2YnKIAM0iH6qf9dCe0ditbwVjbV7StA/duDr5n4pqOiP/oaEwG/qpM7urJ8BbqlYdI1uIH9O4rdaZLnMfG0KkiQ2MWzaGhUmvWSkTmUfYknUlLizunZNBZK/U7noZ+QY3c5dZqDnHPoFS4/LKUtP93QF3h9Ejz3KQGp3uFV38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780410249; c=relaxed/simple;
	bh=1kycnoBb6zMW1dCK9pPTA3MFg+MKXjsWEBZ7O7MFldU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VnFIRzJkr9euq2hW0I4AiCq08WwTWgsScXetu9q7ubFjdvJwJgRgaqQz9ZnMpk240RX8ETfWcLrbR8vh8+ZhCZe/8CHDg5rO0O/0/h7z27BADz651p2rJsKQlu1ploO3q3gD/xAQFeSRIeUYHmL5L7stP7a9V83iApxxHmT61L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FuK2K89Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FuK2K89Q"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65280HZg2118330;
	Tue, 2 Jun 2026 14:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3mFRcDIES0Wygdzgm
	w9D1J32vRwcqdCkwOIUwOsy9Uk=; b=FuK2K89QJ+xvawHdivo+sMrTmZHt0x5Z8
	V4vQgdpqI4Dcr6SP4wWGrm0qia5xEp0787XERvSQ7fOLgDeyvHApJzXDMqrtycA1
	5UekVjRP2WPRbvK9yNc5BimVaRWfTSlYoqxY3Ezykl9eIi17IJ5w75wlUvYlH16c
	eA0P5iSrfs+Kr88uaeuoYkPdlijsldFqmz0HDXdxR9LGNO1wPf7KepPMExAV2Kww
	U3CmJs2MWMolEEvR26x6T56OvsPcuFXhkxZjcKCOJ0NysR4EMFhk6YwlEZMDqh48
	tWVXZPDfCG1/iQ6DOhu34VZRgXFxYFGX+631O1J2QfqcXREOzy+9Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqd46drc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 14:24:05 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652E967w026810;
	Tue, 2 Jun 2026 14:24:04 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egakvur47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jun 2026 14:24:04 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652ENwIv36962792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Jun 2026 14:23:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD3F320040;
	Tue,  2 Jun 2026 14:23:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A48E420043;
	Tue,  2 Jun 2026 14:23:58 +0000 (GMT)
Received: from p-imbrenda.aag-de.ibm.com (unknown [9.52.223.175])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Jun 2026 14:23:58 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
Subject: [PATCH v3 10/10] KVM: s390: Remove ptep_zap_softleaf_entry()
Date: Tue,  2 Jun 2026 16:23:56 +0200
Message-ID: <20260602142356.169458-11-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602142356.169458-1-imbrenda@linux.ibm.com>
References: <20260602142356.169458-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDEzNiBTYWx0ZWRfXyUgap/Gni44x
 sLxukxw0AuxZxZ+DYs8T4M5arJ8TslOXlgZmtH8ejWdPb+sgAhfCKjQMXiMtANXEDE09E6nVZr9
 sOsHhmD9moyeqI3FjccMciiB69FYy4PHQnvwj7fttRdCCTwbK4cmV1ex05B65wCGIskgKQyCbAB
 5yPqD+J9lz/cXxNkHhRQtVsDjbCcNVDLNaefWoF+ALQqziX3O9DZXTJWyiXRs+idEyQUfYsw3q1
 KB5krv2H/pJuNe6c+S6aeNQIswBTlW3wU4J353waIB4nAqIK7rgLu/zveFRQUxhNbu07Kn0MVJE
 VwK+mN0FOE+fWk2BibKba0gEUVv4LOLRLkmAZNnQomrjUBejic6wb7d4ImIe0OhEGaGC22ql6Ke
 TC/5KORsMT26jVrDwUsp5tq1JlTsTMjbNB0cvCov0gfxTavptxThXhcaUGyjqEwBS9UBC5XsuD1
 cBvpFTg//hTKlP3uKeQ==
X-Proofpoint-GUID: i09K8kAfgNqkg2FBT86fn8elWGH2bAa_
X-Proofpoint-ORIG-GUID: i09K8kAfgNqkg2FBT86fn8elWGH2bAa_
X-Authority-Analysis: v=2.4 cv=DZknbPtW c=1 sm=1 tr=0 ts=6a1ee786 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=LFT47s6f9hPNm4szaaUA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020136

Migration entries do not need to be removed.

The swap subsystem has been (and still is being) heavily reworked. The
current implementation of ptep_zap_softleaf_entry() has been slowly
modified and is now wrong, since it unconditionally calls
swap_put_entries_direct() for both swap and migration entries.

Remove ptep_zap_softleaf_entry() altogether, merge the path for proper
swap entries directly in the only caller, and ignore migration entries.

Fixes: 200197908dc4 ("KVM: s390: Refactor and split some gmap helpers")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
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

