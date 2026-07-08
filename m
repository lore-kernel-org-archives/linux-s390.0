Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1288A34753B
	for <linux-s390@vger.kernel.org>; Wed,  8 Jul 2026 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783504943; cv=none; b=KhmFXUe1ba5bgiuF7jQD/qtnFBnud/y1jP51YQcMtjzutWoFooGWAxZQLO/1a2UW7+rD8sFnfzT1QGmVAGNroLVkCxnThRcZ3K1vb2ltQWhjEcNiDEEXWtOOViCa879vV2KTYT9EJ8OGEOXzTvi/7URrmrDvAzQK1E/3I22FZDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783504943; c=relaxed/simple;
	bh=nj/tXYICVZsncp7mCBoL33SdT5yGXUnBuA0ysViUKYE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oOKDTTPkSzPUSMtrbn/Nb1JuueNHc0MB95tloRdv5DFAm1gaHpDYk+7h6nstb3h3Jv6GJKSRfqp8FVFw52GF5rcCv5P6voHGcTH5rXIJxP+uN8TAp4NsZV1XsfUiUbY6I/XQEofNCz8jCFNFwCtBUerqvkAF2bmSwJ0pKyJDAmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DcM5cLqk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DcM5cLqk"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6688IDl22501467
	for <linux-s390@vger.kernel.org>; Wed, 8 Jul 2026 10:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:message-id:mime-version:subject:to; s=
	pp1; bh=hTUXtRVlciOZTPP2S8tXzuPJI54IEIe0THyw5Hkx1/0=; b=DcM5cLqk
	mH4ffRK8O4/qwVWTfha6lXJVqfc0F2dO/U71MaFUikw7L2q4HYoyGiD7YXnAYvPs
	U/sBb62xPsgKrjB3BIGRQizZEICKApWr9Pw0Km11mS3pyX7bKsfD1cmvsqH2QLKU
	OiGMhvQZeY6X8IfM5BmYR22g/Tpq6cMYJfuqJ72ruzzkI1DDZHHO03UxyCdNO3tA
	36CctSrai3vcXXLtB9iWbIivt/ZpaFDu3pjp7NMUJ5N/hyTw17Niw+6pQSSz9usB
	ICtIHnHH/qKyok0uKMGG1Qc2y8SltPsihyBU8iYTbFDN3JXN9Kx7waIoy25RLK6h
	nOPeiyvsseCgZQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4uubd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 08 Jul 2026 10:02:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6689YcNe001514
	for <linux-s390@vger.kernel.org>; Wed, 8 Jul 2026 10:02:19 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hf7fd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 08 Jul 2026 10:02:19 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 668A2FPi25952700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jul 2026 10:02:15 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B10DF20077;
	Wed,  8 Jul 2026 10:02:15 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 758172007B;
	Wed,  8 Jul 2026 10:02:15 +0000 (GMT)
Received: from localhost (unknown [9.111.0.64])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Jul 2026 10:02:15 +0000 (GMT)
Date: Wed, 8 Jul 2026 12:02:14 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH] s390/checksum: Fix csum_partial() without vector facility
Message-ID: <p01.g0de361f35d11.tthup4z@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Patchwork-Bot: notify
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _BV_P04x_LjitjJZleyLexw1uhxyE86D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDA5NCBTYWx0ZWRfX9WRxajMbBQg8
 5E0iyIwMWjG3vF8bo8+KY0Ci7/dW4SXG4SMUG2AQ2JFZavj0eQn4I2JBZCs/udRvtX+MCFwS+D0
 LMMBNIYYTrX0OIKtiYIywVTC2QtUsYYOhCIChncFmBNd/g02c0AYisx5LUtPqiofHuRzdkJSorY
 SIgra3+5l64ME2z2qmKATitv/ls1AWq1+LpS5dlm8mPW5FV/1eUrzfCa4UCxg+fwoV/TYpMjO6o
 S05Hz0ccFme8NAGPZTKzXfsrBuMLMXjKTDUfuSS3kyBs2EMgwTgOe/HmPws1Sep8DMhz0Zwp05L
 c8OCg7+W93GNLsBc3q39TqenExy3+BiPf4MiZNO7VC0LMKip7TeKm62ofO0JChLHeWx29SIcKoL
 KhIKViL/mnRaTLB+5Kfib/LqsQoNDD4RgRqRZ/2OupLXfYCGJoPH5k6athw3d77V/XFNnU20cYM
 oH2VMnb46PgqzS++L7g==
X-Proofpoint-ORIG-GUID: _BV_P04x_LjitjJZleyLexw1uhxyE86D
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4e202c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=BXMOZH6PS6HjN1SVsM0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDA5NCBTYWx0ZWRfX5Bo8znqEUcGT
 WgbI59Vkasx9yWOvoQkIhYS6o++/+LI2nKrL78sPodZQBjWAe8KQ8I2adzM2y7zjOfQN3bjJZZ0
 7LWkMXu6yw4w+XTaEuURRscDVKOzRWE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_01,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080094

Currently csum_partial() calls csum_copy() with copy=false and dst=NULL.
On machines without the vector facility, csum_copy() falls back to
cksm(dst, ...), causing the checksum to be calculated from address zero
instead of the source buffer.

The VX implementation already checksums data loaded from src. Make the
fallback do the same by passing src to cksm().

Fixes: dcd3e1de9d17 ("s390/checksum: provide csum_partial_copy_nocheck()")
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
---
 arch/s390/lib/csum-partial.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/lib/csum-partial.c b/arch/s390/lib/csum-partial.c
index 458abd9bac70..9d74ceff136c 100644
--- a/arch/s390/lib/csum-partial.c
+++ b/arch/s390/lib/csum-partial.c
@@ -23,7 +23,7 @@ static __always_inline __wsum csum_copy(void *dst, const void *src, int len, __w
 	if (!cpu_has_vx()) {
 		if (copy)
 			memcpy(dst, src, len);
-		return cksm(dst, len, sum);
+		return cksm(src, len, sum);
 	}
 	kernel_fpu_begin(&vxstate, KERNEL_VXR_V16V23);
 	fpu_vlvgf(16, (__force u32)sum, 1);
-- 
2.53.0
