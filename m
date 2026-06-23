Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085A52BD5B4;
	Tue, 23 Jun 2026 15:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782228822; cv=none; b=liGJtvrYcBF5mrZboMX6k+G3Qnj72EOTAyQoB6MuIy9iq9sABVOXKUPIpACBIBCOZKQiAvgSYA4h04kusxhAuqyoqvOkPnh2PG1SQB2EfrrjKYEZ8mj2C23CGE5LHm1tnBMb0GF2rym93z4XJPxYjjbed2R51u0pxwnZGS/AacY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782228822; c=relaxed/simple;
	bh=okAOvLQ4y0eY/fwgkvGuuxb8NOEPB30eyMm9tizr6DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MlPhiMiZe0457N6Ys1w+k1rV1GLJp1xPez3n+n4YAPXY48VvHqenuG94UbM7aHzuE4t3PpYeyl8UN7TTUqj3mTsQcGi+sZkjDim6Le7LM4R7W2f0j380rL8Flxjq3ZnDxuS2gUq8O95/mt+JRMRV/kv4VkNwghMAoRBuZUUw58c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L1TNxHYe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L1TNxHYe"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBn4BT1827221;
	Tue, 23 Jun 2026 15:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VlM7qhGlAWkChpNhk
	2d/9oqxLbUmFTK4zaaRixCZd1I=; b=L1TNxHYe+AyiNRLqG0JllrN+/+LOIv4ih
	R9vmy8mNLH6G+fNv+LTEVqHJ83lyFeMvZjH0R24+8CQRfnVSuVyf80A+6ASDqdjx
	2/MwqyAZUhGTsA8O9IKTWA6janKpJau1mLBJJrzA0xkZWbu4BfRUdsvTYWz+ojIS
	z3Ay2u5z7aksxIgGFM+27HWsx/VrSpd5Ie3BiZfBu19c5XhVeyG8dEe2PTYIlKva
	IMVOR8gQQ7iIBLGMPJhFVgKohoc851HMoxZEIPzs3RbzzYhcR2nncSvpwwPsQ6/K
	ViahAZQymoY8cHpalN1GqyCL3PdHu/KoMjsdWuCIsXEBO8y9q1mTg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjgsq8f3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NFJhJ7007012;
	Tue, 23 Jun 2026 15:33:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phbxt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 15:33:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NFXVEC27984134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 15:33:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C208B20040;
	Tue, 23 Jun 2026 15:33:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 939EE2004B;
	Tue, 23 Jun 2026 15:33:31 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.224.75.30])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 15:33:31 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v6 01/10] s390/mm: Fix handling of _PAGE_UNUSED pte bit
Date: Tue, 23 Jun 2026 17:33:22 +0200
Message-ID: <20260623153331.233784-2-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260623153331.233784-1-imbrenda@linux.ibm.com>
References: <20260623153331.233784-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfX18OqUWvEvZSc
 LvKapP744A3TZwXvbuVju7XKem4KghDQ4AZ5G9pikRLpaPgYaIvrsFgh8XL7racZFqbqrDvL/a5
 HHVXjkqxZaHDXQt8dJUeYonCg4Uyktixb59Khg4r5j6htnzhGonSiluBJt0C64zIADhnAQR1Ww/
 6674Y/JJldAg6L2hHupq2bjHhDtxRblUV0FM3qy5EiIyk7qSciv1uWHD5Qm7pMV4xvmv8p1nKKC
 YGmufra2CvRXmQVg+wkAXMvuuYja2dhexdylYSZxQtCMYsHKD17FTX9Fjc1Y4PUS0ZCcZQ/cYrq
 DC1HqCREHwwbi42VdBYRIk/9t655SSmeoGJEsmafVAAvo7uZSxc7QyNEARPcwC6sBQ3hVljQAJT
 VxL7LhHuv47noI4kBdXW+WcPxbMcR2FXlcZw9ubHxRk8aUZUMQhnmJLaQzRZaDm7xbT/VHeql3o
 6rNGWQvDWU3sm6gdjLA==
X-Proofpoint-GUID: 6RoehG4KgSeQOeUBNzDGVeT4qJn3WcZS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEyNiBTYWx0ZWRfX/JIAw01zpkCh
 BO8stmDXsMMGQ9FJRLIcjCmlUVdPkwQSEK2/yMQMHKKnjUMg1fQBlRhMNuVUalYtcjzyqDcbIRP
 7hEzlCdI+xC8MfFReM21BDQO5WKjVjA=
X-Authority-Analysis: v=2.4 cv=I/lVgtgg c=1 sm=1 tr=0 ts=6a3aa750 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=BXoTXrUDSLvzEcKRN5AA:9
X-Proofpoint-ORIG-GUID: 6RoehG4KgSeQOeUBNzDGVeT4qJn3WcZS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 impostorscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230126

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

