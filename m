Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325524AA00D;
	Tue, 22 Sep 2026 19:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106729; cv=none; b=NvkENXeC/yHpXNfyWTRYUCW79VpcrmFKmWv4/rQa/IXpim7DSZqtB0K1uBk0VeQiOtRwOCtdhdFvJOA2xD4bnK2duUNbOJbbT6Baw60eyZ9diDZjxFesBI8Gtd0+RPuiuSvQhVs9PEa/8CmyMEt1ftr8pGsoPNen40uYUj+Qg9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106729; c=relaxed/simple;
	bh=Pp7DmVHziTjsngerGzAzS9ggZnFeUelWoLtKn7VLkkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDaAWJR1c0NIRjnt0qSTDrWxGjVnw6ImmFwVHdjV0KqRpv1FYLobQ6M3d9L2q8BuYX5UfVNgIjW1yM1hxrChjURDZrVYsXVCrBBK1RxIjPHMKZVr8qBE2eDUgcyNDVmsBjLQ87ynmNnpj6ye6pVEVtIK1wIia+WjOIuOGn2axlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e4n/7rka; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e4n/7rka"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI7YaV1129430;
	Tue, 22 Sep 2026 19:52:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=l0eLohf0bZd7cQUOX
	391fnN0GQ8lLsDWvhUe+M+IiXM=; b=e4n/7rkapL8p9VU6Kw2FRsZ/PMQNbFEjH
	0RW3lMTumo2Qp8HBh2mKGboiu2sqQDzGdAWC3HgPVmnhJ2WRsHhN+CSCWvy8N6QO
	loNdmL2fMWH6R7BmrUbSEZn0ctOpfYsCgNtI9YTel8vUJ7dZO8NpvmiDjBpJsFZ8
	u4YEAEHZvqFl7t8r2p3SxjrY2AUCxKx592rRuOELj8RVFe2fL0ld/FHa75wsVrqk
	KA8o/0OmnSoD+2SZiiHN1eZAjz1gQ6wVU4DrJl2SmxLOx8HtZpJ3CWKVEwQtru/V
	6jyV7KyJie/FrnL22GvVA5c5uXMuXIdn6VsGu6sRvTWj54sC3pEwA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgs7pr7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 19:52:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68MIHXBq4187956;
	Tue, 22 Sep 2026 19:52:04 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gt7dyb171-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Sep 2026 19:52:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68MJq0hR22413912
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Sep 2026 19:52:00 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F02058052;
	Tue, 22 Sep 2026 19:52:00 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2BD358045;
	Tue, 22 Sep 2026 19:51:58 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.246.118])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 22 Sep 2026 19:51:58 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, stable@vger.kernel.org
Subject: [PATCH v7 1/4] s390/pci: Hold fmb_lock when enabling or disabling PCI devices
Date: Tue, 22 Sep 2026 15:51:38 -0400
Message-ID: <20260922195141.94548-2-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922195141.94548-1-oelghoul@linux.ibm.com>
References: <20260922195141.94548-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab2dc64 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5NbLduwtq9nBFWGw9KEA:9
X-Proofpoint-ORIG-GUID: pUtK9MOx1B4o5gEc8rvbYhz92H4Cw3-P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI4NyBTYWx0ZWRfX4ZauGVkn30ac
 D95qT4W89GF7FnruTibbSf5jpIUJV8BBmIWN45UM5BmMCw0D+ClfELeBuVMyXcJZqJPqlRBFB5b
 APEyW/wbt0ZZWV2oLlV8RzK3Hus9SXgCTxBqbdY/88yqEuetEnOLxj6Cba4UrMLZnq4VuNOngdr
 T7hoXaPFTHiONI14BVOGmMSitzJOEFMywLxPWkpLharq7H/E3uEzwCCJpz0WqwX58tXdR0+zWYC
 g5whu9lH5q6HTFgdLoZtU2j7QjEzaR84Xz188GS1sW0jtOAufTt5nrl+OkviEWgXNLJdtNL1/ZY
 /C091gVmi+g7ZrNw3ywQytPRPEJ//JJI8FnCluhzjeiNKUh6SlkUahhDX2BQOD2OQeqonJ6bDxe
 Y0rW+VikJxpvA1qw9+RmZsUjFDfUH5Ui2cjbcOt4s+DS14Wnzu/gGnQo8jE3XMsLfqzs5DkgyvD
 /UgiFTlFS9wLA9W8lrw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI4NyBTYWx0ZWRfXz59whd5j98cF
 K8zBC8muAK69RJPrApNF5nTlI+UNJTcJ/L8CcEoMGDwm0jBTrfAwcJNJ8ORooTZQw6jksXFrBvK
 FkkWRojsoMYfEeza9ARtnThQJ92Ww2s=
X-Proofpoint-GUID: pUtK9MOx1B4o5gEc8rvbYhz92H4Cw3-P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220287

Ensure that fmb_lock is held by pcibios_enable_device() and
pcibios_disable_device() when calling zpci_fmb_enable_device() or
zpci_fmb_disable_device(), respectively. Additionally, assert that the
fmb_lock is held within the latter two functions to prevent future race
conditions regarding new callers.

Fixes: af0a8a8453f7 ("s390/pci: implement pcibios_add_device")
Fixes: 944239c59e93 ("s390/pci: implement pcibios_release_device")
Cc: stable@vger.kernel.org
Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/pci/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index d64c544b32b0..c055a9ad0972 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -173,6 +173,8 @@ int zpci_fmb_enable_device(struct zpci_dev *zdev)
 	unsigned long flags;
 	u8 cc, status;
 
+	lockdep_assert_held(&zdev->fmb_lock);
+
 	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
 		return -EINVAL;
 
@@ -211,6 +213,8 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
 	struct zpci_fib fib = {0};
 	u8 cc, status;
 
+	lockdep_assert_held(&zdev->fmb_lock);
+
 	if (!zdev->fmb)
 		return -EINVAL;
 
@@ -639,7 +643,9 @@ int pcibios_enable_device(struct pci_dev *pdev, int mask)
 	struct zpci_dev *zdev = to_zpci(pdev);
 
 	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
+	mutex_lock(&zdev->fmb_lock);
 	zpci_fmb_enable_device(zdev);
+	mutex_unlock(&zdev->fmb_lock);
 
 	return pci_enable_resources(pdev, mask);
 }
@@ -648,7 +654,9 @@ void pcibios_disable_device(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 
+	mutex_lock(&zdev->fmb_lock);
 	zpci_fmb_disable_device(zdev);
+	mutex_unlock(&zdev->fmb_lock);
 	zpci_debug_exit_device(zdev);
 }
 
-- 
2.55.0

