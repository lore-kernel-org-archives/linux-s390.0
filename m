Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A573E1692;
	Mon, 27 Jul 2026 10:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785148602; cv=none; b=XPsrLSUUzUicN0AOF5K1JiuJQTkJ+FxODEKhEoShIleSmzVp80kkyLxFT0AKoiJ+oaDLP7jz8YqdB90yPUXcjBweDhSNkV1yiShvR4EoENzRfsSDT7InlTwQbxxbKE/BeJMA9n8IgmtwUUCQZAxrEnPnpIdS1Z1uwZVya0aVpzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785148602; c=relaxed/simple;
	bh=daoUDRClxVWbojePJwCC2aQxl32W6mKGEUWq7vv8rCI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=k3299knuhtN0wsepBZmmrW6Dt2qfOAhY1iScZ/Hi5THH8MZKVzd+Wox8Xtyhw3eag4A1vlUHR9ueCUAqNvBK+oPnJo2IkYzGFRHedThqSIsBIKdebb4elKyHZDOnJJtCbuaaZWHWfpL4V+4VaI3D0LD2Gw891B68a3/kpfiy5kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P9lzwXnM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P9lzwXnM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RAIbZu1837657;
	Mon, 27 Jul 2026 10:36:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=cTtr3urEBP9Q/FPKHv4WV15ioDZC
	bgUOSjG3c9nep4U=; b=P9lzwXnMoYHQOVTn/DiPXTHchufyfLM+uuWcwrHIrEM9
	JCMKejMUZV5bb+xAIMm0TOV3KSGCQLAouKsA/vqgZqJzN8V1rPuMURGTKtujoq/0
	gvYYGp1WFvubjWTa8NpsR67Hox37Vd+V8vlYW/+Uq9gFeNeGAQvsT15A3z9ML5oV
	wROk29LKysc9+oJ46p1Jug8lPyNaJ3PzwWGTjBOa8QzOmTcVHkAK1W4bNlVRQNV4
	Leyhh8B8V/EoevI4M+i1DTkFCE0j0zMyp1nSLOU3y/KJn1jgbRBd9MBGqyDQGsR1
	zlHoz1JpN9bnPdzNkge7IFsMQFO2aT6nZaUvZ3yk5g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nf3km-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 10:36:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RAQgVe014526;
	Mon, 27 Jul 2026 10:36:29 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh4wre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 10:36:29 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RAaPbR49283488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 10:36:25 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDFAF20065;
	Mon, 27 Jul 2026 10:36:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C70A2005A;
	Mon, 27 Jul 2026 10:36:24 +0000 (GMT)
Received: from [192.168.2.127] (unknown [9.111.31.34])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 10:36:24 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Subject: [PATCH v2 0/3] Introduce arch_do_panic
Date: Mon, 27 Jul 2026 12:36:19 +0200
Message-Id: <20260727-arch_do_panic-v2-0-4e25ceb05075@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/13MQQ6CMBCF4auQWVtSWmTElfcwhIylyCTSklYJh
 nB3K4kbl/9L3rdCtIFthHO2QrAzR/YuhTpkYAZydyu4Sw1KqkqiKgUFM7SdbydybATV2Fd1TaS
 1gvSZgu152b1rk3rg+PThvfNz8V1/Ev5JcyGkMFQg4rFEo0+XB7vXkvNtzI0fodm27QOTkBPOr
 gAAAA==
X-Change-ID: 20260724-arch_do_panic-a97f699aa332
To: Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEwMCBTYWx0ZWRfX+yUcBKtAnyk6
 gUBqLnAtnWh5+10iaHvVe161Wsj9F9IZxJsUGV541gTGXhSqGjSp4mjg4VzlGNVoSLM64LeyoXv
 ho5gxK7pA2Hdi1iVYN4IL5a7TtBjqH4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEwMCBTYWx0ZWRfX/9+i8xslvIVc
 rueRYb2lRo/d01ojyFWn3wS4EqjftRwQUpycmfbhyuYRNhNB+S6LH1yRtyWlDlOpjWwsQdjYj78
 Q2N/33ETBMJZa8Z1RmTplfX/nMbILvKRPdedzWS75w2SrFvKcoU59isoquJdEZyxgF1KrWgZiuV
 9Eyv0rZwYWIqBvTZE9uGpb4HApY8biMyBQpcTnwlNBItIuvgMaJNdJ0mu7gvAG8Y82iiL6Iih7f
 Yz15ta7PbTMGK/v4YKsi17RPvRKVu4b+X2cTO/ApalwdfNQfXPsFeMFrCLMFdM6TYKAwIihxgZ1
 vtK1QH1eIC7Me8sSVF7PnPN3r7ATREjy1bfHpWjhj0JifCUUESXyt8S2IdHJF6cjSyBwrSAIZ+6
 I/DLtpSKFhC6Kwxb3T/nqoxAkZ1jdpTACHQha2kCo+mhRa60ShzokZqIKnVk8JMLoKgidZAGCyj
 RAQDvjx6U+kH2diyoXw==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6734ad cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=mhgiN3pIpOqnq09bPUIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vY1kAGRH7cgNmXHSoferG83221u356Nm
X-Proofpoint-ORIG-GUID: vY1kAGRH7cgNmXHSoferG83221u356Nm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270100

Changes in v2 - Address Sashiko findings;
- Patch 2: Remove unused leftover code
- Patch 2: Mention panic_timeout and shutdown_actions relationship for
  s390 in commit message
- Patch 3: Use bug.h instead of setup.h to pass around arch_do_panic
  implementation of sparc

Replace architecture-specific ifdef sections in vpanic() with a clean
arch_do_panic() hook. Currently s390 and sparc embed their panic
handlers directly in vpanic() using preprocessor conditionals, making
the common code path harder to maintain.

Introduce arch_do_panic() as an architecture extension point called at
the end of vpanic(). Architectures can use this hook to implement their
specific panic handling without polluting the generic panic code.

Move s390 panic handling from the panic_notifier chain to
arch_do_panic(). This corrects the execution order so that the
panic_timeout is properly evaluated before architecture-specific
actions. The previous notifier-based approach executed too early in the
panic sequence. 

Move sparc panic handling from ifdef blocks to arch_do_panic(). Remove
the preprocessor conditionals from vpanic() and place the Stop-A
enablement code in architecture-specific files where it belongs.

The cleanup reduces vpanic() complexity and establishes a pattern for other
architectures needing custom panic behavior.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
Mete Durlu (3):
      panic: Introduce arch_do_panic
      s390: Implement arch_do_panic
      sparc: Implement arch_do_panic

 arch/s390/include/asm/setup.h  |  3 +++
 arch/s390/kernel/ipl.c         | 15 +--------------
 arch/sparc/include/asm/bug.h   |  3 +++
 arch/sparc/include/asm/setup.h |  1 -
 arch/sparc/kernel/setup.c      |  8 ++++++++
 kernel/panic.c                 | 18 ++++++------------
 6 files changed, 21 insertions(+), 27 deletions(-)
---
base-commit: 48a5a7ab8d6ab7090564339e039c421f315de912
change-id: 20260724-arch_do_panic-a97f699aa332

Best regards,
-- 
Mete Durlu <meted@linux.ibm.com>

