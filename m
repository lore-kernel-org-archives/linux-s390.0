Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35BE1DC04A;
	Fri, 28 Feb 2025 21:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740779116; cv=none; b=USLzQq7cJtGOe9NchDCcgdHWkcXle34bijJK21N91Hi9c0cCzhczHykcPuNmdp6wMIebVignTI83BHNxQDZ7a9sBAjrU9rEw7fXsplKOKT0QTs8WDqCYcn0IpsC6+SihYkbdfANumUn+CuUqeJXeDojdnm0DBaJm+i7zWRNm5dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740779116; c=relaxed/simple;
	bh=uOhM/SeJA7XJ6jxexnYg+VBH7262vz85NsNZs5+Kod0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMJxK5LyRczAfkbHaxedIvb+ghr0MeMmhNQbDeztpfifHtGeqzASr84IMb61YDGZBx9C+6ZaXNMIJEOd92IJVXSI8RyoeI7Xn0kV0HHJOp6Wpyaxck5sVw2KsEPeGP5Ggy8sjqdXQd0DFm2b/997FuoWYnttmBe1aWe131g+fbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cnjjPD3+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cnjjPD3+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51SFAaAp025575;
	Fri, 28 Feb 2025 21:45:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=l9qzkoY85tehv4Cpd
	CCTcxeMAPhI92X5AVUKNsyaU34=; b=cnjjPD3+py+SPZsJMqJb+NDftKcjcO6DJ
	tEFWtD9dPe7ie1piSmWN1n28RfJOPYrk2flrUdlvTYKr1BKltWsk5qSSzQmLP9aQ
	FL8+1rsYrHEpl/dlNAoL2orFcmF3ccD02007wfDbcj+V6l+JoSOj0jQ8Siab5rPt
	GoB/RhJt0JZ/mwDlWjYXnctcGl5kjGm/FwMl1GWFB/JEKqA2yzFm5eK9BAi70ifd
	nm8QxclnxqCt6I6VovXYm7TV44oWtrLcvrfh0kVdnfP5QimaLVOMrzfx6JtF1wF/
	OHyahCHOC5S18EKBzsAs2Z1JwbISdOMuDjNdGzBkWHTUKALyuU67g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4538uq407a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 21:45:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51SImCWV002567;
	Fri, 28 Feb 2025 21:45:03 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yu4k8gxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Feb 2025 21:45:03 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51SLj2fF26345876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Feb 2025 21:45:02 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1E1258055;
	Fri, 28 Feb 2025 21:45:01 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 034745803F;
	Fri, 28 Feb 2025 21:45:00 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.46.135])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 28 Feb 2025 21:44:59 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v3 1/5] iommu/s390: set appropriate IOTA region type
Date: Fri, 28 Feb 2025 16:44:52 -0500
Message-ID: <20250228214456.440641-2-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250228214456.440641-1-mjrosato@linux.ibm.com>
References: <20250228214456.440641-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DsPZoguYondpruYYv7fVzLW72DD0P4kM
X-Proofpoint-ORIG-GUID: DsPZoguYondpruYYv7fVzLW72DD0P4kM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-28_06,2025-02-28_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 mlxlogscore=999
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502280156

When registering the I/O Translation Anchor, use the current table type
stored in the s390_domain to set the appropriate region type
indication.  For the moment, the table type will always be stored as
region third.

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
2.48.1

