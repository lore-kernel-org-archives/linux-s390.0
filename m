Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0BD488229;
	Wed, 16 Sep 2026 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789594465; cv=none; b=kElL/WDgFd25dswuzK4AvcEoT3WtMExog/Vj3gqqdf2OCSKt8DKoYR8cntJ+2aJBmnPozWe5ppHWH69nTPsFke8IsthlZSWs5u4uUK60jslFDeOepUwifdLEX4fj3o4TKhj67zh+AMwijr4jB/ZPI2JMZcx/O3Jh6nZM0gPmBUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789594465; c=relaxed/simple;
	bh=OxnRcXJLxFWHA/hZj4hIW4fVA48+PAX9Dgr+SJ7h00g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHM430/mztaCQhcgY9BWOE1+XYqxzUNPpdPitIxjvOJq+bOTgbAzw0GO8skbCNOzwuUQTcPSKuf1o/09iv+q3CFMoZeZgg3/qiYC/3TQi0SvqoQdgvtQI4mX1+HFJeMokzYpnm7WmunLPJ+mZp5YnorgUWofkSiFmtMSiDHw/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hzIQvAI6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hzIQvAI6"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68GG1Y0F3041096;
	Wed, 16 Sep 2026 21:33:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HqAw7R/fQ8z6iOXuW
	jMtpQGnqXsXvOym+0CvIVMs8lE=; b=hzIQvAI6GjYi7Z3t8gcHTmaHwPQm7xc1p
	BSB9RtaUEmVVtPGAniVtB5RPDzmXNQEoUYbA+7y/vGUomEGDuqmukibWlbEqzP0q
	04As0gGB4sEj+fvZ5UHOZANDkCvupayllYPQ4p+nXVMRoVEiNfQKlsUkBjWOZMkr
	nH+v9pIxfjAHTr7TEIsBy1c5pozGS8wHLAyoiwTc9YbyK/bk7Lu9HDCjlidkKI85
	BIkVizJrp/MY0X2cl8RAWoSKB12bQ9KigDEAg5hbf1yObIVEl03rubg2MHYlhrDG
	d2u/lgiQm5ApxLrHSUeK3IWL+Df0NP+if2r034IEHX3WlXrTv5SSw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmw5e6u4m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 21:33:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68GJ1Ovx1625860;
	Wed, 16 Sep 2026 21:33:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gpyxsgm6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 21:33:57 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68GLXt8Z30147182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Sep 2026 21:33:55 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3B84D58062;
	Wed, 16 Sep 2026 21:33:55 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E7CA65805A;
	Wed, 16 Sep 2026 21:33:52 +0000 (GMT)
Received: from Mac.ibm.com (unknown [9.61.251.90])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Sep 2026 21:33:52 +0000 (GMT)
From: Omar Elghoul <oelghoul@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: oelghoul@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, alifm@linux.ibm.com,
        farman@linux.ibm.com, gbayer@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, stable@vger.kernel.org
Subject: [PATCH v6 1/4] s390/pci: Hold fmb_lock when enabling or disabling PCI devices
Date: Wed, 16 Sep 2026 17:32:19 -0400
Message-ID: <20260916213222.233-2-oelghoul@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916213222.233-1-oelghoul@linux.ibm.com>
References: <20260916213222.233-1-oelghoul@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDMwMCBTYWx0ZWRfXx6OZl6jzwu2a
 hP6JILMGlDr7AtjWXnSGAhSBwOEuapCtd8yWBqzkzdk94b2W0CvsoopeSLC5H8iZAUSgPpDovdt
 sGom4v7HrssIKaPFV8rWYRq3YsMqfjIquZpu9XwgZD0IHySFenTaxKpueGSICDSHO/nv8m2Nmdh
 hgttIcOeNLGcgULw2c8fm0DgMdZqmSYxMkdIe5c6IEEMeQLTZFQeEGxapf70dcR9OWI3aLwN9LV
 3/KtzrKUuU2/kDZsm26vyAvHZW92cMSIKgxAZFxT7UGhvtwDYvXNUamqcLXUC8BmegCpKHm7R3d
 ZZqhUfnCICrJLThq+dzadvYl0AUr0TaSvxkbb0FTyMYIbjPaToXdWKiczCslPJI9VE5rzxkqcHa
 NSNR8sfeTMKAG8nuVSgHRPcAMYgPpx5T+IvmyEfsHVOv/1Z2Y1K4wWpwYD6oLtZPy6rYPpEWwJm
 4Lp9fOkbNNmt8QbOTcA==
X-Authority-Analysis: v=2.4 cv=E/NYNqdl c=1 sm=1 tr=0 ts=6aab0b46 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=5NbLduwtq9nBFWGw9KEA:9
X-Proofpoint-ORIG-GUID: ogkhzlbF3YJhBJMImhqUKBzov9GWgPNE
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDMwMCBTYWx0ZWRfX07zupqKskldX
 sxmqJ8QEen6Sr0EUgcreWKLImxSpD1sq2PkKsTMRsoIKpd8bl+dkg20fjVo1o/helieEC0zyBcN
 1vibTM2LzH2bjL6ZUx5j5JNGUFFmk4c=
X-Proofpoint-GUID: ogkhzlbF3YJhBJMImhqUKBzov9GWgPNE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-16_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 adultscore=0 clxscore=1011 bulkscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609160300

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

