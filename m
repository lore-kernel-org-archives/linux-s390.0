Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D513B3D16FF;
	Thu, 19 Mar 2026 12:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921921; cv=none; b=QlRj8TshgO+wLo9r9A9tlhaaT/5rfIhdbgtZI1oMs6CndJ5xKyXTTGjoMpPdfGD+27tFBiPMtB5/e2uAoSBgmTtEp/yMbmS6eMwb2hJxIQGtb7aXMXw61g8lrT6s3kx3y4QZZbcPm7KsOB3crmnbWMFvpqZkrfIVNEnpLVeZIUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921921; c=relaxed/simple;
	bh=1kdk+CK6bk84jIsKAayEJ9LpHGdQ5vexBiN3RDJ/cto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TamgyhNvJivl0gOpbeqTYUuYR2Lzqz7r5sBIVdYwXIllmdl15OluzHKWs2ALQpIlf9DGaEcqOFWFom+NHXjT6NmVamkfOsPih3W4TP1oDyV+T3yzfizBTHlWJOikB96dVToDVPXCjdjnoRtzcoF1TYHf0SM8blam8q6acEf1GmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KCMaB5xx; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KCMaB5xx"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62INusid1368595;
	Thu, 19 Mar 2026 12:05:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3HDFlARG0P0h478Bf
	zN/iHwOctLoiC6OSWAsIU7WS9c=; b=KCMaB5xxUFSdZUowxpbgKx4SUbJdtrHHh
	kpW9AUIWDG8b24YWvsOSiDuMb3nxdc7wb/60+rvn72QakBlw7JJXP8podZ2BhEfH
	PjrpuRVBpGgsQTAffPy8cq+RS2THYR2HOmTWtNQARYu5uveEcPD5WKPNyoL4Ql51
	uk98M/p89ZM2yqtPG3BcAci7DJT39WHBNrx9afS8Wag15gnKPgyX3O08BgIaqZhU
	MW4svz3FbCZJ6BcuhyMeXPf2WtFYKbefMPA9c/qfK12ldWuqneKrO+GnaIna+59o
	Y3nSkdbhoHwijl4dqUtTykv87JFMNi9VVhhebr5/NPvaB9sGydPnA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64xux1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 12:05:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62JALdRX028471;
	Thu, 19 Mar 2026 12:05:08 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1j4dk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Mar 2026 12:05:08 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62JC55OF48693688
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Mar 2026 12:05:05 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0899C20043;
	Thu, 19 Mar 2026 12:05:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA9E520040;
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
Subject: [PATCH v2 9/9] s390/percpu: Remove one and two byte this_cpu operation implementation
Date: Thu, 19 Mar 2026 13:05:03 +0100
Message-ID: <20260319120503.4046659-10-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: khOn5oyK-tvj1JfqDJrmW9CBLMKlMdz9
X-Proofpoint-GUID: khOn5oyK-tvj1JfqDJrmW9CBLMKlMdz9
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69bbe675 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Q4reuYiO1UekjhQ8NNAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE5MDA5NCBTYWx0ZWRfXwHmy8ZwuPuS7
 C3Uoc94sDsamoHohMAMcGdoYB6QR05XxnXu4LD0AhbK13ScdQ0/yUG8NmzdjKdjOsHEXe3GOiC/
 IduRTnvCqeE77v8aAZgPjCJ/AiwdInoojCS/d25UREK5GwH2rtCE4LNaKdWp+xrMe7liqEAZk8O
 vBkylNRYqgYouiIRrbZ5Akn74qMTcExpjb0FAMLpO7hs80ZlUcF0EEC+wdlTjB6ANtDXpyo0EDY
 veQKydDTBCRJlxSfWboMfHI9po8qzn3Cm/db2zuDqe7+Z4e1MLL5FHPVuoRqwn8qvkQVgItfRa9
 iE22otg5li/PAmwbNzBfF0OSHFaCkBTLY6lp86W3RQhylU8g2XxGu5HiZDJn1lcKUnz+cppZnC8
 TJjXog1+WG0FOEewwbkvc3W7iEDku/Ok2tZgNzpoii8cBp6U6AsbAagTL3+6cV/2HRR6FmF5M71
 zGXIqtaFQEFLS2JsoBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-19_01,2026-03-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603190094

There are no one and two byte this_cpu operations within the kernel
(defconfig). However even if there would be the s390 implementation, which
uses a cmpxchg loop, generates a very large code sequence due to the lack
of native one and two byte cmpxchg instructions.

Remove the s390 implementation and use the generic implementation.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/percpu.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 44501a407e6d..b5b61471439b 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -51,15 +51,6 @@
 	new__;								\
 })
 
-#define this_cpu_add_1(pcp, val)	arch_this_cpu_to_op_simple(pcp, val, +)
-#define this_cpu_add_2(pcp, val)	arch_this_cpu_to_op_simple(pcp, val, +)
-#define this_cpu_add_return_1(pcp, val) arch_this_cpu_to_op_simple(pcp, val, +)
-#define this_cpu_add_return_2(pcp, val) arch_this_cpu_to_op_simple(pcp, val, +)
-#define this_cpu_and_1(pcp, val)	arch_this_cpu_to_op_simple(pcp, val, &)
-#define this_cpu_and_2(pcp, val)	arch_this_cpu_to_op_simple(pcp, val, &)
-#define this_cpu_or_1(pcp, val)		arch_this_cpu_to_op_simple(pcp, val, |)
-#define this_cpu_or_2(pcp, val)		arch_this_cpu_to_op_simple(pcp, val, |)
-
 /*
  * Macros to be used for percpu code section based on atomic instructions.
  *
-- 
2.51.0

