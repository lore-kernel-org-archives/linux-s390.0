Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A25E31328E;
	Mon, 27 Jul 2026 14:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161163; cv=none; b=UoHD/p6rPxTrwXPuAUO/yN8wqyjqNKYtVYm6w5MEnmp7Fu4K3zfystTzvjGCz3PhNLHwda8T5ZSNmFzt7ncxIppu8HqGe3IRI6MBnPHu4luLYau1h2oBGW7l18DOZqCnKS3Uz4Zf3rqOgEK6BV8unCAi4myBdbFW7yEjXMlraz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161163; c=relaxed/simple;
	bh=dvLX83Y1N+bxcR5GC3lVUIytKdI3Jmlt/0HiFjXm8dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PyBkp44ME1XaD/uFxiUbhzzzq5tkquOPu5cdAoS1BuLQjdmWwKjFONvEPdi5/TQFGMFESGu7O+zxOAiX9AlRPZZuah6yF0LIanIU1Y5s3JChOiK8eL9OXEVzBfHzEDmNd56AhGp1kPPSw88XyofMu2NI+3R8Lk3t3GnCMFvuNJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SGM1TgHb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SGM1TgHb"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnS3e2298720;
	Mon, 27 Jul 2026 14:05:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PVI0u44dEHcXtcM0s
	Xi475GM3IfnyCxK+FZSSkdF33g=; b=SGM1TgHbi1bO0y89C+iuf+dU+fwbPtVm5
	o3X74/2vFz5yz2VNfvHIrX8Zfr0L9RUcvJI0xAheq3kwGhIQC6AxD+oTCiC/e6Ax
	GPFYzMj859ciJ0QEt4yCQD1hIeBun9gPJV1H4hp8EY1KqpoUJ2Q4PIaTpK7hxX92
	xrcPT7atcc6nE8RHn8NlvN311EIg9JQ0i4RTEB18dzcu4O/asJsB2MO7AcJUj2xO
	4zRcQhkCjm7PAvnJpPsz47l4HqjpyADXH3CSoHxY1qFZTSFjkvIVjyQjI0gvQlm6
	ViVAgsmzUOi7XddlQF5n/8SVtJCXx6Iw/rXvkRagzAa4KpDStwTkA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyhyy20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:05:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RDuc7u024729;
	Mon, 27 Jul 2026 14:05:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjwnrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:05:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RE5bTg39256472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 14:05:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 141652007E;
	Mon, 27 Jul 2026 14:05:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B5C1B20079;
	Mon, 27 Jul 2026 14:05:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 14:05:36 +0000 (GMT)
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
Subject: [PATCH v2 4/6] s390/diag: Generate CFI type information for assembly functions
Date: Mon, 27 Jul 2026 16:05:11 +0200
Message-ID: <20260727140514.116501-5-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727140514.116501-1-hca@linux.ibm.com>
References: <20260727140514.116501-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzMiBTYWx0ZWRfXza0uGdSfv4He
 ECNqBGFymJEmfyjsIbupFa+SsaOQ7y4MBxv1Rpn7zYgI1YZz63BL9oo6B9zj5n/KxPTHsVgeLJI
 h3JLY4RZTTN/90fD7JLJa8q/0iJ+UEE=
X-Proofpoint-GUID: o7WlJHfT4Q_ICeaFk3gqNfezRZgni46q
X-Proofpoint-ORIG-GUID: YLroBgjoEXvBcVVFAsrD_lgB9wLwnf_m
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzMiBTYWx0ZWRfX4AWXOADBtRez
 gMHRP0HRql0HnRpbVO3sa2ZQ/0YbSYORG8fHD0mMHoZP/YUA10m8cc+dzAzQNVvAYQeJCItxNZu
 9cCbrh18qHxYp8R/QadSlaPHKEhkS/S9tSYF7yjn04a4fyQC+qpBe9ggbQnvfkhjxzz5utlNVyQ
 eCG0uqVWjKHIEn1giZvi4IzOOMk0X/Eq6q03MBYDn3Yvju++MFBXkQMyGRgZWRiClG4lLl3EiRJ
 Vkvsxvi/KT3jsCVVwmrTkAIrb7mG5CGxDdIE5aYYDVEqAGIc10884JyJvcj+I5sDi2bTbgaJlTP
 QoKpHOMWBtefLMv11G6EMlC+9BLdI++MZvTZn4DhRDyDIP03lvKh2kdOOCRZBnM+QPepOK1sUTT
 MWKT5qrKzNfDIVeJo5TFn6P4yusfUgg9yzf3u6MYv1HhkhNbhLtT71vGv2DciReDq0h5tCAEhgB
 Zhy94cB5Ix0JshHfE6Q==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a6765b7 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=EPsGp4Ve3OqINF1AOYoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270132

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

