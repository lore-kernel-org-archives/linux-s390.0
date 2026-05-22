Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A9F376A02;
	Fri, 22 May 2026 14:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459205; cv=none; b=jlR/e+5YgnNwLjG+cylJczYNhiYt7rYAeRZG31+V+RJ1YZOpwedgOy423ALed4FHiNbFumB4Dm8bTBkupvLmZW0okjSGFMwSo/4iTnCrZB+A273B+taFVFWwJ+NqzL9hQGrYdIOyZ5GVWx5ze4X+vn6RlHjmP7C3iDN+hvD0vGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459205; c=relaxed/simple;
	bh=ymvOTQIUMMk/aXoAHGjadV+xaKIR/6VtOmZHZnfV7ds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i10nntM7vRMu7KmcaR0xVYANh51+JLswwSfnjr/RtTgZv3R7C5JPmMumBLLi1zbvU8k6irm0GOJjzsUAAzA//so6nxnU+kSJApHGSga+bzwAVUd2x9QqKlv6wclx3+GFLKB+9RYMXLXsymonPJiXKlIsKll6NSDLkhCdmTw8YNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mxcrotRD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mxcrotRD"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MAZU6C394602;
	Fri, 22 May 2026 14:13:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GcHNS14L5oGtPrEvK
	Nq+s1QrWpgqQu6oEiiBPNVUaIM=; b=mxcrotRDb4aoUp7GvzQtvaveiXETLUx9N
	F606SItNkYcTngwqZoDWR/iq6o5frF7UyZJEo6FF0BD12qpGNqo1CnXVhKs5jI/i
	bAtl6okG73IzDnxwGij6nH7m0vFeYItnPjs3dGbsGPneurZddQnKAit6sXD98hBP
	qd5IbMc2U8eQlkz13W5Tcn2rJj/JiBnulctJQobiszSXOgYDASyJkQI0PHH4z+Dh
	52jqoovCS3Fi7cZDLBQ1NfeYNiNE/tcugMszlJmjAaXJdiSU5bRozJ8BkGNVh2Qi
	KDNqFufkzql3lYGJd189B+HxnFdWsOR+vK1iSWB7e6YBwrRX7UkRQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h9ycegq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 14:13:04 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64ME96Ne030307;
	Fri, 22 May 2026 14:13:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dj149x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 14:13:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MECxLI30409104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 14:12:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73EE220040;
	Fri, 22 May 2026 14:12:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4497E2004B;
	Fri, 22 May 2026 14:12:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 14:12:59 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang@os.amperecomputing.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        David Laight <david.laight.linux@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 6/8] s390/percpu: Provide arch_this_cpu_read() implementation
Date: Fri, 22 May 2026 16:12:55 +0200
Message-ID: <20260522141257.303617-7-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260522141257.303617-1-hca@linux.ibm.com>
References: <20260522141257.303617-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE0MSBTYWx0ZWRfX88H+HOQvLCFC
 adZzs8a1mX+eV8eqSCOFWqkWb2zmAmDNs3pz2HSdttUmK58nP9RfknI2UwgvhS2/fowmlsbR2j+
 9jh9d3WhALBu8UrPk9iJxwWgbDTLPIp7XThrDPHj4T/dNHQ77/iG/sfaOGoETLMYr49Ivm66RoJ
 qyojxhiScEKYTe0nHvWl1pp36WQHjGAW0DnINbtigRtOuTxXJnL9fflo1bDMJ8TMNjw4hH8D8Xj
 ASbhPHprCkOP1qHoPc5SmSM5y8ITCwK1ArNzsS8fKJEOF0pMj73ojC+ZEcOlvK2kX6EBGma+hQ2
 8Xm+7OnNM1gqjdVzwsxIePDOnzw3UTHz77XW88RySgSN7bmNwJvuhOtmaOupdp1xdIy/kL4EeJQ
 RP5yz8w+YJB0mMMLrFdwW7HqTxvsxwPajdwVYaxdmXGO5YslErqu/b91JjSnAesqGdRa0HCdwIY
 UOf3I1sYiQDCe5uJA4Q==
X-Authority-Analysis: v=2.4 cv=BNuDalQG c=1 sm=1 tr=0 ts=6a106470 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=4bOSrtcVyj7iNoH5sBwA:9
X-Proofpoint-ORIG-GUID: jGfygW6w-RgxBFKIUPPTnBHvqQ4l71VS
X-Proofpoint-GUID: RKXgQKclBBQBFxEF3jERM2iumFDWL0U9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220141

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
index 5e0185e5960b..2b6c2c5606b1 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -248,6 +248,37 @@ do {									\
 
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
+		MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]")		\
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

