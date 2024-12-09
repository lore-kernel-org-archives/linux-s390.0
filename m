Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0635A1991D8;
	Mon,  9 Dec 2024 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772366; cv=none; b=QaZ+2x8144Um29Uo0wxs8xNLjwnZqe8muuAJXABwiRRoFnvb9s+/KBmiQgmmI9kUEvFdawCdKugVE1txObHuSta3I+86SeQbW2NahUSbIuJxY916C/tlXy0hsvH5VpRYtXOiHawUuxFupe9VN0vPGQEmZZNa8DPoEMsuzWYhdK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772366; c=relaxed/simple;
	bh=wxZWM9Xs9hzLVx4T4oIxM0wQO9HXSPjKPMqyzhTXIgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmijFBXzVhjwcpIYZux8fwQDDnD772EWusOmF3z594aRhk1g948/E0l+NHjMC6CV6Ia+gEBh2buAof+xvJhSuodu83VBjKfaXz8lOzYFHIcmUcqVs1Mt04H4odsOBs6umv0HVE+SDwNhWLkWBnJlbu4RuVT4gnPiBe6UPbXkkKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aIv065iS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aIv065iS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9E4dEJ032428;
	Mon, 9 Dec 2024 19:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=D2f2503/0UUWMj4Q2
	QM5cTBMIYS1TJwXDMjg3PiH/oA=; b=aIv065iSv7nO+KhmlvUqogMKb0Am0YpGF
	HE/q4ezQmvPgfqaVaFyu24+jN8JiFbmvqHLWERxr48wQkKnwAA53EQAwxW9wRdDu
	+RpXC1FF6XHwfTPHo4wTS+rdszfbU2yEtt/23Rkph8YyH4hNK+EjlhKcfYjMbpme
	BaJmhNIqEPd8vrGlacUcMjt6ImXyUzvAQKChCd6Q5SvDo5gB9XeLgSXw1g1Eny6U
	Jkl1oG6F85FF4MdFd6cWP4H3UZFqFTSMvEEnUm+4SV7i8CDatOPbHzu0WHW+TBeF
	9mq3m1zigEKivguqIdjxhcciTWwbA5hxZJsmncKFM4RahEgf1ytUg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cbsq2hu9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:25:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9FtZPR017364;
	Mon, 9 Dec 2024 19:25:53 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 43d3d1fqwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:25:53 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9JPqeD21234216
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 19:25:52 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D46458055;
	Mon,  9 Dec 2024 19:25:52 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6A49358043;
	Mon,  9 Dec 2024 19:25:51 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.107.222])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 19:25:51 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clegoate@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 1/7] iommu/s390: add initial fields to track table size
Date: Mon,  9 Dec 2024 14:25:43 -0500
Message-ID: <20241209192549.107226-2-mjrosato@linux.ibm.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209192549.107226-1-mjrosato@linux.ibm.com>
References: <20241209192549.107226-1-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xjECl8VcHEBY91AEimNOqJLLhPfnrsFC
X-Proofpoint-GUID: xjECl8VcHEBY91AEimNOqJLLhPfnrsFC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 suspectscore=0 spamscore=0 mlxscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090147

In preparation for allowing for additional table levels, add the
necessary information to the zdev and s390 domain to track table
type.  For now, these values will always be set to signify a
region third table which is what s390-iommu always uses today.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/include/asm/pci.h |  2 ++
 drivers/iommu/s390-iommu.c  | 17 +++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 474e1f8d1d3c..8f8ebaeec60a 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -189,6 +189,8 @@ struct zpci_dev {
 	struct kvm_zdev *kzdev;
 	struct mutex kzdev_lock;
 	spinlock_t dom_lock;		/* protect s390_domain change */
+	u64 max_table_size;
+	u8 origin_type;
 };
 
 static inline bool zdev_enabled(struct zpci_dev *zdev)
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index fbdeded3d48b..f6c27b6ab4c6 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -31,6 +31,7 @@ struct s390_domain {
 	unsigned long		*dma_table;
 	spinlock_t		list_lock;
 	struct rcu_head		rcu;
+	u8			origin_type;
 };
 
 static struct iommu_domain blocking_domain;
@@ -331,6 +332,7 @@ static bool s390_iommu_capable(struct device *dev, enum iommu_cap cap)
 
 static struct iommu_domain *s390_domain_alloc_paging(struct device *dev)
 {
+	struct zpci_dev *zdev = to_zpci_dev(dev);
 	struct s390_domain *s390_domain;
 
 	s390_domain = kzalloc(sizeof(*s390_domain), GFP_KERNEL);
@@ -344,7 +346,8 @@ static struct iommu_domain *s390_domain_alloc_paging(struct device *dev)
 	}
 	s390_domain->domain.geometry.force_aperture = true;
 	s390_domain->domain.geometry.aperture_start = 0;
-	s390_domain->domain.geometry.aperture_end = ZPCI_TABLE_SIZE_RT - 1;
+	s390_domain->domain.geometry.aperture_end = zdev->max_table_size;
+	s390_domain->origin_type = zdev->origin_type;
 
 	spin_lock_init(&s390_domain->list_lock);
 	INIT_LIST_HEAD_RCU(&s390_domain->devices);
@@ -450,9 +453,9 @@ static void s390_iommu_get_resv_regions(struct device *dev,
 		list_add_tail(&region->list, list);
 	}
 
-	if (zdev->end_dma < ZPCI_TABLE_SIZE_RT - 1) {
+	if (zdev->end_dma < zdev->max_table_size) {
 		region = iommu_alloc_resv_region(zdev->end_dma + 1,
-						 ZPCI_TABLE_SIZE_RT - zdev->end_dma - 1,
+						 zdev->max_table_size - zdev->end_dma,
 						 0, IOMMU_RESV_RESERVED, GFP_KERNEL);
 		if (!region)
 			return;
@@ -470,11 +473,11 @@ static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 	zdev = to_zpci_dev(dev);
 
 	if (zdev->start_dma > zdev->end_dma ||
-	    zdev->start_dma > ZPCI_TABLE_SIZE_RT - 1)
+	    zdev->start_dma > zdev->max_table_size)
 		return ERR_PTR(-EINVAL);
 
-	if (zdev->end_dma > ZPCI_TABLE_SIZE_RT - 1)
-		zdev->end_dma = ZPCI_TABLE_SIZE_RT - 1;
+	if (zdev->end_dma > zdev->max_table_size)
+		zdev->end_dma = zdev->max_table_size;
 
 	if (zdev->tlb_refresh)
 		dev->iommu->shadow_on_flush = 1;
@@ -732,6 +735,8 @@ int zpci_init_iommu(struct zpci_dev *zdev)
 			     ZPCI_TABLE_SIZE_RT - zdev->start_dma,
 			     zdev->end_dma - zdev->start_dma + 1);
 	zdev->end_dma = zdev->start_dma + aperture_size - 1;
+	zdev->origin_type = ZPCI_TABLE_TYPE_RTX;
+	zdev->max_table_size = ZPCI_TABLE_SIZE_RT - 1;
 
 	return 0;
 
-- 
2.47.0

