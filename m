Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD8F388880;
	Wed, 16 Sep 2026 15:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789571684; cv=none; b=p9nwltfgwfnpiAkg/+7Ub1ROtQQcvhNsYLmn/vQ4idD854Z/XUFJBZW/zuvQQTSvhgxVshbYZq76EUQc16Ua4jB1pVazQNIsZQbm6Sa3a5B4R6wYsKnub0bnlzTM3mKHyLFbKuQnA9pb+5WnL1uXcg2cAHUPSFaSk36KKwl4gig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789571684; c=relaxed/simple;
	bh=Lq/6OUOvjHVlGLDK+8BJrdYXAhZrDn36TsSaj+l/Ln4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ryj0fFmrYvxXDyotTMG4Kh0UDt8exs2oHvGAx7SmnLz00TCCwJR56XjuRmUWujyc+TydEH5jpRsrEFfqM7g0bFCf4oIJJO0hdXsV5wt/t8uzBqbmDj5wlYQiw8IhW0V2xrXPwaYA6NvDlGca0C7OaPBCZCkhgwqEH9c5YJzVLFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HiN5P5fc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HiN5P5fc"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GEVtHd4047050;
	Wed, 16 Sep 2026 15:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=l6wq1Q
	N85BT9MEE+00dtKwkd7PGC+aUahqx6NHyxgw0=; b=HiN5P5fcOw1E3Efrf7K7e/
	5CUgi7FCEWETElD//EUNd+hbkLqeZqIP8RwRuw0ywIK11lqu8Y/nEJeuAu0SmNMF
	s9qeP/epzFRGiRKGTdy/+QF5joQJcGKMGmh89OGSr4Aad//WdnyacOEHSEINXteo
	79Ynjpk8yCPJIpXp2eoAPAO0AXcq050pw86Kz1D6N9OBVdNz/b1XoXKYiX+LFZS1
	ETCT8zrc32I0qADt+8WiWQcEB00FX9d5Z6pYkvFa6pAvJowZolVHu0UYwORrWngH
	v4W9kyBlIwD+T386tPJ6J76j8KXZ8b2foNjIS1HbEAg2UeyX8s9oMtLhegfk2PWg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxcv4wtu-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:14:42 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GEaBjb2520780;
	Wed, 16 Sep 2026 15:14:41 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpw6d7fvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 15:14:41 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GFEeeh47514006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 15:14:40 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 401D858053;
	Wed, 16 Sep 2026 15:14:40 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1394258043;
	Wed, 16 Sep 2026 15:14:37 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 15:14:36 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 16 Sep 2026 17:14:13 +0200
Subject: [PATCH v3 4/4] s390/pci: Don't report recovery success on skipped
 recovery
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-fix_zpci_report_status_pdev_leak-v3-4-61a2f980e71d@linux.ibm.com>
References: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
In-Reply-To: <20260916-fix_zpci_report_status_pdev_leak-v3-0-61a2f980e71d@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=Lq/6OUOvjHVlGLDK+8BJrdYXAhZrDn36TsSaj+l/Ln4=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGLJWbfILebcnMefb5MrwSd/k51o9vKZyKiv+4gvpt7fXr
 xE7fqVAu6OUhUGMi0FWTJFlUZez37qCKaZ7gvo7YOawMoEMYeDiFICJnL/ByDDj+MGFWtemm7In
 ignxynsd/vlDsL1w1aeX004c+fu8+UcII8PJBI/tl/h/MWTqRjH1Pim80drro9ymsUUu5PWEWfe
 q3/IBAA==
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDIwNCBTYWx0ZWRfX4wqn14IJaPVT
 b9j+wNoeOhTjkEz3npiw2KxqY+d+erOKhiVpOOjj+U7qdlnzZGS/pPPcBr1l/SQpYT4hgYGRiGO
 0zlsF3VV7xDQQx3od2fLaPIoxxwX90A=
X-Proofpoint-ORIG-GUID: Hfg60ZFSIllSIEwuTvE4aNay0M6sB9RJ
X-Proofpoint-GUID: Hfg60ZFSIllSIEwuTvE4aNay0M6sB9RJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDIwNCBTYWx0ZWRfX7pjydJot00mX
 WKUx2uiHsV+HLIBUPfOROHnc3mgXynSTmEWFDupH56tXPy4dPHSjXhWKZeKrsJeUJncCA4LG5uk
 d02rXRsH2UJ1KkFSdtzEbP9PVLAW0FE+eSUnyoCHp4qnxfKSyC/iuKF6ASqTTILoVHHao7Yfc+K
 nQ3GLT6Rk0MpqQFPO63t6m+6M5u/2YMeZE0SnfRJq/r/EiF9rnCUJMNflHpphy/YfEVOwF8dW1E
 KhUDdFNTeqcP0kdqfd/9bnTGjjVwyKbGFJPeZkpHRaOqNeG/O7/zj44uAc8BYWvZe3cvNskhKqb
 sggww47M/k0UDbRCe7JbH+j15mVeI98J+siEjV+T/Sy754mUvIFQd3+5dq3VZIrqjdYzJeImxe1
 82F4mn4w88A+L22yVq+IUIK1qfJIojPTw2/fkoI8mcxQFdfBtEhXjBzCpNWBI7eau0kRmS0IMM+
 xEeO2H2eiEdAXu120bw==
X-Authority-Analysis: v=2.4 cv=F+7C5ahN c=1 sm=1 tr=0 ts=6aaab262 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=p9OeIctiVzUaSuujbjoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_02,2026-09-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160204

When a PCI device is already in the permanent failure state, recovery is
skipped, but the SCLP recovery report still shows success. Fix this by
changing the status string to explicitly state that recovery was skipped
due to permanent failure.

Cc: stable@vger.kernel.org
Fixes: 4ec6054e7321 ("s390/pci: Report PCI error recovery results via SCLP")
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_event.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 7b538c6ae11b..d6af4015223e 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -226,6 +226,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev,
 	device_lock(&pdev->dev);
 	if (pdev->error_state == pci_channel_io_perm_failure) {
 		ers_res = PCI_ERS_RESULT_DISCONNECT;
+		status_str = "skipped (permanent failure)";
 		goto out_unlock;
 	}
 	pdev->error_state = pci_channel_io_frozen;

-- 
2.53.0

