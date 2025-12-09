Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D67322B66;
	Tue,  9 Dec 2025 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765282648; cv=none; b=mg5ffiBsD4rBOWU2RcQce5CQuAVJ0GodRWqZN1/u/zo3ZILoDrQ7LDw+tv5HYhjEjZI8dZWgN322k2dbpTSMvbun/Tt3hLMAGZWu0ugOyrZsp3oHwyug1AtpYOHRCqP5zliCYiQyoidPBXH19tJEySa9ln0fjoHRDnBJmJxcrFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765282648; c=relaxed/simple;
	bh=CpVMq9d2BXRwZi/Ix9Tb0FHrQ250ufry9ym4HTnCt1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X9dTJMCiZrWbNXFUZfOPYGfUOik+B/0Tc9IEQhjH9DZlC4pxwY8N7R7XETmAxK2KNYkbOESCNGfrFbM6zIN7lpOGxc2o4Qcex8r7dy+GBar4Rf4cd/TXLeqFJ33btAHMCL84gQR0wSbNZsFUe9zZjrvPPcjyp+EGdNzR3agxqmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qSLKHwuW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qSLKHwuW"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9BLs9D031277;
	Tue, 9 Dec 2025 12:17:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jpKY+wQk5Scv0775N
	O/PAaz9kp7MOF3vOEIhnUAuIH0=; b=qSLKHwuWOVcaiLlGr9j5QI/hptaVKVeWs
	LmZLJWNLj+MmUhgVP2qNRfg1n/9E+W1jKUNftfncWGkimek5T4+i9iDqz93Mr4rg
	z0A8Hof+xM5x+Z5NFPgkEYBX7MRGuBHLgVOHW72wVqYOUNzRci3EjibBNwe0v6fG
	5FaQQKz36lRNsUTDH9wj+k2ju61sDEa0Wl46cVBwim5H5kiINj6FM5O0179Dy1tm
	3Fx53SkEsglHgZfNnkLFH8NMrGDBF2TYfZkWJ5BRusJHzDuFpk9YgxYSKZQto/Br
	bwah/NKVKcTRamZR/883A8Tf1cPkcRYUC6WVihCdfnzEb4ETujfGw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4avc7bvr8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5B9BZdXW012432;
	Tue, 9 Dec 2025 12:17:06 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4aw0ajtpbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Dec 2025 12:17:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5B9CH2Q725494156
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Dec 2025 12:17:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9B57420040;
	Tue,  9 Dec 2025 12:17:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 70B332004B;
	Tue,  9 Dec 2025 12:17:02 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Dec 2025 12:17:02 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>,
        Jens Remus <jremus@linux.ibm.com>,
        Stefan Schulze Frielinghaus <stefansf@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 5/9] s390/traps: Copy monitor code to pt_regs
Date: Tue,  9 Dec 2025 13:16:57 +0100
Message-ID: <20251209121701.1856271-6-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251209121701.1856271-1-hca@linux.ibm.com>
References: <20251209121701.1856271-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: NVVY63WwizCBnWVST_QAAy3DCELitTyQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA2MDAyMCBTYWx0ZWRfX6/CfjKBpw7ec
 SA9ddvr0UFja/m7BAA4aS5H1HZx0Dwr76nWSEk+otFafTM/7zjMy0ZluvFDYTZ2nWNxlN/bPDcE
 bpBIKLnA8JMEsAimuY12nPVGXnM0VItfF+z6ePeD5K4QLQtFcvDK6pEOpwKL7FOlLhZ5n508nR8
 f5s3N39yvx1xufs7gcduHIpzS8CtT+pLL7sGmOYwyRJUls6ibqVvgw+RWYQy4axENz7Vj3+LOEw
 IZg4fq690hdg/fK8RsQI41Crm9cM2dzG7XhqJD7xz57/ll6O1Xk3Z0DVm4mjEqNGIGHnDfc1Guf
 /98sajn0R2JCR3p3dM0ZweQPrHMkIPkTJ2vhZGaLgOi7iBqPgsmHCF7iJ72M79WGYUDSOUf9cxC
 z1KnxGObH0NhHSnwpDuJBtXq9tGLsA==
X-Proofpoint-GUID: NVVY63WwizCBnWVST_QAAy3DCELitTyQ
X-Authority-Analysis: v=2.4 cv=FpwIPmrq c=1 sm=1 tr=0 ts=69381343 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=K8CxzhMZn-qOOmtg0DIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-09_02,2025-12-04_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512060020

In case of a monitor call program check the CPU stores the monitor code to
lowcore. Let the program check handler copy it to the pt_regs structure so
it can be used by the monitor call exception handler.

Instead of increasing the pt_regs size add a union which contains both
orig_gpr2 and monitor_code, since orig_gpr2 is not used in case of a
program check.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/ptrace.h | 5 ++++-
 arch/s390/kernel/traps.c       | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index 962cf042c66d..f3c3a4ee263c 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -120,7 +120,10 @@ struct pt_regs {
 			unsigned long gprs[NUM_GPRS];
 		};
 	};
-	unsigned long orig_gpr2;
+	union {
+		unsigned long orig_gpr2;
+		unsigned long monitor_code;
+	};
 	union {
 		struct {
 			unsigned int int_code;
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index de63e98e724b..b2d6d7cc3b17 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -298,6 +298,7 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
 	teid.val = lc->trans_exc_code;
 	regs->int_code = lc->pgm_int_code;
 	regs->int_parm_long = teid.val;
+	regs->monitor_code = lc->monitor_code;
 	/*
 	 * In case of a guest fault, short-circuit the fault handler and return.
 	 * This way the sie64a() function will return 0; fault address and
-- 
2.51.0

