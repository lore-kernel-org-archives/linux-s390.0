Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7499F1850AF;
	Mon,  9 Dec 2024 19:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772259; cv=none; b=eToqA5fHHO+5wfcdo7de9GuwzEERe5FxQOKq82zAp4AhzQhEuIc+8DWgb4wzREwkM75ObmroLvTTH4dzvKDXAZTWJOT7fTquxx2WSZgFjvvGD8Wm+ACxcmC090ac99aDrJ5+/1ZN4KKwe7cV2u5Wh0D3LEDY1OiOcCCyt96t4vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772259; c=relaxed/simple;
	bh=u50d26RvbtfcaZDxSeP0KgsaZLJEbWoUHpAH7IDGEBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kYD7EwMzbqLuqT4tVo0Vvu/iST6LDHG/mihiXHVM36Oa3BgOacRpGhHfmKswjQ2NzgKgHh8uNJ/WsDaoKmn/Esar24W8xMzkhaJTXuRLL3ao7F+RGDs+qOzHfDcMezd1Mb7rWEIjdcP//K+aR9cCqXm3JkKE7fdUsxRCniDgXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nPmwaYue; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nPmwaYue"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9CD7oK011164;
	Mon, 9 Dec 2024 19:24:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=IIYYVux+1iMONKF0yPGBAnVmD9qlPsySTVsLN6kNI
	Ck=; b=nPmwaYues2zOvimfhSz/7Q38h1gY77PJoy7yR1/nYjtlH3KRRJ2xTVoUw
	a2npi8y4hNFB7HdJMQdw8qAJ68T+i9Yns9pW2z5ymWVG4o0tK2umkiqQizxQz8iB
	ossZ2MfCMtuQusEtv0uc0CsiDmKMfD3ArqTTo1fqrH/0mt/g9qgUwb3jua31Wnhh
	6PBFEAffufU3qlBVf296KbCt/ok+Q2A7d6VntXb4R4Sw8mcB9T/Z0at20cG4Wcq5
	m+puduk6LCYrp9l7YRJ9DnYiuDTY6ewkZE3CSAVJoru9uSEYpn3K+/5P1mqTAEm+
	abE6uxvPx3YMs63oTkqx23I7cjNeg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xa6bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:24:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Hgq6Y032739;
	Mon, 9 Dec 2024 19:24:07 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0ps89ja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:24:07 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9JO6WX7340672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 19:24:06 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EC0E5806B;
	Mon,  9 Dec 2024 19:24:06 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 847AB58065;
	Mon,  9 Dec 2024 19:24:04 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.107.222])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 19:24:04 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 0/6] iommu/s390: add support for IOMMU passthrough
Date: Mon,  9 Dec 2024 14:23:57 -0500
Message-ID: <20241209192403.107090-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JyeEx5IlrMzQ6eHTqj9k_W4m4waSpOv-
X-Proofpoint-ORIG-GUID: JyeEx5IlrMzQ6eHTqj9k_W4m4waSpOv-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1011 impostorscore=0 mlxscore=0 mlxlogscore=417
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090147

This series introduces the ability for certain devices on s390 to bypass
a layer of IOMMU via the iommu.passthrough=1 option.  In order to enable
this, the concept of an identity domain is added to s390-iommu.  On s390,
IOMMU passthrough is only allowed if indicated via a special bit in s390
CLP data for the associated device group, otherwise we must fall back to
dma-iommu.

Matthew Rosato (6):
  s390/pci: check for relaxed translation capability
  s390: enable ARCH_HAS_PHYS_TO_DMA
  iommu/s390: implement iommu passthrough via identity domain
  iommu: add routine to check strict setting
  iommu: document missing def_domain_type return
  iommu/s390: implement def_domain_type

 arch/s390/Kconfig                  |  1 +
 arch/s390/include/asm/device.h     | 12 ++++++
 arch/s390/include/asm/dma-direct.h | 14 +++++++
 arch/s390/include/asm/pci.h        |  2 +-
 arch/s390/include/asm/pci_clp.h    |  4 +-
 arch/s390/pci/pci.c                |  6 ++-
 arch/s390/pci/pci_bus.c            |  2 +
 arch/s390/pci/pci_clp.c            |  1 +
 drivers/iommu/iommu.c              |  5 +++
 drivers/iommu/s390-iommu.c         | 65 ++++++++++++++++++++++++++++--
 include/linux/iommu.h              |  2 +
 11 files changed, 107 insertions(+), 7 deletions(-)
 create mode 100644 arch/s390/include/asm/device.h
 create mode 100644 arch/s390/include/asm/dma-direct.h

-- 
2.47.0

