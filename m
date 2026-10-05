Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758B34A0913
	for <linux-s390@vger.kernel.org>; Mon,  5 Oct 2026 14:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791209675; cv=none; b=JKkJ/ei+FE5HtJJOaBr1AnhKMioNqq1fy1V3USA9gafYJhFDlBEjcay4dvq/Pqt94IOh2ZctzNfpOdVS/X9poShjGXZJkCaFJ37SGKCf68qSsIQgrU0bZVd+KQwcX+DxbUkZuz+xF31H2tjFIZW5m8dHUOMTQAQlfoGbDvN7bd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791209675; c=relaxed/simple;
	bh=f+me4vTaMOCwag8WpYAZUj0guennGkvVt2IargiPn8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oyvc2qp0a8fw5bxRRI0ALm1SP0VrwTvpddhOEgKNZioXut+9F4BHBJuvHPG9pxRBCASg3A5bF+CeqoKPfprJiBoyU9EAmLCP7qdLi6XTAR4j7OSPeTof/zNdt0cuctDHJKbm/5WknJFB+gBrn8hapBvWOaFkzJZd6fF7eadLUf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eT2iPcH+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eT2iPcH+"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695CZfa83623564
	for <linux-s390@vger.kernel.org>; Mon, 5 Oct 2026 14:14:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=w5qdiQ6yl9MpWAA0uxQnk5efBYa2iIAC2vPchsaj1
	Ss=; b=eT2iPcH+TYfhZzIafGBo+YN9FOwjZuIMmEEcmF5YayEEWq8lYddT3aD59
	yLNcYpEs2XMOrjBPGbUSpFdJdv2aKvCEdJnbwhvT5xvg0Zq971KYN+x/MC2DJxHO
	bh4mi3l+yh401hI2Oy3chPcdaT1GJ1u1k2vDmRnOWzqbjRKXIteR4OV5RE8Lw3pC
	52ob0pThg37S+gjgJYh0KGHby3ITDRpiL4WbQph+q7lBpsZCKkAupjHHcIwrvXsR
	kXXVHxDnjQ+XkbThBXkqFo05J4xD4oo+eVYOvENhGxa3puAinlrxULmNJFr9rq27
	+HtGhBs8KmTjlSMx0qQpcQnOY6uVQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4ft3vy-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 05 Oct 2026 14:14:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695CHpaj2913127
	for <linux-s390@vger.kernel.org>; Mon, 5 Oct 2026 14:14:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3eqy5j4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 05 Oct 2026 14:14:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695EEHqw55705944
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 14:14:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4408D20043;
	Mon,  5 Oct 2026 14:14:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 23A3320040;
	Mon,  5 Oct 2026 14:14:17 +0000 (GMT)
Received: from funtu2.ibm.com (unknown [9.111.167.168])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 14:14:17 +0000 (GMT)
From: Harald Freudenberger <freude@linux.ibm.com>
To: dengler@linux.ibm.com, fcallies@linux.ibm.com
Cc: freude@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v1 0/2] Rework cpacf_kma() function
Date: Mon,  5 Oct 2026 16:14:14 +0200
Message-ID: <20261005141417.65822-1-freude@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac3b0bd cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=e8S0QdtimCeowGomMgIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA1NSBTYWx0ZWRfXwlfeI93u5CcK
 eIVqeFE1R87zrKQDGeKWopj8CRVGee/X28CWZc7puym7cYFARjYgWVHF+S3pDOymun3OOnUPD+Z
 7KGXEBmOWEWW/Y9A35x2fdy+XY4sNt0Sj+viIXb4kR83ttAEH2ORH4YBMgeDdoLhHeeTDDyQ2dd
 EBPu5bzTrqKJh6Wo5w72HA5r5R+1/n+gUvsHQEwrrjoXvmtHzhZ+16+WJNy4d+WAiYfIDDVk026
 2U8jdufaIkxfftyIxp740n6CjwaMG2PYll2WxDGPNqmxwAe4TEP9dyjb1IGFOvB7B+M/vVQXtu/
 6JsbpY8YjtMxROS9QoRADg/7XjDiDEUA/z8/UG7S6YBLH8KRF+QbemYrJbUoGWIorf1NZo7QDNe
 nUq1QuomrgWRW++jA34q2Zf0Ib1FQ9QSd1jIfu7/Oy9VL2obrRKs4GFVYpxx3278vzDU9PoZ/XX
 Xb6eoIbSJki+QlvqBcg==
X-Proofpoint-GUID: 6lETAGzQphxdN6VK_JsCQUvMhJNq85ZU
X-Proofpoint-ORIG-GUID: 6lETAGzQphxdN6VK_JsCQUvMhJNq85ZU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA1NSBTYWx0ZWRfX1XNXYY/ur+UE
 VO/QChZJWwfv2e4SvVFLuV81fJo/lp3oMpLif1/hiFpGe3c8i86qZwnaJbpJ+jVj7PBxHPbT+vn
 3HSknP6/YCGwS/mMf8Vjqdjb+E3JtEg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050055

Rework the CPACF inline function cpacf_kma() and the only caller - the
AES GCM implementation in arch/s390/crypto/aes_s390.c

Changelog:
v1: initial version

Harald Freudenberger (2):
  s390/cpacf: Rework cpacf_kma() to return condition code
  s390/crypto: Handle cpacf_kma() return code

 arch/s390/crypto/aes_s390.c   | 11 +++++++----
 arch/s390/include/asm/cpacf.h | 24 ++++++++++++++++++------
 2 files changed, 25 insertions(+), 10 deletions(-)

--
2.43.0

