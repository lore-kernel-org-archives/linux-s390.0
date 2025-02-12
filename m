Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AFE202F6D;
	Wed, 12 Feb 2025 21:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739396078; cv=none; b=DgVaqxvkBEt5IQrxT/Z3r2NnThjVY9X2HbHkFY0LlapH3fcHZmpQlAJpTMAuyx9DL8zFIcBtiiIjwWuhp2DIjlqyP7wVnvMXZGndeCJYygy9CqsSMoiFw0c06O1pin2gzXeLIyYqxOYpufdOTZcXAWm8v5w8QUBtC6ICkoQo1ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739396078; c=relaxed/simple;
	bh=fzERoalNNXp/hmizWvEuDSArp4eamDZD6SV8xLCFnvg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mFM+96PsKhIqc+S2/J5kfl+hBUcA4SHAE121MPPIbL1MKAGZaq/0M/MsBKVEGODcbPcwyTBJzjxbJxGlpk+n4NxsnpIoeV5cDvlsPIxyzFWgAqBQRAFiRIF+YkQ2T+Y55FCIwmVtXAbfSGyB4zB5FeeBBF3EWwt6hOCXRHwYXDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qtDmKaS/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qtDmKaS/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51CKGGfx030209;
	Wed, 12 Feb 2025 21:34:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=MgBTRAm2qlJPQpFVXIko132bunUaVhteRudWPVi7E
	cQ=; b=qtDmKaS/QND1FLaq2CHccAYvt3EpqeaIgNcG+ds+rjYnrZyPBJlclhtgN
	7NQmFI121Ig3lwz/olAaLxevcBsK1OW/I9ELZk914nr31sXuYOdONzT69/lFt4e2
	QymGUS6zsQsbopPgvxZmCAC4qhiwzSLoQex6YJuphBgfK+jh4iivVOm9LMVzQcij
	/gcyQL7vM30VHoI8yn0h6t6ghVIyjomDuEJxZaMExIIcNFnpNTFV5uW16D+TPhGU
	CAZlnWIVrzRpwmR4ILuSEO/m9yOr9llT8RKUftLchyHAq4piyxAg3o+LSKnf5H89
	TDJKVNiLWWlxY2Xd6xUEbbdU2mSCQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44rjfywmnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 21:34:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51CISi6L028244;
	Wed, 12 Feb 2025 21:34:21 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44phyyk53x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 21:34:21 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51CLYKK427460106
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Feb 2025 21:34:20 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C5975805A;
	Wed, 12 Feb 2025 21:34:20 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4C74F58056;
	Wed, 12 Feb 2025 21:34:19 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.186.234])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Feb 2025 21:34:19 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v5 0/4] iommu/s390: add support for IOMMU passthrough
Date: Wed, 12 Feb 2025 16:34:14 -0500
Message-ID: <20250212213418.182902-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c8Zv0tFLzrc5MeB81vmbhQJXWciR6Rc1
X-Proofpoint-ORIG-GUID: c8Zv0tFLzrc5MeB81vmbhQJXWciR6Rc1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-12_06,2025-02-11_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxlogscore=689
 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502120152

This series introduces the ability for certain devices on s390 to bypass
a layer of IOMMU via the iommu.passthrough=1 option.  In order to enable
this, the concept of an identity domain is added to s390-iommu.  On s390,
IOMMU passthrough is only allowed if indicated via a special bit in s390
CLP data for the associated device group, otherwise we must fall back to
dma-iommu.

Changes for v5:
- Fixup error checking for bus_dma_region size
- Add review/test tags

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
 arch/s390/pci/pci_bus.c         |  25 ++++++
 arch/s390/pci/pci_clp.c         |   1 +
 arch/s390/pci/pci_sysfs.c       |  11 +--
 drivers/iommu/s390-iommu.c      | 138 ++++++++++++++++++++++++++------
 8 files changed, 168 insertions(+), 67 deletions(-)

-- 
2.48.1

