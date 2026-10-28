Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793213672;
	b=OkrLQSMpvmDsiu2cP4BraE2vkmpQMSJCAbjuXG23pruDUTE2rcBbvGxjW6b6ihhUobM8
	 lUOUn3dNvdpz6tHzQevmdz1icrhDIwIDrOCY8JagmWLs08yWlP5WdzzTQ2g7C958qXn7c
	 eSaQ/rJ4rQNFB9y+GEnwUuzCFQh5nIEaWzB/J5Luz/HlTnG868NfI6D58tCj5OJ7h7qIx
	 IorG65lVTGCsBaMZ1d8QqiMYdZs2WejbJ+Hg56Hb4LZe6L+LFIXxKD7iUd+Bd7pw7572E
	 pesrxichA7AwGKA8vHw2F8bm7TISLTmq7p9+XUAIcm3LcpO69y0OctwD4rKGY6hYQJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793213672;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NS1j9lVogng+5ldDAIMdZiwng3ol+ONe8hkzIucuqmU=;
	b=vIWiuqsKEwM6uurfi50FyWLKvN8I/8ZyYFtGNMq+FlQ6xEBKO+w3IZ5tVYmo73iLMq5H
	 GDFTdXLAZwzzxkZfEcMGO5rzaTeVkPv1mJEGU8pqBqAZ6I/xsx9pvgk8AD2fWDHtDR8es
	 SsEYr0xoiyMP0SLcGERPxSDBmuMUc49oCWvwQE75KB56LLjLbAwY+mVIcVTXXX2SB0pxi
	 BhXhMzGaxW/eWcq4Jzm+xTkpTc2lr5AnhDBNcorTFpGhuBZXXVY7065igGbjWW5ThUUiL
	 zFsE8n6oIUdhyZolmynw+aAhWXsOZ1lTbEn0flI/21yTOr6vBu9fB45kEqOflh8ChbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UTzGSgya;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06D5606A31C;
	Wed, 28 Oct 2026 18:54:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F06D5606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UTzGSgya
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69SIiDkN869278;
	Wed, 28 Oct 2026 18:54:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NS1j9lVogng+5ldDA
	IMdZiwng3ol+ONe8hkzIucuqmU=; b=UTzGSgyaRGLyaDWcuaeEXJEgp6OtBwXZ7
	Ro3wFmQvcb8TRlZilolchIcKwH7urs8ir33voVoeyf/RVY7bQAWcHlto6Sz9vpds
	5Q+NzHiZe9d8/1GPqFb1ekRBrwux+XvpukBIY1/VnkaxpLGOTgGExRUJK4xuExq1
	kTEjNabJiBQEbO0epskUJTTXNUIYKWCEaev7hyN2FH5zmmCfkmDvBAt1b1Hw7UEX
	MNMN2Q6Ze1hKCbS988CJ8S5e016JP/kI/wg2tjnw8p6y/Un6eUvbZvhafo2TEvq1
	zMBMeBr897AvFWmQa03Jxt++IVAxyrMSt1o/0T4DsNfwSaTCXs+SA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgk3g69fj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 18:54:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69SIYpRJ1900425;
	Wed, 28 Oct 2026 18:54:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hjtnnedys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Oct 2026 18:54:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69SIsMYE51708190
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 28 Oct 2026 18:54:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1AB420040;
	Wed, 28 Oct 2026 18:54:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C291B2004D;
	Wed, 28 Oct 2026 18:54:22 +0000 (GMT)
Received: from p-imbrenda.ehn-de.ibm.com (unknown [9.68.31.243])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 28 Oct 2026 18:54:22 +0000 (GMT)
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, borntraeger@de.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, nrb@linux.ibm.com, schlameuss@linux.ibm.com,
        gra@linux.ibm.com
Subject: [PATCH v4 3/7] KVM: s390: Fix idte_crste() clobber and table type
Date: Wed, 28 Oct 2026 19:54:18 +0100
Message-ID: <20261028185422.272146-4-imbrenda@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261028185422.272146-1-imbrenda@linux.ibm.com>
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=BOMmP1QG c=1 sm=1 tr=0 ts=6ae244e5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=B6i_w3R9oO7yGhDFKykA:9
X-Proofpoint-ORIG-GUID: ZoYwu7bxefpWm6Scj2I73RTXQ7mbyW56
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI4MDA3NCBTYWx0ZWRfX8rru6nPUF2/p
 wroRrn3D5pH0q52sTQd7468TH2+SzUhjjQgEJTiM0Ivry/xTw9JkwYtQkEChsIhzJ3CeEc9rAoX
 ixnaOmwOnGFdfqJw/A9pyu/7Joo3yZwkWREhNOWRaVsNaPq2V0StlVSNKhzCEyKGz0x6YhlXnoM
 Dp+bwKGvi2AcyUVPu8eUpCiXih6JNfpFD8FfJ9bQ5GXfYxYPDSX8Go67Dx2yPbkwPqRgSA9UmBl
 qT8dLJR8vOZSYlhFlfYHf6yFAIeNQP91Q6QFQ0DMMMmrofucnySaIMMF9s8ktH5DGaUiuxWzvz8
 VmaPwfCXqcBZZ0FFcAsoUqL2td/c7oByxJnuSO6tqRe4KHy+jPQXHbox6dknjlQ5EGwKbx/ZCCS
 oD/LSXa1/c6i+D2iPIEX2kgk/lGai7xAEyb0FFsjUo0pOPT/UfNUuyG8KpiTObjrbIwMArKjEZm
 wsr0TIdz4IVLHFk10+g==
X-Proofpoint-GUID: ZoYwu7bxefpWm6Scj2I73RTXQ7mbyW56
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI4MDA3NCBTYWx0ZWRfXxBfcArlKcrVs
 okkgdlPdf8liRQkdi41F6c6aQc3/NIInNDRTlYLvaLDfAM9GbDlUU3CJsFIraWND6AY0XUlVDGL
 PWzl+2h3kcZrupevxAAWimaAfQzuv1U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-28_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610280074

Fix idte_crste() to add the missing table-type bits and the missing
"memory" clobber.

Fixes: 5a74e3d93417 ("KVM: s390: KVM-specific bitfields and helper functions")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: stable@vger.kernel.org # 7.0+
---
 arch/s390/kvm/gmap/dat.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/gmap/dat.h b/arch/s390/kvm/gmap/dat.h
index 687e1fa904d6..fb7e839a355f 100644
--- a/arch/s390/kvm/gmap/dat.h
+++ b/arch/s390/kvm/gmap/dat.h
@@ -640,20 +640,22 @@ static __always_inline void idte_crste(union crste *crstep, gfn_t gfn, unsigned
 	unsigned long table_origin = __pa(crste_table_start(crstep));
 	unsigned long gaddr = gfn_to_gpa(gfn) & HPAGE_MASK;
 
+	table_origin |= crstep->val & _REGION_ENTRY_TYPE_MASK;
+
 	if (__builtin_constant_p(opt) && opt == 0) {
 		/* flush without guest asce */
 		asm volatile("idte	%[table_origin],0,%[gaddr],%[local]"
 			: "+m" (*crstep)
 			: [table_origin] "a" (table_origin), [gaddr] "a" (gaddr),
 			  [local] "i" (local)
-			: "cc");
+			: "cc", "memory");
 	} else {
 		/* flush with guest asce */
 		asm volatile("idte %[table_origin],%[asce],%[gaddr_opt],%[local]"
 			: "+m" (*crstep)
 			: [table_origin] "a" (table_origin), [gaddr_opt] "a" (gaddr | opt),
 			  [asce] "a" (asce.val), [local] "i" (local)
-			: "cc");
+			: "cc", "memory");
 	}
 }
 
-- 
2.56.0

