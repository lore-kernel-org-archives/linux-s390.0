Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F3A3F86EF;
	Thu,  1 Oct 2026 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850786; cv=none; b=e9Q6A1v4NIh8o39Iz6fSxZYL+pJU1ue3jXtFF3cwWkdzerF1SPSBRSnwhaq/DRHw1MQa+Omr1exv0BOivA2czjdb21/bjS92fKkzh4W/Vu4L7k4C3b77sgYta+LNW0/QqYFnx4I06KRz9de4vvOuzWYg7pLCQ1Oa7Sm2KCFkprA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850786; c=relaxed/simple;
	bh=VLhFccrY1H9lgV/Mo43vFSTX7xXewF7wZUWKWR98+Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ec1P+uTffqdAYEplcUV4t6R7v2YxKfo8uMmSUgabh6B46FFoi6/EZVH50WmLVYdI8NF+7XrXhN8TvraYA47sDRl0IF8PLIgd0DFyfPdOoeoWerbdu+UlFqesL4EYCzIETc+DpcuXkA0+ptkNit6k5FcpfqL8B8DakmrF8Snn6c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CBkw0Xa8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CBkw0Xa8"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175dH04040963;
	Thu, 1 Oct 2026 10:32:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gMJPGrKkkyP8YabRU
	8AXf2URNZxwm3DYXZSL+bwQVLc=; b=CBkw0Xa83J6LoeQTTb3SYgukjDiOc9ceF
	nZYu1vfn/EA7d/ECiAg119r/7GervGqWOozTmuUmNisruhm1B50heb6iDR2miFOe
	JYhaRLWm8Vur5Q6ipSsIF0WXsMoyMs6sAvr20QGLz0MLexbUaOahGEeg3NQ9VqGn
	8D3Y7vBqLu5LVNEdTdK/MhnUZ6ZgpgQdXW0hQ8siorLXkD90OcIgrOb8crvw3LCC
	2GVNOO/0eAZ3F3ZsenQgLBkkDtv3GaNStAYFRM0aWX9YNNSoFnHO4l8dkNmfepoi
	bCBhh7+RVvvRHmH5ghrTkf+WacD6WbLAxfC+ZA+ESUBpgJT2zdjcw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fehfn3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172YfW561211;
	Thu, 1 Oct 2026 10:32:55 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0g8e8kb2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWqci41943372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1068B20043;
	Thu,  1 Oct 2026 10:32:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8B152004F;
	Thu,  1 Oct 2026 10:32:51 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:51 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 14/32] s390/diag: Convert inline assembly to EX_TABLE_INSN
Date: Thu,  1 Oct 2026 12:32:29 +0200
Message-ID: <20261001103247.1989111-15-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001103247.1989111-1-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abe36d8 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=sYOz-H63P38W3EJanfYA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXxVd8V91pTSFA
 NGhmt2NNDAxwzXK5+55DythEmRSeEtIBGzq8UbV463syljZKGg3BCYajh+/jwsTrizvfihoOGYm
 8HTu+dHdhFi/p4h0dDDZPjWy8uIf83w=
X-Proofpoint-ORIG-GUID: zczkrJlga0eKapdhQUoMaeUBwEhDAIa1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXz1TvychMTt4l
 SrtVnPRfH5XqqQCjbqK02t8OENa0de14vBW3Bqw6fZkw2UfHDeiu2B6Vth+UtfoTNKegE6Ro6jT
 xJB3edrPtBk0MQeJNvcWZmPXEjk15Ga57/NJOeUD0HLAX0hwhSx+OW7/rZoRU8mPCws6seHHxT6
 qiGyKsIAS9dvzd5rwS5I+SiWwFjb1un84CQ9qOtRL/jnzMXwCmtaoyqLIVJZ9dLf6/xqTbFX2OP
 G0ywWngeg5pJqszslMzOhb3jWS8b7X25qXHLAdQ5Cxt9hhQUFcVLikuL3Kqt8eOUNcwbA9mXczn
 EDCO/h7dSCT+AohUw2zrcI45fF3jaug0nI0IoE61HrjSlvsbrz+0kHbzlkRqOOAs76+aQmrXIBk
 s0NNF3HCU0Y5GYk4S7Ut8uAM/EiuxgsBsercxyYkqup2t8Vqeemy2aYlf0skOOUC2ZUhFdv7QRR
 xVT0yr7UDLQr2jHkkSg==
X-Proofpoint-GUID: zczkrJlga0eKapdhQUoMaeUBwEhDAIa1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010040

Convert all diag exception table entries to use EX_TABLE_INSN.
With EX_TABLE_INSN entries always point to the faulting instruction,
so duplicate entries and nopr padding are no longer needed and removed.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/diag.h    |  5 ++---
 arch/s390/include/asm/diag288.h |  6 +++---
 arch/s390/kernel/diag/diag.c    | 12 ++++++------
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/s390/include/asm/diag.h b/arch/s390/include/asm/diag.h
index 8db8db3b1018..1416ee1ad323 100644
--- a/arch/s390/include/asm/diag.h
+++ b/arch/s390/include/asm/diag.h
@@ -68,9 +68,8 @@ static inline void diag10_range(unsigned long start_pfn, unsigned long num_pfn)
 	diag_stat_inc(DIAG_STAT_X010);
 	asm_inline volatile(
 		"0:	diag	%0,%1,0x10\n"
-		"1:	nopr	%%r7\n"
-		EX_TABLE(0b, 1b)
-		EX_TABLE(1b, 1b)
+		"1:\n"
+		EX_TABLE_INSN(0b, 1b)
 		: : "a" (start_addr), "a" (end_addr));
 }
 
diff --git a/arch/s390/include/asm/diag288.h b/arch/s390/include/asm/diag288.h
index 5e1b43cea9d6..f0a37a80d672 100644
--- a/arch/s390/include/asm/diag288.h
+++ b/arch/s390/include/asm/diag288.h
@@ -28,10 +28,10 @@ static inline int __diag288(unsigned int func, unsigned int timeout,
 	int rc = -EINVAL;
 
 	asm volatile(
-		"	diag	%[r1],%[r3],0x288\n"
-		"0:	lhi	%[rc],0\n"
+		"0:	diag	%[r1],%[r3],0x288\n"
+		"	lhi	%[rc],0\n"
 		"1:"
-		EX_TABLE(0b, 1b)
+		EX_TABLE_INSN(0b, 1b)
 		: [rc] "+d" (rc)
 		: [r1] "d" (r1.pair), [r3] "d" (r3.pair)
 		: "cc", "memory");
diff --git a/arch/s390/kernel/diag/diag.c b/arch/s390/kernel/diag/diag.c
index 56b862ba9be8..f23b3e2b070e 100644
--- a/arch/s390/kernel/diag/diag.c
+++ b/arch/s390/kernel/diag/diag.c
@@ -196,9 +196,9 @@ static inline int __diag204(unsigned long *subcode, unsigned long size, void *ad
 	union register_pair rp = { .even = *subcode, .odd = size };
 
 	asm_inline volatile(
-		"	diag	%[addr],%[rp],0x204\n"
-		"0:	nopr	%%r7\n"
-		EX_TABLE(0b,0b)
+		"0:	diag	%[addr],%[rp],0x204\n"
+		"1:\n"
+		EX_TABLE_INSN(0b, 1b)
 		: [rp] "+&d" (rp.pair) : [addr] "d" (addr) : "memory");
 	*subcode = rp.even;
 	return rp.odd;
@@ -287,10 +287,10 @@ int diag224(void *ptr)
 
 	diag_stat_inc(DIAG_STAT_X224);
 	asm_inline volatile("\n"
-		"	diag	%[type],%[addr],0x224\n"
-		"0:	lhi	%[rc],0\n"
+		"0:	diag	%[type],%[addr],0x224\n"
+		"	lhi	%[rc],0\n"
 		"1:\n"
-		EX_TABLE(0b,1b)
+		EX_TABLE_INSN(0b, 1b)
 		: [rc] "+d" (rc)
 		, "=m" (*(struct { char buf[PAGE_SIZE]; } *)ptr)
 		: [type] "d" (0), [addr] "d" (addr));
-- 
2.53.0

