Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782C5225762;
	Fri, 24 Jan 2025 20:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737749930; cv=none; b=MrGVzzMC/YhL5nfX35n6O8RY5655AUI54c8fCltYaUQbi1LCJ6da5BoJ3dvtM7nllgE/FXPl0AGmAf8DqLaJlXh326s7FcAdia/OIYVjMZyivMSwQMgaK5ANZj7MbFMS16DDkvoULUpxKORu/sbhcoWajOIwy2bu7b+quKJRepQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737749930; c=relaxed/simple;
	bh=pT/7AlUe4dxL5NJ2hEzis+4o3CayyTif7T1u0mz3kBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k4S598EE1tpCdupj2as8TbPbQEjnMUVIWMeaF3rikrYOVIvF4qDgTnNLW3y6dI3LDBTRN/qhntssnQLLWtJWL5Uu6IqgYkThccYoU74RsbAmVU+8jycBO4CS1f3u9t0TKeUR/KZXVhGBP+gPo1JKKBhrg/aHLWnG90LjLu8xo5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JQyHNcjz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JQyHNcjz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OJ9fYA009864;
	Fri, 24 Jan 2025 20:18:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NRQwuH3A30mPpJet1
	sQ0Rz415sNQ5MtBJWGnboZyE5E=; b=JQyHNcjzqGJJDVEMU5CXHU2NN7qRygMuB
	7eO5wW1+bp/w+XVmr53rzkSkeDNS3ZvHOVpVKiS5UpXySiHpZSiNFHBkmqI9ACdI
	yRXeK9+6TLXdomAZqb5rkLgIA/XE7jgs7W/7qjfZKeLvQlczojGZLNz+76w3Vxwf
	Bshte0JK0uHl7VPjfsTJQ5fwpjvBSsAjlCQFZH8H3ZddF/v7L5u/t3szqcXe+17s
	naGWCrIjvPYWoOUL2AeWhE4BtuD8TriACPYBLZcw8FgdP9f16zII9pUcUfW1cb0k
	iUeRbSveYHiGuhqL/5rYYANOj8QOCcv3E0VG7uNLYe681cuFymklA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44c1pywmxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 20:18:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OJ2EOo019266;
	Fri, 24 Jan 2025 20:18:37 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pmswf09-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 20:18:37 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50OKIZ8424445472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 20:18:35 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F7905805C;
	Fri, 24 Jan 2025 20:18:35 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5A87C58051;
	Fri, 24 Jan 2025 20:18:34 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.77.196])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 20:18:34 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clegoate@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 6/6] iommu/s390: allow larger region tables
Date: Fri, 24 Jan 2025 15:18:26 -0500
Message-ID: <20250124201826.348848-7-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124201826.348848-1-mjrosato@linux.ibm.com>
References: <20250124201826.348848-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: guMNenpfqk7rKSVBiELxTDOHhYHcwjgn
X-Proofpoint-GUID: guMNenpfqk7rKSVBiELxTDOHhYHcwjgn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 phishscore=0
 mlxlogscore=886 bulkscore=0 lowpriorityscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 impostorscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501240137

Extend the aperture calculation to consider sizes beyond the maximum
size of a region third table.  Attempt to always use the smallest
table size possible to avoid unnecessary extra steps during translation.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/pci_dma.h |  1 +
 drivers/iommu/s390-iommu.c      | 22 +++++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/pci_dma.h b/arch/s390/include/asm/pci_dma.h
index 8d8962e4fd58..d12e17201661 100644
--- a/arch/s390/include/asm/pci_dma.h
+++ b/arch/s390/include/asm/pci_dma.h
@@ -25,6 +25,7 @@ enum zpci_ioat_dtype {
 #define ZPCI_KEY			(PAGE_DEFAULT_KEY << 5)
 
 #define ZPCI_TABLE_SIZE_RT	(1UL << 42)
+#define ZPCI_TABLE_SIZE_RS	(1UL << 53)
 
 #define ZPCI_IOTA_STO_FLAG	(ZPCI_IOTA_IOT_ENABLED | ZPCI_KEY | ZPCI_IOTA_DT_ST)
 #define ZPCI_IOTA_RTTO_FLAG	(ZPCI_IOTA_IOT_ENABLED | ZPCI_KEY | ZPCI_IOTA_DT_RT)
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 4924fe9faccb..c6b2bca881c3 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -953,12 +953,24 @@ int zpci_init_iommu(struct zpci_dev *zdev)
 		goto out_sysfs;
 
 	zdev->start_dma = PAGE_ALIGN(zdev->start_dma);
-	aperture_size = min3(s390_iommu_aperture,
-			     ZPCI_TABLE_SIZE_RT - zdev->start_dma,
-			     zdev->end_dma - zdev->start_dma + 1);
+	aperture_size = min(s390_iommu_aperture,
+			    zdev->end_dma - zdev->start_dma + 1);
+	if (aperture_size <= (ZPCI_TABLE_SIZE_RT - zdev->start_dma)) {
+		zdev->origin_type = ZPCI_TABLE_TYPE_RTX;
+		zdev->max_table_size = ZPCI_TABLE_SIZE_RT - 1;
+	} else if (aperture_size <= (ZPCI_TABLE_SIZE_RS - zdev->start_dma) &&
+		  (zdev->dtsm & ZPCI_IOTA_DT_RS)) {
+		zdev->origin_type = ZPCI_TABLE_TYPE_RSX;
+		zdev->max_table_size = ZPCI_TABLE_SIZE_RS - 1;
+	} else if (zdev->dtsm & ZPCI_IOTA_DT_RF) {
+		zdev->origin_type = ZPCI_TABLE_TYPE_RFX;
+		zdev->max_table_size = U64_MAX;
+	} else {
+		/* Assume RTX available */
+		zdev->origin_type = ZPCI_TABLE_TYPE_RTX;
+		zdev->max_table_size = ZPCI_TABLE_SIZE_RT - 1;
+	}
 	zdev->end_dma = zdev->start_dma + aperture_size - 1;
-	zdev->origin_type = ZPCI_TABLE_TYPE_RTX;
-	zdev->max_table_size = ZPCI_TABLE_SIZE_RT - 1;
 
 	return 0;
 
-- 
2.48.1

