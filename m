Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFEE21B90B;
	Fri, 24 Jan 2025 20:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737749923; cv=none; b=K0mEclyhpSnzzKPc5oa+GPYWbIbqPZelByBIYtUwMeg9EKtJuHSzTdNjA2zot309aDuQ8mP1lKOc6VVGUsU4hs1rdXHtGhwaFdYMt8VUp0tIl7bKVh/YC1KD6XYsPWKckpgXeXrK9CErQRN0wfav44m1ApnyRejzLmPW4t+X4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737749923; c=relaxed/simple;
	bh=CJPWzygsWzjXtsTcjLTc+PIMVm5aq5zkF9+AC8W8h/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3mwHA3Dvm4EuzO+KYRegFpLXEt+1YkdP6rbXJctqFVqxxe+uX0EtwBnQ8VZQtCb+s18UShGidWq/Shx5KvYb7eYa732UC7uei2PQXAzlcsH/lAjdaxPcVzzXe9F4qJJxz+0c35CrAO2XdeJnVYMBfM9t8DoD1lDooZ/hFdT/d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AC1fO02B; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AC1fO02B"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OHGT0g019218;
	Fri, 24 Jan 2025 20:18:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=fkkbYaVLCwqP4fK8iWVDSBLISHxD2mTqyy967ck0v
	zs=; b=AC1fO02Br6dA1ejIR64vtQdWlW8vFQ4mNHyXKjW3Q765hY/yeaEs5RbHT
	I6hzaPdTjq9zSMSRmYUmMzm1nRXuvUVKb2H9AbHIZFLTSmweJihFIWsT9sdIjXeQ
	GjXxCamvLQFrssEJwEgRtbCRwLEYO/RneWX+SYQ5jd/cHtBJgK9Vz5LIK+7Wy9r8
	fNNSsaDP8NcY0j8KGHVqk8IGvpEEV8VRR870mIyBeyZcOlvz4LhYDL6Oi5yJVK99
	of608O+jaTkvCxooE8TTlcxdvP4juhqpa8QWzpweBh4jgxNF9RMDQMgABfwJ9OBO
	YT0ywzc2tAgq0CZJ5ejsz7LnMj9Sg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c0x9605u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 20:18:31 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OIXO1U024252;
	Fri, 24 Jan 2025 20:18:29 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0yndr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 20:18:29 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50OKISrY27722342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 20:18:28 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B28C15805A;
	Fri, 24 Jan 2025 20:18:28 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DE3C85805F;
	Fri, 24 Jan 2025 20:18:26 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.77.196])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 20:18:26 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clegoate@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 0/6] iommu/s390: support additional table regions
Date: Fri, 24 Jan 2025 15:18:20 -0500
Message-ID: <20250124201826.348848-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sr6OnuwBiou5a_aXlbiy_25knveZWfBe
X-Proofpoint-ORIG-GUID: sr6OnuwBiou5a_aXlbiy_25knveZWfBe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 phishscore=0
 mlxlogscore=601 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240137

The series extends the maximum table size allowed by s390-iommu by
increasing the number of table regions supported.  It also adds logic to
construct the table use the minimum number of regions based upon aperture
calculation.

Changes for v2:
- rebase onto 6.13
- remove 'iommu/s390: add basic routines for region 1st and 2nd tables'
  and put routines in first patch that uses each.  No functional change.


Matthew Rosato (6):
  iommu/s390: add initial fields to track table size
  s390/pci: set appropriate IOTA region type
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
2.48.1

