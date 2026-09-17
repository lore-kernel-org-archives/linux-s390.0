Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7444E0B8F;
	Thu, 17 Sep 2026 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672978; cv=none; b=F54rWKl9yfA/Xnev07PalhxoC9VZiJkLUz2Iir6PX9bF1Q5bWRXIFNx+dMidm76V/ZiMsL4SYhehon18D8QyVJl1SU8Zb4yLZeTRTI2QqDffJIyQ1b/qr5gcAgU4LJgSG5IU5DvKlODHJPv4DyYAVtmLGWHO8buw3YXW23xZSso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672978; c=relaxed/simple;
	bh=l5cSCb4nn5yHpguCzR5EHEKzQduv+MVNUnXV52VBGTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YcKIWF8R2FOQcMik9XDfwBHZXcApmCIpgISrugctw3lfwvqiokjplXxb504p23h6rLmyN8oI/zvdAii6cRyUfTMYlN0/Qy7RIiS+HaSRqKJWl6UBIDw48ZlJFaFL+cAO4fVXPeBXWDQMFx/0vvAuIWxxrd3fQYo9ZU9pIObI2jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W/c8V+Dx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W/c8V+Dx"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68HHVZcd3182086;
	Thu, 17 Sep 2026 19:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RXLRT6WBMUNAq53iP
	hiF3ryWPK+yl4SQ+KIVUWG1A4s=; b=W/c8V+DxupugGKXX+jA2Bg2BiCLiW3LKW
	KILzUHyc0LF1tZ5z/A3YlfnUfO2/4mg+zjET+eyKtiOswSEte+xowjfN0IfA2/Hy
	PWndo0up0+e9GSjEV//TCYNxqiITM6GC1JLJ5L70Fynvi/2hEKCZHLlRwKPG1jTc
	7R8UMMwl4DjL3kv8s+g8fFCG2yskSCpfYH+5utQEqH2w6CgObRISY4jozQXXG6Mg
	TrO7oZKdznAZj9a3rlBpF7IBuCJVMomWHW4NRT9XY/g3BxZ+stRx/xojDuFEbbk3
	+xjvuJux/spzD7+kZha3PsS8d2z0Zl4MtB/vYdJiB0eZ3SuI/bg1g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcvbsx8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:44 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68HH9CwU3474937;
	Thu, 17 Sep 2026 19:22:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gra3fb26s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Sep 2026 19:22:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68HJMdmE10158424
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Sep 2026 19:22:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8FF6E20040;
	Thu, 17 Sep 2026 19:22:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 629942004B;
	Thu, 17 Sep 2026 19:22:39 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 17 Sep 2026 19:22:39 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 11/12] s390: Add CC_HAS_ASM_M_FORMAT_FLAG config option
Date: Thu, 17 Sep 2026 21:22:36 +0200
Message-ID: <20260917192237.638324-12-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917192237.638324-1-hca@linux.ibm.com>
References: <20260917192237.638324-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfX/n86JsQX/nLg
 T4++vqeA4r3dzP2MAoGYII95waFFyOTEcckYVHymYlojpwE76MJ5qozb1VIpGY+K6M5Rjb8zmoY
 FGXaIOqoFPIQMYW5qAVxDg+Fayi6dWY=
X-Proofpoint-ORIG-GUID: XXRLb-Neclnh0-qQAeM2qL-wPo23XNoa
X-Proofpoint-GUID: XXRLb-Neclnh0-qQAeM2qL-wPo23XNoa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE3MDI3MiBTYWx0ZWRfX7JhqGzbH3mjT
 l8PHrZ/1npt9OEb/ipouNM0cziTHHcYc1SUJ1+ktW0of6cgcKPPiYKoefrf57UtS6wiczjnls6C
 /fm6NwogKH4/aLZwCyWSyqtRBS31oMDmt6FnBeN5jN6zY3uYbKeFNDfadO+VC0LW6mq3Fn3+YD3
 wFuO8PstF9lOiD2gdNS6pIZ9dDZ+O842pHH68qbJcXHhflevoCGzA9wgPcXf7w63y0NgHoCBqXH
 kyrhq8xaEQilt3dRMsVhc+JmlZBjiPhttWKFVl4cWu2eSg1tWtXlmpza6fN+3XnyjvkUMKQYDmW
 DePxRfmkO6+Xl4KWHDpGa68vYDkQiKFTz9XNQwQtSh/nFFX3oCLlRAHs3DzG5PRCXfYdoedBXKy
 oE+AFlLzqR3sXonv1vTK9MzYVlQENx2E6IUWGeq7yk5fX8shezpW86OsxWFVV3bujrmCu1NvZMS
 BSAMo+DEy+0wZAbbrlg==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aac3e04 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=FPxSlPHqShoRM3yPCfIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-17_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609170272

Add CONFIG_CC_HAS_ASM_M_FORMAT_FLAG as an indicator if the compiler
supports the 'M' operand modifier in inline assemblies. The 'M' modifier
allows to access the odd register of a TImode operand. Clang support for
this modifier was added recently to llvm-project [1].

The config option can be used to write conditional code depending on
compiler features.

[1] 28c23411e15f ("[SystemZ] Support the 'M' code for the odd register in inline-asm (#215481)")

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 4b51bc6e8948..f1fbbf6eb50a 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -66,6 +66,12 @@ config CC_HAS_ASM_AOR_FORMAT_FLAGS
 	  Clang versions before 19.1.0 do not support A,
 	  O, and R inline assembly format flags.
 
+config CC_HAS_ASM_M_FORMAT_FLAG
+	def_bool !(CC_IS_CLANG && CLANG_VERSION < 240100)
+	help
+	  Clang versions before 24.1.0 do not support the
+	  M inline assembly format flags.
+
 config CC_HAS_ASM_IMMEDIATE_STRINGS
 	def_bool !(CC_IS_GCC && GCC_VERSION < 90000)
 	help
-- 
2.53.0

