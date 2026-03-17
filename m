Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D45F344046;
	Tue, 17 Mar 2026 19:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777295; cv=none; b=DaLZQb3rFCrZCBJW2o9RCCohiUV4NLI6YWroUkjYFOi3rTB/ue5R6CUKgFzGGBkuhHSThMAgo6Tz2HRvCrMq7ANvhYv7318QWPjjCHp8unwz6zqrhjZIrzkUfrgEJBKk/MYdadlhghmjLbDcbOCz6BJPePZQx4qkMvYn3Aaeimo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777295; c=relaxed/simple;
	bh=cyiIEE70OvqU/8K935m4rjmMWeyeJ4lamNcgOtsTcvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JoR59uax89uMChTyNLiccIsZV23EUEzDy4GMZ4qmkwIDU2wbF9PPdSv9MUeJXX+ra2HSPIlHd/QnailpCbgshs+sKpRCNR5gg9WcUCNKgn3BHhsyDi//nYO8fBnv2UE1jgzph2XmVQ+w8Sh9U/LuUHCyuBwGoJpMRqcnR5U1Oq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rxPT7j2j; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rxPT7j2j"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62HDbcCG2776227;
	Tue, 17 Mar 2026 19:54:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TynVgsv2JvJtZX0Ft
	fpc707Evt8OnZ6jw+3qaze2k+g=; b=rxPT7j2jDWkUUgMGFLker+JfB6WKqaLDG
	otNdl5p6HT2snn20OTYPzWYdkKw4ov+iLEXPhTFJSfPbrWvs4pv5NPUXqEYIFGuR
	kWIpNa3EmiFe4TAGRXSn0gx1x2oql8t1+EfaJrQ/ZQIV8V9sXrPezStBvWfqchPx
	83QSKTI9R0V+Z9xbe5MJEUc+i9k69bfox8LEQBjSSuM1tl5W3vOWD3q7johOODQS
	NJZcutJk4yMiPZIVktclzub05/DgEtwN35ItajZ829cFDQ854phVGEOlBXdXDv9V
	YlcOb2CHMkdYQDYPhlE0dthdFsaGgdXJnT/kZ8ZB2rjaBfSBx/RIQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs6m87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:54:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HId3IU005380;
	Tue, 17 Mar 2026 19:54:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0sawx4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:54:43 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HJsdmn31851038
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 19:54:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2B9620040;
	Tue, 17 Mar 2026 19:54:38 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAEE02004D;
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
Subject: [PATCH 9/9] s390/percpu: Remove one and two byte this_cpu operation implementation
Date: Tue, 17 Mar 2026 20:54:36 +0100
Message-ID: <20260317195436.2276810-10-hca@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b9b184 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Q4reuYiO1UekjhQ8NNAA:9
X-Proofpoint-ORIG-GUID: oL1te38Vtt7yZuJQm4julqVNdWk7rdYS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE3NCBTYWx0ZWRfX16RCjScsw9bM
 zVSU57SboglzvWOY/cUNYT4gpzf+lZagOpB+ZziFkXx4q83+00x0H0C+lBhg1W8TnmctmlHjfP3
 vMO+7T3bmVSKt9qDC6QcDzj5vJEwKkVv3aXYa6WW6ndE9y6ZKh+QMgCd9X4/dvthfcP7V/48R7k
 +f1Sxqm+ZMw82RSM6p2Ji30NgQEXHZ6W7KwjPvRuuMWjvdjmSZz7F1qGYDXvt7aYzX/JRgTWGax
 YVk/tKHwN6sK1IRJhd2Sm8Fnm492wLxmHV4cMMSOsIUS3H4qsFKpAlBhf45izGsrM3RbeteL20s
 mFpflGAdIAuvIwgFMKdfNp9+OrfBfjcokx5sH1E2LgidBZSomO1aSIIPzrXO/GH6pLG/Ngx21pc
 F5ZRIug5OD5mXi9OIY6mRtMeNXV7+lQ10Ylh7lNiQVeW3hipsdu7G7z4HRcvLcuhMZuK4K11vKh
 2q1cQCf1Zd5Fdqq5G2A==
X-Proofpoint-GUID: oL1te38Vtt7yZuJQm4julqVNdWk7rdYS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170174

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
index 7a411b75bfa6..11c4d64ba96c 100644
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

