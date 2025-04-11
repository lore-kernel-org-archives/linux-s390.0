Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A6F280CD9;
	Fri, 11 Apr 2025 20:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744403094; cv=none; b=VLFfTKFDdIq3n4ZOCxwkaxE/L0kqVeDEaAIMWJ7PTHMj15MvVzrefZI5EfHIroZ+u703f4XamVfdXmZYBDIXKG7QWqg6IPlnkM1+MUwYBYGKEedlpP2JHbvdjuJI+iyR1NYidex+waHoI7IAqO/JV9JHsNvAso3+tWzlWJehNRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744403094; c=relaxed/simple;
	bh=n8K15PPjyjU9zgMxma4R+5zqZAkCM90jZquIgPswRuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dJKO44DE6UpWjRgupqO65BMS3kuYexePEfDRsFe1tzcCggraqhuajyUZDt7SHtQDkvU8cgTZ9Z/eWsgUEO2gtr1ZlGuh28eJ8v7/8ZX5gi0n0doilz7mlNMXTaBwytd9R6gTXqfqsstMhmDf8n9dr7SJudQQ6sqK8jEYyMTRYaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eADgly6d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eADgly6d"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BIIP14023248;
	Fri, 11 Apr 2025 20:24:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=pgbVZm3FmUBQ81FjNursYtSljrkVXH8NWFQSolPjB
	G0=; b=eADgly6dz19IvF/72BeuVlI+2NVgbOdw4BeHRQ7in7qam9gxrQlVJGeOY
	1awaCkJz2yaifymYyT2ZXKpTy4dutAfGpZs6UGJippsmjdSVEeQxp5DUNm1FQVz9
	3rhf1899WUwYGWvdrgvzCNghtmOPpm7HZEWkdwONg39wmOsEClaoGuojnZRDJo9D
	e+Tc7LNMY964NIL1wbuw6LODlm8y7FNb2KsOSfyjK3aJhQiV32GQ5qzaiB+QzKPb
	xjrgMWvy00WslWAoUNN3VS5W11gukKc7iIhaOpEPtpqj4gIRR3cElChcjK8RdLJE
	WhWMTUMx0wEIPyh/VbKfWW67wbeXA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45y343tb6e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 20:24:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BIw4tM017825;
	Fri, 11 Apr 2025 20:24:35 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2m4he9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 20:24:35 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BKOYaT30736968
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 20:24:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D9F0E5805A;
	Fri, 11 Apr 2025 20:24:34 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D831D58051;
	Fri, 11 Apr 2025 20:24:33 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.105.190])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 20:24:33 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v5 0/5] iommu/s390: support additional table regions
Date: Fri, 11 Apr 2025 16:24:28 -0400
Message-ID: <20250411202433.181683-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gBIZNC05wFANwEVJbwq4M8do_xbDqVA6
X-Proofpoint-ORIG-GUID: gBIZNC05wFANwEVJbwq4M8do_xbDqVA6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_08,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=708
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110127

The series extends the maximum table size allowed by s390-iommu by
increasing the number of table regions supported.  It also adds logic to
construct the table use the minimum number of regions based upon aperture
calculation.

Changes for v5:
- fix GFP_KERNEL under spinlock in patch 5

Changes for v4:
- rebase onto master/merge window
- convert patches 3 per Niklas to remove gotos
- convert patch 4 to also remove gotos
- add review tags

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
 drivers/iommu/s390-iommu.c      | 345 ++++++++++++++++++++++++++++----
 2 files changed, 314 insertions(+), 34 deletions(-)

-- 
2.49.0

