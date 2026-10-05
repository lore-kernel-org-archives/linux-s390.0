Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41333B42DD;
	Mon,  5 Oct 2026 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791201813; cv=none; b=KRxaZTdJCCOv6Pwp4zMZPz1InCRfjNzzmOICydCXdWiD/JJ3I42guIhfkCme+EL/LBj5yUzGQiZal5RSoS6w9AKo51onnDb3d2FVHfZEDrAsDMOIrRQbIPRGdlqoS2DZ+EAr45IYhpPzHfi3wzrZavQuFxVQZbvkvEYHciR163Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791201813; c=relaxed/simple;
	bh=lG4Bk3v3D1enr5LEgG+UgADQfDx0GXYlXzWchnyH3ps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Xi/vQWaSbOWvDb/msAdTabn11hw7dptd246mhtUSJ9F6Y3dUGAxpKHaY3fAGKUmUroEQPebdDRY5GKzOkjUzV93aO+OwI2zHXHWse/ku1DsWOCHrCDN9pXHiLuL/Nb8Qa+ec4CF8W3CP7uv/2CWJrZgeQ/I9FMdFQi5JXQ7AoqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iuI1tMUl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iuI1tMUl"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 695BZxU82911178;
	Mon, 5 Oct 2026 12:03:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dX8jQJ
	Rd5Bg5g3fUC477hrufgGvknLdXXFJAnu0EHxg=; b=iuI1tMUloydfaLCkReVjcb
	zRSZq1IwqOHWE0q1JPmwbNp2YrBIbwgH63ys6xZdpg4x8fUVc183hCDYx/7Wj0a1
	rJwiGfQlwivUDnHrRYx6L0NCdDViWC9+pdIW6QFRIFAIofARXNbuAXruvwWo33Sg
	NlXzpbDZEMcUryHu3I4xVP0CwTx249IJK1RB67oE1x49tWFLjsc3/HK4QEgirfjT
	fTyccpmEcXo6Orjs54qvInbRfsSYFwINC3JGcQcdOiZkPwDkpGIse6a7AY+woClV
	UCCFM3UOTZWzA87K1PcvGLgSa7dMbou84ZGzmIFuv0CcCWs6UDiyA1zBIpAwIIpg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2scra24v-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 12:03:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 695BlU6R2843447;
	Mon, 5 Oct 2026 12:03:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvne5u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 12:03:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 695C3Pce25625226
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 12:03:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9F5CF2004B;
	Mon,  5 Oct 2026 12:03:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FFAC2005A;
	Mon,  5 Oct 2026 12:03:25 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  5 Oct 2026 12:03:25 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Mon, 05 Oct 2026 14:03:20 +0200
Subject: [PATCH v2 5/7] s390/pci: Add error cleanup in
 zpci_directed_irq_init
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261005-s390_irq_domain_fixes-v2-5-d45b824874c0@linux.ibm.com>
References: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
In-Reply-To: <20261005-s390_irq_domain_fixes-v2-0-d45b824874c0@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tobias Schumacher <ts@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX2exaQ8QiRmhd
 QhsioJOuE+G40hyOORB+3Dm/yPFDWW0E7GeLy/5unKjHMmrJwUs/wWKgmq3cAZnvT1czzanuJgB
 wI0TkQEfdQTqkYrtaXt5ESdRDKAocyY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDA0NSBTYWx0ZWRfX2fpPeXnmoKT3
 3zFvEG77j12raFx26XYXer8Sh40VF67VbO906sPfPIFTbIcFrfyy+3OqvXW7D2ipULyLOxFTbJf
 UiegaSJjkXCUvF2c/8HbENSnS3PjEw2yXkrnfHhpKt5593+AA4zrpwr0N7Zcf6WQp4KBquwXHyc
 PXj6S+mvINc4jiGG7Dszct8eppSZBuk1f305hivw0AYQe4XWJRSaIxGd2X8hMOauIw2uyrqbnl+
 uWtL5A/idW/ObxZtwGYaIeudclcQX9cw+RfsupMbAZztMYZgWpbm/bseaQY6TzFrAqjo+xrs5//
 jFN1bSDlYvk/qABu6dPbhLp+cmt8yUrMcjNJoe1Xh1aH+OsADwQU9RjGHwbQ6Ki/AavweT443qy
 2eG4kdq/rwa7jmXj4OzltzcNz0RMxy/5rlvMu3UhS84n14vUHho420MQfJzQuSpesp4P9Tq0uur
 fZozr3riibgmyqHGzfg==
X-Proofpoint-GUID: A2mj2rIzxF-KifUwJQTkkgotjkMsbxno
X-Proofpoint-ORIG-GUID: A2mj2rIzxF-KifUwJQTkkgotjkMsbxno
X-Authority-Analysis: v=2.4 cv=B7osQ+tM c=1 sm=1 tr=0 ts=6ac39212 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=bp1g5Iz1D7c7guLF1_8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_03,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 malwarescore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050045

If per-CPU airq_iv allocation fails in the loop, previously allocated
vectors and arrays leak. Add proper error path to release all resources
on failure.

Fixes: e979ce7bced2 ("s390/pci: provide support for CPU directed interrupts")
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 81a27bf756a3..682bceb6525e 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -576,7 +576,7 @@ static int __init zpci_directed_irq_init(void)
 
 	zpci_dibv = kzalloc_objs(*zpci_dibv, num_possible_cpus());
 	if (!zpci_dibv)
-		return -ENOMEM;
+		goto out_free_sbv;
 
 	for_each_possible_cpu(cpu) {
 		/*
@@ -589,13 +589,25 @@ static int __init zpci_directed_irq_init(void)
 						AIRQ_IV_CACHELINE |
 						(!cpu ? AIRQ_IV_ALLOC : 0), NULL);
 		if (!zpci_dibv[cpu])
-			return -ENOMEM;
+			goto out_free_dibv;
 	}
 	on_each_cpu(cpu_enable_directed_irq, NULL, 1);
 
 	zpci_irq_chip.irq_set_affinity = zpci_set_irq_affinity;
 
 	return 0;
+
+out_free_dibv:
+	for_each_possible_cpu(cpu) {
+		if (zpci_dibv[cpu])
+			airq_iv_release(zpci_dibv[cpu]);
+	}
+	kfree(zpci_dibv);
+	zpci_dibv = NULL;
+out_free_sbv:
+	airq_iv_release(zpci_sbv);
+	zpci_sbv = NULL;
+	return -ENOMEM;
 }
 
 static int __init zpci_floating_irq_init(void)

-- 
2.53.0

