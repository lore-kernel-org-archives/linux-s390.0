Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B98F377AAF;
	Mon, 27 Jul 2026 14:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785162542; cv=none; b=Ny4wJlbxJhcQAWB8CXIwBtYPu1UMESa2PNKdEGaYnw0FC4yvtIaWS7A1JdI+O8KmNMYR8JaNvloDQHP3GBZ1QrbxPCvEqhVTww1ZDDhpfsdAh+b5oYgwTFRYVtHU8k5bj6DgtTVUFuSmsKzEZIIvOor677sCWti1Xln6LHUM2Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785162542; c=relaxed/simple;
	bh=7x4+zMALgGMoSiWBQXPJHrNRUmmJ9dpJBmHpZzWEEoU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bxn8fn19cOuSFixItFqCVEz733YiMNle4KCNLvNpil4fAY/pl6z7GAd1AaK8D1BdjxBONQEn2zrGbLvwwAjmV/TLu01ROxCEA66z5IPrxI4GHXmpazB0UepivG9+caKtH/3RxZsvkGynybOt2QdLajBCRiEIn0uCT7+0AUeH0hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=otrbPhoE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="otrbPhoE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDngJZ2299023;
	Mon, 27 Jul 2026 14:28:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ErIAIykcR0gD78hE610r/aa0D1P2
	3JeBNEjQvCSSiq8=; b=otrbPhoEdmY5QD1SkmPAAYaZBorXg7zYokVDaixUqGku
	gLjdM0GXyO1nZL1fpARboSvuBNeRZXzT/KKtAEqd/wEuqpibdq3S9s+h35N40tkA
	GshfQIfS+19mN/rLW7NG4tRj5BOM8N+4NV3xF/fcLpwTZBEwFXIptlMaoNCOVTCe
	AlsSNO6+cGm0ooBQRMRUp0hh8t8QOF00YITySZH8zYrN04LQJMPl4uVeedhUqZRx
	B7duScVC8UNExT2hK3neiiCVSRuFdXxSq6SUWbbNjcX8ZhTaPGrbvzY3bvEBFhkD
	tFxLoPDzQYHwReVAof4BKpV0S+iUayF6TOukw7Z8oA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj02gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:28:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66REQJQR027660;
	Mon, 27 Jul 2026 14:28:55 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fjwr1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 14:28:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RESnw750331964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 14:28:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55C24200C9;
	Mon, 27 Jul 2026 14:28:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2DE00200C8;
	Mon, 27 Jul 2026 14:28:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 14:28:49 +0000 (GMT)
From: Stefan Haberland <sth@linux.ibm.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/3] s390/dasd: fixes
Date: Mon, 27 Jul 2026 16:28:37 +0200
Message-ID: <20260727142840.567286-1-sth@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX4zOx9JORodH8
 wbMHgWml5v7eO0uxuwIEC4UD879cLKBR4IJkrm4HrTSXKjAuLDSaoiJ3FTqFjbE85mRz9ESjEZP
 Rx1J7ZcGFsSNjkIz7Ocs3Peg0/gLLk0=
X-Proofpoint-GUID: pzHQULJe8cDTaW7cwu5QlZf3nZk_0t1z
X-Proofpoint-ORIG-GUID: pzHQULJe8cDTaW7cwu5QlZf3nZk_0t1z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDEzNiBTYWx0ZWRfX2QgL2quilwzn
 0xvLBi0H4NHyuKJlre0rWEU5NcTvlVfc4UW8Z8l04GBy+kDlOP9YfqrneB57RKqy9HipqS4s963
 qMvS5VL4TlKEgCmdipTW3u3wgFhLwoTB7bEc7Sk4pzdEtZm0ihrUIzCIWcApBhAEeD6lq0YjPcE
 9hgpxoELT/g8fJWBPfivxNIVDlgMu7Swz6fLQ634eX8/zv+8XmStc/GiXcoBwEonlzijpsiJ6HE
 wigGeGjwrGbaMZ05ADc8M47f9IrD+avjoXVPdf6nD3SxvkyD5mhDC7fdhmacjZmY7MNHB17BJij
 i2NBK7mai0sS9ZdI2vS9qln91mHYFqrr0P4adee4XUnM9vp1bjv1iSIFUL+R0e8PVs3a/c6S0WD
 lFV1C5UyqrFe9Cx4oAik/I+rziDi+vNDJrVckB3NhLtQ0qOv6vXoMvpZgin7+kWkoVJ0zOW4OKl
 k6uvQyzDcEti/ZQyqnw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a676b28 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=yTgE9w07y7j8ZUCElcEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270136

Hi Jens,

please apply the following 3 patches that partially address rather
important issues in the DASD driver.
Thanks.

Jan Höppner (1):
  s390/dasd: Fix potential NULL pointer dereference

Stefan Haberland (2):
  s390/dasd: Fix path verification interrupted by concurrent
    dasd_sleep_on_immediatly
  s390/dasd: Fix undersized format-check buffer

 drivers/s390/block/dasd.c       | 14 +++++++++++++-
 drivers/s390/block/dasd_eckd.c  | 11 +++++++----
 drivers/s390/block/dasd_ioctl.c |  2 +-
 3 files changed, 21 insertions(+), 6 deletions(-)

-- 
2.53.0

