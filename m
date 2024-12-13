Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE601974EA;
	Fri, 13 Dec 2024 22:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734130200; cv=none; b=lZKqS2gWGG8AAOpHMf43fAgS/0tEq434zOOD2HVm+nSfzqGKJfW0s34WLtc6xtd6dLekEc0DxdkEK7XyYEj2E9rR6Z4az8JX8H8ATCgtI5HcribfJOb3chfJwibBqLKl7e4ltsmPlP2t4zR87J02lwOc6y+ygKNFOXsi2sRq/aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734130200; c=relaxed/simple;
	bh=NCk0yGwQrnKmvHRbI2bE7MLBd3R2lKVj5OYRusrX2RM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OIJykT+JgHnqid8TfOXYH0zzaYZp/6ihjbt6s/G2oSFyVI198TfymBH11xHo22k5+3HYaNffu3UWsZXUThAB8cek+ApDYIGicQtz0+02Df5KphxQRztKbfbyhmT/jiY7lnb9xhoqtuqmuZVz787+4rLyG/2/70UZIBBW9xH8Y8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NjvB3Uou; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NjvB3Uou"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDGfQnm021825;
	Fri, 13 Dec 2024 22:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=MY998Sh0WfeOsaRpEzyzi/vZus1Qqzr8olSoeFQoS
	yo=; b=NjvB3Uou7DMPpWZLBAczJ3Jc0+xNhAwdYd8kQUHVaDNvkXkQUTdLHJ1oq
	W3lIw5pug634Tqr0WHEDOgJraZ62j+Jp0Ol+1Oj2J0KqZgf9b+ActAL/xVoAAyQP
	R4aS57aQs88ATDqVgdJf+j5IgPjoo+VwbXFBU37VAsSQ73tWjGCOLOk5SU/d28kl
	TbWhlKoTwce/J/YVUfbhhJ49xvSAHjU1H6/i2NzlEgcRFCcMNekKxn2N/ByXA/7P
	vb81zCfUwltaXC1+ARkiHfhkTWZusjWIHo7Ryx2N97tlZ/kPFiTYEPZu2mVqL9tZ
	jcJkOlJWOqdiZmTv0tDFZdnVPqy5Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43gddmd05b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 22:49:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BDJbxon032760;
	Fri, 13 Dec 2024 22:49:45 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0pt0amu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 13 Dec 2024 22:49:45 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BDMnikO14746228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 22:49:44 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 381DA5805A;
	Fri, 13 Dec 2024 22:49:44 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C79958054;
	Fri, 13 Dec 2024 22:49:42 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.107.222])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Dec 2024 22:49:42 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 0/3] iommu/s390: add support for IOMMU passthrough
Date: Fri, 13 Dec 2024 17:49:38 -0500
Message-ID: <20241213224941.571060-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qVPPdSX-m9oL6y8ck-MZjQ46n6gldSff
X-Proofpoint-GUID: qVPPdSX-m9oL6y8ck-MZjQ46n6gldSff
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=684 suspectscore=0 impostorscore=0 malwarescore=0
 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412130159

This series introduces the ability for certain devices on s390 to bypass
a layer of IOMMU via the iommu.passthrough=1 option.  In order to enable
this, the concept of an identity domain is added to s390-iommu.  On s390,
IOMMU passthrough is only allowed if indicated via a special bit in s390
CLP data for the associated device group, otherwise we must fall back to
dma-iommu.

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
2.47.1

