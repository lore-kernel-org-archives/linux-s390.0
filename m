Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF362EB860;
	Wed, 15 Apr 2026 15:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776265306; cv=none; b=ISc5mKRNfiuP8AR0Gfg9v6vXkT7H77yD92tHBPK+2M7L8pITrKFcMDr1KrhFCZv5mLtw2X9GHN13xeKp0JvE30U7PfXrwqr6J4Q92fIRnoc2CiP2Dj2mNVpTIH8loJ7QfHho4PEuO2yGPGjfeu450jGbHKnwcuhBS+T/vAchFN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776265306; c=relaxed/simple;
	bh=omKwBK/YNBKNRN+c0WJCiX6VYlFlzBYGGpdfLaIP2iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MoZ2Pu7cz6v+gh7kbDNLBlx23DmVkYGXUd1u+Vr5enMMJ3h4Hhy5HokZqhL1KDNfvd2rYYGpav76kh2k9clxYYr/31oB6z7OUisq+4JuxkOPx+4ZvGuBup677er2KzeLncHwwkKTlePHYKnN982Jo37J1OcD3VCkWTsRYCI9W7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XDb05Qxk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XDb05Qxk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63F53Crd1805234;
	Wed, 15 Apr 2026 15:01:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=yBRR1F60wTYJWiacY
	JmTk6Dc6L5tjtST2WlW/uldChM=; b=XDb05QxkZ6GZqYlqvRMAPLtjO6MY4FyOx
	LVHZ4pQ6LdT2bCK9v6ONyhYgCIC4ymL1fs0InBNtIPx1PMnFqJh/eTjuEZnHFtAX
	7wfOW7y1QjFauUYXkzH3KsmSuPSeam+m6+vKZJ8ACblploG216B6Id3QKhQLcAL5
	cUJkJ6xVW+peHdNza52YhDxnR+vLt+BGQAuq0a9z26YFFHchhGSXhEfkXx6LqNpv
	4k9ZoMgN93+hG6NX/6tU9lVg7rmNmDZ8RzSJWAAmk+Flc3TkvJF9bn2wvsGBrGv6
	1o5t4t9T6x4vnpZNt3SL2oZiWi8CtwFp7LGUCwF2ErKW3y5lfdnTg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89k86eg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 15:01:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63FDNr3t003305;
	Wed, 15 Apr 2026 15:01:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4djbh90aug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Apr 2026 15:01:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63FF1PSH50463190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Apr 2026 15:01:25 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D0C72004B;
	Wed, 15 Apr 2026 15:01:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C12520043;
	Wed, 15 Apr 2026 15:01:25 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with SMTP;
	Wed, 15 Apr 2026 15:01:25 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55669)
	id DC23CE081F; Wed, 15 Apr 2026 17:01:24 +0200 (CEST)
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] s390/mm: Allow lazy MMU mode disabling
Date: Wed, 15 Apr 2026 17:01:24 +0200
Message-ID: <24d843c5568a8b591cbbe16eca092e7f45d18cf5.1776264097.git.agordeev@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1776264097.git.agordeev@linux.ibm.com>
References: <cover.1776264097.git.agordeev@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: l2dlRjD_8C7XYgEgk06AnfNamAoit9K8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDEzNyBTYWx0ZWRfX3dGuZkUwyxFs
 P9qcjJOqT5qP/DG5iIzm18JRHriX4VUVAT4dPIKNnaDZ+8gFdqHNbVLijuJOM4/ey/6H7Z/6SLu
 p4k9Yao+Bl1lQa8vQFylg9QXm+6QgrIbpe38xkcEvgKCHrCwvSEhyJMEMN2+2k7juclN3UhQ0KY
 XyZna1THNUqLSVUv0sB8wZ+AtoaY4KdPBYaI60kkg4sTmdzm/RFBMYv1rCbvjTPqOUEbUUvFwOj
 PmJRF8yvvY7ESYlFDNh0FOJsF6fWnWc8GaENhk68h3y+wxEtgwTlmxtgnrzNVbKBFRxaRu6h7no
 UCm43P6TTkFdvAjnNV75HGtplBjQw1PCGYzistOAtZdxisG+dltFshROgg4NWjBTFfqYoL59iZq
 1w0iaK9PPrmpNccuMchCAhVooA1kS6mPqtKU/SugeWpG/6iYdbG+DRLjaiFDcHGfNKR8Cm3c+YH
 jT27eHk0jfso9Y/tjpA==
X-Proofpoint-ORIG-GUID: l2dlRjD_8C7XYgEgk06AnfNamAoit9K8
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69dfa849 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=bNGpEJzzvkTflYE8CzsA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150137

Inroduce "lazy_mmu" kernel command line parameter
to allow disabling of the lazy MMU mode on boot.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 arch/s390/mm/ipte_batch.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/s390/mm/ipte_batch.c b/arch/s390/mm/ipte_batch.c
index cc4c50347d0f..cd86daeba7ec 100644
--- a/arch/s390/mm/ipte_batch.c
+++ b/arch/s390/mm/ipte_batch.c
@@ -16,6 +16,22 @@ struct ipte_batch {
 };
=20
 static DEFINE_PER_CPU(struct ipte_batch, ipte_range);
+static DEFINE_STATIC_KEY_TRUE_RO(lazy_mmu);
+
+static int __init setup_lazy_mmu(char *str)
+{
+	bool enable;
+
+	if (kstrtobool(str, &enable)) {
+		pr_warn("Failed to setup lazy MMU mode, set to enabled\n");
+	} else if (!enable) {
+		pr_warn("Disabling lazy MMU mode\n");
+		static_key_disable(&lazy_mmu.key);
+	}
+
+	return 0;
+}
+early_param("lazy_mmu", setup_lazy_mmu);
=20
 static int count_contiguous(pte_t *start, pte_t *end, bool *valid)
 {
@@ -169,6 +185,8 @@ void arch_enter_lazy_mmu_mode_for_pte_range(struct mm=
_struct *mm,
 {
 	if (!test_facility(13))
 		return;
+	if (!static_branch_likely(&lazy_mmu))
+		return;
 	enter_ipte_batch(mm, addr, end, pte);
 }
 EXPORT_SYMBOL_IF_KUNIT(arch_enter_lazy_mmu_mode_for_pte_range);
@@ -177,6 +195,8 @@ void arch_leave_lazy_mmu_mode(void)
 {
 	if (!test_facility(13))
 		return;
+	if (!static_branch_likely(&lazy_mmu))
+		return;
 	leave_ipte_batch();
 }
 EXPORT_SYMBOL_IF_KUNIT(arch_leave_lazy_mmu_mode);
@@ -185,6 +205,8 @@ void arch_flush_lazy_mmu_mode(void)
 {
 	if (!test_facility(13))
 		return;
+	if (!static_branch_likely(&lazy_mmu))
+		return;
 	flush_lazy_mmu_mode();
 }
 EXPORT_SYMBOL_IF_KUNIT(arch_flush_lazy_mmu_mode);
--=20
2.51.0

