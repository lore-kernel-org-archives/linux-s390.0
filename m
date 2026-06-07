Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3092F28FC
	for <linux-s390@vger.kernel.org>; Sun,  7 Jun 2026 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780849785; cv=none; b=q1+RJ5FHoOvSKLJDJ+0is+xY/2kJ+uQPtueB2qO5SiHctzYzFIOL1X7EmEKHhvOG1mw8tIdpwBxWhgF2P05Na7pEtaJSl1MlK4Y6EM7g+qDEMOtuA9rDJUW78wsl0XOPmeQlHrZkI1ZXZuzu6czRQjDDCISeDWpclGCDjJuKgOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780849785; c=relaxed/simple;
	bh=F4h7gjHGLH6+Ri6xQWyUoJPOpNu1ZybSl5G7NMzgcwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aUhjLpJIkfZAQBc+hLwUxdIBw/hXHCQb8q1KuqKClz7fFOepUHTf0wU5OxBFsWu/3LPeUGK8EuGmluf+XLF5AyEmV2StCYjs+iLRJU1Na/JP2NtM8VCdKznHyUZjrAwxDXwK6TEWFV1M9IBaUVy7U2oZgONHvhHvZCW7s+9YogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gyuFnzmp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gyuFnzmp"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6572U46p647728
	for <linux-s390@vger.kernel.org>; Sun, 7 Jun 2026 16:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=jWVrlrGUA/26K9usR0sp/xiZtM5UDGpsr07MwHXwR
	ZI=; b=gyuFnzmpH6pnY4agPFcHfvMDLagLj+PZjSUd9jcuTwQrOiD9yXpXgWlKF
	Z8w4RzuEem+RSojpOlcPxb9py36OJ2JWtjWt8LaOTt7GMu0uBoymQKC+mLLQYYI4
	IrkWPA/Kj3eRM2mLJp9TIsIK7ZLjhyn3Wo9EeehamrkSlom1c9BxC2RJ53Co/JMz
	eLVhD+eoeX+sV8dy+JJyN696PzOOYCsojptkI3smWt+I8V/XacFVfgAxsfiVMg6G
	MP402G4LcIURg4XchjaRUHFAOhjaZO/aE8AbvYvZuGpDVjvhOuMezh06AhuKPz3K
	j+tYVBePdnNWhGxUhKc1b6O8hSoGg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb95463q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 07 Jun 2026 16:29:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 657GJZq5025182
	for <linux-s390@vger.kernel.org>; Sun, 7 Jun 2026 16:29:41 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emycgsyp6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 07 Jun 2026 16:29:41 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 657GTbxn52494756
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Jun 2026 16:29:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AB692004B;
	Sun,  7 Jun 2026 16:29:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A54020043;
	Sun,  7 Jun 2026 16:29:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Jun 2026 16:29:37 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Subject: [PATCH 0/8] s390/string: Convert various functions to C
Date: Sun,  7 Jun 2026 18:29:29 +0200
Message-ID: <20260607162937.2927356-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a259c76 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=M7tyv7rS-7CcTU4fdMUA:9
X-Proofpoint-ORIG-GUID: dYdpe6P3Q6we6r43Agbq-Po_y0gjkPPK
X-Proofpoint-GUID: dYdpe6P3Q6we6r43Agbq-Po_y0gjkPPK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDE2MCBTYWx0ZWRfX+p9npAMpXYj+
 YKTYAh5rVbRaI297P5U1I7mPlnS0iNLv9R2E2z7j7MgPX95Tr7kQlTCWsfj2n700IUxkdE7FZXP
 mxySlRNi3lkYyty7j2fGqtg0DZbqJGIhDW913GGQwtdvycKtOQhJMxnSu2CwjZS9L43r2/+pfc7
 qcy6YE/Fll2nvg7vQzCU18D/Djpx53CveZIMsU6OtmITYb3m/i4nwvwXmQRZEv/pIXlWfUZKifL
 bM7/rKEY0wl7k5uK/0xs19jUD6N9WrafnZFGm3JitobtSe8Q5X99B/9uDYcvTQODmWFz1IgH+/J
 tog9DMHpzaEpUZ2gAcSU2raAUFgtWKRttsidlOMiMnvEgPzy835ApTMl67WElhNBMDsh36XoyYo
 yev+OAsbNd7iAEEbGSacMhBI1qqTLeRKXU7GDqFOYpZe5QPEORgBKWAu2F7IdWYyyjz1gVn5AX5
 Z0Nsa4ClILvYnSOP5Ig==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1015 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070160

While working on something else I stumbled again across the various mem*()
helper functions, which were implemented in assembler to avoid recursive
calls [1], when using the compiler's builtin functions.

Convert the functions back to C using inline assemblies, which makes them
hopefully a bit more readable and maintainable. Also improve the memmove()
implementation by using the mvcrl instruction for the backward copy case.

Thanks,
Heiko

[1] commit 535c611ddd3e ("s390/string: provide asm lib functions for memcpy and memcmp")

Heiko Carstens (8):
  s390/purgatory: Enforce z10 minimum architecture level
  s390: Add .noinstr.text to boot and purgatory linker scripts
  s390/string: Convert memmove() to C
  s390/string: Convert memset() to C
  s390/string: Convert memset() to C
  s390/string: Convert memset(16|32|64)() to C
  s390/memmove: Optimize backward copy case
  s390/tishift: Convert __ashlti3(), __ashrti3(), __lshrti3() to C

 arch/s390/boot/Makefile                |   2 +-
 arch/s390/boot/mem.S                   |   2 -
 arch/s390/boot/string.c                |   6 +-
 arch/s390/boot/vmlinux.lds.S           |   1 +
 arch/s390/include/asm/asm-prototypes.h |   4 -
 arch/s390/lib/Makefile                 |   1 -
 arch/s390/lib/mem.S                    | 192 ----------------------
 arch/s390/lib/string.c                 | 210 +++++++++++++++++++++++++
 arch/s390/lib/tishift.S                |  63 --------
 arch/s390/lib/tishift.c                |  64 ++++++++
 arch/s390/lib/tishift.h                |   8 +
 arch/s390/purgatory/Makefile           |   9 +-
 arch/s390/purgatory/purgatory.lds.S    |   1 +
 13 files changed, 290 insertions(+), 273 deletions(-)
 delete mode 100644 arch/s390/boot/mem.S
 delete mode 100644 arch/s390/lib/mem.S
 delete mode 100644 arch/s390/lib/tishift.S
 create mode 100644 arch/s390/lib/tishift.c
 create mode 100644 arch/s390/lib/tishift.h

-- 
2.53.0

