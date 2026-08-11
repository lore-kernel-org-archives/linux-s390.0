Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41491441612;
	Tue, 11 Aug 2026 12:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786450404; cv=none; b=Vg5kDoW8QS0THFLA2Zfh52Blrt0H6IUVms1R/OChhh8ji9p3m/D6dCbL1/Z9fyOJxPUBb8bkYV++NSu+sj7lzAwREr9LIUgDwjD3WiT3GCn35Ts8kJplBrtIVHSVnSYnSSh3L98acwxqKge2PI3QTqLZvfb37w47iVqx4trrGa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786450404; c=relaxed/simple;
	bh=AJzUXXtRVme24twgOTFRxyxPKPibajxDweG+9B/essA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8xNqj1U8S3qKdOAxQEbLaBoLN0oDrgYvajOOEBVBPhxJTB8sGdEl8/2BY/YmP932B5i1krgHdcFMwrFXyNKGa/Aa/IMwKJWLJR064fiCq2kt/UTDN/KcX+7KNK6SHQ3F9UltDCrIVA6bO031S2K9NWpM21/ncDMz3mHblxkskg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rz9qZJ9R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rz9qZJ9R"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BAVgW7065121;
	Tue, 11 Aug 2026 12:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=F33Kzwbr4XstHAu1hJl3hlRLxWE01X2+jn/QLHKDf
	dk=; b=rz9qZJ9RdWOoGPGTv/G6CQaEsEag6mhVlIrbgXVBnPx7fqO94plaQzxlZ
	Qx7fjesqaGjP0wbApQmKOwqiQwCwSXkog4K2CZzkhFu3FZ7btasgea4DLp8uge5F
	UxLSVAs1cUXyF8Q1+1DiokiMTq9KCaFixuO/gRGJ1oKJtI6x0k7/nfa4xTJosJAw
	4JiBjvfwCc5iCCjBaTCyLTUPSAOffwc9kQISb5hJLY0H7ih5FWzYHFpBCVlIhnB7
	9YXFhDNILGUXq7aFeEh/OUDCEmqSN3POUbeRfbRLbExvOn8agcYyeVDkSTWHUFMg
	2M2vOk7PDG4QBnbNR52bL4nL1v7hQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2v58r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 12:13:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67BCBHiB006537;
	Tue, 11 Aug 2026 12:13:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h0rdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Aug 2026 12:13:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67BCDG8333816896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Aug 2026 12:13:16 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 588652004B;
	Tue, 11 Aug 2026 12:13:16 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C01820043;
	Tue, 11 Aug 2026 12:13:16 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Tue, 11 Aug 2026 12:13:16 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id 200F0161223; Tue, 11 Aug 2026 14:13:16 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390/mm: Fix fail path in crst_table_upgrade()
Date: Tue, 11 Aug 2026 14:13:16 +0200
Message-ID: <20260811121316.2622460-1-agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7b11e1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=2jIwNAcMr-JrPlo6F3oA:9
X-Proofpoint-GUID: 8Xxl0Ahz6-imZbqROpoo5PuqH0GhkisE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDEwMCBTYWx0ZWRfX0HnBbJIIf78C
 eVR9PUJvbfHjP3rziofZ0zvrN0i1uB/ARet2W1YPXTQQXFveXnlJXfIpIPMj6UduPEiijs1RWbl
 jbKkUUVe8Sjuzp4wf/clsTRianAp1WCWCfJDLAVEn2q1UEBYKhrUiecfpkZA/f47IDrZ9cjqqUg
 BIcpY9kbIV/hBZGbTAJ0DKe6hf2uGNBAIfjbMXfcnd5LK+dmfh+9jhLIg9HVdtPllU+cUDszrg6
 kioQE+0KFtMX7CSJzyl4KFn0fOfx6SHmZ1iyTOez262D6WPr6tJAOV96TCtGxtJdAyF0cgVGzsH
 HuCylpN2PJiYvl5WXbYqRiM7xnh9Izt+DL4lTwno0k8WNbKDO/wQDA1ilNIZ/7HiPg3b5irXGs1
 Aa9lIX2oX0DL1jLGNKR24oNXzYQtWxJJhZfau40n0PvP2SNGWQDRiDn8wM5uOmBje8l97zvZzG6
 Y7TeKglwso7axd3Umpw==
X-Proofpoint-ORIG-GUID: 8Xxl0Ahz6-imZbqROpoo5PuqH0GhkisE
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDEwMCBTYWx0ZWRfX/EtkRnWX60o8
 cqqGMdkFxWuUSNIay50hR9MPoqBKIi5d6eykpU/JhOTvjyNB8DScisbn6gLBtRTX9mgk3S4QE9/
 H2e4ZxF4CqsRibJsmHEgSAhvE59GXGg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_01,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608110100

On a 4-to-5 level upgrade (unlike 3-to-5) p4d local variable
stays NULL. If the pgd allocation then fails, the fault code
path calls pagetable_dtor(virt_to_ptdesc(p4d)) with NULL.

Fixes: 502269ab98b5 ("s390/mm: add missing ctor/dtor on page table upgrad=
e")
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/mm/pgalloc.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 9610770fcf6d..87a8bdb3e51e 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -69,14 +69,19 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned=
 long end)
 	if (asce_limit =3D=3D _REGION2_SIZE) {
 		p4d =3D crst_table_alloc(mm);
 		if (unlikely(!p4d))
-			goto err_p4d;
+			return -ENOMEM;
 		crst_table_init(p4d, _REGION2_ENTRY_EMPTY);
 		pagetable_p4d_ctor(virt_to_ptdesc(p4d));
 	}
 	if (end > _REGION1_SIZE) {
 		pgd =3D crst_table_alloc(mm);
-		if (unlikely(!pgd))
-			goto err_pgd;
+		if (unlikely(!pgd)) {
+			if (p4d) {
+				pagetable_dtor(virt_to_ptdesc(p4d));
+				crst_table_free(mm, p4d);
+			}
+			return -ENOMEM;
+		}
 		crst_table_init(pgd, _REGION1_ENTRY_EMPTY);
 		pagetable_pgd_ctor(virt_to_ptdesc(pgd));
 	}
@@ -106,12 +111,6 @@ int crst_table_upgrade(struct mm_struct *mm, unsigne=
d long end)
 	on_each_cpu(__crst_table_upgrade, mm, 0);
=20
 	return 0;
-
-err_pgd:
-	pagetable_dtor(virt_to_ptdesc(p4d));
-	crst_table_free(mm, p4d);
-err_p4d:
-	return -ENOMEM;
 }
=20
 unsigned long *page_table_alloc_noprof(struct mm_struct *mm)
--=20
2.53.0

