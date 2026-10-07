Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F3E345ED2;
	Wed,  7 Oct 2026 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791381592; cv=none; b=tAgxP0djmeJbAtYFQ1LvgyUMHfynMqoDwtMw5wtxw4/wZaIdNYyIIMXr1KNRAdIGe/CvY8ws7K4VeDwft7wlz50/qo9Ve6movEqOFPxsbOYkda79oZT9r2qOIXyXfnG2+RLSWW+HnY1VOKS8tA/9jijEk2g51gXSkXDjuQm/u+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791381592; c=relaxed/simple;
	bh=rwZ+Lm5Tiad0gHsdDiPGtrmBxgP9Yj3MxexhXGckhWw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AimLj0l1/XNCm/hHB57I/q0paV68d2Ikk07CD4is743ULCPYs1c+T8748hq+t5oOh6aRXXngtKxf6mRv++7sNQ2BQFhH4okuPFCNpdC2aWeaOi81GL37oAoimlYglZcmhlFzM7d1cpRPPZjMIG6UpOOXgwmgrsonxvn1I0i58gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jh9lyIaP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jh9lyIaP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BZv7T2463474;
	Wed, 7 Oct 2026 13:59:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ugy1MPPX4rX1hKJ3I
	u+kcccg2ZINH127EjdwX5suMt0=; b=Jh9lyIaPBguspkPrRReZ8FRTQfFa24TIo
	nuaKDiAgwl8bRPlVzRG2tnAYUfZkikoUcYgpqOgCeG2ud88O57UavbJ+CZj2zcrZ
	BHD6Ke9M+rW84yrWNj7CXQ1SXFAd4jmgoMxRGLdVQwCXC4TzLk0sh/nnrexAjoFt
	K1Kb1Z9LmxE+WUj9GuWGg4fHptT7U+ZeQHzyvxEedh1N14TftI9LZ3mUolSqoQVD
	3tEqEGLLNUqFhOOFpugFQZvY5SHc/rXgy4sil9yJGMgkgWraHP20EIqXxEbbl3aC
	bhgysa+utUVQOK0vMqdZ4K0ZTIOpA2to59y4LgHs7d8hfXVtRMLAQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2s74wuqs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 13:59:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 697BX7xg1852611;
	Wed, 7 Oct 2026 13:59:40 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgxsr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 13:59:40 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697DxcxR13632176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 13:59:38 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 96A7058056;
	Wed,  7 Oct 2026 13:59:38 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A342D58054;
	Wed,  7 Oct 2026 13:59:36 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.253.231])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 13:59:36 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        stable@vger.kernel.org
Subject: [PATCH v9 1/4] s390/pci: Hold fmb_lock when enabling or disabling PCI devices
Date: Wed,  7 Oct 2026 09:59:23 -0400
Message-ID: <20261007135926.82935-2-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261007135926.82935-1-oelghoul@linux.ibm.com>
References: <20261007135926.82935-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H942ptXNuFKGO2NcGL_mLpdTd4-7SC43
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1NCBTYWx0ZWRfX1IfWCzf6PL9I
 0JXxTuSibUHAPuKmDYm91OngNZ7sJN0fuR0lZOVB7e/Jzoxl8vRkHETObV+JtUXMqk6G86ZX1qu
 t7lAAm0CltS6aZuA/ArL8yPJ6FaXGbU=
X-Proofpoint-GUID: H942ptXNuFKGO2NcGL_mLpdTd4-7SC43
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1NCBTYWx0ZWRfX0DLQMKad9qoR
 pJp8YhwFXzAb4YWeo5oVJkIjljQnm9mzCIPCdklZjrtN5wFtxUNC0oWXMrNBuxOPInerFprj3KT
 UbrdssKkvWHrPTC2vJNqwmSsLiOwekPWds9BaVF3tDGwz/OrMEeeGis4CP8e8aMJtmAuPaPegRT
 p5GlkLetYHi+9QepAkokWfFA6Xrns/gDOQhWbLDNv+MzDPfOHjmmX+edoRn2P29Q9Pap6TuywY0
 tY8ujE5s20M0qxXs2GACAO9UgKR+oFjumUUKguSdCnneV12BaR17c2FD089NSal5zXcuieBq3uF
 5fvy9yc8VEdQQT3OsnxGmdDKJ3I0IGD6RD3jPIsuMhZXKVrl0Ekb/VtlHbWR2QgBVIscYDg/3mG
 M7ujH2KqOvs2DwJpeUaSv5wVlx83XAoYH3nbVcfI8WlvXdaDj8stplvgClYC1sYP+AVwY+RYxS2
 hVPSvEjPHkQH/BAwDOg==
X-Authority-Analysis: v=2.4 cv=fM2sTpae c=1 sm=1 tr=0 ts=6ac6504d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5NbLduwtq9nBFWGw9KEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070054

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
2.56.0

