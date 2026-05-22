Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFDE4219F8;
	Fri, 22 May 2026 14:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779459204; cv=none; b=fpFazmNzAzGr9Ty9Vw2wfIDsdNKjONRCuO4lolfHJaSkZyxbnkDEK8NWXuo7Q/1nORoyd8HxYAnWT7BufExQAon+yYKSDLl0FmukBXdolxg7bZxhf6kSACAzvbGj86aF0bltr1q3c9qA4f/XyGvl/7dDR64kjd2EVY4AdsAlpEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779459204; c=relaxed/simple;
	bh=b7FCCZgRhyt9e0vVBfaDC2rx8PAEMyApt/6cQkR9LLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHadloApM+ojGty/q7dbkEHZwp5SAeYBKuy6GLQGkmdV4jXp7quMx49S5vU6RmJ3RfkHKfIrkwCfoWyr3RpDLaSxEGSfjSJH+5q2NVvNBUO9cjMP/Zi+Va4bAPceZXNhUCQmw6YcvYESmmySDIsPm+DKhLN9em5BF7OGeIgU6rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XtUTGSpx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XtUTGSpx"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64MAJglC3901160;
	Fri, 22 May 2026 14:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WlfIVcJXQcx0zZvV7
	ElSdd7SSTWdtlR0tVVA0tV2ph8=; b=XtUTGSpxPJzLBifLSl91iqgxN3sxrYwhi
	0UZ34wpMwCJGX8veHDi7ObCPXg0Oicreie/NjMon8VmUdiP+rRnu8rnGlf/SbOmd
	MUHKvVK7JdH9A4fCcWBLzWh4beKq5r8wZ4Aopp9kYkj4Zm+agqjEvOJ+Sgw8lcgC
	F4uN8EFxvoAXSg4iX5vHZo2wvLtHfAUlc31dEeSnFevbs6+ktGhSKxZrUe/mn41z
	7DphdTDUK1cb1c1WtHKPzQvCAe3PhL+8kaQ+cdTCofL2dVSNK9hvYAj2H9MAlapZ
	ns5wDUxKtTTFUT09ZVSbklD+LlnQ4Mmpxt6iuaU4ytAoyfxsWIp3w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8n49nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 14:13:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64ME97JR030310;
	Fri, 22 May 2026 14:13:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e74dj149t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 14:13:02 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MECwfG62914970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 14:12:58 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 949E02004B;
	Fri, 22 May 2026 14:12:58 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FC382004E;
	Fri, 22 May 2026 14:12:58 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 14:12:58 +0000 (GMT)
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
Subject: [PATCH v4 2/8] s390/percpu: Add missing do { } while (0) constructs
Date: Fri, 22 May 2026 16:12:51 +0200
Message-ID: <20260522141257.303617-3-hca@linux.ibm.com>
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
X-Proofpoint-GUID: U0AxLtuHKhNm-d6vfc6-W6hYzeH5nB_P
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a106470 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=V-yoBbGPs5LSgb0Mvs4A:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: RUo6GzenQmhY_3CLC6ZLT9iXHT6RXYNi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE0MSBTYWx0ZWRfX9m5Vx+lTjHzR
 5xhkIrW3v4ka2Qt2ME/qi0uW1ZxmdtDecGQQdTss4OSDfi+q2WlUrNygMVvRBsTxi+L5ESyCP7A
 1Vx9bw0DJKcMfNsjZq47DbnFYPYhRF2vHtv7nHBrBjaomUfXLlNJCQFPpUdnfETVImsXrzFFNkt
 TL/vMmubJPgq6CV9HMy/62RgGJ5DEdaK65NmTpXywm5SR3Ke10DWtdtvQJfTvzXZ/H+ruIHwyVl
 n1sWExG7YKxKljB+/siXtS9B0MoErluau/AHtJ5WZ0f/bRk8Eli4aERIVTnelfyepoy5mix1RRg
 8JJohaNqVZTg++9btPEguZUFZvK63Loc+60jiN0ETIpiDaQGX9+h1zECWXz9vMLlH3SdBJB8BFu
 kl96oH/j9dEhWkZA/STdKnWFEjt29m4goPsFrToWE/nH2KmABaXNnqVzF7M0kfV3ppaiFx8iRLq
 2IR52jOLttSAZ6c4z6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220141

Add missing do { } while (0) constructs in order to avoid potential
build failures.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260319120503.4046659-1-hca%40linux.ibm.com
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 78602d2f5eba..79d5a4460b18 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -136,7 +136,7 @@
 #else /* MARCH_HAS_Z196_FEATURES */
 
 #define arch_this_cpu_add(pcp, val, op1, op2, szcast)			\
-{									\
+do {									\
 	typedef typeof(pcp) pcp_op_T__; 				\
 	pcp_op_T__ val__ = (val);					\
 	pcp_op_T__ old__, *ptr__;					\
@@ -157,7 +157,7 @@
 			: "cc");					\
 	}								\
 	preempt_enable_notrace();					\
-}
+} while (0)
 
 #define this_cpu_add_4(pcp, val) arch_this_cpu_add(pcp, val, "laa", "asi", int)
 #define this_cpu_add_8(pcp, val) arch_this_cpu_add(pcp, val, "laag", "agsi", long)
@@ -182,7 +182,7 @@
 #define this_cpu_add_return_8(pcp, val) arch_this_cpu_add_return(pcp, val, "laag")
 
 #define arch_this_cpu_to_op(pcp, val, op)				\
-{									\
+do {									\
 	typedef typeof(pcp) pcp_op_T__; 				\
 	pcp_op_T__ val__ = (val);					\
 	pcp_op_T__ old__, *ptr__;					\
@@ -194,7 +194,7 @@
 		: [val__] "d" (val__)					\
 		: "cc");						\
 	preempt_enable_notrace();					\
-}
+} while (0)
 
 #define this_cpu_and_4(pcp, val)	arch_this_cpu_to_op(pcp, val, "lan")
 #define this_cpu_and_8(pcp, val)	arch_this_cpu_to_op(pcp, val, "lang")
-- 
2.51.0

