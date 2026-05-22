Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92977421F07;
	Fri, 22 May 2026 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459195; cv=none; b=OK5khHFaIPLnsZJV6bFLjGUhv9nXX7CMEFJht56KNF8Vu3eTrbXbxqc+GzbAj3SU9quAPT5p2SYrfHO2H6BaTaz4JYsnBvlV1Xb3nudWIt5U5PAvht+7jOBLBhMRNh5p8HJAXwzPkdRRerB/7SdxZD/I6Z5Z8o2KoYgGYS+cPHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459195; c=relaxed/simple;
	bh=GaYj1K6sO65BvmgdyPCtcYf/B0XutCChjv7AN9LJEoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8cQHW0l8L02xOt+ZhIqLON/FhNAAXXwrAZjMc4wXo7Cpscnaav7yChJmv5fOFitq+CLv5aC9tmpb5aZBePYCg+LiujBSeWzI2hTLQ6Kr1Rj9wiXzqPo5zEiFMxc1vPxqX7BYoT9p8YqyWB8z9lkWSNST+h5IJ5PNwyWLS2xM7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=buCdWQx+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="buCdWQx+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M8WfMK1249248;
	Fri, 22 May 2026 14:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ca4EJwt3Fxr9YM+Gd
	7nvh+qnRJop56S/2rZYP22tEpw=; b=buCdWQx+QdMMdEbhP7HkQZVKCPjr57Zpn
	OQb0tpyQkvLcdGipSBt6z3WuX/5yafttbdDw4z8fzweGGOSvFdogXLx+WK7nOif+
	PYp7+AWPkSiQVYMbQGxkQHKv+YRy/piF+qHwdn8L8BKa5Bu57nWyldgZBiVnCP1B
	O2cI3YoBe0X5dv1VzBHTQ/VA8GPASyAKuwVYHUah5fC9ajHv7O/Bh35lYgdt1Ye9
	DTlGNbOxTQHG2X3P0RATZ6RFPFFRQFE8dLqAHh5hfKEMHmSxggGJY5+WRB8JdI4P
	Hp5DMn8hRUQtEv/I/G3Vud7sTFAZ+6YE3IGU4UquQvh56WCbUju8Q==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88ttnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 14:13:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64ME95h5031298;
	Fri, 22 May 2026 14:13:02 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kygwk0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 14:13:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MECxWH27328922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 14:12:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EB0A20040;
	Fri, 22 May 2026 14:12:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E30720043;
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
Subject: [PATCH v4 5/8] s390/percpu: Use new percpu code section for arch_this_cpu_[and|or]()
Date: Fri, 22 May 2026 16:12:54 +0200
Message-ID: <20260522141257.303617-6-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: MedwrGDFBXR9W2Izoo_ruvkqfWu3fwMa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE0MSBTYWx0ZWRfX1x+9Kqruw8za
 GFf2YteRmUdm4U/xfvZXswczvruOVSF48Kksu0rDHKxFM6wetxddwOI+XNHM1vieMrrCIS/k5P+
 bHa7LkUxEnk3vFYOVg8wk8PETSul7q6X/PGr9MDKYIUhTB3FGSh6Z3PiI3nE34IhaL2wAT6J58+
 6aTdf0lnKFpEnSIm4i8OJ0noTTJaXuJkX+mPbM4QdQajoUXJ4rjlqV4jaowOSyu6dUBrLj9KC0Q
 oGcdRVJM9ue9zWEIfyLtgMAonHHTAint5mO5/ksId2joBNQhpmTbs7FUYZIkekHqRrd9lcbcE6C
 RtVKjSsft6E7xl1iZ/TfOQtE5i6lK7zKKWh+XfTo5Vi0om0QGJhVdK2jbeydXjTSIlWKJ/AsbnG
 KX/fIwFb7Fjwb5exgwqxyq2c9ZFLvs0nEN4GInOsodgUV7FFN8P3zDsa26xeO70z8VQpvyYoDtp
 /+l4+L4ma8FQyHeYPrQ==
X-Proofpoint-GUID: H8hwbLhgSDwTe-ST0JFaCE78_Y7zgvgl
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a106470 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=4dLYTkTKlH5g-JvQF6AA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220141

Convert arch_this_cpu_[and|or]() to make use of the new percpu code
section infrastructure.

There is no user of this_cpu_and() and only one user of this_cpu_or()
within the kernel. Therefore this conversion has hardly any effect,
and also removes only preempt_schedule_notrace() function call.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index f2d0e0354582..5e0185e5960b 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -216,17 +216,29 @@ do {										\
 
 #define arch_this_cpu_to_op(pcp, val, op)				\
 do {									\
+	unsigned long lc_pcpr, lc_pcpo;					\
 	typedef typeof(pcp) pcp_op_T__; 				\
 	pcp_op_T__ val__ = (val);					\
 	pcp_op_T__ old__, *ptr__;					\
-	preempt_disable_notrace();					\
-	ptr__ = raw_cpu_ptr(&(pcp));	 				\
-	asm volatile(							\
-		op "    %[old__],%[val__],%[ptr__]"			\
-		: [old__] "=d" (old__), [ptr__] "+Q" (*ptr__)		\
-		: [val__] "d" (val__)					\
+									\
+	lc_pcpr = offsetof(struct lowcore, percpu_register);		\
+	lc_pcpo = offsetof(struct lowcore, percpu_offset);		\
+	ptr__ = PERCPU_PTR(&(pcp));					\
+	asm_inline volatile(						\
+		MVIY_PERCPU("%[disppcpr]", "%[dispaltpcpr]", "%[ptr__]")\
+		AG_ALT("%[disppcpo]", "%[dispaltpcpo]", "%[ptr__]")	\
+		op "    %[old__],%[val__],0(%[ptr__])\n"		\
+		MVIY_ALT("%[disppcpr]", "%[dispaltpcpr]")		\
+		: [old__] "=&d" (old__),				\
+		  [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
+		  "=m" (((struct lowcore *)0)->percpu_register)		\
+		: [val__] "d" (val__),					\
+		  [disppcpr] "i" (lc_pcpr),				\
+		  [disppcpo] "i" (lc_pcpo),				\
+		  [dispaltpcpr] "i" (lc_pcpr + LOWCORE_ALT_ADDRESS),	\
+		  [dispaltpcpo] "i" (lc_pcpo + LOWCORE_ALT_ADDRESS),	\
+		  "m" (((struct lowcore *)0)->percpu_offset)		\
 		: "cc");						\
-	preempt_enable_notrace();					\
 } while (0)
 
 #define this_cpu_and_4(pcp, val)	arch_this_cpu_to_op(pcp, val, "lan")
-- 
2.51.0

