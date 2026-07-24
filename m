Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC47431A52;
	Fri, 24 Jul 2026 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784902423; cv=none; b=bTFFRdp2vy1anSKFUw8IFa0tq9dJGcq41VVZ35nT1m6s135I6rUrmCRtfbP86zGw/FNPbB+oSclMi8ryixrR1Istzjx7/7HM1uPwgSoWVnRHiXBnexLu70dMu7VVyrwCOgmEuW+1lJfOkBpzX0UzfOWjjzUlDUmlty6EHjHD3Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784902423; c=relaxed/simple;
	bh=dvLX83Y1N+bxcR5GC3lVUIytKdI3Jmlt/0HiFjXm8dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z2WXm51rz9m1j3jemiH51s51scXatT7k8e5eehd/v8krFuKEKtpmmsVTOrWKpGtVNIsvfb+wDt+UzNiS1MNQo1b3csWUa3v+S4zscPPM5N/hoCsQfQMJpfY9brZ6Lq38MS54W2E56UzJ7Nbl9O0imSUaGNbhS3TfAt9yIvtoC5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iHRxBRZx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iHRxBRZx"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODg0Q81898317;
	Fri, 24 Jul 2026 14:13:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PVI0u44dEHcXtcM0s
	Xi475GM3IfnyCxK+FZSSkdF33g=; b=iHRxBRZxr0sPtEVC4hNCfd8S7V2qEr9n3
	3fa8ucupvBkycKP6F9FG/pgqWfog+oYTuQl9DywrZO7Yj2d0GSm0SMvIWYJ66EjL
	T6UCky+fIR9MiLa6du7tAP3UXp7pQm0APRwjcSiaM+7wGms7jiht62eEXYb+HHby
	IiaU4MBOZBSG/CDueNZ7lmnhJR0AIccF9ADejek1ki6hfOfvaUh7QNnvAHX/PLWp
	EIgwrSuBMT9i6UXs7I2KtjpXcjMZ9D61bqqSdsdmTp4IFZ1PnhUdBAjq1w4E8prM
	c4S09NFABRcAqEu25acwcPCJZFkGwXbEv4jzWG/LkwqtstpW6Eifg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77kmf2n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:13:27 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ODo4Sm024935;
	Fri, 24 Jul 2026 14:13:26 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnahh68v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 14:13:26 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OEDMhU31195660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 14:13:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B123120116;
	Fri, 24 Jul 2026 14:13:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6BDA620128;
	Fri, 24 Jul 2026 14:13:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 14:13:22 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Dominik Steenken <dost@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Maxim Khmelevskii <max@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Sami Tolvanen <samitolvanen@google.com>, Kees Cook <kees@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: llvm@lists.linux.dev, bpf@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] s390/diag: Generate CFI type information for assembly functions
Date: Fri, 24 Jul 2026 16:13:16 +0200
Message-ID: <20260724141318.1037434-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260724141318.1037434-1-hca@linux.ibm.com>
References: <20260724141318.1037434-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a637307 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=EPsGp4Ve3OqINF1AOYoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfX7eFOp0aEPHMC
 rulBIjpXV3Ltd2QvzbxiqZvieA+EpXCYN6HxLRdvZZ0VYM2pUHz7WmE72A/+RvXBeEG+Zir2voy
 ZsM6OQ7+E9G7eEoJIoqa+Le86XeqFIm5nMh03ubMPnal5w0PremALqeDin25fsoUTMN3dx2C5N9
 dGn73EirWWF4NCoufJAvjiWSo56Cf6so+YraDspefpErRbG0o9BmbStGSWo9T+1Wkctkh/Kpfl0
 etTBt5RdT0kOLo0l2BhgCaQCkeu6nmtNx1EuJR0PlHX0yaxhhshuS4goi47TDF21wDRosDOSqWf
 swgr5Ko9OSBoyeMwvno8uN/5I1DMqmSJUElD6qEaYIB8CPMu0k5iiIxDsOydXu045TxlhK9N2Hv
 1sGGtVThP91568rFhXIWbjRRDTWu6YmF6bX66dpn5Jr0n9jv75zIzwrkf/U3tGLtQgGPjP6KrDD
 ks7vs6Brn3UBjLFygwQ==
X-Proofpoint-ORIG-GUID: dCY8e3MjymhXNBKluNILjvjPhiO0K4vo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEyOCBTYWx0ZWRfXw4COyJb3bpZT
 FTkAw8DW9LPd3MTwBdlwzUESeh8OsRSkM4uxq/r3tcZJTuC+CoXicuMXkwHnUaLOrEm1aZtMt2c
 N/Awm2g6wdyL7vi1RneYtBu99KUpG1s=
X-Proofpoint-GUID: 4Rn6Sqs90kV_tR1pBnG6U0oNcFoMP9xe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607240128

Use SYM_TYPED_FUNC_START to generate __kcfi_typeid_ symbols for assembler
functions which are called indirectly. All assembler functions contained in
text_amode31.S are called indirectly and require such annotations.

Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/text_amode31.S | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kernel/text_amode31.S b/arch/s390/kernel/text_amode31.S
index 26f2981aa09e..f007d892d0c5 100644
--- a/arch/s390/kernel/text_amode31.S
+++ b/arch/s390/kernel/text_amode31.S
@@ -5,6 +5,7 @@
  * Copyright IBM Corp. 2019
  */
 
+#include <linux/cfi_types.h>
 #include <linux/linkage.h>
 #include <asm/asm-extable.h>
 #include <asm/errno.h>
@@ -26,7 +27,7 @@
 /*
  * int _diag14_amode31(unsigned long rx, unsigned long ry1, unsigned long subcode)
  */
-SYM_FUNC_START(_diag14_amode31)
+SYM_TYPED_FUNC_START(_diag14_amode31)
 	lgr	%r1,%r2
 	lgr	%r2,%r3
 	lgr	%r3,%r4
@@ -46,7 +47,7 @@ SYM_FUNC_END(_diag14_amode31)
 /*
  * int _diag210_amode31(struct diag210 *addr)
  */
-SYM_FUNC_START(_diag210_amode31)
+SYM_TYPED_FUNC_START(_diag210_amode31)
 	lgr	%r1,%r2
 	lhi	%r2,-1
 	sam31
@@ -64,7 +65,7 @@ SYM_FUNC_END(_diag210_amode31)
 /*
  * int diag8c(struct diag8c *addr, struct ccw_dev_id *devno, size_t len)
 */
-SYM_FUNC_START(_diag8c_amode31)
+SYM_TYPED_FUNC_START(_diag8c_amode31)
 	llgf	%r3,0(%r3)
 	sam31
 	diag	%r2,%r4,0x8c
@@ -77,7 +78,7 @@ SYM_FUNC_END(_diag8c_amode31)
 /*
  * int _diag26c_amode31(void *req, void *resp, enum diag26c_sc subcode)
  */
-SYM_FUNC_START(_diag26c_amode31)
+SYM_TYPED_FUNC_START(_diag26c_amode31)
 	lghi	%r5,-EOPNOTSUPP
 	sam31
 	diag	%r2,%r4,0x26c
@@ -91,7 +92,7 @@ SYM_FUNC_END(_diag26c_amode31)
 /*
  * void _diag0c_amode31(unsigned long rx)
  */
-SYM_FUNC_START(_diag0c_amode31)
+SYM_TYPED_FUNC_START(_diag0c_amode31)
 	sam31
 	diag	%r2,%r2,0x0c
 	sam64
@@ -103,7 +104,7 @@ SYM_FUNC_END(_diag0c_amode31)
  *
  * Calls diag 308 subcode 1 and continues execution
  */
-SYM_FUNC_START(_diag308_reset_amode31)
+SYM_TYPED_FUNC_START(_diag308_reset_amode31)
 	larl	%r4,ctlregs		# Save control registers
 	stctg	%c0,%c15,0(%r4)
 	lg	%r2,0(%r4)		# Disable lowcore protection
-- 
2.53.0

