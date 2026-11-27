Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789454;
	b=M/esflt6L615tBPD907eTKH4lwJWqBKGFb1SdftIaqSWQ/dmpBLiBw5gzfcsJxwheGHE
	 F1g8OGmhIr+WaJ97Xf51l5N6wtGmJPmIrXDZhNh3vcTqxtBybP4aFQTGyDKKG1ocvalpe
	 3CzZ4m1IDKRYQ37HjU9v+rh+rzH8F/kR4c9uajfACmj5KHP3cgH8bP2DDC3nXLgfLBvIL
	 n3AYckiwddRb69YoH38scvuHU72WxDE+6cZC9N8xYG7RDmzlt1RHrm0SY3Kbz4RlzXqM8
	 UxYmkSQYVLvhPBlFvYOCm5/MuSPyEqZKvk+VX4gjhwZ1TTdIf+kbIrijB35j6VG9PoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789454;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gh6rQvgD45hRErlKe8dVyyI+YTtSGocYiIeYjcccslU=;
	b=bIyLABMWsUPdU+lwjPIF0hDbLv7oQMegcuElxxsVwuOfBEE3UhM4FPqsIMu3Sov5abi5
	 BDy5P1gnWdjt90q/xa+z4hduCppo9v+FuKerZz5+UyjwMbI3BnCw2sr0o0MVH60DZpUN2
	 JYgP2poOZ9aTYSIkoLlQ9pxbwwWY4Fq1tDuy+fWr5wtT1oQib83VaLg1YeCbKQZ0C/5lt
	 +QjWh3/VcQcH6SgaMaDqqUyEfBo3Ht5DcrO/NDcM24QR7GUWAxHedcoHSbiHaZoPHzGTz
	 ip1jlhY2mWF5U/Uqe/J/oMvURFEu+SsWMNqalGXcTd5tIj4XEXSJDHJVTUKpWtwNDhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E3+iKkAt;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF229606A6A7;
	Fri, 27 Nov 2026 14:24:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF229606A6A7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=E3+iKkAt
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE51K02012238;
	Fri, 27 Nov 2026 14:23:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=gh6rQv
	gD45hRErlKe8dVyyI+YTtSGocYiIeYjcccslU=; b=E3+iKkAtQCYlHJLDDrB5h9
	wSPszI9D+Sb5R+k8W9J/B8QoBhmxBVrjNiW92pK+E75BXmv4o+GAQB1kVwX9gG3F
	1ON3cyaauCqKLLWPTd0Kqdwqsx4oRfCA31jxJ2zh+IGQYZQVeNCvBMyuKj5Vop7n
	CJFD5eD4suwvqUKe0cbvuJbCUn6HsmeGMogMWLcYolXPOZNcBbk2kiefmb88UCOM
	mdZzrs/qZ1Wy2DyHTSXf2MJI7WW/kZV3RXHMnG661k7C2Vag70/l8ujf/Q1eOlay
	Y34OHFeCPtsP+PLM7vW3i0MnpB2slly2uD93i1+pA77cdbsmcA7e4ajHf2GrIoQw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j34p4w8gx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ARE4KTd3999046;
	Fri, 27 Nov 2026 14:23:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j6x3h2eu5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 14:23:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ARENL4b33161652
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Nov 2026 14:23:21 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDEDE2006B;
	Fri, 27 Nov 2026 14:23:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80DB82004F;
	Fri, 27 Nov 2026 14:23:19 +0000 (GMT)
Received: from a46lp73.lnxne.boe (unknown [9.87.84.240])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Nov 2026 14:23:19 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Fri, 27 Nov 2026 15:22:15 +0100
Subject: [PATCH v4 12/25] s390: Add range check asm macro
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
Message-Id: <20261127-sysreg-v4-12-a6318d18aab5@linux.ibm.com>
References: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
In-Reply-To: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfX7ltNTek3rOkG
 +3HcIvU9pg59kx5L0HS2Wr9AVZbnWreb7nuetF6I+rlw9QqqzkB1CxBY+WHgibh+b2EtTqZu6WI
 I1wcVnNselrjn6g/85gy4Aj6ev9wdMg=
X-Proofpoint-GUID: SVk6GIfqlrwW-zbi3mk3AMiC8LNJNkVN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDA1NiBTYWx0ZWRfXyC6DiKnny9jN
 E0wEBCE08ylmrnuSI46mV4HlE4FF28kB/Ts5aoz/z5iHU4/rzIJeOzMcHp742FeqB9x/aafdaPL
 FC0hkHxqyT6BH0qyHTD9U1TlIi/KK2skBZU/rLqb+YLA9wXQeL7HYbDjQJKG/kDT03MF+OnPmCV
 niX+V9JMN2IAZIzyfy4kzUm61toQRHnfhvH+/Cv8rKm4Ml0VQc8FuJrEWY7oKKcGReEY+0acwJj
 xi9U8euWJ6xRMlviatekQ2nX88lphEe+3haIUZ0O+f+9AJlyub5vALVAjd3M9gkjgxd2U4XB55T
 CBnbudtBRb2U19rrfEnda47TH43SK4yWqJGNmqbwYIIAEyctcxEFlXIoFCtWgnJrt1ZobOg3jYf
 EbO34dRL1TUgZG6UCkxQUIFmhSqOL05SUayPjg8kOuA/GdsTaYwc3G78LiVK5QDwX7hyBmki0tL
 61mlUOteKzhgC/EF5/w==
X-Proofpoint-ORIG-GUID: SVk6GIfqlrwW-zbi3mk3AMiC8LNJNkVN
X-Authority-Analysis: v=2.4 cv=QabzLcbv c=1 sm=1 tr=0 ts=6b099262 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=Hoxe6d4Xkq5xC5L4oCMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_02,2026-11-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 clxscore=1015 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611270056

From: Jens Remus <jremus@linux.ibm.com>

The range check macro turns cryptic assembler errors into an easy to
understand error if e.g. someone mistypes an input value in an asm
macro.

Add an asm macro that verifies that a given input value is in a specific
range. Add macros which check for ranges often used when creating
instructions. While at it, add a range check for the register numbers in
the GR_NUM and VX_NUM macro.

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
2.56.1

