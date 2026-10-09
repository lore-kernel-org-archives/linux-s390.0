Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C0A439F86;
	Fri,  9 Oct 2026 06:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791526660; cv=none; b=NzeJQUK5ZDinCiL4GJ/eW7aw4RckKp2KsHzWCR86EIr5+iZx4wjDK6n+VeqsrPP5eimtApmgeB3dZYtdqalzq+xTZCIh6YemL4ZNGDxGYdoofUfUjzmuMGn16DLoUPy8ijaWSt4Z5NRNGGQbY4SLgD8CZZt9iL/1/DPfiwh4pcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791526660; c=relaxed/simple;
	bh=nfq30sp8PnfhC7cwPQALoGRy7KTBLGA+SML6Zeqt82E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Myy/Jsa3i0tYs4beNTxvrpxPUTefMvotSBaFhdW+49H9NLHXFjT8z8R/iR47BIE1yq3mcxm1lXkJfEDyomItvG6Y2FKBCWVVh6EMMCBR8K33T0cPkJ7wz/Y7jUNVCFVUHJiMFEEOWBDqH75hi8G0JsN9SOyU0L/+9F+eYt7QSQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bDpYbR3C; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bDpYbR3C"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6993ZWcc3061630;
	Fri, 9 Oct 2026 06:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zGY7Pd
	tYaV04t91cZZfMiVZIExrkENDyO4AhDoo4X3c=; b=bDpYbR3CtNNhvqyLs1Atyi
	eoeaVRToCHyGryOOiIXArky6s/1NsHB84ZDky2/THddpqsWU9zEj0DQbp3J3dK3b
	4STnPGq1shjFqfxddyLtGD/qYhERBOr1ydTzZDusT4Sptb9oWeq4FgmyOAGajvV0
	Ma2SMgFg2mHqUi9tow9BGeA39V3obvJE68YvdqGtB46Z82IxytRGZw91kUhNaCCg
	siCXOtOC+FLBtGaHN8LGfxEpH06nM2x68vKfTQJgNRjnWSeWY38q/FueqvjCondS
	SYRp7DOI4ruQOuzA8d+aeVSKUSdRS8mbW5XzY/S1xoiQU577+2v6ceJmmFdXQ0WQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw87nn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:37 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6993HbwF290535;
	Fri, 9 Oct 2026 06:17:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5a6dtn3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 06:17:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6996HXEl42926376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 06:17:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7223C20040;
	Fri,  9 Oct 2026 06:17:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C10B20049;
	Fri,  9 Oct 2026 06:17:33 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 06:17:33 +0000 (GMT)
From: Tobias Schumacher <ts@linux.ibm.com>
Date: Fri, 09 Oct 2026 08:15:49 +0200
Subject: [PATCH v3 2/8] s390/pci: Fix resource leak in zpci MSI setup
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-s390_irq_domain_fixes-v3-2-ced19028da3c@linux.ibm.com>
References: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
In-Reply-To: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfX//G9WJCOdaGT
 LpliFJKyYZHbTfy55zdIJKJamuq+1UzYey8Pn7D1gvoQSNdhtJyC+xMm9Vyo9I1pgFxWIC/o6T2
 EcXF/2I40CllZyrFU4gUyiQFjVz90pE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDAyNCBTYWx0ZWRfXxr+GCpdwmIyH
 53bC33QIDRmVS95+MGPhtVJcHrsqyxiY/p9/ybP9lHkuqMuKdWXowSuVvK2ryLy+gwrYkPkv/GB
 Nzxs7ywl/ccvATRpn6cNKuxPr5xlmZtzeXbqrVjVVkKS7bFqayHL25JV9yyhwWVuWoaaDqLV7Fc
 XuRC05XBgxSuW+vB9Aoc611VOVCoYdLO4zfWjR1c4rSu0baEGdtvwggTUkPFTjnWD6+Gn7yq0zl
 4ETb05135IddzrEWG9vkKTt0+61N6YwWDdfRLXNp5wVqrQ0tDWmR+nV4pbuE3iQBLOHgWQ091h8
 6K5TNwD83BuOqi9VKshxRQogxjBBOyHZWhDuSBS7gUGevafHZUHXI1Bkg65pb/u3LvF32lrLUA0
 kaBVe0nHwYchLrBRzfdlGJt/aKGkxxjVQ9pH96jSKxgY8YAzpPBO3Me9CWqO0jgLnx615fWs2cB
 Yp4CLu18XLi0LMm6Jlw==
X-Proofpoint-GUID: HvfjII0gClUPC-rLV1LolBdNAk_p5Yxe
X-Proofpoint-ORIG-GUID: HvfjII0gClUPC-rLV1LolBdNAk_p5Yxe
X-Authority-Analysis: v=2.4 cv=XcwcX455 c=1 sm=1 tr=0 ts=6ac88701 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=fzb7yXF3lHBN6XHo5OoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_02,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610090024

If airq_iv_create() fails in __alloc_airq(), the zpci_sbv bit allocated
by airq_iv_alloc_bit() is never freed. This permanently leaks one of the
ZPCI_NR_DEVICES summary bits, reducing system capacity with each failed
device hotplug. In systems with repeated device insertion failures or
under memory pressure, all summary bits can be exhausted, preventing new
PCI devices from being added until reboot.

Add proper error handling to free the zpci_sbv bit and reset zdev->aisb
if the AIBV creation fails.

Fixes: f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ domain API")
Cc: stable@vger.kernel.org
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
---
 arch/s390/pci/pci_irq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index c9520a16ca75..134f8f4a5cfa 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -313,8 +313,11 @@ static int __alloc_airq(struct zpci_dev *zdev, int msi_vecs,
 		zdev->aibv = airq_iv_create(msi_vecs,
 					    AIRQ_IV_PTR | AIRQ_IV_DATA | AIRQ_IV_BITLOCK,
 					    NULL);
-		if (!zdev->aibv)
+		if (!zdev->aibv) {
+			airq_iv_free_bit(zpci_sbv, *bit);
+			zdev->aisb = -1UL;
 			return -ENOMEM;
+		}
 
 		/* Wire up shortcut pointer */
 		zpci_ibv[*bit] = zdev->aibv;

-- 
2.53.0

