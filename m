Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C8B3BED66;
	Wed, 20 May 2026 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268980; cv=none; b=MzpIZhMNblrE8fAsQJSwSHNVBo5zTNJQMc0cn/fSccyx3j+FPTG35mCF8g6SHXhObx7wQ4fe/dtTRzmFqbp6BtrisDeiPl6el6Eq154KTDbqkyGbqKvP2L+8rvbu/zQmpX4YCKQ0GzZAv5bilUkSPTCkIu02NBUtKgUUH3Wy7Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268980; c=relaxed/simple;
	bh=PPMUfyzHj1wJrKxOQ1wNO8oKi1gXYEX3a83zcx6MgDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgrFgBVw6+MCtiAToukpR25eJ++1m+ur3SxEEhni3ct2k0kgjch2RgZvapZgiGMgml9q190b6IGePsERK/FTWVdhAnWgBYCNiEm+nMLyDECjaGdoI5xPvO2Yztq0WG3UsigdUoZ/hL16Q3r3FY2qejZd2emwTI7AfOma7ueG2a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hV3NNzzP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hV3NNzzP"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64JLADRm3907161;
	Wed, 20 May 2026 09:22:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WS1QX18NMJTzeEbjT
	v10Xg8Ic9yy6JorqopS7BB+yU8=; b=hV3NNzzP8WYwBlo+J58dnedF9HDlPmTLm
	Itmrki/ps1DtqJT40HgZu2RQykn6kvKlry4k6hrBUG2i6DSE4CcgSgEHLTVOlWPs
	aK9D3turdGOyN9pxv7mE+/eYepyMUACzQKi/b9CRIRbzGd8dWWxDmdXl2rAdIjHx
	flHo60kU7/6FwUiRrAYuoPitww9MClt1Q9xsFprhbT/OmoBDS230bNtBnm5Nq4ej
	ngU6NHWo0j+el4OqQdvRLyZMqbyuyuoCPVyVJwnJApdFrcE0O7J9iPjw+iN9M1R3
	TG63tKoE1XuHPfCqWO+7XT8nwlZhDS483IiCbTHf4IkChahodsJ8w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hb8gb2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 09:22:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K99ANC022924;
	Wed, 20 May 2026 09:22:49 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gef64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 09:22:49 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64K9Mj6l55116222
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 09:22:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEFF620043;
	Wed, 20 May 2026 09:22:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1E3120040;
	Wed, 20 May 2026 09:22:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 09:22:45 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang@os.amperecomputing.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 7/9] s390/percpu: Provide arch_this_cpu_read() implementation
Date: Wed, 20 May 2026 11:22:41 +0200
Message-ID: <20260520092243.264847-8-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260520092243.264847-1-hca@linux.ibm.com>
References: <20260520092243.264847-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA4NyBTYWx0ZWRfX5be0+wc1KcNS
 YbOBcwf51DGir+jTRR7srv4fXYVtNsefDoPGLy5l4rJBErNn2V6fY5s7xEOyQdFjg3tTjLQ54fL
 f5M4sfyAaYyY7LSFMLaFhFlr667qzveY3cQ1jZYklgeNyHmd6CxvvJXQrsgAYyavX+4gN8qV2sH
 0lCHRBvuWB0ZgT1bTDczlnc5xa1yqEM338G1jhnj3415XxdT1zbAQmEZn5bnxdslFMsss/lZ58w
 a0OJ7jxxgS+xAzoj2HsHxwWFA0yRoBvM3tgu5jtCHPrmTpj9LxHUorF5e5bPbmKZxRUVvPc/NWN
 VA2WJLTi523sgH6ODMCzG/ETkoD4DC0ycRvLKjKJeRgWmFZRi+6qf7t4ncLJ5vINkuHVH/RI+/k
 qwvphU+NWcMmQ/mpBe9kofdIYpkHjs3gFqO81OAaVt1+TA+YeIX9GI/TO659EU9g32uTYVU/1f6
 H7qPRzeX4nsn6uj3nOQ==
X-Proofpoint-GUID: PsXHdtYS-ltAz4RKGlL5uocqu2WfP9X5
X-Proofpoint-ORIG-GUID: PsXHdtYS-ltAz4RKGlL5uocqu2WfP9X5
X-Authority-Analysis: v=2.4 cv=aYBRWxot c=1 sm=1 tr=0 ts=6a0d7d6a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=4bOSrtcVyj7iNoH5sBwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 clxscore=1015 spamscore=0 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200087

Provide an s390 specific implementation of arch_this_cpu_read() instead
of the generic variant. The generic variant uses preempt_disable() /
preempt_enable() pair and READ_ONCE().

Get rid of the preempt_disable() / preempt_enable() pairs by providing an
own variant which makes use of the new percpu code section infrastructure.

With this the text size of the kernel image is reduced by ~1k
(defconfig). Also 87 generated preempt_schedule_notrace() function
calls within the kernel image (modules not counted) are removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index fa3dc3de5f8b..abd774fdd73a 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -240,6 +240,37 @@ do {									\
 
 #endif /* MARCH_HAS_Z196_FEATURES */
 
+#define arch_this_cpu_read(pcp, op)					\
+({									\
+	unsigned long lc_pcpr, lc_pcpo, res__;				\
+	typedef typeof(pcp) pcp_op_T__;					\
+	pcp_op_T__ *ptr__;						\
+									\
+	lc_pcpr = offsetof(struct lowcore, percpu_register);		\
+	lc_pcpo = offsetof(struct lowcore, percpu_offset);		\
+	ptr__ = PERCPU_PTR(&(pcp));					\
+	asm_inline volatile(						\
+		MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
+		AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+		op "	%[res__],0(%[ptr__])\n"				\
+		MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]", "%%r0")	\
+		: [res__] "=&d" (res__), [ptr__] "+&a" (ptr__),		\
+		  "=m" (((struct lowcore *)0)->percpu_register)		\
+		: [disppcpr] "i" (lc_pcpr),				\
+		  [disppcpo] "i" (lc_pcpo),				\
+		  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
+		  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
+		  "m" (*ptr__),						\
+		  "m" (((struct lowcore *)0)->percpu_offset)		\
+		: "cc");						\
+	(pcp_op_T__)res__;						\
+})
+
+#define this_cpu_read_1(pcp) arch_this_cpu_read(pcp, "ic")
+#define this_cpu_read_2(pcp) arch_this_cpu_read(pcp, "lh")
+#define this_cpu_read_4(pcp) arch_this_cpu_read(pcp, "l")
+#define this_cpu_read_8(pcp) arch_this_cpu_read(pcp, "lg")
+
 #define arch_this_cpu_cmpxchg(pcp, oval, nval)				\
 ({									\
 	typedef typeof(pcp) pcp_op_T__;					\
-- 
2.51.0

