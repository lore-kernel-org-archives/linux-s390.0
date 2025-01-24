Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E84318A93E;
	Fri, 24 Jan 2025 20:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737749855; cv=none; b=MScLVUInpaPV1Bq0KqfTYxzliF80rFCNBd/jylnWNxzOHPEFwxrzl/sMSIA2W92Kqwt2GuZy9jTXMs3TEjpazXu2dQgZybeOPnZx86v1VA2qPQvtaPGSxJ3K4NmWa++Wzs1tgcnWAzdJD1qloVNRGDTYt21+rZtefqcyLGSQg00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737749855; c=relaxed/simple;
	bh=cSdBeqSdI7/awkmiroRIbKwN4Ne0/4Tk7FghcFFLVZs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jgcby/3Ul2lbIY+h/CetewCzpjoBwdFTNwZlX2rb3/+Gl+Qwh1qxU4R7B0pIkkKjI4Gm8/sbUrOJ0P54RPJy7Z4yuIwze99WkVv9THz6KVm2Ur3QTi5/O584/2Zquy18Rz72jPgMtLwCmPE1NR0giM3daUC+V3bV4feKOaGiXJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DVaOjRAF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DVaOjRAF"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OF1JPp017605;
	Fri, 24 Jan 2025 20:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vOg/PwTm5ybAaNIlaLLNyh8w/gQtdPpxqLvXcxRSg
	FY=; b=DVaOjRAFz4epYK/Tq62I5xoUJfhN9kmsM86M3u0Nc9sv8aUH3QR08NsFh
	F+txWcMhr7ZLSnDtDlppYW5E+1ocwZufEaI8tEA89ntnb/AEf05buof5Hk+7SqBK
	VnfNj1b0jdcjuVeUHea6w7DkG4Te+tIEgpqW6p8LbYWx4BAOWvFswl+cdEawliqC
	fZ6l/WoVgh8miXNVMMxZXHPi9eJEhU1iy9/veO9JzCY8c7jg5pjXnTm0+pVguawW
	qmfwHIAR1Wj/A6ec9RGQOuc1nin6jumkE69ePhjhXKhmgxQsV3olV6O7LzgcglqR
	dB39r3M5N2paLzy6b5L1TYo3iXjiA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44cd4yhj06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 20:17:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OJIxUE024231;
	Fri, 24 Jan 2025 20:17:21 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0ynd9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 20:17:21 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50OKHJoS57147738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 20:17:19 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AEB758045;
	Fri, 24 Jan 2025 20:17:20 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 496A358054;
	Fri, 24 Jan 2025 20:17:18 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.77.196])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 20:17:18 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v3 0/3] iommu/s390: add support for IOMMU passthrough
Date: Fri, 24 Jan 2025 15:17:14 -0500
Message-ID: <20250124201717.348736-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nKIbAKcaBXOWq4iAI7AVgcYnI2_XpGEd
X-Proofpoint-ORIG-GUID: nKIbAKcaBXOWq4iAI7AVgcYnI2_XpGEd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=662 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501240137

This series introduces the ability for certain devices on s390 to bypass
a layer of IOMMU via the iommu.passthrough=1 option.  In order to enable
this, the concept of an identity domain is added to s390-iommu.  On s390,
IOMMU passthrough is only allowed if indicated via a special bit in s390
CLP data for the associated device group, otherwise we must fall back to
dma-iommu.

Changes for v3:
- Rebase onto 6.13
- fixed bus_dma_region size (Niklas) 

Changes for v2:
- Remove ARCH_HAS_PHYS_TO_DMA, use bus_dma_region
- Remove use of def_domain_type, use 1 of 2 ops chosen at init

Matthew Rosato (3):
  s390/pci: check for relaxed translation capability
  s390/pci: store DMA offset in bus_dma_region
  iommu/s390: implement iommu passthrough via identity domain

 arch/s390/include/asm/pci.h     |  2 +-
 arch/s390/include/asm/pci_clp.h |  4 +-
 arch/s390/pci/pci.c             |  6 ++-
 arch/s390/pci/pci_bus.c         | 18 +++++++
 arch/s390/pci/pci_clp.c         |  1 +
 drivers/iommu/s390-iommu.c      | 95 +++++++++++++++++++++++++--------
 6 files changed, 99 insertions(+), 27 deletions(-)

-- 
2.48.1

