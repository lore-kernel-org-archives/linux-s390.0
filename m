Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557B030C37E;
	Wed, 27 Aug 2025 21:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756328921; cv=none; b=r0R8BMZEqVyi1hAtd28Qeny83JoE+hkAfeoKALZW3PFjBVTK1Xovn45hDBjxfBKPemspRTpW2GD8jvfar5LIBrV9FO8bCOKaXP6jmKHf2Yw6CKsdj8G4Cdd8xwrhwymVkEkXDuY9GEaPGPWHljzR1Y8PDBgRJq2OeI2zIgcWMt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756328921; c=relaxed/simple;
	bh=lQoFCbkvux/8DSGnpabMbpmJq7LLQkp3FW/Fv1o3JoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gW7FUNyjNiAZnvfr5SF7Iohp76CAnB75t5E3Eq/uxEklQEO/F4I/f5jTyq598SOUvBHSFdwtwhOah2cAg+VOu1Lh4sN2mVZ1esvXkLWHTtSl+HslTj4geZJmnOBdt8KPmBD2jFKiV5eUBXiuU2TeyxSXnDgyfD5mJpnGKOSEj40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lvLhnIKB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lvLhnIKB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57RH6gR5030697;
	Wed, 27 Aug 2025 21:08:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=bqjnZwKnMa+N0AC8KUB6lD2BbjylXkThN52eo+73g
	q4=; b=lvLhnIKBO/jgHGPz1GvmKZ4DTOlsima5VdWmRhD5Kl39Ju/gVh236+TEx
	M5P2R0xEeH+GHhdYJq4YNO/YB9mxgYjy/RNCM4W5gfShH9nwmuqy9zDt12r5nqwp
	630praqeSshcA1gax8cAfd4uNFJC6kyAfydcC1N/hgJkZur9M2k+cwvHB8sysFeL
	5g1yirVeNy37369ojP8UbmlwSfOAqgcdTe70fa5mHlVv8Vv/5z5tudN6haErvzx9
	SwnAznuNi9k5q8eSufbFPZ+WP+JWe3FuHa0wKxfnhm7Ib4dnyCTpDgY2voIy0hOj
	3EkFA5ulr320jz9uPmvHVar8hWiHQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q5avpayb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 21:08:32 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57RL0IBW018006;
	Wed, 27 Aug 2025 21:08:31 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48qtp3hjtg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Aug 2025 21:08:31 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57RL8UNA21693054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 21:08:31 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D3505805A;
	Wed, 27 Aug 2025 21:08:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 490AE5805D;
	Wed, 27 Aug 2025 21:08:29 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.160.201])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 27 Aug 2025 21:08:29 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, schnelle@linux.ibm.com
Cc: will@kernel.org, robin.murphy@arm.com, gerald.schaefer@linux.ibm.com,
        jgg@ziepe.ca, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, stable@vger.kernel.org,
        Cam Miller <cam@linux.ibm.com>
Subject: [PATCH] iommu/s390: Fix memory corruption when using identity domain
Date: Wed, 27 Aug 2025 17:08:27 -0400
Message-ID: <20250827210828.274527-1-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CL5xb0cttaozS9hlBWyRob2q_BkQTay2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX+L1bAXC7oCdx
 jZ8CwhWkkZiRcM1GxOxw42sbFzHz45Nj37SD1CpR3wtN4xN3vlsXvPezox0oR89oVwVBYVr+4H0
 zz9UmtzlpJsve2W3HJKcyKOC+bimXc0fUDH9vGo5xIVFEzCRQMvjaxh41mvboDb0zmpkV8aJA1N
 nvO9pYbKjk+QSkdzh9IQ9TjMY52aHCBVZhghkninoLlS5DMEjRtDYo0oVKNr4ES+R5RHnMTanDd
 zLbOJt70DMqmIYQEGOhGLqAsPqCfOPOAzFMZRzJfMWy7yllLtvgL3YbsR0gg3dlN2Tp04NuApqU
 pg7XhpSTSEyxqOlltKBEqlhtKMQKigieD0os97erOZK5KQG64H1goH2KJsh2lTRYZA0cKyu03ko
 vAZExXsA
X-Proofpoint-ORIG-GUID: CL5xb0cttaozS9hlBWyRob2q_BkQTay2
X-Authority-Analysis: v=2.4 cv=SNNCVPvH c=1 sm=1 tr=0 ts=68af73d0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=Z7V3-7iYKtOFoFvQ_6sA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 clxscore=1011
 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230021

zpci_get_iommu_ctrs() returns counter information to be reported as part
of device statistics; these counters are stored as part of the s390_domain.
The problem, however, is that the identity domain is not backed by an
s390_domain and so the conversion via to_s390_domain() yields a bad address
that is zero'd initially and read on-demand later via a sysfs read.
These counters aren't necessary for the identity domain; just return NULL
in this case.

This issue was discovered via KASAN with reports that look like:
BUG: KASAN: global-out-of-bounds in zpci_fmb_enable_device
when using the identity domain for a device on s390.

Cc: stable@vger.kernel.org
Fixes: 64af12c6ec3a ("iommu/s390: implement iommu passthrough via identity domain")
Reported-by: Cam Miller <cam@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 9c80d61deb2c..d7370347c910 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -1032,7 +1032,8 @@ struct zpci_iommu_ctrs *zpci_get_iommu_ctrs(struct zpci_dev *zdev)
 
 	lockdep_assert_held(&zdev->dom_lock);
 
-	if (zdev->s390_domain->type == IOMMU_DOMAIN_BLOCKED)
+	if (zdev->s390_domain->type == IOMMU_DOMAIN_BLOCKED ||
+	    zdev->s390_domain->type == IOMMU_DOMAIN_IDENTITY)
 		return NULL;
 
 	s390_domain = to_s390_domain(zdev->s390_domain);
-- 
2.50.1

