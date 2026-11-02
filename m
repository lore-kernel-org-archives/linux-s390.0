Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793638278;
	b=ekzjqQ2uPDaR041C+z79kuLXcNBsNN0Gb6H1PS5xhfhCgtBNzjs27S9vrYHGZrkamDcU
	 cbxEYVyUNXG//fpbTRCSI2OOZ47CjsN3SHksE33igPcE84aO+hC+p8S6gGJuiIyrZP7Pb
	 qauuCznqSbUujMB42VMEYLq7GQADDxfAEF5aKLGWjTSa+ufY0ZgcpvmXoEt72nKBiePH1
	 1WWEaPhDV9IgK1V/1hPKh6VfzlGXPlvLcukc/akaA90uyjCmZh+BXCrO79YK1RoDxzSot
	 t4eKp3fr4kkuTlxbEjQILi1LsQiyXCJImP7LljuqLk+xdlvZJraqAmQChFj5gRW/YLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793638278;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=+U/mjWVawnE0BkPpR4MVwaR9xy7TVaZQVjZw7XRSOGw=;
	b=XwYC66wW0bkt8z1vVYlLFF4RC3JBroyfiVeoE7SU/I0dXBLGpsG+7PYURQ/G9OcCK100
	 iDql2MaPW8t9qWlgNaIbHLUJWCHsScksYXgAvU3YQm2jdKlzb9X0Eze+SrN95AlWRkb5i
	 tfeVp4//KSPtuylxfCyR5QSJMIsHF1lg8Mvx/VPhsGcz/T8FKpJ6lW31qVTVzUUH7RZo5
	 ittT9M1+icQExHyL6Mdflx8lpcweH4cYRXxjj4/Yj9Xw7oLVFxtqGfyjqvDT2hE52WRFZ
	 GeRQ6Z+Zj+hDKHiRbQ46wRTfqNlE1llCfzMWJbHgamai6zCFsPZegSbPMz5XS38qOdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aFXg8vDL;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F265E60A8C03;
	Mon,  2 Nov 2026 16:51:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F265E60A8C03
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aFXg8vDL
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2GiIAH3421707;
	Mon, 2 Nov 2026 16:51:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=+U/mjWVawnE0BkPpR4MVwaR9xy7T
	VaZQVjZw7XRSOGw=; b=aFXg8vDLvsB8Ue6yhAu6e5DUJQM4SafqO6291ZRxMMm8
	xaxryBkA4BYOG8/dDQf9pVd+uwfhq7j8WteBEO9fZXHNCzJl0sNsNce0kUwmC/n1
	gruBH+8+ovteR78OwHljJaTJUHI3xEfRa6VB9Y8+mLEJRkMK3v7eHYr1hEevBzxJ
	mIqmEJ9UDF7/U3jByNtaSC1QHjJw0VUFVRaV5JXEysn4BY6aPoQgud12rPgv70y3
	LJ/Yu4iB3GeqYQfh5Jk87Ecqc5nDOZboO+fCJkAT6qGJDZencgDuLDg5sXafMfFh
	tmKZIZnVAnoVDeR2K7+RFf9x1pp/zmwLgQSw2Vwzbg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn826hrnw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 16:51:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2GZ06g1242310;
	Mon, 2 Nov 2026 16:51:16 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnwbxxmpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 16:51:16 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2GpCLq51315040
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 16:51:12 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9104720043;
	Mon,  2 Nov 2026 16:51:12 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71B5020040;
	Mon,  2 Nov 2026 16:51:12 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 16:51:12 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Mon, 02 Nov 2026 17:51:03 +0100
Subject: [PATCH] s390: Add assembler-level include guard to
 insn-common-asm.h
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
Message-Id: <20261102-insn-v1-1-df048a0be0d5@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwMj3cy84jxdU+OU5OQkg2TDtLQUJaDSgqLUtMwKsDHRsbW1AMtkFsJ
 WAAAA
X-Change-ID: 20261102-insn-53dccb0c1ffd
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steffen Eiden <seiden@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h3GZoAjGTZFjABmbEirmgWufsaTY54A1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA2NiBTYWx0ZWRfX2F6z6wOMcKyy
 Z9D2pwHerjoFFQbhKGJoMDLs6N5x1x5MtJ6CCdUDqtesBqWakkkaGZQdKVVFQdytldbbDdRz/yj
 TL1VhYFO89DuowxkpqcinSshfwcGUbq9/DHzogLXKgy0FgURAJpiwJ5bOt79D4TNNc5DHb6cIa7
 ZxhHqxKhy3OGQ3zHpIdR/QkyEU50ogb7ByV1pU+CIG5l9ummAa6VYnsz02MOv8oWfc23SzCZk+0
 N2H+qVQO5FNNB1QXT3jdIM2WL9qd9ZJkT5IMyBYEeBdTPQFPSWcS+npeIgj4v5qur3omYfUArJ4
 zJKjA5xwkV/CIUqpCGcrtOGHxLjtZCU9rg0DvSfdCjfU8o/ixHkWskWWlxvdybuixh5qOI2IiZr
 kIsXciqBXMAK7X3R0HqKLaYhvkuUwzAkG1NAT5mQ3SqSdSKT6M83QkqxQ3CTJ5KJ91Ej0HO2mvV
 kUd8Upin6fMqOadaixA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA2NiBTYWx0ZWRfXzqYxe6W2VdjV
 Iiaz4qh1VoXax/jnPzlmvxt7iKOaDzGaIpYnd4qiFKbx0VEIoLnsh9Z3j/fOeEKZxxWh56GDLpx
 BoRJhviPKHk1QJbwwHfy4VnwkajQFIk=
X-Proofpoint-GUID: h3GZoAjGTZFjABmbEirmgWufsaTY54A1
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6ae8bf85 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=5vy43KvvU7CKeNUKWJ0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020066

The CPP include guard of insn-common-asm.h is ineffective when the file
is read via a gas-level .include from inline asm. The assembler ignores
all '#' lines, so every .include redefines GR_NUM/VX_NUM and fails with
"Macro was already defined" if a translation unit emits more than one
such include. This is not the case right now but may lead to future
build issues.

Add a .ifndef guard with an L-prefixed (local, non-emitted) symbol so
the file can be include multiple times per assembly unit.

Fixes: 495bc70aa3225 ("s390/fpu: Move GR_NUM / VX_NUM macros to separate header file")
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
 arch/s390/include/asm/insn-common-asm.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/s390/include/asm/insn-common-asm.h b/arch/s390/include/asm/insn-common-asm.h
index fd9b3cacb7c5..060116719846 100644
--- a/arch/s390/include/asm/insn-common-asm.h
+++ b/arch/s390/include/asm/insn-common-asm.h
@@ -9,6 +9,10 @@
 
 #ifdef __ASSEMBLER__
 
+/* Prevent duplicated GAS macro definitions. CPP guards have no effect for GAS.*/
+.ifndef .Lasm_s390_insn_common_asm_h
+.Lasm_s390_insn_common_asm_h = 1
+
 /*
  * GR_NUM - Retrieve general-purpose register number
  *
@@ -49,5 +53,7 @@
 	.endif
 .endm
 
+.endif	/* .Lasm_s390_insn_common_asm_h */
+
 #endif	/* __ASSEMBLER__ */
 #endif	/* __ASM_S390_INSN_COMMON_ASM_H */



