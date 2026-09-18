Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA584B0E27;
	Fri, 18 Sep 2026 08:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721342; cv=none; b=kS08ZWVzLJpSv7DjD+5pYk3QNqIwrz4IR4jWTr2JyAay8Daz7nGGszFWB7AgXnMnWw81az8UYn1w1vjoWyQgRBcnmQaBX5in3ftnHfa+t30sa7X+Eo8AJkBgO9ukom6DdZoB7MIXq2Lv3t3EfVIp73bDRSx5fCHJmtkE+XxZLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721342; c=relaxed/simple;
	bh=l5cSCb4nn5yHpguCzR5EHEKzQduv+MVNUnXV52VBGTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eh9l0Hsj2OYvkrl5Gqbhyr+/hH2hOOG+YZEWBdIEqri3I0/BdwcgStfgW3wlLAENZwBr3nrM4qs/cC+uiSzuNK+4BPJiEdUvwL2+M4UcZYRWnqAZxPIv2tkTyyTDhGc5yr9PCAmirHl3cUjYsR3wcNhYgb2ySaKOSH3rMf3kogs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YgErOeH8; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YgErOeH8"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I61TMh470268;
	Fri, 18 Sep 2026 08:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RXLRT6WBMUNAq53iP
	hiF3ryWPK+yl4SQ+KIVUWG1A4s=; b=YgErOeH8u72Is5kZ53ciyAlRItamgGD7j
	sUXnOUONF1+NahoQcDa3u+Utk47tRJPdhlYZ5P7USFr0MUavx8ILpZcpUjIWDAyJ
	wIRyAx7QA2/4VccLGSxfME90el6z0yNuY0aDknoOHf/hNxO+x8fMne+uSIdRCOhN
	J4DewmUwPmHWw89lj5PxEvYLqlxmbNsxHm2mglfcZq1N+vJ5aMU7FIs0gM22mU+Z
	5rO2NgbK9+dtoRCxx7rNn57KX+yx71MqWTcNAffD6JLEJL23MjZXzo5Hb0Tdw1Ga
	vl16s8bNuu7ZvPVYzMUS5DYVs9eXv25YusrrRXobCUhLZOoiITP2A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf5f5hc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I653bQ196196;
	Fri, 18 Sep 2026 08:48:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5fjpj1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I8mjtf48628054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 08:48:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 188EF20040;
	Fri, 18 Sep 2026 08:48:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D426020043;
	Fri, 18 Sep 2026 08:48:44 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 08:48:44 +0000 (GMT)
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
Subject: [PATCH v2 11/12] s390: Add CC_HAS_ASM_M_FORMAT_FLAG config option
Date: Fri, 18 Sep 2026 10:48:41 +0200
Message-ID: <20260918084842.2333237-12-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918084842.2333237-1-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ocEJ9YhiQfIXDIPruy1qXQGPDliKl68q
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfXyCkrhH/g3Whl
 nCNfbeD3ZO0XhbUEbXRiSUjFM3OR1Jtu9yVuV61Jv9cvAOWx7wvfjXLY9pkYnJl3f3dTfXnAQuo
 LcsZ0UK7omcHSJY2UN3+EMnTdcMqa00=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aacfaf2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=FPxSlPHqShoRM3yPCfIA:9
X-Proofpoint-ORIG-GUID: ocEJ9YhiQfIXDIPruy1qXQGPDliKl68q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfX8sH9JItzuWdQ
 d1S4nJK8fKWhkL67gcRqx3sFnnwTiSLvMb6D6sYfR2YqV3m6046C9K8qthgy0JJ5Wk+5xa/tc12
 /QWxiB5vGeWPbVKB3GsmZhxHnhWeOgPPjknSfIC86By/RyNVxfb5vmL6poK4SloZNR1R39iYgVJ
 +x2/IrwjHXrMkC7zdZdj4YDtzG0YboIa94Kx2QgTh9yh2lBCYTuCu7OX5V85HTrz1NuEJW78YuH
 Ze5gBG+Xb7BdVrUQANVgr6A8lTuRDVFexbneFmiXS2HPEEV0YfQ8hBm8YmaQWx6nkMM4NmD4ys6
 lyCctxWXN6ntjmjMHDJvNf1EwJgpeAvmpkdv/QlXoF9HJGMizYY9ms+2ii5bC810/+ntIZ2KR1m
 IFasYdCxO0fR6XoDojDzQ6Q9Ryxy0fAxP1BeWQTC5jziFhjAnUhOddQXkE1kU6pbxxswt47DaJx
 pnGLeJ0rCidKgyXTbhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180117

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

