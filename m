Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3446834DCC8;
	Wed, 20 May 2026 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779268981; cv=none; b=kFwRdvqG0+qoMDH9FHZZ9yxFf5s/bEY6VUw7hd4xYCTe98PiI5KT7qBgR5gjIyFAJ8o8nryRuG2TZ1+HnRz+eVNHMnXS6abPUKEm+U0sbMlKET0BP9IoxhTw9GPKTJxjSfRrAhtQClhmhDLcRsCfsY2QVF4DBlw6KMqBP/4dPEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779268981; c=relaxed/simple;
	bh=5gaQNpuYvawh0wrEaPibXQTlaY2dPhZHPydLMZIsIfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qOtNMUc1tiY1YCfSyy77lrAecUM3mZjVgvzA4aKBQ87PQdVGie0M8LxP+mxhqdvBiIO2XTz0ABtg3zE6v4qYkGRbDoVZzLoaSsvsI4xMH4c5/jNfpzQjfw7DcJdUab40UOv8uLe1q3MWm4yEkUWuF5zoCoZjTrZ42S57zOpjw0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E7kwQH2U; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E7kwQH2U"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K6VPBP1839474;
	Wed, 20 May 2026 09:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7ua+SCOOYqK79bzMR
	hDsvBmjg4cNCt1vhxkEacZsI3I=; b=E7kwQH2UWnKLuiI8hSNkbQGh3aY9V4t0K
	UoyFM3/uyULoEI+rI+R61C4zg+fGWks0C0OgYg6Q3YlywQ49eBkTkm9GzoayCmVB
	/1qvpGzLAo6Wncf4T+R/ojjGsbSbotLGK7CPpeeUqP9vLFWYodE1LxtxKiFpYeEu
	0YFM2eMPk1higSpI4X2ukuZb4hVMsdONg8FBjTbftNSkIqApf3xTfgqU2l5JodaL
	H1XPpFPkwGeA9TIFtiVIWzig/TKiFN8fNlSgijuGdYhFaWSanGKPqrcZo90dWhP5
	Hcs7rqNpWqqT5R1rDwHVcXcWX+/BW+fsnKKy22MKEg4azpDV5/+/w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8ms95n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 09:22:49 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64K99ANB022924;
	Wed, 20 May 2026 09:22:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gef63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 09:22:48 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64K9Mje256885608
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 09:22:45 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 36A3120040;
	Wed, 20 May 2026 09:22:45 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08FEE2004D;
	Wed, 20 May 2026 09:22:45 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 09:22:44 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Yang Shi <yang@os.amperecomputing.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 4/9] s390/percpu: Use new percpu code section for arch_this_cpu_add()
Date: Wed, 20 May 2026 11:22:38 +0200
Message-ID: <20260520092243.264847-5-hca@linux.ibm.com>
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
X-Proofpoint-GUID: 5fGnuyjwJINd0jsd7YW2t-teeW7EsY69
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0d7d69 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=SujZmW7ZfIunUtho7CIA:9
X-Proofpoint-ORIG-GUID: 5fGnuyjwJINd0jsd7YW2t-teeW7EsY69
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDA4NyBTYWx0ZWRfX8IKYmmfaRxaI
 4q7QhmL0ZwZyotL6r7TYQymRCaecWJQ5n2UYecbBmA3SyUi/LvwEDcttr4xO4PBUicKg6I/RVN7
 UJBwm6ovmmP/FXBZg1nuPrr5g4XZG4yelhlByqRwTZNHX7GDmIIwGwuyCzDI6wONIExxo/nMVuM
 LCvLJAHH0VYJcQ0BSD1OXLMdqbAsjfPvoUE8g/DznnHWdrk+dkn24r/i4LwsaYS0FYNF63k/VBQ
 l7qlKT0O5aGnvrJoDdw59xb3me1KXZO5vMbdG7O99Niyb3dCAPaVbXr9MTQ2FRi7XitjPENJDUZ
 dQIhq1qL1IWZasPbZTnohUW73Z/+VBs+Ip4zDMBSeMSPXpkOa+KmAcznfuWsykTgJaij8Y57CBX
 t34xPLUwsxNAWwq+FjKVLj0LKl89Psh4Qq+UGL1XJ9RiHavQJG6o2GKTsonMYHXvay/BHO7p4B6
 b1Ali8I0P9otsFpTHKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200087

Convert arch_this_cpu_add() to make use of the new percpu code section
infrastructure.

With this the text size of the kernel image is reduced by ~76kb
(defconfig). Also more than 5300 generated preempt_schedule_notrace()
function calls within the kernel image (modules not counted) are removed.

With:

DEFINE_PER_CPU(long, foo);
void bar(long a) { this_cpu_add(foo, a); }

Old arch_this_cpu_add() looks like this:

00000000000000c0 <bar>:
  c0:   c0 04 00 00 00 00       jgnop   c0 <bar>
  c6:   eb 01 03 a8 00 6a       asi     936,1
  cc:   c4 18 00 00 00 00       lgrl    %r1,cc <bar+0xc>
                        ce: R_390_GOTENT        foo+0x2
  d2:   e3 10 03 b8 00 08       ag      %r1,952
  d8:   eb 22 10 00 00 e8       laag    %r2,%r2,0(%r1)
  de:   eb ff 03 a8 00 6e       alsi    936,-1
  e4:   a7 a4 00 05             jhe     ee <bar+0x2e>
  e8:   c0 f4 00 00 00 00       jg      e8 <bar+0x28>
                        ea: R_390_PC32DBL       __s390_indirect_jump_r14+0x2
  ee:   c0 f4 00 00 00 00       jg      ee <bar+0x2e>
                        f0: R_390_PLT32DBL      preempt_schedule_notrace+0x2

New arch_this_cpu_add() looks like this:

00000000000000c0 <bar>:
  c0:   c0 04 00 00 00 00       jgnop   c0 <bar>
  c6:   c4 38 00 00 00 00       lgrl    %r3,c6 <bar+0x6>
                        c8: R_390_GOTENT        foo+0x2
  cc:   b9 04 00 43             lgr     %r4,%r3
  d0:   eb 00 43 c0 00 52       mviy    960(%r0),4
  d6:   e3 40 03 b8 00 08       ag      %r4,952
  dc:   eb 52 40 00 00 e8       laag    %r5,%r2,0(%r4)
  e2:   eb 00 03 c0 00 52       mviy    960,0
  e8:   c0 f4 00 00 00 00       jg      e8 <bar+0x28>
                        ea: R_390_PC32DBL       __s390_indirect_jump_r14+0x2

Note that the conditional function call is removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 65 ++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index c8fc8b320a86..459603c7305a 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -127,28 +127,49 @@
 
 #else /* MARCH_HAS_Z196_FEATURES */
 
-#define arch_this_cpu_add(pcp, val, op1, op2, szcast)			\
-do {									\
-	typedef typeof(pcp) pcp_op_T__; 				\
-	pcp_op_T__ val__ = (val);					\
-	pcp_op_T__ old__, *ptr__;					\
-	preempt_disable_notrace();					\
-	ptr__ = raw_cpu_ptr(&(pcp)); 				\
-	if (__builtin_constant_p(val__) &&				\
-	    ((szcast)val__ > -129) && ((szcast)val__ < 128)) {		\
-		asm volatile(						\
-			op2 "   %[ptr__],%[val__]"			\
-			: [ptr__] "+Q" (*ptr__) 			\
-			: [val__] "i" ((szcast)val__)			\
-			: "cc");					\
-	} else {							\
-		asm volatile(						\
-			op1 "   %[old__],%[val__],%[ptr__]"		\
-			: [old__] "=d" (old__), [ptr__] "+Q" (*ptr__)	\
-			: [val__] "d" (val__)				\
-			: "cc");					\
-	}								\
-	preempt_enable_notrace();					\
+#define arch_this_cpu_add(pcp, val, op1, op2, szcast)				\
+do {										\
+	unsigned long lc_pcpr, lc_pcpo;						\
+	typedef typeof(pcp) pcp_op_T__;						\
+	pcp_op_T__ val__ = (val);						\
+	pcp_op_T__ old__, *ptr__;						\
+										\
+	lc_pcpr = offsetof(struct lowcore, percpu_register);			\
+	lc_pcpo = offsetof(struct lowcore, percpu_offset);			\
+	ptr__ = PERCPU_PTR(&(pcp));						\
+	if (__builtin_constant_p(val__) &&					\
+	    ((szcast)val__ > -129) && ((szcast)val__ < 128)) {			\
+		asm volatile(							\
+			MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
+			AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+			op2 "   0(%[ptr__]),%[val__]\n"				\
+			MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]", "%%r0")	\
+			: [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
+			  "=m" (((struct lowcore *)0)->percpu_register)		\
+			: [val__] "i" ((szcast)val__),				\
+			  [disppcpr] "i" (lc_pcpr),				\
+			  [disppcpo] "i" (lc_pcpo),				\
+			  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
+			  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
+			  "m" (((struct lowcore *)0)->percpu_offset)		\
+			: "cc");						\
+	} else {								\
+		asm volatile(							\
+			MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
+			AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+			op1 "   %[old__],%[val__],0(%[ptr__])\n"		\
+			MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]", "%%r0")	\
+			: [old__] "=&d" (old__),				\
+			  [ptr__] "+&a" (ptr__),  "+m" (*ptr__),		\
+			  "=m" (((struct lowcore *)0)->percpu_register)		\
+			: [val__] "d" (val__),					\
+			  [disppcpr] "i" (lc_pcpr),				\
+			  [disppcpo] "i" (lc_pcpo),				\
+			  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
+			  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
+			  "m" (((struct lowcore *)0)->percpu_offset)		\
+			: "cc");						\
+	}									\
 } while (0)
 
 #define this_cpu_add_4(pcp, val) arch_this_cpu_add(pcp, val, "laa", "asi", int)
-- 
2.51.0

