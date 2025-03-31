Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5FA219A67;
	Mon, 31 Mar 2025 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452538; cv=none; b=ogaKsO1RxLuxJZ8sSI39pQDwkhhWoIu/xfqHE8EsRIqjGTgyZMcCA5SjxryiKrReWccy/hX+N9ojz66o7zPYya8CCaFoyAZnz8mv3jcFMi6DGuLZvU67J44KijPIqI2wTnn6PNs4n2oWJkIiFTuHewEAG91hzaIRM4viTZFzIao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452538; c=relaxed/simple;
	bh=x7B9MnN6xpz37Iys3AovmgLR2oS5tnCU9+OgjSjXdhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pB2VtZi72/c6SsMG1uvEqZ25/hs4E9gkWyAbz4IBiXNQQ0tCAiHbc7ol2kFDRcW3e6Q0G03GWhAGYKmyBdsQF05ddWS0dNQ7eTTtDed2lKsQxzl8Mu9MJF5i3FpMmznBiVmw1OUo05INKfbv+0alQEMGoWle1mgJ1m7Yno+ilc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ifWslu6Q; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ifWslu6Q"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52VCSVC2027970;
	Mon, 31 Mar 2025 20:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=PQyazkUkM7A2DT0v2
	mq2AovAAjWaC5LljDabv03UP2U=; b=ifWslu6QetAPUkPGRJcxKOiTZqAn37Kot
	udD0VsS+RjDdY9cIV9DmFeY/IDitFRnge9jUTMklOLjfnK9tCVSimuM+PCWoKGsg
	VG1UflxDcigT8g9wzpdwxD9Pq8ZvoW6/BdNdMkJRvILiRXcIJs6z6amjRQ4qzBhi
	x6NwaFSEXipdqw8O2ET8D9d7AEPqi5S4VMaP0qazMliBbYZjdGcavG+wP85t0O6j
	y4qq/UJjEdC4OUAVH4he9Fvmf5Rv0hVyI5E9tvQU5u0EcUerPNaCmF39CpGf+kMu
	aKArRwLN89qIUANk6Zcnd8c1F8cwFtAB4xiag6oO1DyrBbcEW4daw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qu32a8t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 20:22:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52VIE0B2010272;
	Mon, 31 Mar 2025 20:22:04 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pv6nqd28-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 20:22:04 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52VKM3mA22151780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 20:22:03 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 494DD58053;
	Mon, 31 Mar 2025 20:22:03 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CAC0B58043;
	Mon, 31 Mar 2025 20:22:01 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.39.63])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Mar 2025 20:22:01 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v4 1/5] iommu/s390: set appropriate IOTA region type
Date: Mon, 31 Mar 2025 16:21:55 -0400
Message-ID: <20250331202159.85956-2-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250331202159.85956-1-mjrosato@linux.ibm.com>
References: <20250331202159.85956-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: btU5VDVasQ0i-YqsG1aHgxIczWgjCsfD
X-Proofpoint-ORIG-GUID: btU5VDVasQ0i-YqsG1aHgxIczWgjCsfD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_09,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 impostorscore=0 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503310138

When registering the I/O Translation Anchor, use the current table type
stored in the s390_domain to set the appropriate region type
indication.  For the moment, the table type will always be stored as
region third.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index e1c76e0f9c2b..cad032d4c9a6 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -31,6 +31,7 @@ struct s390_domain {
 	unsigned long		*dma_table;
 	spinlock_t		list_lock;
 	struct rcu_head		rcu;
+	u8			origin_type;
 };
 
 static struct iommu_domain blocking_domain;
@@ -345,6 +346,7 @@ static struct iommu_domain *s390_domain_alloc_paging(struct device *dev)
 	s390_domain->domain.geometry.force_aperture = true;
 	s390_domain->domain.geometry.aperture_start = 0;
 	s390_domain->domain.geometry.aperture_end = ZPCI_TABLE_SIZE_RT - 1;
+	s390_domain->origin_type = ZPCI_TABLE_TYPE_RTX;
 
 	spin_lock_init(&s390_domain->list_lock);
 	INIT_LIST_HEAD_RCU(&s390_domain->devices);
@@ -381,6 +383,21 @@ static void zdev_s390_domain_update(struct zpci_dev *zdev,
 	spin_unlock_irqrestore(&zdev->dom_lock, flags);
 }
 
+static u64 get_iota_region_flag(struct s390_domain *domain)
+{
+	switch (domain->origin_type) {
+	case ZPCI_TABLE_TYPE_RTX:
+		return ZPCI_IOTA_RTTO_FLAG;
+	case ZPCI_TABLE_TYPE_RSX:
+		return ZPCI_IOTA_RSTO_FLAG;
+	case ZPCI_TABLE_TYPE_RFX:
+		return ZPCI_IOTA_RFTO_FLAG;
+	default:
+		WARN_ONCE(1, "Invalid IOMMU table (%x)\n", domain->origin_type);
+		return 0;
+	}
+}
+
 static int s390_iommu_domain_reg_ioat(struct zpci_dev *zdev,
 				      struct iommu_domain *domain, u8 *status)
 {
@@ -399,7 +416,7 @@ static int s390_iommu_domain_reg_ioat(struct zpci_dev *zdev,
 	default:
 		s390_domain = to_s390_domain(domain);
 		iota = virt_to_phys(s390_domain->dma_table) |
-		       ZPCI_IOTA_RTTO_FLAG;
+		       get_iota_region_flag(s390_domain);
 		rc = zpci_register_ioat(zdev, 0, zdev->start_dma,
 					zdev->end_dma, iota, status);
 	}
-- 
2.49.0

