Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5934B1B4138
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782840760; cv=none; b=QEEHTvyf3vR5ei9wX/78sHzFqUjtur2AUL2rkIEA2+ywRKe5bZbIs4TZ1coSsGWNfUvpeC9T75HF02Wh9rejZpAhtSB6ZCsyD8225dVdzEJ0aTiG5sHp7HMFqEayKRZLDwjzTHGjm6nc2KEcrHxO/1WFi6uAbhcjL1Nr3RVIGUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782840760; c=relaxed/simple;
	bh=PtVAeUl6iTdVhktVLd7UAKrYE/A/Rrdm+ga45MSTYYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ausKV2go0TzZw63GbAqx+XRp0M49XxgFfJKcblAEoImjjnpVK+oWRVgNVGV/8iV6PK/UsdMXZe5Yvd6PoPrxCYgh53c73zS4Kxdprwm/w/0zC84dlXBR/W7h1fZ8Y9ARRGy3bAzn0wDvLOt1LZQzHQ+wAb3gOsxNsd08kBFrupo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XsP34QyG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XsP34QyG"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIU7J2233669
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 17:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ybE8Y+EChjaMNjV8L1j1W7w5bKftTEuuaWP7066Hw
	vY=; b=XsP34QyGrbh/sX7QJCWxHG9GCLyVTDKvKM3+Rv8Rfu/SjuP77dYxA2IWF
	nepqZzw+xXS5iQo/gqPGjKJOhaCEyFIIvZja8k6/08u9k1Br8BbbJq8iH7pJ73+Z
	wq4NLz4BQKZ8PwVFJ2wI2xrFujnV7Jkm2MvttnGc+oZvN+jK0tG/0QFtSCtKU6/G
	UAGWIKaKJgmXgHj9CsDxv4O9jeKoCI6xV4HDdUoYUQUXqXwc8w5Ls+exeZJW4RLP
	wWubhMVH9wVZBOzdAIK1UPrutMFBNHjL557pDphkHSidDSi190Md003g7w7RJ3yR
	hlpR9ykJQJmcBcHCCm4GhfXnc76KA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26n5r7jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 17:32:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UHJaco025415
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 17:32:37 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqbn2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 17:32:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UHWY3l51315078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 17:32:34 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06B6D2004B;
	Tue, 30 Jun 2026 17:32:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAA9220043;
	Tue, 30 Jun 2026 17:32:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 17:32:33 +0000 (GMT)
From: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To: linux-s390 <linux-s390@vger.kernel.org>
Cc: Sven Schnelle <svens@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH] s390/mm: Fix type mismatch in get_align_mask().
Date: Tue, 30 Jun 2026 19:32:14 +0200
Message-ID: <20260630173214.3114408-1-gerald.schaefer@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE2NSBTYWx0ZWRfXxwglWpa5AxNc
 a5yQAlOzSrVJy2uA0SuutAJZXXc/S6DE9PPZuBVhGUx0i8CqgiVR9K4lgvkX07l1ZiWH4cfmsDr
 2dEcgS0bgL32gMxnGh2Xp3TzEEZCZv+HHgU+C/P1gJlVQs//b7I+4g7aYl+jB6qmKH/tx3ZbCCB
 t8sQPMT/8Jc1R1qwojOtvAnlcPJ2FYSDYmc2z/zg3hcEuhS7G300jLqVsKTvV88dyjOAntuo70+
 4PJp5mWYeZDUufRCeZq5fO9AZwSYyBcasIuqmC0FqoJo1n1LjMG9AhBfMicWfpPbJcqBXf9MG7r
 BOeCjyVQCs29ddqIbxfV7Sptha4JuTlHaAYIpPLgnvjYy6IuBqX+EbEllB4VcyhR546IWU4BL+a
 kSCl7D+Vr2oxLrfwl9QM3xTTB2scjvHWYKMpUK/X696KCBEINbdhHHr/W7rd7vXFFANata+LIrh
 O9CBWkzJpKDqRpAh8Mg==
X-Authority-Analysis: v=2.4 cv=V45NF+ni c=1 sm=1 tr=0 ts=6a43fdb6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=Q4Iz8yLfMio2wSdAjBAA:9
X-Proofpoint-ORIG-GUID: U8AqoP_nCSmk8WY3V9WfYVp6N_Hy9D4Q
X-Proofpoint-GUID: U8AqoP_nCSmk8WY3V9WfYVp6N_Hy9D4Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE2NSBTYWx0ZWRfX0/ySgiTS4Oa/
 HzzW2mI0hXyeFIjmhmDAialJDRiiagFfeRmZ/7CNrvZg9UTHO1TuQQydIofpw8Df68GCSLqEQ4e
 tEoBBxBirjtlFBhUm7Z8l459EHqTjBY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300165

Commit 86f48f922ba79 ("s390/mmap: disable mmap alignment when
randomize_va_space = 0") introduced get_align_mask() with return type of
'int', while the target field 'info.align_mask' in struct
vm_unmapped_area_info is 'unsigned long'.

With currently used masks, this should not cause truncation issues, but
fix it and return 'unsigned long' to avoid future problems.

Fixes: 86f48f922ba79 ("s390/mmap: disable mmap alignment when randomize_va_space = 0")
Cc: stable@vger.kernel.org # v6.9+
Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
---
 arch/s390/mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 2a222a7e14f4..ef7bfc87758c 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -64,7 +64,7 @@ static inline unsigned long mmap_base(unsigned long rnd,
 	return PAGE_ALIGN(STACK_TOP - gap - rnd);
 }
 
-static int get_align_mask(struct file *filp, unsigned long flags)
+static unsigned long get_align_mask(struct file *filp, unsigned long flags)
 {
 	if (filp && is_file_hugepages(filp))
 		return huge_page_mask_align(filp);

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.53.0

