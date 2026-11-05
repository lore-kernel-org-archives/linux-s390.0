Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793886399;
	b=c4qgnOWBpPkOwMGobnBpD3aox/gmKyk49DY6A0AzTIeTHhrOgcS8+6/jnJfZOQb2g2sN
	 mpqJi0SycVfBu4ADj1Ltt43KJ8DOfmF0MHezUk5SAnuic4x5s1rekhIcvnlO4BmO/DYaH
	 zPeXNrlDuubNZIDLGuaoxTa2ysmJQ8YrTp81s42x/0w5NxWKGXCZOWhTKXOO/YIWuMwkn
	 FaQvYko38vdaTyuKw7H7RSBGsWyF5X+EDsRAxh+MBAz4bKTCmMLqFBPBKKzA7XhnXCbmV
	 VkcaoveaUyhDGxHASSDU2leZiqpuJEzfkZM19UZMDMQhBvglnIuH2xzCchEl3lkZSlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793886399;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=NnmJA2c1IcbLXewnYcD2q5jSVIwApHa63jh2ihJdDN4=;
	b=o+G/NXM8huUNOHSBsYKnW6Qg/bEnG9dJRs5Cjgty+W6IczjzpWpK6kyVHc2jRT1tSKKU
	 KioTBOD4aMSI+wkSWCtCIxoYPK9ow/+2k54aCuxgq4Wx2EWc264ehNwh/LlcK0li5WgDA
	 LbVzN2abUbWqLKGz4p+xdhnb44ef6qL1fgwWxUYIvvViViB8tqwt8RAT7maU8pVv9dF27
	 qYDvJCABW64apfCTXBlyk6It24dNRhkd6pZFKkwb5FqoxgVoBffaIUM60010780dh2wRT
	 CHYdMjgviea9kiK+2Nb7skTuxeTX3Vk8UcpIahDnpblq0PNTzGf5LJtlHw8FGlxYMHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fg13T+yQ;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF14606A31B;
	Thu,  5 Nov 2026 13:46:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEF14606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=fg13T+yQ
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5AE58r3219958;
	Thu, 5 Nov 2026 13:46:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=NnmJA2c1IcbLXewnYcD2q5jSVIwA
	pHa63jh2ihJdDN4=; b=fg13T+yQHBcQm3+3SQMVff0by7aAEYvVXs0B68jdQ0UO
	AVIE8b7QjoanGNywXGvQHH+NHyrrxohtJKVNIkGDUpZ0/KVS0QY5oCd+vSVoxaSd
	KUWfDT1EoYnHdaq1sbkiIxeX1HqJdwNKgj3yCLVLgbLVL/sKev+rRA7+vKUA+LyI
	1xD3w7IdwCFwSy9BmrCtz15osw3U/s3TyE7Xm6bj71o9vkcf1O8XBeMUhFG1Ed7o
	ZkNS0Mnr6DN8MsjLzjpQob5DZk444qcNbvCqek8du8XN2mpc37gTSxRSfmc+Uoft
	6K8lEJfNhc7FqH1uR7qiINTfLtoxGauwoal36LbjQw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn8272fe4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 13:46:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5DcUSU1364994;
	Thu, 5 Nov 2026 13:46:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hrmrehstp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Nov 2026 13:46:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A5DkWc841419010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Nov 2026 13:46:32 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE7142004B;
	Thu,  5 Nov 2026 13:46:32 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7A5920040;
	Thu,  5 Nov 2026 13:46:32 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  5 Nov 2026 13:46:32 +0000 (GMT)
From: Steffen Eiden <seiden@linux.ibm.com>
Date: Thu, 05 Nov 2026 14:46:14 +0100
Subject: [PATCH v2] s390: Guard emitting assembler macros for
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
Message-Id: <20261105-insn-v2-1-ff27987aa212@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13MQQrCMBCF4auUWZsyE62IK+9RumiSiR2wqSQaK
 iV3N3bp8n88vg0SR+EE12aDyFmSLKGGPjRgpzHcWYmrDRr1mQi1kpCC6o7OWoOWvHdQr8/IXta
 d6Yfak6TXEj+7mum3/gGZFCnn8XQZ0TC67vaQ8F5bMXNrlxmGUsoXS2iD0pwAAAA=
X-Change-ID: 20261102-insn-53dccb0c1ffd
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steffen Eiden <seiden@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 1Ii3RI8vWK0buFMex16TED2BiV3hHHeC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfX6Ul2RZJFcTVV
 XyhcUbjmpyZTzHsZhzKaqxqaVt45l1B9IIWmCtvyOWwsG8kM/NzTrmD2r7+V3H46jGutJdnB0Wi
 2eXx3mHdJPsrvFGe0sjod6Bqq7nQU+hHNSlAssLEomnBIBfsVirNRk5Nd04HsP235+x0t43gMIK
 uNRdVewlWk7KYKtEYPx4onX/aAMJRW8gNRO+ewohtat3WiNQhJj4qemN6pLZs6apSZDowFzkJYE
 oIiHD49U4RIVIRv2knPsn2yQPDFfKbO0J9+lf1XKaGvMkd+2aVudBZQcZY7/pxUVhy+fUYOrix4
 1zm52ekMblqgXMfJYHIxUlPI0YHsaBZOdP2LPWdx6YcNfWjb8e409bbWWESRyXdGowLTGlToEuc
 FnJa48nS1/ov12/Y24u/4GVsv6M3BRQF1DTyfHZZorp+7QuF+LVXaK27SbJkBLlZvGg1+o8miXO
 S+EzUpJv/CfX2dTdgAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1NCBTYWx0ZWRfX6xKeadhQgr0b
 WIlOFltjW9P0pHK96+i3sSeYYvDQ7usMdTJpQcFE3MK+EMCCEIgbpJTLdzOPlKkmql2fMw94dHN
 435cydyCIGnb5OEQt17vPehsCUYbc1o=
X-Proofpoint-GUID: 1Ii3RI8vWK0buFMex16TED2BiV3hHHeC
X-Authority-Analysis: v=2.4 cv=EsJHPicA c=1 sm=1 tr=0 ts=6aec88bd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Sq4U453bNoN16_hl0w0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050054

The CPP include guard of insn-common-asm.h is ineffective when the file
is read via a gas-level .include from inline asm. The assembler ignores
all '#' lines, so every .include redefines GR_NUM/VX_NUM and fails with
"Macro was already defined" if a translation unit emits more than one
such include. This is not the case right now but may lead to future
build issues.

Add a header 'asm/insn-common-asm-emit.h' that can be used by C/H files
which want to emit those macros. The header guards the GAS include to
prevent multiple includes in one compilation unit.

Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
---
Changes in v2:
- Use a separate -emit header and CPP Guards to guard the asm .include.
  (Andreas)
- Link to v1: https://lore.kernel.org/r/20261102-insn-v1-1-df048a0be0d5@linux.ibm.com
---
 arch/s390/include/asm/fpu-insn.h             | 2 +-
 arch/s390/include/asm/insn-common-asm-emit.h | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/fpu-insn.h b/arch/s390/include/asm/fpu-insn.h
index eeb0a233d5c7..aaf1faeb3dc5 100644
--- a/arch/s390/include/asm/fpu-insn.h
+++ b/arch/s390/include/asm/fpu-insn.h
@@ -14,8 +14,8 @@
 #include <linux/instrumented.h>
 #include <linux/kmsan.h>
 #include <asm/asm-extable.h>
+#include <asm/insn-common-asm-emit.h>
 
-asm(".include \"asm/insn-common-asm.h\"\n");
 asm(".include \"asm/fpu-insn-asm.h\"\n");
 
 /*
diff --git a/arch/s390/include/asm/insn-common-asm-emit.h b/arch/s390/include/asm/insn-common-asm-emit.h
new file mode 100644
index 000000000000..26a31e8439bf
--- /dev/null
+++ b/arch/s390/include/asm/insn-common-asm-emit.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __ASM_S390_INSN_COMMON_ASM_EMIT_H
+#define __ASM_S390_INSN_COMMON_ASM_EMIT_H
+
+asm(".include \"asm/insn-common-asm.h\"\n");
+
+#endif /* __ASM_S390_INSN_COMMON_ASM_EMIT_H */



