Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3EF1CAA88;
	Fri, 28 Feb 2025 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779114; cv=none; b=tJjfetPKxE4jUbZyFbS3PhDOTzM4v8a6+TAhkC3gRFwZTY+Rek20jt+WcrUs0KROamaXDq8r5aLKka+wAEm7T+HHzv7LaS/EJWtT+wRDRGIAIX/iJbebN0kJ2m5BPttMLuD0n4G78kF1+443ZkwjLsRfHVyN1EcX+pgAzjJdVvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779114; c=relaxed/simple;
	bh=2PYqIj8OL4eaU77gi9JIQhss1+9xYUM5nfsHiZEomsM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b3X3sEN1gghyAZwsk4YngNOJIFO8i/tMauzVf+UhY3W4ek0tYkKNTjjeFo90c0DxniYbmeWahqYjw6hdv1yBydgbirc/F9XkHRtN0xiEnK13BS05EQElHpwN5GJTYPE2DXukAsJiFo9oRBDigN2CoJy5pkiTtVxQMqtgAhAmetM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b6QtgF7a; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b6QtgF7a"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SDOLav010336;
	Fri, 28 Feb 2025 21:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=tm8xRUFBbR3eFgr4uE29a1Wzb11JuiXUKUoEZvjJZ
	ac=; b=b6QtgF7aADanozR15AqigGRqN+QOryOVA9OyN6F12SoxLHwyuMO2EXJSI
	PHUf2n0VR8ylf4u6CDZ44ANvbaMLx69VfOOm1UyJQSvDNf+jFKxLSMXUN28gvicf
	e2eOypL0KU/sCObJGYtw+HElIoJIXdxp+XYa7UDRL8Fe1NPZ33kF5mwmBVFRJRJX
	cXETOk1yyoJtGwteGEsoXcKpB+4tLJEeVJyP+2K4Ut8pVOps5yPC8hBEuq/17Oc5
	0BRfqAgonY7LpLs65AkbHAYbTswHfSmHLCILPk2RM8yDu7bEMzjbctM1EDWfel0z
	7I8IN7Zlutu4/jZ7fFcVFw0UzJeKw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45337anqfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 21:45:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51SJoW30012565;
	Fri, 28 Feb 2025 21:45:01 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwt91hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 21:45:01 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51SLixMR25035488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 21:44:59 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1CD758054;
	Fri, 28 Feb 2025 21:44:59 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A7DD65803F;
	Fri, 28 Feb 2025 21:44:57 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.46.135])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Feb 2025 21:44:57 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 0/5] iommu/s390: support additional table regions
Date: Fri, 28 Feb 2025 16:44:51 -0500
Message-ID: <20250228214456.440641-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: PwG3vMng1FHNr_PnEgLPtQIqz3t0vjdN
X-Proofpoint-GUID: PwG3vMng1FHNr_PnEgLPtQIqz3t0vjdN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_06,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=732
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280156

The series extends the maximum table size allowed by s390-iommu by
increasing the number of table regions supported.  It also adds logic to
construct the table use the minimum number of regions based upon aperture
calculation.

Changes for v3:
- rebase onto iommu-next
- move IOTA region type setting into s390-iommu
- remove origin_type and max_table_size from zdev
- adjust reserved region calculation to be dependent on the domain

Changes for v2:
- rebase onto 6.13
- remove 'iommu/s390: add basic routines for region 1st and 2nd tables'
  and put routines in first patch that uses each.  No functional change.

Matthew Rosato (5):
  iommu/s390: set appropriate IOTA region type
  iommu/s390: support cleanup of additional table regions
  iommu/s390: support iova_to_phys for additional table regions
  iommu/s390: support map/unmap for additional table regions
  iommu/s390: allow larger region tables

 arch/s390/include/asm/pci_dma.h |   3 +
 drivers/iommu/s390-iommu.c      | 342 ++++++++++++++++++++++++++++----
 2 files changed, 310 insertions(+), 35 deletions(-)

-- 
2.48.1

