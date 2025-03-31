Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2780F1CAA90;
	Mon, 31 Mar 2025 20:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452536; cv=none; b=pMjjm65nC9fV+7I/pb9hxrhO0zXyJcTzsaEgynkfP7/if6+pCRAVtC2VpqG14Fn7L053gIMZT8gzzUYotNS7JT6RdohHexW0LkCRvb93E/6z68b2poxqeCGjJ7b6N6Yr+70RJrJWe02LTSe96/q+eTTgeMQK0+jgSN4GJH4rM0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452536; c=relaxed/simple;
	bh=plzVs98fA256QsqGGJNd59GaLDLiouTzzaLTM9twSlU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UH/+MGQn51oqsTpoAV7eIdEmuZNn+NCVI9A4PuVtuBQz4IL476nWHxPVZjocBKXCszlWhcW/86IGLcwL3OgPDaQ1vvk0Xfoq81AD/MOi1+RlSWeHWnen6tIQWH973XndgHHFBpivKSXDweT/hiOroWcfN/7AolOluAYEAS1wSWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sTC81XOF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sTC81XOF"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VDXTR2020195;
	Mon, 31 Mar 2025 20:22:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=PXthgOzdfVDDzrQfquLGmUN3HkV/FmIKtNPzXw3U2
	/U=; b=sTC81XOFAtmklwtXzfMk1zs1LtOk7CvCWezFMFhpwfFd2IlhwKpKBcZpf
	Ok0RaXL0KGzrlxleNPSwVPA0Vcp3rliPgsLq+imHYSCG9N+jqoHzAUcsEfhHHaI8
	pFYtIf0DnDELJFU9KZrse9g0swLhCAFipbCnHC41QjVKOZVq11tQumTTOrnhOyBv
	wMNmIVmUE/irFM3O4Qi4ftF61k7M2g/C0wmBb4EqlRbr++Z9B5pLuVQA3E5WMmTA
	pwbL8J73oHP2uiXocYiam2PG5UWshJQIJXpiupdTKI1EHKqDMmq2VCHsYOULKbX6
	jvvtX2e1Bzhi9HhQW7d/XT6phzjlA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qke9m4vf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 20:22:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52VI1si7010313;
	Mon, 31 Mar 2025 20:22:03 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pv6nqd27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 20:22:03 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52VKM1Xf27525714
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 20:22:02 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0BF558053;
	Mon, 31 Mar 2025 20:22:01 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EFD158043;
	Mon, 31 Mar 2025 20:22:00 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.39.63])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Mar 2025 20:21:59 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v4 0/5] iommu/s390: support additional table regions
Date: Mon, 31 Mar 2025 16:21:54 -0400
Message-ID: <20250331202159.85956-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: veeLgI50lUi7d8tHrcA9p2pY8r7dg-j5
X-Proofpoint-ORIG-GUID: veeLgI50lUi7d8tHrcA9p2pY8r7dg-j5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_09,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=621 suspectscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310138

The series extends the maximum table size allowed by s390-iommu by
increasing the number of table regions supported.  It also adds logic to
construct the table use the minimum number of regions based upon aperture
calculation.

Changes for v4:
- rebase onto master after iommu/next PR merge
- convert patch 3 per Niklas to remove gotos
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
 drivers/iommu/s390-iommu.c      | 346 ++++++++++++++++++++++++++++----
 2 files changed, 314 insertions(+), 35 deletions(-)

-- 
2.49.0

