Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016216;
	b=FBslXJZPFwc+y9pqFwJWIVUvAjD9/MBhEHTmXRouQqa//MPBR6jzqUCbT/MiaxiFOo6I
	 O+2CJMpNSKMXRot8SxZ1kQhqd4LvgPIuo08TiDaPXTE+3aeul5qOvHSmCno37yqN9HOlS
	 Q/ezuEh84sqPyt/AcoblMweEp3m9zn8Lv9NaqoT6wvsm6VKl6/iNc1S/9o7XRHZtm3OrR
	 3fA+fDX5iPHDtFi0iPRLyItegT4h74tDsJTgoPzb1S5x28lnEwpF+jOMwtsq9QuZ78Ivc
	 xBdLFwExYAx1xActUyzAXXYH7WTtgVZFTzvhLhZEsjdWRornaSke5AvBG3HhJmhNBsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016216;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=CN4eY44lRsCwe7+CFKH++QWSSwtLj2NJDRKl0YcqSos=;
	b=IJ1v8i0OgpJZTEEc7lxTQwaI3wKjM5h4tCfRaWw7cciaPQjxZ8QQ3FBCP/9mbShxLFlw
	 Mdp8kaQlL93lzMjxVpdM+ZDoInXp/1gS8cbpczjOta7CAH7zW8TGtsal4UsSR1rbcuLdv
	 ZDSBeHrpLrvnoIOqY7iOUcbPA/6fEzMan4TMkXRgRuwepa+yDRtkJKAKMRPFZPXruvYRU
	 WgybucOZSn0DKeRtcfITCH4jsDZ21ZK7bR8dXSQlBNSEZKNo52t6/KzAAJ+L03WIydske
	 C6me8sp4GozBWFY4YtBk8rrMYVUbPNpKQd2bQyXNajaAU0FWfjp2TL+TqiYg/N4QsLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f7qG8k1J;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AF5606A320;
	Mon, 26 Oct 2026 12:03:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14AF5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=f7qG8k1J
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QBEiSi3358083;
	Mon, 26 Oct 2026 12:03:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=CN4eY44lRsCwe7+CF
	KH++QWSSwtLj2NJDRKl0YcqSos=; b=f7qG8k1JD6kSgRzeMmRgDqjn1FYciYeAP
	WCdObwMAV7YJDdoPMcToL+e6pMuVOnNYNpb9z50qVPjOynIXZpsyzWUQGkOC5B51
	JfP1uWa/tqwLKzcMGWNSHHxO2w1KO7C3hGKJ4y5i1km925bfs98P3mSApmWUC+Xj
	r6u5hTzTUeQx5vltKRRRpyKpjJYglghJerkrp+cyrMaN8sILgF77jJXJB3syCDQy
	jYyEoW0bqr6/co1gwPdJHA7VVWFa780U0A6CYPqTgfGXR8KdW1qi2Jjfs99846U/
	ARdq7IT8jfaiCIxP7FTy9/tSXekXtuNhfbPqDutwHIatH8oZJrSiQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmav9bcw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 12:03:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QB4wnk2500610;
	Mon, 26 Oct 2026 12:03:34 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh8ggwmm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 12:03:34 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69QC3Ux140173928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 12:03:30 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82E5E2004D;
	Mon, 26 Oct 2026 12:03:30 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 53A832004B;
	Mon, 26 Oct 2026 12:03:30 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Oct 2026 12:03:30 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/4] s390/ftrace: Serialize text patching with text_mutex
Date: Mon, 26 Oct 2026 13:03:27 +0100
Message-ID: <20261026120329.1792436-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026120329.1792436-1-hca@linux.ibm.com>
References: <20261026120329.1792436-1-hca@linux.ibm.com>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6adf4197 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Du24JD4PTAPhdpIohfsA:9
X-Proofpoint-GUID: UPFazb4qzPapHLVQoFZ2BFcanaw_wueu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0NiBTYWx0ZWRfX//1KUtc6/DjP
 2/L/6H3C6mNa+ikFPlRigChFYHU19LWZgd7sQUlPajApaDDCPT6LHU0UWsGAZc/SMOqOLHrR9t+
 hN1gGpMrZayCl24fOxPT7KbpsADCG0E=
X-Proofpoint-ORIG-GUID: UPFazb4qzPapHLVQoFZ2BFcanaw_wueu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0NiBTYWx0ZWRfX+Aw73kBfRJzH
 dNwEJNqohTLYHNnfVrOx8HENYjjnZroLM0eEKZzCmm47BpPmGxPkbXe3OVhigN5wTSpoCyltPSY
 q7IGZtQJwP4UTLhqVoTy6bZr/pe+1R35VExruQHZ2/jZ5x6tMBaQKmkOcxDeuKy0O6UjH7rx8wB
 ib8vXxsjytbxuuEa5cv+Qno4Z7m4901CaWrI4v/8vLGXBFARCQnqWfprgbJ8hbBFQttyXs4+LGS
 nKTe7+plaLLAT1OSwK15pO35UtamTsGObD2JEt7XpuMCwlE527FIyRKnKAtBrxDT0IDixMZMgXP
 YquwY4/EzC6BCfGLExZVvnt6srr/7xJzX9ZCcq79xBiI7cq8WbcDUmTB1k1yK3XLvPqDlwTYfsN
 5WLcFoDTKjwsinsNLfmCs+XwGSLlYaU6GdMCR72qcPFkmG6TAzIFNklZssaFHAqBZ3Dzl2oUIL5
 BwjMgXZFNEiP2zz7QAA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260046

Add ftrace_arch_code_modify_prepare() and extend
ftrace_arch_code_modify_post_process() to acquire and release text_mutex
around the ftrace code modification pass. This way s390 uses text_mutex
like e.g. x86 and riscv.

This is a prereq for removing the spinlock in __s390_kernel_write().

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/ftrace.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index e94bb98f5231..772dbdcc51f2 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/hardirq.h>
+#include <linux/memory.h>
 #include <linux/uaccess.h>
 #include <linux/ftrace.h>
 #include <linux/kernel.h>
@@ -247,13 +248,21 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	return 0;
 }
 
+void ftrace_arch_code_modify_prepare(void)
+	__acquires(&text_mutex)
+{
+	mutex_lock(&text_mutex);
+}
+
 void arch_ftrace_update_code(int command)
 {
 	ftrace_modify_all_code(command);
 }
 
 void ftrace_arch_code_modify_post_process(void)
+	__releases(&text_mutex)
 {
+	mutex_unlock(&text_mutex);
 	/*
 	 * Flush any pre-fetched instructions on all
 	 * CPUs to make the new code visible.
-- 
2.53.0

