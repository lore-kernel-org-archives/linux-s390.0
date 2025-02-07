Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA09C1A8F97;
	Fri,  7 Feb 2025 20:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738961633; cv=none; b=rBLx7r/zczoydKXzBL2ilNsiNiw8nM4bnZfYym1Jxda7mAgfNgerMbdauRGSoiUqywCeKjH5prx3fgW3pXJ2NVm1bXKDjAyUXhoejDIrcS87rJEhFpvAGmOR1IuSP9xH21Ps2rQaObTY4rGGxff6ODi2nkug6UWdwljblrI3WnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738961633; c=relaxed/simple;
	bh=+XE1Gibj53XUdm3yvQ0U9Wn6es8t7Fa+pXS6zzOUfNg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MpNFnbEY8P/vnqpDdd2F+nO4p09m82LJgkNFKa46pKvwy9jwQhBZSA2QsjRixuFc/kCQI4+Zn6Hcyspnhf5IFLfBW8UmcV35FCSTP3NlouK9wGgzKrPU5RdOukRnzPqW6LhUm3p1kLhVI5KzHg9fSI47s7Ihz2ocN45fnAWkVDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GI1AQyIw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GI1AQyIw"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 517C1Apo028647;
	Fri, 7 Feb 2025 20:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=MaC+iU9MwJfPXnKDmF+0wEXepTZYUvrOmE2qOB7q+
	4k=; b=GI1AQyIwClkwioyBaIHD43FEVX9dHg8HmyBRc4nY2vLz6U3xKzTeyhQoW
	1M8+0FY2aoXUxAr/AgaCHgfdqvGAPC9IsPagI+PVaYkl0X4n5bLHSmD2J49duVRX
	Dp2c9rp+lr3KaXLCPnPOZfEEHqDpoaClF6ZuvzDAjd0i/hfzpayvRwCncYLc9G+V
	1ywm2HcZiC6Li4WV4s3LKYxwG393V+Zw4lwOmWhQ1zdm0qdWQCkTNDnIemAscaoP
	977JU40Bpri/yv51S3EDmWk46AnEYXKS2lZzm92wKKQLAurWuxi1CGZ4WxHGT2JR
	VpzQtt8uCzZ6k4PaAG4o3bZVjKZ8g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44n910d1q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 20:53:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 517Hq4Vp016391;
	Fri, 7 Feb 2025 20:53:38 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44hwxswmne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Feb 2025 20:53:38 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 517Krb8x16646810
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Feb 2025 20:53:38 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C36758052;
	Fri,  7 Feb 2025 20:53:37 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02DF658045;
	Fri,  7 Feb 2025 20:53:36 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.30.101])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Feb 2025 20:53:35 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v4 0/4] iommu/s390: add support for IOMMU passthrough
Date: Fri,  7 Feb 2025 15:53:31 -0500
Message-ID: <20250207205335.473946-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lJAzURkSLHDBwagGGbtFvD0Sxd48ofPT
X-Proofpoint-GUID: lJAzURkSLHDBwagGGbtFvD0Sxd48ofPT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-07_09,2025-02-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=651
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 spamscore=0 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502070153

This series introduces the ability for certain devices on s390 to bypass
a layer of IOMMU via the iommu.passthrough=1 option.  In order to enable
this, the concept of an identity domain is added to s390-iommu.  On s390,
IOMMU passthrough is only allowed if indicated via a special bit in s390
CLP data for the associated device group, otherwise we must fall back to
dma-iommu.

Changes for v4:
- Additional patch to handle IOAT registration within s390-iommu.  This
  fixes an issue with re-registration of identity domain during events
  like zpci_hot_reset_device
- Fixup page alignment for bus_dma_region setup
- Dropped a few review/test tags due to above changes

Changes for v3:
- Rebase onto 6.13
- fixed bus_dma_region size (Niklas) 

Changes for v2:
- Remove ARCH_HAS_PHYS_TO_DMA, use bus_dma_region
- Remove use of def_domain_type, use 1 of 2 ops chosen at init

Matthew Rosato (4):
  s390/pci: check for relaxed translation capability
  s390/pci: store DMA offset in bus_dma_region
  iommu/s390: handle IOAT registration based on domain
  iommu/s390: implement iommu passthrough via identity domain

 arch/s390/include/asm/pci.h     |   4 +-
 arch/s390/include/asm/pci_clp.h |   4 +-
 arch/s390/kvm/pci.c             |  17 +---
 arch/s390/pci/pci.c             |  35 ++++----
 arch/s390/pci/pci_bus.c         |  18 +++++
 arch/s390/pci/pci_clp.c         |   1 +
 arch/s390/pci/pci_sysfs.c       |  11 +--
 drivers/iommu/s390-iommu.c      | 138 ++++++++++++++++++++++++++------
 8 files changed, 161 insertions(+), 67 deletions(-)

-- 
2.48.1

