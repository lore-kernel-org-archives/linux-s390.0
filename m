Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78C83ABD8E;
	Mon, 20 Jul 2026 19:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575521; cv=none; b=D1JBPpHUbR4MbmY98kQNkNZmY4IARMZAi8vfiPTIWFjKJfA6LyhhFT1ursm5UU+iM2sOylvdfoGQqgz5g83U8hBcG4WfoQ2C/rJAhX77ZpI37OHVxqvckoCOPSyvBOUOk1MHEQa6o4zTig5kXKKmiqaNCQmaBKvPnnqBJq7lJsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575521; c=relaxed/simple;
	bh=cX5TZtvSZwarWBI5c6PMZ7i7miA4OLjgPxAssK4YgaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJ29+no5LWLf6EqO508SZA80jrrNkUgST/UJ3/FsgHf6i+d+33PfQ+ww+pp/9aWycePtsybDB3A3iSzolHA2E1kcEEu3GTkfYQ6E/4W6IAM9Ec/f3kCPoLY8lZI7ouIDPJtyxd23XKUOJ4QWcvt++NPrkWm77l+Rf2yqzuxyWEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T0Kkbw9Y; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T0Kkbw9Y"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHBwxW2731473;
	Mon, 20 Jul 2026 19:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vXU3DidQiGyzHYE/9
	ch2T/ZRaHPRlcHfwPGBi3+olgE=; b=T0Kkbw9YL+WQKZY6n1b3YLqsY7mNyQTrj
	xz3d7anMUc8iUiAnjLZkJMvQBa1rgC3+xUdV34WrEy6o1WJSDosPC6/rPC4w8Z/M
	g2BmiMIXAuP4MHgHXlPDt7IrrE7PX25ArsDi4MhSK9T8rLv/3Pbl8Xelkc8wgJo3
	5Uylbm0l67lOfDcQRDL/0Uoovsy1GA43snTNi6j4i1tFP35sa521twektnqDGshu
	pO3YqUarBexgBeLHyyiav9tUTuN7hckj9DtMeLYxJ4NOGhOYqsimVN2MIVnxPNmB
	8BBtIdoQoJ7YtpZrq35mtjgoI/cBgOAB9Ck34nJEplYMr+2pHPK4A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77k0v67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 19:25:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KJJZWK019247;
	Mon, 20 Jul 2026 19:25:11 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgm6vy517-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 19:25:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KJPAio328444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 19:25:10 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 445915805B;
	Mon, 20 Jul 2026 19:25:10 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C8B858058;
	Mon, 20 Jul 2026 19:25:09 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.255.209])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 19:25:09 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v22 3/4] PCI: Fail FLR when config space is inaccessible
Date: Mon, 20 Jul 2026 12:25:04 -0700
Message-ID: <20260720192505.2957-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720192505.2957-1-alifm@linux.ibm.com>
References: <20260720192505.2957-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HJXz0Itv c=1 sm=1 tr=0 ts=6a5e7618 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=1owyFLT6pZZ0tE0DW5YA:9
 a=zgiPjhLxNE0A:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIwOSBTYWx0ZWRfXzKKmhqlBXQgu
 XLnIP88UDV6RaWll19UvC9MBChhuAy9SDDJf76K/pk06RpDHPKFi774SYf9Rz8UM84Dft32LkLd
 uCU0Tm5+A2qKGujfMXshaGtXpuBjAaz4PqlqUHP/yy9t9EywWRTnlIAIELhJlqHQkSuMXDHYIli
 h52ZQCjUrCurYQH5LAInh69/gEXZ9emk881WbPpMA26bvOISGji7vTioeHXZCUWykCYCJyiDqO4
 umpHDKm1qFKwSE7VflVGzfxmNjubdHk+TKLAptNtvqjP3xrAdFPcAkQBn7foiCDNgBhg8oIh/i2
 tQwxDrRGCnpA/zcimtnyesRBCC2vW2km7iXn7s4iYCUG2jWY8hl7My40KVtPOm1xZv+o82E68Kh
 aPLpCHZa84S2kzxIolAGE3vr+wjY6DhicU3FnoWW5aNK/xtOFnFspuZwuNKNfKYrcLnA6zpqORA
 EKCGBO8kqEcUr8QS/3Q==
X-Proofpoint-ORIG-GUID: V-BKkZF64b8tfOnZYXBHFbm4Np-9dLcz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIwOSBTYWx0ZWRfX1SIC8xyQU7cL
 dCsqv7Dqm63vliJHBYzmtnlI+riVe/LDxZz9Khj4IvxT2lSkOD86EoEXTmZnnUJaXGDLK9Jf7Mk
 cozqNtdb0TkVGeE9FESJWg24dPr7oW8=
X-Proofpoint-GUID: V-BKkZF64b8tfOnZYXBHFbm4Np-9dLcz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200209

If a device is in an error state, then it's config space may not be
accssible. Add additional check to validate if a device's config space is
accessible before doing an FLR reset.

Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e8d7de77241a..9a9d021301c4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4384,6 +4384,9 @@ int pcie_flr(struct pci_dev *dev)
 {
 	int ret;
 
+	if (!pci_dev_config_accessible(dev, "FLR"))
+		return -ENOTTY;
+
 	if (!pci_wait_for_pending_transaction(dev))
 		pci_err(dev, "timed out waiting for pending transaction; performing function level reset anyway\n");
 
-- 
2.43.0

