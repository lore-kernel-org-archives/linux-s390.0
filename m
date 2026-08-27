Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0123E3DC4AF;
	Thu, 27 Aug 2026 10:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826524; cv=none; b=uDJHSOgwFczk8IvngxjVcGT38jInMyqFiRUIkSa0kljKud42aUVDJHPuThFgFEOSEDx+mLwIJL+pW07/iug62SErV4WlMvFYJQWYi2UFpsS7QUq2VWeiCwX0AgqnjDxhh4W68TA1hWf1DrY+cTBPFRAKD96u1vGE+qCYGGOdbEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826524; c=relaxed/simple;
	bh=B5eRHQi4aVcRT9KSKSljHOGc4HHlTBM/d3rAxqR2Ty4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qr5RmGrjaOCyaprakexeozbU5+aNebJqcNdc+4YOMqHYkesTjnkY+ibbcuGTKeqx0zGzZVFa4UmS6NA20eWoPex0gs4lhnPdhm0uu81z9CMZ2dy5V452/3fUwQ3tVawaMgUeFasgdrTeVO5Uzx/bzBjxLopvMt3smoUc9KNyTxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S+RETZy7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S+RETZy7"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67R9Vef12663128;
	Thu, 27 Aug 2026 10:28:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=YdZF/NKi8un+/ZN4rqJ+cFcLJaghGZGcJ3nVrs4lq
	C8=; b=S+RETZy75aX8UiIGuKBrRUH5BbdOgxiztfy82A65Cchk3aaixWjPRUNJP
	9a97GvXGmhAPK7OIegaAFmEHVL/qN8lpOvaWgMQwYTDAlNLvhSVT3DMS4Nl0pwos
	jtS15Bpev4cbkZWHnkTFEEOQ95AcDOTp45dJIGIW1bILxdzpoLxLfKlV9OAbvHjl
	tPwW/C2uB/cVwG7Y2c07f8+yL2hHAx3jiPuKwihuf2xRs4c2yVW1iKaV1OTzJBnC
	wndcvEvPY4goFDfXn0oVk1qlJ9rwljN+SoPzkWdKfKRpuFCEZCdXNrOE/F3KF/Gr
	9zdrE7MQ3fFfKjfL142drCYdxKFgw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxmbvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 10:28:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67RAQM9H017017;
	Thu, 27 Aug 2026 10:28:37 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyf7ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Aug 2026 10:28:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67RASX3v39190986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Aug 2026 10:28:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 357102004D;
	Thu, 27 Aug 2026 10:28:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 193402004B;
	Thu, 27 Aug 2026 10:28:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 27 Aug 2026 10:28:33 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390/mm: Simplify crst_table_upgrade()
Date: Thu, 27 Aug 2026 12:28:32 +0200
Message-ID: <20260827102832.3823857-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA4MyBTYWx0ZWRfXzGD0C8oM9eLU
 kpWHDfUHOfmybh+dxEXTOzE5oSlgzrNdZ2foiEgs0jmTUNOw3G5BbZdbnI2g46SQroYNYkEQBl9
 xyVSPlgtErHzPv2NkZBKSHzORVBk+s4=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a901156 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=rUPa83oKdi4ztXijT6IA:9
X-Proofpoint-ORIG-GUID: z_Fmeo0mc5U4OBo2gg7ou1B2YqBY8rXa
X-Proofpoint-GUID: z_Fmeo0mc5U4OBo2gg7ou1B2YqBY8rXa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA4MyBTYWx0ZWRfX6NFM4liurHki
 RwRbWO7yuDK4u1Es33oPEowLUiv7dvIfWiq+kIN7ZPPnc0WthgN8pxb8PSPuzdmG7OIjZm5ojbV
 wTMiHGF/S5RLApSh+QTDrukfVhjBOpdVzTD9d110/uj0sG5vlTY/LenQOdCgjAqlfiq9oOS6Zca
 /i/8uIeJRew/dS58txQSUZKnRzpP5kE2p4gJL2P0aWQ/WQOv+PxCKgoDorgE/gw12KYXf0gW0TW
 PNnYkZ/KWq1CKy+LDSgCrJQaUL+gv9EVaU7HvmzJsrXDld6N8iyDIIQALtOXC+YprMFbL39CRmR
 jHncSq7AORj6RkK0Zry5M6hwbEhwJIjZkV62GHgBPohx5v3V/Il1k/Q178/O9V/FjL6FMoi4D8S
 fJbSX+r1wQbcVUL2No7URuTn34jz/9w2k4FkNq8WYeTu45cDK7xk/vsefJ1CqyY8SlHbw7aJe2+
 /XQwQmDBTdbjzOyNkyA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_04,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270083

In case of an upgrade from four to five level page tables, and a failing
pgd allocation, the exit path of crst_table_upgrade() would incorrectly
dereference the p4d NULL pointer via pagetable_dtor().

Address this by reworking crst_table_upgrade(), which basically is a
revert of [1]. Take into account that GFP_KERNEL order-2 allocation
failures are very unlikely. Therefore keep the code as simple as
possible:

In case of an upgrade from three to five levels, and an allocation
failure of the fifth page table level, keep the upgrade to four levels
instead of reverting back to three levels. This allows to keep error
handling minimal.

[1] commit 31932757c612 ("s390/mm: optimize page table upgrade routine")

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/mm/pgalloc.c | 89 +++++++++++++++++-------------------------
 1 file changed, 36 insertions(+), 53 deletions(-)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 9610770fcf6d..4b160eedc5a0 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -55,63 +55,46 @@ static void __crst_table_upgrade(void *arg)
 
 int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 {
-	unsigned long *pgd = NULL, *p4d = NULL, *__pgd;
-	unsigned long asce_limit = mm->context.asce_limit;
+	unsigned long *table, *pgd;
+	int rc, notify;
 
 	mmap_assert_write_locked(mm);
-
 	/* upgrade should only happen from 3 to 4, 3 to 5, or 4 to 5 levels */
-	VM_BUG_ON(asce_limit < _REGION2_SIZE);
-
-	if (end <= asce_limit)
-		return 0;
-
-	if (asce_limit == _REGION2_SIZE) {
-		p4d = crst_table_alloc(mm);
-		if (unlikely(!p4d))
-			goto err_p4d;
-		crst_table_init(p4d, _REGION2_ENTRY_EMPTY);
-		pagetable_p4d_ctor(virt_to_ptdesc(p4d));
+	VM_BUG_ON(mm->context.asce_limit < _REGION2_SIZE);
+	rc = 0;
+	notify = 0;
+	while (mm->context.asce_limit < end) {
+		table = crst_table_alloc(mm);
+		if (!table) {
+			rc = -ENOMEM;
+			break;
+		}
+		spin_lock_bh(&mm->page_table_lock);
+		pgd = (unsigned long *)mm->pgd;
+		if (mm->context.asce_limit == _REGION2_SIZE) {
+			crst_table_init(table, _REGION2_ENTRY_EMPTY);
+			p4d_populate(mm, (p4d_t *)table, (pud_t *)pgd);
+			pagetable_p4d_ctor(virt_to_ptdesc(table));
+			mm->pgd = (pgd_t *)table;
+			mm->context.asce_limit = _REGION1_SIZE;
+			mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
+				_ASCE_USER_BITS | _ASCE_TYPE_REGION2;
+			mm_inc_nr_puds(mm);
+		} else {
+			crst_table_init(table, _REGION1_ENTRY_EMPTY);
+			pgd_populate(mm, (pgd_t *)table, (p4d_t *)pgd);
+			pagetable_pgd_ctor(virt_to_ptdesc(table));
+			mm->pgd = (pgd_t *)table;
+			mm->context.asce_limit = TASK_SIZE_MAX;
+			mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
+				_ASCE_USER_BITS | _ASCE_TYPE_REGION1;
+		}
+		notify = 1;
+		spin_unlock_bh(&mm->page_table_lock);
 	}
-	if (end > _REGION1_SIZE) {
-		pgd = crst_table_alloc(mm);
-		if (unlikely(!pgd))
-			goto err_pgd;
-		crst_table_init(pgd, _REGION1_ENTRY_EMPTY);
-		pagetable_pgd_ctor(virt_to_ptdesc(pgd));
-	}
-
-	spin_lock_bh(&mm->page_table_lock);
-
-	if (p4d) {
-		__pgd = (unsigned long *) mm->pgd;
-		p4d_populate(mm, (p4d_t *) p4d, (pud_t *) __pgd);
-		mm->pgd = (pgd_t *) p4d;
-		mm->context.asce_limit = _REGION1_SIZE;
-		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
-			_ASCE_USER_BITS | _ASCE_TYPE_REGION2;
-		mm_inc_nr_puds(mm);
-	}
-	if (pgd) {
-		__pgd = (unsigned long *) mm->pgd;
-		pgd_populate(mm, (pgd_t *) pgd, (p4d_t *) __pgd);
-		mm->pgd = (pgd_t *) pgd;
-		mm->context.asce_limit = TASK_SIZE_MAX;
-		mm->context.asce = __pa(mm->pgd) | _ASCE_TABLE_LENGTH |
-			_ASCE_USER_BITS | _ASCE_TYPE_REGION1;
-	}
-
-	spin_unlock_bh(&mm->page_table_lock);
-
-	on_each_cpu(__crst_table_upgrade, mm, 0);
-
-	return 0;
-
-err_pgd:
-	pagetable_dtor(virt_to_ptdesc(p4d));
-	crst_table_free(mm, p4d);
-err_p4d:
-	return -ENOMEM;
+	if (notify)
+		on_each_cpu(__crst_table_upgrade, mm, 0);
+	return rc;
 }
 
 unsigned long *page_table_alloc_noprof(struct mm_struct *mm)
-- 
2.53.0

