Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D293CB2E9;
	Mon, 22 Jun 2026 16:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144468; cv=none; b=EGPy4VO0rEbXLzWmqilik4Y198Whj/PZ8OBBLYzkO/XYYTDq+6zFOYk0ztT9lUF939a3H5E9b9v7JKEFrpo3lt9Vm6lDzuLKf1h9DWnySBuXl8aqo7OY0IJ+5BXaVsYBJClgpANppgxfylLY3yPFt6ADc8k53IVteClgy8GX/9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144468; c=relaxed/simple;
	bh=okAOvLQ4y0eY/fwgkvGuuxb8NOEPB30eyMm9tizr6DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mjgZNfiWk27L3lKhGs8A3g1IOAYqEP9/NpT8btHwQHO0VmwGqVJzltiwnWdLqDpVh3NlQ7mjWzELb1IOOW2FxecPopxWy88m3edMPe13tyovMwy/HhFQvYc4jcLWVo8i4ug5hGht62o6flevBQ01VZesOmtF5dvPepLiqRxaV7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pF1bW5Mh; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pF1bW5Mh"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFm9023398075;
	Mon, 22 Jun 2026 16:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VlM7qhGlAWkChpNhk
	2d/9oqxLbUmFTK4zaaRixCZd1I=; b=pF1bW5MhQsBGsK+lcrErO2G+72UFC76Zi
	lhlyJ0IcDhppo5gGoMLyzCK4t2rbCl8G4ZZBYJphhhSRdQ/LWrGJFEMZ/I4W1E/T
	5AqwNvf5Igb1N05nXsiL/zkS+01FfJNJ1W0UPr1FtJyhFfXfXzHZQdCfOxQoJNKJ
	V7OQNuDwuU2w1NW0XA6irRiaJ5xHqshMPqgfZf1Yq89r2UfYVK7GaBgwKkb5+2a9
	aWirzO4HWLwXUdI5WsL5O0Wt/83/acZbD932EoYrecqjUsJDTHqKSQI01cj7tdDv
	k6FteY/hWDFi0YA1Q5TrbuJmuIFkPDSoaxvGCmHX6Upog5vgh0+Og==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4a540-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:45 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MG4edg022728;
	Mon, 22 Jun 2026 16:07:44 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66jy0c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 16:07:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MG7eRn43319684
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 16:07:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F71120040;
	Mon, 22 Jun 2026 16:07:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 412722004B;
	Mon, 22 Jun 2026 16:07:40 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 16:07:40 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v5 1/9] s390/mm: Fix handling of _PAGE_UNUSED pte bit
Date: Mon, 22 Jun 2026 18:07:31 +0200
Message-ID: <20260622160739.202044-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260622160739.202044-1-imbrenda@linux.ibm.com>
References: <20260622160739.202044-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfX3YxsFa6O/Msj
 bYwFYTUIHS+ynW/DEy4aQp3z6XC3tijX0aJvuiXh12UF8a+rqsYfEnCH6mE6wgzT5K79dMtFAEm
 SQGq7XyR/p+Grudsu8uBZ0tfF9mUbck=
X-Proofpoint-ORIG-GUID: hVZjFg9giER8hu5WHb2NY6XrCWMGsISv
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a395dd1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=BXoTXrUDSLvzEcKRN5AA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE1NyBTYWx0ZWRfX4hCDOJTWjwfQ
 0oQJGmHDCu3achABAN3BQHSV6yM9ByeNOqyL9GK/aGJMHh+K1jgtMwRPDBPpfEVVNAgyrP32DQe
 ODuNx4HDuNoAq9oTo8DRGcID1wowJiKtXtip9OG2zCDbUTDYysI+N1zQOCMklRc641yeMLDydBU
 5hTCZ7AvV0qQ371Jez9/fR54GtlNdwis0oWWADoEyaJ4qIWYxyhwNJY75du/cSsPdqOlkIfU7ga
 v5bbO5FpfkAnNrhkx4IUfnvd/j7cigNVJoQWQEp8yQth9YYEBlnSGu3gSOfhd7ZGXtvFuvtF57t
 a5R2iJCabitvt0cgr/YmElKWsoIEeJTidq/KoxrFwx576X9HFA3+vgOkYKP6urAikfFnWd6KGFc
 v/T8rv1OHoI7bsy5AM8zaX4QcNStUNAgP6mWpxp7DMo1OllxKbURVTKe/m8HHdUxzO3bRufOAqQ
 LxPhoVLXPFyoASDh/yQ==
X-Proofpoint-GUID: hVZjFg9giER8hu5WHb2NY6XrCWMGsISv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220157

The _PAGE_UNUSED softbit should not really be lying around. Its sole
purpose is to signal to try_to_unmap_one() and try_to_migrate_one()
that the page can be discarded instead of being moved / swapped.

KVM has no way to know why a page is being unmapped, so it sets the bit
on userspace ptes corresponding to unused guest pages every time they
get unmapped. KVM has no reasonable way to clear the bit once the page
is in use again.

While set_ptes() checks and clears the bit, other paths that set new
ptes did not. This led to used pages being thrown out as if they were
unused, causing guest corruption.

Fix the issue by clearing the _PAGE_UNUSED bit for present ptes in
set_pte(), i.e. whenever a present pte is getting set. The check in
set_ptes() is then redundant and can be removed.

Also fix gmap_helper_try_set_pte_unused() to only set the bit if the
pte is present; the _PAGE_UNUSED bit is only defined for present ptes
and thus should not be set for non-present ptes.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Fixes: c98175b7917f ("KVM: s390: Add gmap_helper_set_unused()")
Acked-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/pgtable.h | 4 ++--
 arch/s390/mm/gmap_helpers.c     | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index ca376a9b8e41..d03663483f76 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -980,6 +980,8 @@ static inline void set_pmd(pmd_t *pmdp, pmd_t pmd)
 
 static inline void set_pte(pte_t *ptep, pte_t pte)
 {
+	if (pte_present(pte))
+		pte = clear_pte_bit(pte, __pgprot(_PAGE_UNUSED));
 	WRITE_ONCE(*ptep, pte);
 }
 
@@ -1332,8 +1334,6 @@ pgprot_t pgprot_writecombine(pgprot_t prot);
 static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
 			      pte_t *ptep, pte_t entry, unsigned int nr)
 {
-	if (pte_present(entry))
-		entry = clear_pte_bit(entry, __pgprot(_PAGE_UNUSED));
 	page_table_check_ptes_set(mm, addr, ptep, entry, nr);
 	for (;;) {
 		set_pte(ptep, entry);
diff --git a/arch/s390/mm/gmap_helpers.c b/arch/s390/mm/gmap_helpers.c
index 1cfe4724fbe2..60023b6fdcb1 100644
--- a/arch/s390/mm/gmap_helpers.c
+++ b/arch/s390/mm/gmap_helpers.c
@@ -181,7 +181,8 @@ void gmap_helper_try_set_pte_unused(struct mm_struct *mm, unsigned long vmaddr)
 	if (IS_ERR_OR_NULL(ptep))
 		return;
 
-	__atomic64_or(_PAGE_UNUSED, (long *)ptep);
+	if (pte_present(*ptep))
+		__atomic64_or(_PAGE_UNUSED, (long *)ptep);
 	pte_unmap_unlock(ptep, ptl);
 }
 EXPORT_SYMBOL_GPL(gmap_helper_try_set_pte_unused);
-- 
2.54.0

