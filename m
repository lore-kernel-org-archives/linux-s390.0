Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A811957FC;
	Mon,  9 Dec 2024 19:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772364; cv=none; b=B91qkIXj/vHmgjRuS3oT+qbeLzcFqWBQ9PCXDJp8EbhA4oyHotISiGYtdaJTew/bEQZ5x55W88mCtMf33CtII+psz1239ZloSGO5nu+OpWm+RkpX2ZBVhpRSAZ2Hp2e1oAEgAEHoMtwCW8Q9T8H3oEBQmgEgiTGSeSY25pWg9bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772364; c=relaxed/simple;
	bh=78V5/KzMvRDdu5358sDQNxa5zJdjBP4Z0iLNQxc+GPs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PP+BmRhyFoYLHqZ0YFzdAtoNHwKUreH2WYOKILDyVWuX7Lc4BRAVnHf9fIiW44s/OnxNfqQDY8Xn0x3Y+q9bLVDycI9JNf0sp0BfhwVqtGhor9VTe2CR68RZ07P889HsOIWJUoH/P/IapYv6M000K6yRVDTyQlOma4uBbz1k264=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QExH20zW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QExH20zW"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9AZxsU001905;
	Mon, 9 Dec 2024 19:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=8kw9r4+vm0r844Sw3kUh82R17hA7TKgGuKyyP4jDp
	RI=; b=QExH20zWqSUOB67yd95OVbl3XKOwAQa9GkNzQL8iASjCue9ldYVkoSeLh
	mmhORMtd+j7xugwZq5LfX1iZxyOLHj6937CG1yjDzrctfW/xDvru99eFFEGTcpOZ
	e3lTeZPOesyNcJkVUa5HykGW6hOF7k/qyxbXd1nGprnb6PRFG4XxSgO/hFmoEHw+
	VKfvEFHh/84Zu+T7I8lWgIJvXTdB8bdt55dWUzModMAn3MxPtulCvY0HdZTT2CoK
	3FRSF5Zir4foIyD1TsDIk+sBrA/5gjWRIfUoGP8X2+S2Cq17JYN1nv4aZYb6RG5U
	ZGluB8bQIKnI45bx9GsrVLOYJZqQQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43ce0xa6nq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:25:53 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9HUnSi032734;
	Mon, 9 Dec 2024 19:25:53 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d0ps89wq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:25:53 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9JPpaq33948394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 19:25:51 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A76658055;
	Mon,  9 Dec 2024 19:25:51 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27A5758043;
	Mon,  9 Dec 2024 19:25:50 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.107.222])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 19:25:50 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clegoate@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 0/7] iommu/s390: support additional table regions
Date: Mon,  9 Dec 2024 14:25:42 -0500
Message-ID: <20241209192549.107226-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: V-XUeUEGoEZ-vlH3dkryKPbnzUMnc-YL
X-Proofpoint-ORIG-GUID: V-XUeUEGoEZ-vlH3dkryKPbnzUMnc-YL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=690
 priorityscore=1501 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090147

The series extends the maximum table size allowed by s390-iommu by
increasing the number of table regions supported.  It also adds logic to
construct the table use the minimum number of regions based upon aperture
calculation.

Matthew Rosato (7):
  iommu/s390: add initial fields to track table size
  s390/pci: set appropriate IOTA region type
  iommu/s390: add basic routines for region 1st and 2nd tables
  iommu/s390: support cleanup of additional table regions
  iommu/s390: support iova_to_phys for additional table regions
  iommu/s390: support map/unmap for additional table regions
  iommu/s390: allow larger region tables

 arch/s390/include/asm/pci.h     |   2 +
 arch/s390/include/asm/pci_dma.h |   3 +
 arch/s390/pci/pci.c             |  17 +-
 drivers/iommu/s390-iommu.c      | 289 +++++++++++++++++++++++++++++---
 4 files changed, 285 insertions(+), 26 deletions(-)

-- 
2.47.0

