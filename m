Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0BC4FD262;
	Tue, 13 Oct 2026 13:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898501; cv=none; b=hWDsq2kI77D8YsN5mwX2CN0lPy+607n7dqknLB60R4iFjOMZadXqQaZ2qHrmVR+2hAstQ6JlAH9iTkwYDgPqlwssb7bcmH4M30G+VBgRjipycUCosM6JRi666193FHDVt6pnNvh6JAoZZcSbQYrJ8TCyS0VNcn344FFq3KIzmz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898501; c=relaxed/simple;
	bh=r3Nt+6lbGvVRZQKekv7x5PNCyRsJKZp6p2FAIuviPyg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dnV09aDlsdHIxsn4HBmqWYGlE8ZqErGQSSnicwBfS9u9fp9p0uLWCtHLS+jiuwzGc8zJbUQYZw/XjOTLYQ7NEpAY7PMjzI/2VFRLuDZQg+kYeeHgIAA1uye+iF9pqDkWH0OIQnTgsthEAMNm/nFqarVX8YTOxOmI9Xe+JQS4jnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ODzevZih; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ODzevZih"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2EjYi1932193;
	Tue, 13 Oct 2026 13:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=XBwvFM4LgbVsZnTTLJvjaPIKumthjRD35+keWr974
	U8=; b=ODzevZihaZ/MVWlRp2ypqIryvA77AjtaWqp/eVcHsVt8t3RUjxolpH9Yy
	F2GgI8knCiP68VC+4ajDI50xobfWMV8HNnhV+pW8PrH1DbI6UxppRnVsW1J+0D70
	hXAtCMsF1vogdzVCLdg/SItmiQ10cb/aOnXlqXbDV0X7ujEPbgA3t41iG00bUdTO
	sM95VkY866SJlQQz0FRyZuynHH4TFl/cxZ7HmfXbx0zG5F55a8w3P8F33YNHm7ei
	Rmt+oBj9wYosKOFNxybxFr+Km0Cn8DWvq6QNvfyjxqJROo1qgxxwfVJFYQpZfK+f
	qJlkJk/amDVamhS2+zbq9Dh/KeDJw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7e1w5wuh-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 13:34:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCNaxw1440189;
	Tue, 13 Oct 2026 13:34:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wg1vfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 13:34:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DDYsn241353626
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 13:34:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFA092004F;
	Tue, 13 Oct 2026 13:34:53 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C661820040;
	Tue, 13 Oct 2026 13:34:53 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 13:34:53 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 0/2] s390/signal: Fix return address handling + cleanup
Date: Tue, 13 Oct 2026 15:34:51 +0200
Message-ID: <20261013133453.2288894-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1MiBTYWx0ZWRfX5SsBl/W7ZZW+
 aBc090ZvkdMa4qjeNCKKPKYIwu1W+ymwCNpaDXS2Q9LYbiSlKwTj3bB5kZ95M/sDMMVEa18zlEU
 9x0F9hGx8dZKy0as8Iqs1YxDRznNwEA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1MiBTYWx0ZWRfXy8j0uMXC8v8Z
 E77/MqsL3tkN5VjlmcUhGPQlS3DSaK9B+DI2IizwERZBHQ8VbwUjMpwUU5ZP7aa1c5KG+HUqR1F
 CT3NDLoIPwapp7EjS9SjXmCfOFTmaHH4VntwBKQXnp7vLDn6aYdXCXlvTwHkf2taEwnguKFX6o5
 NGgEmhmCyE/tD0k2rsxemTdlZx1t4uLTwu0KxnZbwURXGa6QDFpzGfztVPg0nEfUKD268Ki0CfS
 Kc7GVCm1tRrS1qxYti0blNWpuZXoy0+tPc2IJDqB/nnpKcZpR2CCvbEDypTI/PyZYRPzojdVAg1
 jyUDXXUA3cy5lBirrRexa5SrdTMpIR4k02N2rRmx0NphHn0aRtaQ59jvzXQBhfKTYk7Xjf6pDaK
 m0Gnq8LhFrT/DXVxEjDzvVzke+GKvZdyn6cqFzLmcMcVCwWr/JO/K857eE2tpc1J0Fi5F4yWknd
 IjtzQb5uzIR9ge7rtiA==
X-Authority-Analysis: v=2.4 cv=E6pYNqdl c=1 sm=1 tr=0 ts=6ace3383 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=1CX8SnZJdBV3vg5igDcA:9
X-Proofpoint-ORIG-GUID: K78PCifkEDcopIuPp--XjJ5XDM0vYhJw
X-Proofpoint-GUID: K78PCifkEDcopIuPp--XjJ5XDM0vYhJw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 spamscore=0 adultscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610130052

This series fixes return address handling in signal frames and cleans up
coding style in signal.c.

v1 -> v2:
- Restore return code to -EINTR when building signal frame [Shashiko]
- Fix restart_block.arch_data initialization for kernel threads
  [Christian Borntraeger]
- Add patch 2/2 to clean up coding style in signal.c

Heiko Carstens (2):
  s390/signal: Fix incorrect return address in signal frame
  s390/signal: Cleanup coding style

 arch/s390/kernel/process.c |  12 +-
 arch/s390/kernel/signal.c  | 230 +++++++++++++++----------------------
 2 files changed, 101 insertions(+), 141 deletions(-)

-- 
2.53.0

