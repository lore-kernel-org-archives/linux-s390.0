Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209A53BB9FA;
	Fri, 19 Jun 2026 15:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884338; cv=none; b=BV/0T2kV/YWA8oE97kQF9R8+nUo6vNKigTeVBmgCdgZJl0/TEblqo6dwSe3g4hQI/XHy5PwV0FqATNuT5oxINbABv0d+7mz1JQHe1kGmxmIZFZW5tT7Ho3wF9re5cjFDX5K12scProR+riSPDLk9+1pVnfRVsYuwRb0bI0amUbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884338; c=relaxed/simple;
	bh=MotyW5vj3zXvDoMxIEdjCCbCRVxwaVElCvaRRg6AbiQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrYFjxGnXrmc1MyvsoRrKJd30fBB/8g1ok+HSzgJx4e9sMoWJO/eoTDFywXnId21PQV6f2h1AKZ/atYqctGDCVrLVQnFW0G/6vMDuwfvj9yGcY98I/BXtcrSB5QG8yWQTmO6hWBCzHzv0kuS2bx6DCYZJAd+vSDD2IH7qoWMy6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SzSOAKhs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SzSOAKhs"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65JDIPTJ2292925;
	Fri, 19 Jun 2026 15:52:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TzaokU+Y+h3u3u2lE
	74js3Fr+ir14XtNtlTgxLuH7gE=; b=SzSOAKhsNn3X+aIVHEmIItA/5XrXd/e3k
	jj9ilPvgbrzDR8W+IfSYW3dzrJSH1i8vxiNsrNmiJL7QF0qQZerAlLI/oGFIUM0/
	9MLiQT0yeeSv0+NoJcM9c8MNOxe20979g8mdMohnPYKQP8eebYYp8cQ49lI8RwEC
	JcPn7hHwgmYLJTkiI+8M9trvAP5iJMcH7m2s/aui2sW2AAHgMq0lqHWxS0KMEL3/
	EAQOlP/JfgszvqrkXiRnVZeprP6WU4fFMs8tHoAZNE0oEwWJoXopFcQUHB6LVzn7
	IqhRSf2rS/lUUQ8azM+G1UQgLjwYzeFCeVJLPMgyr8MEJstQY9Vog==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqxe8a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 15:52:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65JFnttE018178;
	Fri, 19 Jun 2026 15:52:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172hgp5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jun 2026 15:52:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65JFpwxk40763670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 15:51:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 88AC020043;
	Fri, 19 Jun 2026 15:51:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E17020040;
	Fri, 19 Jun 2026 15:51:57 +0000 (GMT)
Received: from p-imbrenda.ibmuc.com (unknown [9.111.54.29])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 15:51:57 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        hca@linux.ibm.com, gerald.schaefer@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, svens@linux.ibm.com
Subject: [PATCH v4 2/7] KVM: s390: Fix dat_peek_cmma() overflow
Date: Fri, 19 Jun 2026 17:51:49 +0200
Message-ID: <20260619155154.307572-3-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619155154.307572-1-imbrenda@linux.ibm.com>
References: <20260619155154.307572-1-imbrenda@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDE1MCBTYWx0ZWRfX3n+yVEcKGaJN
 CNDX3k1kWkXpUrQ5H6DfSD+CdkOiEv63R6CwB8/aJ52ch6RUX3ThlIkTxlZEuA2U6HGnBe0H1y6
 70rCtCyWnu3zMt4+IisIL68Xrzb8z0Gz3zPJa7yi2CW2KRpbNV9tJUU5fWbrNd4p8FJ8KeIu6Qk
 r2TEEBg8vempZ7F89OrLYgSMi3w2QTyFmwEKdwMR8izecJ4KMSFlohvI6L3IlTUrMOMlX5P2qky
 5YhebijLnpvJikGZnqOfLIgyqCRtV3cY4gk1CxzyB2iYeYXts1i/08Ck7FT+stFKICSAJhsHvhY
 VVlYbxm00hMXqyMh6m0UxGafFz0y87Fb1J/7V/FEqI7nH9lEoR7iSg06SV4jLpT/MrUeqXwNAjd
 61HPn5fZe8OAyn9uemdlBd/nBhysFKTeqlqPUMhzOeIKtre4zr/nwT/deK1TNWnaiYVnRUYhzur
 oGy9mDH8Pf98bCYp1WQ==
X-Proofpoint-GUID: UxCTQeVq2cUcjMYUxCyaaC0_zvoQR_2B
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDE1MCBTYWx0ZWRfX+wAhOynMw+AZ
 HXFpUpIqfKcmNHTxmxeVf+0XXEIT90Ssba7jly97iQTI0+YZx26dEWA92VM7InaGqSrVE2tT1aF
 u08Dzty9q6MRLhRXWVIQHEFuapfCdxk=
X-Proofpoint-ORIG-GUID: UxCTQeVq2cUcjMYUxCyaaC0_zvoQR_2B
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a3565a3 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=0SZZOaMt82sS6LYugLYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190150

If userspace passes a start address that is out of bounds,
_dat_walk_gfn_range() will fail with -EFAULT, but state.end will not be
touched and will stay 0. This will cause *count to underflow and report
a very high number, and the function will end up erroneously reporting
success.

Fix by only setting *count if the end address is not smaller than the
starting address. This way invalid starting addresses will correctly
return -EFAULT and *count will correctly indicate that no values have
been returned.

Fixes: 7b368470e1a4 ("KVM: s390: KVM page table management functions: CMMA")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
---
 arch/s390/kvm/dat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/dat.c b/arch/s390/kvm/dat.c
index 4a41c0247ffa..cffac7782c4b 100644
--- a/arch/s390/kvm/dat.c
+++ b/arch/s390/kvm/dat.c
@@ -1209,7 +1209,7 @@ int dat_peek_cmma(gfn_t start, union asce asce, unsigned int *count, u8 *values)
 	int rc;
 
 	rc = _dat_walk_gfn_range(start, start + *count, asce, &ops, DAT_WALK_DEFAULT, &state);
-	*count = state.end - start;
+	*count = state.end >= start ? state.end - start : 0;
 	/* Return success if at least one value was saved, otherwise an error. */
 	return (rc == -EFAULT && *count > 0) ? 0 : rc;
 }
-- 
2.54.0

