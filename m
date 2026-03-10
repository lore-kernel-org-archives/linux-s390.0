Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEAD3033D1;
	Tue, 10 Mar 2026 15:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773155082; cv=none; b=qo2hVo+2ha1mXoHfCPhlR5JzcHU584JQqAhBHWqM8xkq5VxJ0naxuEh5navCj3sJ8iFpYYyaJ6UwEodwyEGXifec9fbqgl17LabPaLiAsW22w9yg1/Qc/6kSbkcjGi3+CMf7ST2ZAXqRHLA5vKY7vSUDP4kQP7Tueyj6dFMUZ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773155082; c=relaxed/simple;
	bh=RoJGuZJCMEchP0Wu0RTf/ITZCuB1kWUx+xHAI1gMiIs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YwWlj05JWJyQ6t+YBDom9dypwEw5M9CZl3OBRZWV+yPa1HkdUiTpeoN+NZSMrXFvVLajUV40KiTjulc6qZTXB+BoiD10pMN5utarZpGVADLO0FbG24RS2EWZPRWflDtxBacnAyRh8ixYYOkdfB1WTVM6E3/hHo3N5VZryexG7MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BEs/O+RG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BEs/O+RG"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62A3LRDu741164;
	Tue, 10 Mar 2026 15:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ymDO9IP4ZUmqMedP+1FIpk6tMFI+kU7P/biJfyJBx
	lU=; b=BEs/O+RG+Rb1OQukXA2AF3+u88/Mx5B0ZXrzhBuFjPuQBa4RgN6F2DzVm
	V/LRBAIqLX7AdWCAlIVF2LTvIewTLvs9T+xBp5n7uAjGOptT++pRbDIg9a7uAXAZ
	8Cjp3sufPICozxR9PiWCyEKSiExVgSc9jXGfIlRcUly1CWpjfIEjvw7mEETTnDWY
	++KEQX2dz8dmyP+IKOt9wVZ/8EiEYNqCQGe2zWlzjzAgYi7RcNls6qhKn1HmOXJs
	nnMqB9v/qlrOOfmepCW7DT3OGpG2Pfi7pMKkxFVfuDrykzq1fb6xp+jJJ9AjIqNR
	HftZ09YWVuGoXoEADk5uJNBPlVu0Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcywbe42-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 15:04:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62ABA4Ce021150;
	Tue, 10 Mar 2026 15:04:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4crxbssqkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Mar 2026 15:04:39 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62AF4anA61800862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Mar 2026 15:04:36 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D22820043;
	Tue, 10 Mar 2026 15:04:36 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 099A720040;
	Tue, 10 Mar 2026 15:04:36 +0000 (GMT)
Received: from b46lp25.lnxne.boe (unknown [9.87.84.240])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 10 Mar 2026 15:04:35 +0000 (GMT)
From: Janosch Frank <frankja@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, hca@linux.ibm.com, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] s390/mm: add missing secure storage access fixups for donated memory
Date: Tue, 10 Mar 2026 15:02:42 +0000
Message-ID: <20260310150408.160722-1-frankja@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEwMDEzMSBTYWx0ZWRfX6CJo9h3Wu995
 PtvXCr43WFE/slU+iqSzqWVuM81GbqDZHHYnKhPKX3/dzMMWOonZ4FNiQTmquLpEAY7mXzmXE55
 58kYGZlTZi04BczwH356I6ujfGI0va8XqwLCIlEsd0FRiRQBmMn+lGQ9oOD/9JyRd5SjecHq1/k
 LOeG0wu3lKglB9EsI0eWRUbcpTkcFIJfYQ/eILimGwm5sxAY8KHtT9+GaPY8RezFXe1pEp4pFbo
 mSOROtedYodgK++whv/Nv8n16AYVXTglM0eORDxJAycL2FiMhdP46A6B7v8ivYPDjScmIHWYuCb
 G2Kx4ZeqRpiao6j2Vh5kfobMhhimPSX1spOIL/B2KLITFcHCLtnIDsj2oMUM7kTUuA4Uu67bhLF
 /Cfalg8RKzfv8BX3Hh0dFK/KdTrtr+1MILZRVDzKauSwgukhLSxzmI1HjBb6GTihE7muPueJFRf
 RpW+k4nhb2JlM8owV1g==
X-Authority-Analysis: v=2.4 cv=QaVrf8bv c=1 sm=1 tr=0 ts=69b03308 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=cntIUc9hOoCxFZL8CegA:9
X-Proofpoint-GUID: KaNIrFm9vv45YsecDmUlWF72KlWOUflX
X-Proofpoint-ORIG-GUID: KaNIrFm9vv45YsecDmUlWF72KlWOUflX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-10_03,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603100131

There are special cases where secure storage access exceptions happen
in a kernel context for pages that don't have the PG_arch_1 bit
set. That bit is set for non-exported guest secure storage (memory)
but is absent on storage donated to the Ultravisor since the kernel
isn't allowed to export donated pages.

Prior to this patch we would try to export the page by calling
arch_make_folio_accessible() which would instantly return since the
arch bit is absent signifying that the page was already exported and
no further action is necessary. This leads to secure storage access
exception loops which can never be resolved.

With this patch we unconditionally try to export and if that fails we
fixup.

Fixes: 084ea4d611a3 ("s390/mm: add (non)secure page access exceptions handlers")
Reported-by: Heiko Carstens <hca@linux.ibm.com>
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---

Changed fault error handling to nolock. (Heiko)
Added PG_arch_1 cleanup requested off-list. (Claudio)

---
 arch/s390/mm/fault.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index a52aa7a99b6b..191cc53caead 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -441,10 +441,17 @@ void do_secure_storage_access(struct pt_regs *regs)
 		folio = phys_to_folio(addr);
 		if (unlikely(!folio_try_get(folio)))
 			return;
-		rc = arch_make_folio_accessible(folio);
+		rc = uv_convert_from_secure(folio_to_phys(folio));
+		if (!rc)
+			clear_bit(PG_arch_1, &folio->flags.f);
 		folio_put(folio);
+		/*
+		 * There are some valid fixup types for kernel
+		 * accesses to donated secure memory. zeropad is one
+		 * of them.
+		 */
 		if (rc)
-			BUG();
+			return handle_fault_error_nolock(regs, 0);
 	} else {
 		if (faulthandler_disabled())
 			return handle_fault_error_nolock(regs, 0);
-- 
2.51.0

