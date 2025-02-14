Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8C61DD9AC;
	Fri, 14 Feb 2025 12:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739534512; cv=none; b=JhXx9u2CNB8NkQ2Js9hpg3nTOArd1ALCK9+RRH64XA6XZek25/CXJvUP+nWxOJmBLOxRKgx6kG0s7m87iSBAZl/tQ6kOJ55teNZ3HP779dNstM2DCZ8aR6khBS1RQBNKS8VGNSIlhPcZhBAGVJJ86WLq3kXqbAI8xIK6OSudUYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739534512; c=relaxed/simple;
	bh=DR3a5kaxmwquSiJaBB+sD41Zavc+e5mAl/XGzBrb9n0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aoBnIeVaejnST8HaXZ/v7qNSQYsnuBD+iNBaoFHu3/YH9PCuaiecx9xl4kk+gvfcfr2MERsSSaS5JJvytZv7papY/R7WxeuZIOHH5b8B33Wd2nTTCTGXaUHpIYyCcgIbCLucG+7gNdwREfDO8/fGICoZX/sz6oMoZIFL5nxudd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dQMYfg+a; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dQMYfg+a"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51E7X8Kf026777;
	Fri, 14 Feb 2025 12:01:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=0wYMri5wD3qO+8RYb9X5OlgQi1LR+c2TdfqU6pruF
	Ow=; b=dQMYfg+auBWgLje8tdQMIvlMkzosgNnV1vB1QrQwGYfCA5hNa5Fy2zAAL
	9IbbkH6Iot5ZWrdRzcVEnpKWvfc3XA+KE9OGXNWzGWyOKBIe5eJkNcQM+viALaDN
	DiJFevlUr0i0oZGXGBHyW3h2kKzyPC3aHFMVWZiDBT4nrf72fe+ugozxffhkYObz
	0ZZi9ibjzM0RZWnOMk9FA4L4OlDQyS6/kus6vEalfVinC150tYb6FrcK+eWnGSRR
	CG+pCG0evsCPN0/euPqkhb05iP/MSGqGMMPbWuXr8R9OHMPlplhkkgbAL8RRtcpE
	fLmfSXkhs2PwDdIPX0j4SLCgl9E7A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44t1hps5mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 12:01:43 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 51EC1gHA028570;
	Fri, 14 Feb 2025 12:01:42 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44t1hps5mb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 12:01:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51EBeZ6n001355;
	Fri, 14 Feb 2025 12:01:42 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44pjknkdsf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Feb 2025 12:01:42 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51EC1crE55443818
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Feb 2025 12:01:38 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A11520043;
	Fri, 14 Feb 2025 12:01:38 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1723120040;
	Fri, 14 Feb 2025 12:01:38 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 14 Feb 2025 12:01:38 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55271)
	id C1781E0E8A; Fri, 14 Feb 2025 13:01:37 +0100 (CET)
From: Alexandra Winter <wintera@linux.ibm.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        Julian Ruess <julianr@linux.ibm.com>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>,
        Simon Horman <horms@kernel.org>, Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
        Alexandra Winter <wintera@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>
Subject: [PATCH net] s390/ism: add release function for struct device
Date: Fri, 14 Feb 2025 13:01:37 +0100
Message-ID: <20250214120137.563409-1-wintera@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wxKR11nYCWu0DR48hHku32rcGeGCob16
X-Proofpoint-GUID: DvEupEL37fO0OD6qxSZPPOzVq6CfMLmB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-14_04,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0
 mlxlogscore=967 mlxscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502140084

From: Julian Ruess <julianr@linux.ibm.com>

According to device_release() in /drivers/base/core.c,
a device without a release function is a broken device
and must be fixed.

The current code directly frees the device after calling device_add()
without waiting for other kernel parts to release their references.
Thus, a reference could still be held to a struct device,
e.g., by sysfs, leading to potential use-after-free
issues if a proper release function is not set.

Fixes: 8c81ba20349d ("net/smc: De-tangle ism and smc device initialization")
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Wenjia Zhang <wenjia@linux.ibm.com>
Signed-off-by: Julian Ruess <julianr@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
---
 drivers/s390/net/ism_drv.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
index e36e3ea165d3..2f34761e6413 100644
--- a/drivers/s390/net/ism_drv.c
+++ b/drivers/s390/net/ism_drv.c
@@ -588,6 +588,15 @@ static int ism_dev_init(struct ism_dev *ism)
 	return ret;
 }
 
+static void ism_dev_release(struct device *dev)
+{
+	struct ism_dev *ism;
+
+	ism = container_of(dev, struct ism_dev, dev);
+
+	kfree(ism);
+}
+
 static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct ism_dev *ism;
@@ -601,6 +610,7 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev_set_drvdata(&pdev->dev, ism);
 	ism->pdev = pdev;
 	ism->dev.parent = &pdev->dev;
+	ism->dev.release = ism_dev_release;
 	device_initialize(&ism->dev);
 	dev_set_name(&ism->dev, dev_name(&pdev->dev));
 	ret = device_add(&ism->dev);
@@ -637,7 +647,7 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	device_del(&ism->dev);
 err_dev:
 	dev_set_drvdata(&pdev->dev, NULL);
-	kfree(ism);
+	put_device(&ism->dev);
 
 	return ret;
 }
@@ -682,7 +692,7 @@ static void ism_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 	device_del(&ism->dev);
 	dev_set_drvdata(&pdev->dev, NULL);
-	kfree(ism);
+	put_device(&ism->dev);
 }
 
 static struct pci_driver ism_driver = {
-- 
2.45.2

