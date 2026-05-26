Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE483BFAE8;
	Tue, 26 May 2026 05:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775031; cv=none; b=qlkDuJwIe+arKGymYqO0+qxGJQot+lzNYtMWIG3dTUNmeafaog/J9wSYqfiJJ754a/AfvyUsQB1wo/lRm3SuhcV3qeatWhzga+q+ceN+eZhFUXbhOiMJFLL9P2wFRmuBbCq1dw03Km6Pq/IFTmyk8OQQgXnJUxYoNvehRmhGWa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775031; c=relaxed/simple;
	bh=43Xl+6ylmbaGi3gLHfwJG+pGBATML3jLmk+Sa/dYv7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6VHxhxb85TRxTdfS/bM4oamPUwtbwntLCuppk0Q7tLa6CLwrUMmK+n9oDNqEw/UGAui3RBOuj/AKBhqNb4Kq3vSU0HdAsKjzR7H703fnYoKL7aWenHGN/FwYDh98O+6qzjx9Nji/2P8YrLB3IhoeeX+4N+7ir5VGAclC66ENlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=c6BPu/aQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="c6BPu/aQ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64PFGRM53026762;
	Tue, 26 May 2026 05:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=P0qd27YAF/bkGFxaW
	C+Ca8sscSoRItaSoEXNuNGM6sE=; b=c6BPu/aQf09ezW32YpfbaVkrSGjfgy8Wk
	e+AdfkjjTf+m5M3pcvXnaJIVONf14yZzbEGppntAsF7DeQRMjl/wMxuoFYxX6E3i
	eZbKN1x2sxHQRAH5q8povWCtqfWbzFhvkv7dsklfiF5GAnukV029lM21BHlBovDU
	ntBio2UHsapZHtYTcfxyRfaCQjiIiuQWuVmyoD6slgnSG8hcVyle+4dxWMreaZdC
	7pYpySHuroUiBVRLy/8M+w4WFUmZhGV5S63/qDpdgx8JMbNO93XL1CiQjBrpkAK2
	p9OR/EiqqjNkpIO2AxIHEUYcTvibJFx5dB1B5laCEFPq76ttkc+iQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4nc1ng5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 05:57:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64Q5s9Bc010744;
	Tue, 26 May 2026 05:57:08 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ebqjjqyyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 05:57:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64Q5v4cN14549250
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 05:57:04 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2939020043;
	Tue, 26 May 2026 05:57:04 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E3022004D;
	Tue, 26 May 2026 05:57:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 May 2026 05:57:04 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v5 7/7] s390/percpu: Provide arch_this_cpu_write() implementation
Date: Tue, 26 May 2026 07:57:02 +0200
Message-ID: <20260526055702.1429061-8-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260526055702.1429061-1-hca@linux.ibm.com>
References: <20260526055702.1429061-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=VvYTxe2n c=1 sm=1 tr=0 ts=6a153634 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=ObmbXjF690NQJU6EaucA:9
X-Proofpoint-ORIG-GUID: MFsBNTGGsVTzL0XQ9DEVaSYICoZgsJDi
X-Proofpoint-GUID: MFsBNTGGsVTzL0XQ9DEVaSYICoZgsJDi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA0NiBTYWx0ZWRfXyo5aS4sfu1G9
 2/NBn8u4O390Um7QCutdD6m5sv1U+LcGqgZrzU1hOGfGojgF6Noxum7HUYifk+n44sCG6xPkaie
 Jr5lt8DLVclY4w4PnujrNGrNIA5gEwK0zJqMOxlbU8L2LhLm0JgHAzRnrs5hms0zuE9UrwsUIr1
 zBGB3xxRhfykSqU0cjIIL7Bcyd8QJRDDWUEdGLDd+O+DYX6POfU+39Kkk7dG+356cxksH0FMYL0
 xgAJn0cf7Pa3HRJ6ZidxUvaEJY78wJWqybQwCIH9j69v8SENUTo+gTs1tgu0+ipR/b/lXmMBhXr
 HM7YmxIy5P5W1lP3BCYkZJTXdMP9XO2gchlCYfJINkikXPYZLvOTZdkuDuLGpWRtgrutqE0l0My
 ey+a+CHACMl8dUWfsw2x+U6siK4rnoX4COF8O/OguLET7nFdw2o2l2b7PMPE30P9RHa9vREGp+m
 5UsbTX9MQQYOigyDSxg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 spamscore=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260046

Provide an s390 specific implementation of arch_this_cpu_write()
instead of the generic variant. The generic variant uses a quite
expensive raw_local_irq_save() / raw_local_irq_restore() pair.

Get rid of this by providing an own variant which makes use of the new
percpu code section infrastructure.

With this the text size of the kernel image is reduced by ~1k (defconfig).

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 83195a5dc409..1d955dd0defa 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -279,6 +279,36 @@ do {									\
 #define this_cpu_read_4(pcp) arch_this_cpu_read(pcp, "llgf")
 #define this_cpu_read_8(pcp) arch_this_cpu_read(pcp, "lg")
 
+#define arch_this_cpu_write(pcp, val, op)				\
+do {									\
+	unsigned long lc_pcpr, lc_pcpo;					\
+	typedef typeof(pcp) pcp_op_T__;					\
+	pcp_op_T__ *ptr__, val__ = (val);				\
+									\
+	lc_pcpr = offsetof(struct lowcore, percpu_register);		\
+	lc_pcpo = offsetof(struct lowcore, percpu_offset);		\
+	ptr__ = PERCPU_PTR(&(pcp));					\
+	asm_inline volatile(						\
+		MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
+		AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+		op "    %[val__],0(%[ptr__])\n"				\
+		MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]")		\
+		: [ptr__] "+&a" (ptr__), "=m" (*ptr__),			\
+		  "=m" (((struct lowcore *)0)->percpu_register)		\
+		: [val__] "d" (val__),					\
+		  [disppcpr] "i" (lc_pcpr),				\
+		  [disppcpo] "i" (lc_pcpo),				\
+		  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
+		  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
+		  "m" (((struct lowcore *)0)->percpu_offset)		\
+		: "cc");						\
+} while (0)
+
+#define this_cpu_write_1(pcp, val) arch_this_cpu_write(pcp, val, "stc")
+#define this_cpu_write_2(pcp, val) arch_this_cpu_write(pcp, val, "sth")
+#define this_cpu_write_4(pcp, val) arch_this_cpu_write(pcp, val, "st")
+#define this_cpu_write_8(pcp, val) arch_this_cpu_write(pcp, val, "stg")
+
 #define arch_this_cpu_cmpxchg(pcp, oval, nval)				\
 ({									\
 	typedef typeof(pcp) pcp_op_T__;					\
-- 
2.51.0

