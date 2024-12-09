Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CDF198A3F;
	Mon,  9 Dec 2024 19:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772263; cv=none; b=G01KoRSBd6weA5NuegVdIc7XFPZY+3YDWWkAvuSGJcgIVj5+SvMqHO8BXd5AyXsReBLJcOu/mu8/90ELaN9VAgk3hKFR9en2/PdAzlpeBwxaX4zNEFWpHxRxSNninB+os9Yx5/DtaikW/n2dqgHZ7LPx3RA71a647HbnVwCNoJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772263; c=relaxed/simple;
	bh=rI19rioQDI2uPP2Y1PY/87017aOIDwnrfqz5fN6Fhcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCBsBr6FnND4rlzhW36n3jnIVlooJ4EXRCCU8Gv32bnYjDbEBvRLfpPgVZr/lBLV6U4Cnia62u4oR7D1C4WU+47IjaUvk7SxXaoKDpe4lnEkRuBkJg+vkSCi2JTnQR6YN7CZ4jddckFmjto89PFfcp7ZeE8vWNqE+0fUpDaBjRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AjkTeFbu; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AjkTeFbu"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9FDwKF006740;
	Mon, 9 Dec 2024 19:24:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UT318P9SnxrIM7wfd
	hTP+u/ekosxLEiioyvgQ5vHIzg=; b=AjkTeFbuntFblQ2IEPfQ1/GqPVK03knpP
	7PeMzVVuO4RyinQhmw33gZYbh4MId4l9Une+a0zYGD62M4yd0fidyrCNQHr02cYP
	cJ7g5VZNtIKxWDzdPbl3p3IuQfATNYQ40OV7CUYfao/ntwnmNHmSh23KNKHKKS3d
	6oG29F1tbz/OxZWyjj3Ki1ymCQNyfVW3PY1UYf8lo0rmKkwZjV4CpBFwgbEzh5WG
	Pd740oPwwjcOTP7vX/lVlpanvFX4kYU9Z1N1QE86HgcH9srgCx46pQheRufhwVNr
	eYTGKmZZo8qTHc6WP4zLGfSQXSiaC9iH+yXc0y65kb2kbSTY2w5IQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq2hgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:24:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9FXggw023169;
	Mon, 9 Dec 2024 19:24:11 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d2wjqt1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:24:11 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9JOAgs27394578
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 19:24:10 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 18DBA58067;
	Mon,  9 Dec 2024 19:24:10 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5DF3458055;
	Mon,  9 Dec 2024 19:24:08 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.107.222])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 19:24:08 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 2/6] s390: enable ARCH_HAS_PHYS_TO_DMA
Date: Mon,  9 Dec 2024 14:23:59 -0500
Message-ID: <20241209192403.107090-3-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209192403.107090-1-mjrosato@linux.ibm.com>
References: <20241209192403.107090-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: c6AMFGMkxU0zIwQi9TvZ6RgBiksb9nyf
X-Proofpoint-GUID: c6AMFGMkxU0zIwQi9TvZ6RgBiksb9nyf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=769 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090147

PCI devices on s390 have a DMA offset that is reported via CLP.  In
preparation for allowing identity domains, enable ARCH_HAS_PHYS_TO_DMA
for s390 and get the dma offset for all PCI devices from the reported
CLP value.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/Kconfig                  |  1 +
 arch/s390/include/asm/device.h     | 12 ++++++++++++
 arch/s390/include/asm/dma-direct.h | 14 ++++++++++++++
 arch/s390/pci/pci_bus.c            |  2 ++
 4 files changed, 29 insertions(+)
 create mode 100644 arch/s390/include/asm/device.h
 create mode 100644 arch/s390/include/asm/dma-direct.h

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 0077969170e8..5746d8abc8a7 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -83,6 +83,7 @@ config S390
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_GIGANTIC_PAGE
+	select ARCH_HAS_PHYS_TO_DMA
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_MEM_ENCRYPT
diff --git a/arch/s390/include/asm/device.h b/arch/s390/include/asm/device.h
new file mode 100644
index 000000000000..a6bf5e137a17
--- /dev/null
+++ b/arch/s390/include/asm/device.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_DEVICE_H
+#define _ASM_S390_DEVICE_H
+
+struct dev_archdata {
+	dma_addr_t		dma_offset;
+};
+
+struct pdev_archdata {
+};
+
+#endif /* _ASM_S390_DEVICE_H */
diff --git a/arch/s390/include/asm/dma-direct.h b/arch/s390/include/asm/dma-direct.h
new file mode 100644
index 000000000000..9391820fca2c
--- /dev/null
+++ b/arch/s390/include/asm/dma-direct.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ASM_S390_DMA_DIRECT_H
+#define ASM_S390_DMA_DIRECT_H 1
+
+static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return paddr + dev->archdata.dma_offset;
+}
+
+static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
+{
+	return daddr - dev->archdata.dma_offset;
+}
+#endif /* ASM_S390_DMA_DIRECT_H */
diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index d5ace00d10f0..ec874ba858c6 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -288,6 +288,8 @@ void pcibios_bus_add_device(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 
+	pdev->dev.archdata.dma_offset = zdev->start_dma;
+
 	/*
 	 * With pdev->no_vf_scan the common PCI probing code does not
 	 * perform PF/VF linking.
-- 
2.47.0

