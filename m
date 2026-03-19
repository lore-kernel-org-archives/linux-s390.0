Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42123CCFAA;
	Thu, 19 Mar 2026 12:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921919; cv=none; b=Mo49x/6ck3qrJkiGajEstUNVUIuQC8GjF7f9Mbx9p/po6qlEHa5XbNyOjG0wARAkMWxFAck3S98VpXg/i5pZjNhfSXLz/00q7doZhGkFtuyFB+aUKrqS8c1nt03mghRGTK0Ih4ylJQCMZtDHUabSjh4jZ0/c+ph0pSitI/yM8kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921919; c=relaxed/simple;
	bh=U7fp86askpbhtuuJT7RlGBAIrVIPyG5UDU0rTWsQyuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZVx7cveu+WRarZK6JZywCZHmOJl8iyvgXQgsuoiA2YoNQZRTssfUEvfzf/C+DCJEGAdM2pITZNDcZaVJr4DYLT6pY9Po0LU6EywF8nMnzACW5YSCHGJBGrtGIXj13s/12lgWdNqWdeulv378S3aEWpLOwIvwPRjLuwGEeKZSAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SvIJh+Z1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SvIJh+Z1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62ILRfVj645990;
	Thu, 19 Mar 2026 12:05:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6c4i/zhVRm0J1g2HT
	eHTepeWOP8LfJJiSz/VRN4SxWI=; b=SvIJh+Z16asTkCkduUgnK4srmyUDy3MFw
	j0IMuotjwkMgRKFReRULg781zSMbe35s2ujeFSsSDEbzbcSVpbGygm9RNBWqcvlI
	bGH7Js/vZbeGTpWSlFfrzNJXaiSKZlZfI4xd1at14bAWVf2XWMRP54XGE18CDTs4
	YvV0o1PT44tXmH8Po4Ijqz0DvDUAl+JGgL4aj1IoZvF6yDrunsPZaiYqLZLbLWrd
	HIZc7szD2sK6e51Cpb3Q7g7adNkwZB2gMQhqRm0+IcSWnwg1YWg7JmuOWUa3vRBc
	PDkkC7c5VBtGINNJwH4gMvGNPbALmdK5oUVU/O8ajLEoHeE+b2XvQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyaup001-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 12:05:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62JA7Qj9032397;
	Thu, 19 Mar 2026 12:05:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwm7k25tr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 12:05:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62JC545F52298050
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 12:05:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D57542004B;
	Thu, 19 Mar 2026 12:05:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B35F420043;
	Thu, 19 Mar 2026 12:05:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 19 Mar 2026 12:05:04 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 8/9] s390/percpu: Provide arch_this_cpu_write() implementation
Date: Thu, 19 Mar 2026 13:05:02 +0100
Message-ID: <20260319120503.4046659-9-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319120503.4046659-1-hca@linux.ibm.com>
References: <20260319120503.4046659-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA5NCBTYWx0ZWRfX5qpT/fcysQDs
 Hd1LJ5pvTkNvonwhxh4xVWyL0ppAaXF1loGtXw1XCH2Q0s/6IXK3n3/FATsKzsMGTNUwJzjRwd5
 PnuyL+GqJURVyh38BwMaoIBKZGSfbjP+WNvk1XF9tUCnL+ZQrIw8sifzUI7TechgNaTDOvDL2tf
 YwQq50Bov0SLWGFfHGJeQPDv/Pw1TGMTKxwB7skdulyiO8qPpnJPpN2pEEJsdfECCKIzVJu8iXI
 H02hd8McMEprxA40CKAVmeM6/TAD3pay5MEwTBolUW2M7qzkNXkZVjZFyjDqqKqbEhsxsVe4sMe
 bmUBLm7WVo0WMhCFrrLI+149pdy7FdoR0Vh3OeGYU/KPOtb4TPD0IFtXsIFU7aGcn+ppeKTPllH
 BEmaRdrbay/AD4cg2hvqhvSrWdeYrHmaDZLWH/OP/F/PLp1SOOpOO9o1T5IahOUvbDbmNaZzT/5
 uljrc4z5egI1mMbA3gw==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69bbe675 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ObmbXjF690NQJU6EaucA:9
X-Proofpoint-ORIG-GUID: 4RJ4yB0q0Uraj8G6SfPIHnP8zglvq-zw
X-Proofpoint-GUID: 4RJ4yB0q0Uraj8G6SfPIHnP8zglvq-zw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190094

Provide an s390 specific implementation of arch_this_cpu_write()
instead of the generic variant. The generic variant uses a quite
expensive raw_local_irq_save() / raw_local_irq_restore() pair.

Get rid of this by providing an own variant which makes use of the new
percpu code section infrastructure.

With this the text size of the kernel image is reduced by ~1k (defconfig).

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 08c48fa97381..44501a407e6d 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -271,6 +271,38 @@
 #define this_cpu_read_4(pcp) arch_this_cpu_read(pcp, "l")
 #define this_cpu_read_8(pcp) arch_this_cpu_read(pcp, "lg")
 
+#define arch_this_cpu_write(pcp, val, op)				\
+{									\
+	unsigned long lc_pcpr, lc_pcpo;					\
+	typedef typeof(pcp) pcp_op_T__;					\
+	pcp_op_T__ val__ = (val);					\
+	pcp_op_T__ old__, *ptr__;					\
+									\
+	lc_pcpr = offsetof(struct lowcore, percpu_register);		\
+	lc_pcpo = offsetof(struct lowcore, percpu_offset);		\
+	ptr__ = PERCPU_PTR(&(pcp));					\
+	asm_inline volatile(						\
+		MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
+		AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+		op "    %[val__],0(%[ptr__])\n"				\
+		MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]", "%%r0")	\
+		: [old__] "=&d" (old__),				\
+		  [ptr__] "+&a" (ptr__), "=m" (*ptr__),			\
+		  "=m" (((struct lowcore *)0)->percpu_register)		\
+		: [val__] "d" (val__),					\
+		  [disppcpr] "i" (lc_pcpr),				\
+		  [disppcpo] "i" (lc_pcpo),				\
+		  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
+		  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
+		  "m" (((struct lowcore *)0)->percpu_offset)		\
+		: "cc");						\
+}
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

