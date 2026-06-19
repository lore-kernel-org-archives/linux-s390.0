Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13411283C93
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781855149; cv=none; b=fQ0VVUXZ+bqZ8BZfsvRm4UEeSJIiLFZzArrAzfT2OBDj26RPHAyV8x+xdn8a/Ix1cu1xgjOnvQG62d4x8DSPcfxmA/tmvtpvMhN6tim2/LGPHvDP/2FG/weVMsK5S9i9+y0p+JnSGoWYXantCCXUDgBeMf5SdYv/dPf8V/KEqgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781855149; c=relaxed/simple;
	bh=vUGaapOMlyFCFkRofut58hqriJVRBiRb0HTqAqTfdUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=anra7tLCdAhnXM4Mel3bLouuO/kVIrufFZpJDSzxTZTAcF5toU5EuX8QorMrs9OZGZZkyZMNwlRUjBNqzFk1/8iwSOD3sUsmH0Er9RJ+2ofBIEM2GvMK878uaf+UcxgLwR4lsi31EcXSaWm0dMFFlffj11S++jtMDwPYviuEQ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=niytXHSL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="niytXHSL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J3ICN91283250
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 07:45:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=OdE2mEWfowseThKTX0LCAdKCfJ6bNYlihSjtwxa5Q
	Gk=; b=niytXHSLv6ovOi3l933C7BI18otWtJItSu40TuAKCwdaDkMtvBflEAMBt
	rPU+qEhtCIpeQGhrRkv/GwZV7wN9K6LjWFtJH84Tvk9Vod1s3tWYLHYP9EbjF/MF
	clH3b0GCyqYWbKE83WfcfsI+4xzVA27E/GMO5rKSwYsY49S7om2rGZ6ymEiT+Ixi
	CH04k5OhgmXe/QKQKpA6fUe5ZL6v3KkaQVjgJk+JfqWnhA7ieeqEhUzaBomHyzmY
	cjpRmHuoray7cSGkigrbL83WzPeYzC4J7Lvw7cqoIvoeeQQ0bvK+tFqus+6dxWmw
	rNhwi3pPPvZiPjpjiMR+dOg9tBPGg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequcces-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 07:45:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J7YwZQ015456
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 07:45:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev1727sfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 07:45:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J7jg4O50266438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 07:45:42 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3A6120043;
	Fri, 19 Jun 2026 07:45:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3867520040;
	Fri, 19 Jun 2026 07:45:42 +0000 (GMT)
Received: from ibm.com (unknown [9.111.75.212])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 07:45:42 +0000 (GMT)
From: Holger Dengler <dengler@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>
Cc: dengler@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH v1 0/1] pkey: Fix for PKEY_VERIFYPROTK ioctl
Date: Fri, 19 Jun 2026 09:45:40 +0200
Message-ID: <20260619074541.1710716-1-dengler@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA2NiBTYWx0ZWRfX38CgoJfyjK04
 AdqIV1aP5+ThQjFgl9ads9yQ5ZQEQisQX0jQ3gX9u8wzTkAe0CFX3rfM1KXBGNNeP0LB7mHR+wW
 IKmlxRKm2FY59aXrf7s7JVaoP9myQYA=
X-Proofpoint-ORIG-GUID: -7ENX2GHIdYySIgBKCJQ0VbDt3djLSEE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA2NiBTYWx0ZWRfX5OMYU5U+zvC+
 VHEIzKLyw+AH9sD42YouJjcYnep3yoQRclW889yrIAEiS26RPsraux/KUpwXRYd53fej4bL3jG/
 z+HJXMGtS7McuYLFAaqx/wrqP4s1ivXuMKqisaUxd3QSuLLxbUmiChtZvzo9CyMEyoU3fsLnco+
 S4+FpGn9j9mcypxkwBHKhYG2ipu2fVZmYRtxNtenRx73DTLauqAzJsgPbZIl+y9usLCnYS2vMwb
 YaoucJ3ssi3ryf2yVTjdQSRG69w5H69oXMulVUHj+W/tHZDdkBWosJwjWRxBsg91UPHH6iqi3IZ
 kQbzaKGkoR3nDnypjNYDZuNOeEyOYwZeJFTmuoR+ZsYQqabG9FL9Y6pA0u74/PvFOuERwrhqItD
 5fwq8Q5+dPFndkkkFlAzqgLp72xr/ZzTTwdkMHCma2VFxI80+4roCazlmNycML4vahxjNNxR48d
 pcFjHBIJOxpIouN+NYA==
X-Proofpoint-GUID: -7ENX2GHIdYySIgBKCJQ0VbDt3djLSEE
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a34f3ab cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=riL-3Q2HSPCSva3yo0gA:9 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190066

The PKEY_VERIFYPROTK ioctl is used to verify protected key blobs. Part of
the verification is the check for supported keytypes. The following patch
1/1 fixes the keytype check in this ioctl.

The patch applies to Linus' master branch.

Holger Dengler (1):
  pkey: Fix bitsize check in PKEY_VERIFYPROTK ioctl

 drivers/s390/crypto/pkey_api.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


base-commit: 9ecfb2f7287a967b418ba69f10d45ead0d360593
-- 
2.54.0

