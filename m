Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653C433F37F;
	Tue, 17 Mar 2026 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777295; cv=none; b=QyJRFxhZ6f6qwoCJUThYq1Jtcwn45MKIt3R1bcH8WaYQ691cmutiM61Pr4Uff9bgwtStB+Ke+oneBBSOIKjgfLmo2a/wzq+idfzfF/3Ro9Hmi0SZJ/oIk2oRGg+R6JchombGXqZ/zIoAY8wITuC0W/3OEoSAz90Z2YBeKxoCELg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777295; c=relaxed/simple;
	bh=W9ULdutoRWAQybVggzg2wgpCF4KcYj1yMLN3VI+bc2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KtOMtzfc8sS227JhLWd/WkIFvCi7XmNjkGcQJ6hygRigAYJ19kbktwRm0osRDZ+p8gEx8VIqjibqhPP/POArbdMXf5I8aG5TPEbmAfG7rG2qIOUBfMxpMEtiIHH476fVqxuTSdLIrzhwIOFLcLtc3z+UTftiaZ9CKGU8+6XeB/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SAAbnesV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SAAbnesV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HChpqA3558410;
	Tue, 17 Mar 2026 19:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=mEx2A5dLN+FO7uPef
	qdiultlVyfcX81GA6Ne2gPBo5g=; b=SAAbnesVGHhki9JWnxyOU84o6Q/WO5HIn
	+a9Jum44iJ8fNeWzhVKCUFz9o4ZUCQ3c0q1/aTenKZrGHRtstFkCpBY0KT9zVRrV
	yfH0hahs4ri6mDKIXirXx1gqgeOk/hcsW0HZwJwyNyxaOdwwJsQyikLd4/PTw13h
	haPhlfiY8ffl/zqUenIJCgQbAg2Zh5ermAifg2CuOXOWnqEPcdlPevj4ZkyiEjdq
	2H4YRyzsFOWA3BJWgl8kLhMXkpy1QLGfhgPSRQiEIT3wapyhKMtdJXa32rIsrXiu
	pVylRFkUvLFW/AShwQuBYx1qLtInvWU3pjJAdbekP7HMFCkQxHXTg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hx8v4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:54:43 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HJ3V3N015655;
	Tue, 17 Mar 2026 19:54:43 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0nasq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:54:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HJscDh50987500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 19:54:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4D392004B;
	Tue, 17 Mar 2026 19:54:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9CFE720040;
	Tue, 17 Mar 2026 19:54:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 19:54:38 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 8/9] s390/percpu: Provide arch_this_cpu_write() implementation
Date: Tue, 17 Mar 2026 20:54:35 +0100
Message-ID: <20260317195436.2276810-9-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317195436.2276810-1-hca@linux.ibm.com>
References: <20260317195436.2276810-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wVfREDRjqEUGIQ1lGT9BTkT6RIV_e82U
X-Proofpoint-ORIG-GUID: wVfREDRjqEUGIQ1lGT9BTkT6RIV_e82U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE3NCBTYWx0ZWRfX2WaGt1HuxFix
 WL1M2GmnU5h0F0MT6hya0DkAKecsJffQ/ZnS/Ik/3xXro4fWGG2k5tt5hE7l3Bqfi9Ydlkv4Lf5
 38k/rHHnApuWU2HcqSJiiF2XNbq1XxqwOpwD4QYnNjQmAwBuIlH+j9K2qmfjPlfAuwXDcJE/ZO0
 49GTyAXamS90aiI4GQv2gTrDn4zs5faxoz+6fzTMnuQP7deu/VSSidcYUJkpSgDQJcFbIbBV0RW
 T8xyCLtWpODRHlO3B4dpNeZWmhG1Q2Dg4vejhlSfV4AOhy5aPx4WsA+HXm66tFvdxhm+5vZNNcl
 Yfrq8TdOuRmzcOlYI5c0zA7AHBZ/IwfqlN/E9DmsSlbOMob+NxzfQ6Jegj2yR1dYr8A4/xJAggB
 X8zUyDwuB0lja2jnSe4/RFYVMzXjEItirO5BeCXYGZxetIEkW1XZ8GSovva/HiHS/ii2Zua63CV
 q1zdztQIHVzt+5iG/Kw==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b9b183 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=ObmbXjF690NQJU6EaucA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170174

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
index 35e48d193d99..7a411b75bfa6 100644
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
+	ptr__ = &(pcp);							\
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

