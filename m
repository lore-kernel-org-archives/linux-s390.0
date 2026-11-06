Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984936;
	b=yNI7dg5FW01WwRnrQps48ddDp057trqug+SFlmDtWjl4V4zBg/bSXw9m5zNJDNeY10cF
	 JjPH8DjF3YO4Flrc5JY01evQHfseQfPHxvnvcaZnyXzzzEWSSzhLjYfaXxU1T8pwpAQar
	 iHt3so5c/TxVq4iVIUc3YREmDVMrdkoPU92C+iQtmbxWvUkME1LC5/vZEMqx1GlyCb2F0
	 ejKOLfyaXk1mbtFse1CvvwYgHg+E+VUtiEz4bQxeOvdy26rDHQxnEy4wpbWYkiTuMOD3A
	 dD4ISrdMghHD6XQ/86OUu0rdOCl6UAuMB8u0v3td1OCoyakEJDjBqPVmlOFajcum19g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984936;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nlT/v3ATiR6+zB79ygw3drO2I5hBU8Lt2SllnCuPKMA=;
	b=kjqPXQ3dNxf6dPR8R9/R3KqVJq0KSPk8WoVUyFk/j7dB3lWXZ7bZQkQNzOgvLN0npj8U
	 VNno2gUl1x4d6xLXz+XWupr2SgxvJ5/Ow5hvQ4c8sVn8xUnnt6h16DLRdfB7zVYgU0qpt
	 IkjDbHTYkAW0QiGTdcqyRMVM3wyNUXxZW5sz45f1fNoYoSt22LXunr9LRuPPueosBaOHN
	 zl2amh/K1Uze847XU4up6UVrDKdCLH8GUS+sDoWxA7Pi1YkFRgt+K3TKJnLX/qaBacrwY
	 oIrqqd/WZuhkCdnxUFfQWhv6D0l/W8lKCk2VSP/m8OKG83q9TWzXJHeC2L0SoghsJjw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eEarNtwD;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E4E606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 17:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59E4E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=eEarNtwD
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEDiA2656411
	for <linux-s390@vger.kernel.org>; Fri, 6 Nov 2026 17:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=nlT/v3ATiR6+zB79ygw3drO2I5hBU8Lt2SllnCuPK
	MA=; b=eEarNtwD01WuNGjaSGRC9jc7rDmH9/ke67U/qqOSoU2+u5lhOhwXBAkaH
	xsyAS91i6RP2QNvXsrad73R+23j4pmffNmM6JmctIOM/uS3BlbUtMfYjcRnQPxzx
	BMpNSEla9kXPgBCnlOVeOim0cVX+MgLXc4P0erTHeOVCdsgYJIfozkt+t777N7Rj
	YgNZBOVdqHhKD2gIblACAvoZSIQjEw4Fz2S/OQUHZvRDo1mVJZuHzgGa5t0zVw2b
	HEeEZq76k5G+GrtexMKj4nAZ0elWhM/vWw1r5DrGZB/iRhXviNF/XMU3ww9Z+CUy
	bjhuF6J2t10+gI+rfenl3v9zQdptA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rc634t-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 06 Nov 2026 17:08:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6GxtZR3538277
	for <linux-s390@vger.kernel.org>; Fri, 6 Nov 2026 17:08:54 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hrk9mtqmk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 06 Nov 2026 17:08:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6H8oA930081304
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 17:08:50 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96CC720043;
	Fri,  6 Nov 2026 17:08:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 763ED20040;
	Fri,  6 Nov 2026 17:08:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 17:08:50 +0000 (GMT)
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: linux-s390 <linux-s390@vger.kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH] s390/mm: Allow hugepage migration for s390
Date: Fri,  6 Nov 2026 18:08:44 +0100
Message-ID: <20261106170844.4079771-1-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2NiBTYWx0ZWRfX+z2RZhqjS1ms
 zZOWHZyY0vUdXNHfhcMp+4/UH1/BUBe0ZzD3+2sKZhqb+vuhhgNilHds1NAC7rQ15EN4onHlZu/
 cLJYQtMQEr6uSUnq5RhM9dhsL6Zf3I4=
X-Proofpoint-GUID: slRozmJO34dxtVcBMloIBqrVbHG8kGFx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2NiBTYWx0ZWRfX6VuNbmzFFfNp
 AAiXXJbSjcIqiksDFHbFK/JgjhbzMYVFmbvtx4j5uJnobMp5Yq6xGR4+gPMJE7go2SjOGKeR1Y/
 aELkBOG4pnbgo7XO8FUwenEaRYqVkplyXIFyb8h+Gz2fWdh3/zjZ//9D2RTSUhHvaNUTEpkb1Jp
 FETAHaLvA6Ii8Oc2sfRl11mzaxTvM2taWYTWdlHdNMpVxbLps2tLyouMNxZEmsPnPyQ9wWZ5cnL
 IOT5KdC4GyhwZkZyqmv7C/SljGGpbtksgHB/J4AWxbWcUIxaqnrNGdovZ4NoCqk/0+zYntOubqg
 1o+9+Mgs5iB3TDLJ+pyBbQRPSnnoD0CSDtXGveEXcTX6m72VI52GeTL0UWxe9SZc2o37WPiFgTg
 rUbek9Ka5wvVstjiKxgVlby+mvD5KARJXm8bbUZMQgCDvNyfBdRe4uv+eQdXNK2CSBDZuqKozuV
 G8H7BWdvnTdlTG1iqpQ==
X-Proofpoint-ORIG-GUID: slRozmJO34dxtVcBMloIBqrVbHG8kGFx
X-Authority-Analysis: v=2.4 cv=CY+dd7rl c=1 sm=1 tr=0 ts=6aee09a7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=dqShpuBjQzf0R5tXLcIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060066

After hugetlbfs PTE_MARKER support for s390 introduced region-third
and segment table swap entries, it is possible to also allow hugepage
migration for s390.

This fixes the problem that hugetlbfs pages could not be allocated
from ZONE_MOVABLE memory, which is often used in combination with
memory hotplug. Therefore, without support for hugepage migration,
a large portion of system memory could be unavailable for hugetlbfs
page allocations.

Besides selecting ARCH_ENABLE_HUGEPAGE_MIGRATION, this only requires
definition of arch_hugetlb_migration_supported(), which can make use
of the existing arch_hugetlb_valid_size() function, similar to other
architectures.

Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 arch/s390/Kconfig               |  1 +
 arch/s390/include/asm/hugetlb.h |  5 +++++
 arch/s390/mm/hugetlbpage.c      | 14 +++++++++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 612885228824..e3a704f423f3 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -83,6 +83,7 @@ config S390
 	select ALTERNATE_USER_ADDRESS_SPACE
 	select ARCH_32BIT_USTAT_F_TINODE
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE
+	select ARCH_ENABLE_HUGEPAGE_MIGRATION if HUGETLB_PAGE && MIGRATION
 	select ARCH_ENABLE_MEMORY_HOTPLUG if SPARSEMEM
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_HAS_PMD_SOFTLEAVES if TRANSPARENT_HUGEPAGE
diff --git a/arch/s390/include/asm/hugetlb.h b/arch/s390/include/asm/hugetlb.h
index aea754b67c89..356a18a75d99 100644
--- a/arch/s390/include/asm/hugetlb.h
+++ b/arch/s390/include/asm/hugetlb.h
@@ -17,6 +17,11 @@
 
 #define hugepages_supported()	cpu_has_edat1()
 
+#ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
+bool arch_hugetlb_migration_supported(struct hstate *h);
+#define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
+#endif
+
 #define __HAVE_ARCH_HUGE_SET_HUGE_PTE_AT
 void set_huge_pte_at(struct mm_struct *mm, unsigned long addr,
 		     pte_t *ptep, pte_t pte, unsigned long sz);
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index f84aa9265430..ce61f8738465 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -224,7 +224,7 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	return (pte_t *) pmdp;
 }
 
-bool __init arch_hugetlb_valid_size(unsigned long size)
+static bool __hugetlb_valid_size(unsigned long size)
 {
 	if (cpu_has_edat1() && size == PMD_SIZE)
 		return true;
@@ -241,3 +241,15 @@ unsigned int __init arch_hugetlb_cma_order(void)
 
 	return 0;
 }
+
+bool __init arch_hugetlb_valid_size(unsigned long size)
+{
+	return __hugetlb_valid_size(size);
+}
+
+#ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
+bool arch_hugetlb_migration_supported(struct hstate *h)
+{
+	return __hugetlb_valid_size(huge_page_size(h));
+}
+#endif
-- 
2.53.0

