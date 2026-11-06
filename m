Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981336;
	b=h7O5j2iYa49+8OXVTJmTZbGzOe0PXoF3jkY4z69LzhYkFDGXoZ8X+MjQ57lTpLPzw0t8
	 CLXZseeT6IgnsyMNn7w3iAxnQ7ri15nV5ixeCjGOvpWauXd0+Hq9YyDwnHNYEA4lvdkZD
	 8koKNq8u19Rtp/k7DJ6Zxi4T7FJuPwOoIL7P4C240rG0iQJvZeOe24C+Y8uZ1+uuYZLqu
	 xfqdLaVC/mwnlU6V/09BmvnM55b7ahz0ytsWdjN6bAE3fthpyTtQ1aKqthXrvEUMyN7un
	 9dde9eAA8v9P7ErFSSHBmhwzqFtB3CAlaqDJFxgt7wFRO6TBakZ/L1BVayz5MhxJQ8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981336;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4CRB45o87B1y6cGu+sB4g7GznXFnvc9TXSYvLCMuNzE=;
	b=RQ17srlqskvyRhkJQvVVGIlc97fFZ9f28e+V2eBNu2oSz9Ac3zAnGIw2q2Rht6/3tmV2
	 QlLw5Ndjwb32NTe9qbYT2Im167XCc5OTCf4xKHbwEu6lXhl4x0lg+eUsl0YGbAYtkaSXA
	 d+Y/tN09zhjYMnwDgOYHJwn0g1yJ1sr4rJkhBOz7OAP5nKnd54ifiXp/Gw9E464MIL2kj
	 t2G74GoQJqppIkZVfYLNCBa/d4HedCDbtqitkTgi9BTTDMLwCSfIro3CDe1w+c/aqVlmp
	 gIDnrUvLc1YsmqLyXWFLrb5IUnRvyddFxJxi1fu09h0gK7kbCAdmSiySdRHRmvYwvMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="i/OWvNdw";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D211B6082BFB;
	Fri,  6 Nov 2026 16:08:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D211B6082BFB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=i/OWvNdw
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FEJon1095102;
	Fri, 6 Nov 2026 16:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=4CRB45
	o87B1y6cGu+sB4g7GznXFnvc9TXSYvLCMuNzE=; b=i/OWvNdwLQoxolw0x+kxBo
	BJJorq0xrZc707ltGuNzqSeyj8wlQizuMswYsnQPgrgShSivdB48aOIzBuYolKS9
	zbxWahFlW6AkVnk+bRAUrm2LLkiaLIs1c3OJqFeJmghpGracGmLELzO6tST/7wHe
	C7ZKTFJPX4K/UEsRjIRSqCKHW9qy1200TCLPUDOjNUAaqoFe6zN62lEG2t3DCJmK
	f4DJfXoViD8P/I/X4ar1GZ+S0Yjs7QimWUBPDlLCB6yWI9WMxQMi3KDOyfsFzX/V
	0WNE11MFiEpFr09hX4elKiNEBS+5UN6P9i6bzUY1bESfygBXcgSGy7BZ+mHpCtLg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3rawj0g-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FKCoL3577989;
	Fri, 6 Nov 2026 16:08:27 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqv1v871y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 16:08:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6G8I2v49283430
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 16:08:18 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07D4320040;
	Fri,  6 Nov 2026 16:08:18 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C3DD2006A;
	Fri,  6 Nov 2026 16:08:17 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 16:08:17 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 06 Nov 2026 17:07:43 +0100
Subject: [PATCH v3 10/23] s390: Add range check asm macro
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-sysreg-v3-10-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>, Oliver Upton <oupton@kernel.org>,
        Fuad Tabba <fuad.tabba@linux.dev>, Joey Gouly <joey.gouly@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Andreas Grapentin <gra@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>, Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, Steffen Eiden <seiden@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=QYDzLcbv c=1 sm=1 tr=0 ts=6aedfb7c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Hoxe6d4Xkq5xC5L4oCMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: O86VXZeJplvG5pQV7GWOTTNlEFrwTkH9
X-Proofpoint-ORIG-GUID: O86VXZeJplvG5pQV7GWOTTNlEFrwTkH9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX+rIkcwvVICcG
 MmnOTwlLClupEcx/fqG6cu2/FF+vTHLyoe4Pf6/3LVdScQhlPMjgOBOOiteUHSHr2vS6Uv8khIA
 rSOz5lEErX68Cp0rwIVv0Y9Q5EhMVYA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MiBTYWx0ZWRfX7h+sjArM/dLd
 +B7bCUGm1pawE3eVBEJ2r/L0FUV/dsaJXTakwBIrhHvLHaMoJPlrA6bOr+1+Xy0V680COXre4mS
 StcJzoN6RMaR0B0r0jD5nzZ/KGFhk82rxznWdMmDvjyUW/DUrzbJVFyNKF/8PcfOC1u+81ye0A3
 o0MjGnvt4DTlDYMCpVF1yeihjSP3qjr1H6b6XceKkk2dIMP1MNJEqqCo6exc5F/XVBmnvskjpmC
 iU630pZ7pkiaQS5Z3nqKQ07kGdpyTgyncI3IdHQlItIMPLTynXernKSz2rfCdYUfpLTICbOTCpl
 WafjsPfe4xJK+DhXafPGsrZwzx075olWeD542bfYf7LaEHZdYQvClN2V+czQ8LwIKX/nuuna7J3
 12S4xlj9UJpIQlU9C0uDW20XL7KLpJgGRywFZdN6o/NX8V1PP0naWvmXvdOEbUQBLYjJYs0xgvs
 tvem/afzLK2NiaaO+dw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060062

The range check macro turns cryptic assembler errors into an easy to
understand error if e.g. someone mistypes an input value in an asm
macro.

Add an asm macro that verifies that a given input value is in a specific
range. Add macros which check for ranges often used when creating
instructions. While at it, add a range check for the register numbers in
the GR_NUM and VX_NUM macro.

Co-developed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/insn-common-asm.h | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/s390/include/asm/insn-common-asm.h b/arch/s390/include/asm/insn-common-asm.h
index fd9b3cacb7c5..f3f10f2c92bb 100644
--- a/arch/s390/include/asm/insn-common-asm.h
+++ b/arch/s390/include/asm/insn-common-asm.h
@@ -9,6 +9,32 @@
 
 #ifdef __ASSEMBLER__
 
+.macro	RANGECHECK	min max val
+	.if (\val < \min) || (\val > \max)
+	.error "operand out of range (\val is not between \min and \max)"
+	.endif
+.endm
+
+.macro	ASSERT_U16	val
+	RANGECHECK 0, 65535, \val
+.endm
+
+.macro	ASSERT_S16	val
+	RANGECHECK -32768, 32767, \val
+.endm
+
+.macro	ASSERT_U8	val
+	RANGECHECK 0, 255, \val
+.endm
+
+.macro	ASSERT_U4	val
+	RANGECHECK 0, 15, \val
+.endm
+
+.macro	ASSERT_U5	val
+	RANGECHECK 0, 31, \val
+.endm
+
 /*
  * GR_NUM - Retrieve general-purpose register number
  *
@@ -24,6 +50,7 @@
 	.endr
 	.if \opd == 255
 		\opd = \gr
+		ASSERT_U4	\opd
 	.endif
 .endm
 
@@ -46,6 +73,7 @@
 	.endr
 	.if \opd == 255
 		\opd = \vxr
+		ASSERT_U5	\opd
 	.endif
 .endm
 

-- 
2.56.0

