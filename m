Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B214B3BF695;
	Tue, 26 May 2026 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779775030; cv=none; b=QJ8HvngnZNQKbHHrQh2SGGqw+KTs8dZuVsYUdqZC8NlCvBhsJSl60ts/wUuD5REVsviZS7JqfGedn1YFUS89KiWK4AD/Qvi5T+A/AOojUrkBliCWml99VUgef3Nqz5cFVkO4nRVb0wzDay6MCzmQU5nKJxkdflXueilMIJSq3GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779775030; c=relaxed/simple;
	bh=b7FCCZgRhyt9e0vVBfaDC2rx8PAEMyApt/6cQkR9LLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTqDqaBe7vm5YRVabQCAf+LCiKnZVzeO0W1jGkg51/8EXsCcjP5HlEXYvXFzyvC8X1tiOxrYp6YqbfFKctHQ2noQKiw6XHwr+XJzUZ2AB+QrvyjzPpqiPhidnyzB1wjl1tggJxw0HNtR0TgYOiqSngUcnjsZAiCE4oMeOBvAyos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fhJWDU/u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fhJWDU/u"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64Q0KAwI868208;
	Tue, 26 May 2026 05:57:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WlfIVcJXQcx0zZvV7
	ElSdd7SSTWdtlR0tVVA0tV2ph8=; b=fhJWDU/unSwW6R6jb9hyfXHdLTiGkExXt
	QmXLS17/ZacnR/5MpBmuWsghdPBWGvwPA2/WtYZ7aiLHT2oAR93PsXb96BJnI/eX
	i6Nn+Q72ESTJxLEeyHW5RlbDI0/HIt2/G3/RJeJACcRBwlPGihz/cJsJelrFl+gx
	r7xTiRDR3xnR1nF8htQM2J5Ea0zD72GQ1MvLGSsYWOc+igf+Ror5Qr08ZzaN0/dy
	9o/+VksQut32qxJhBDECtOOAdkEer72HSdHNgkD6aQSBa5Md+6VHqAnb+6LfLnpr
	0vVg6zoSaTHzrPTrU4/uEDlXW/NUuxbEXhRDq6BJot100o9B4yrcw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eb4s2ajh7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 05:57:07 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64Q5s7Mu016023;
	Tue, 26 May 2026 05:57:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ebs8y7q8d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 May 2026 05:57:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64Q5v3k053215630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 May 2026 05:57:03 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8294820040;
	Tue, 26 May 2026 05:57:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66C242004B;
	Tue, 26 May 2026 05:57:03 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 26 May 2026 05:57:03 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v5 2/7] s390/percpu: Add missing do { } while (0) constructs
Date: Tue, 26 May 2026 07:56:57 +0200
Message-ID: <20260526055702.1429061-3-hca@linux.ibm.com>
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
X-Proofpoint-GUID: dxWMZMAXrLVAcOgzTcvpcmW0SsK7N_kb
X-Authority-Analysis: v=2.4 cv=Sq2gLvO0 c=1 sm=1 tr=0 ts=6a153634 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=c92rfblmAAAA:8 a=VnNF1IyMAAAA:8 a=VwQbUJbxAAAA:8
 a=V-yoBbGPs5LSgb0Mvs4A:9 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDA0NiBTYWx0ZWRfX/GWOz43pv5J+
 nnSwOZ8ahvwdCd8rWNi4C25NI5aRn7tjd20KbtHTBmuKvyWz17GH6eNZ/Kc7+Eh1EK0Om+3IEKj
 nHkQAcfqXY4SZ+T5HoxCP6IYEt/fbI89E/j6IjznaRTqV2+S2t4zV73cxiCzBzuz9PMSVi63rwS
 CQf/LGTIdDuUk8LreXNzUBa3UOmvB9prNCffVgkGWjzliSoDcqB7TueGzF21EMHMPd2DP36cUir
 5xstM08CjQ1aZSe7xdvKLw1FJX4fFqgRC1ScjiLTARd0jIBmPPi0l0KN7ggooBZyaKKMNpzh431
 m/QWhhR88pUWRZ0IrYRQWlydnB9JTnc1vhy06XDOzfPieB17Xe2y/xqouHX7pro6BrThONPXD0J
 Z1MkchsF+qy/CZz1JwNxBT31wYD7vm9R9SqXoNkcPbTXyxtpvrm7LpOwzNBIGddpAiZcsYyDJfy
 nE92ZbgAL0zT4o/MaQg==
X-Proofpoint-ORIG-GUID: dxWMZMAXrLVAcOgzTcvpcmW0SsK7N_kb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-26_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260046

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

