Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBB248EC62;
	Mon, 12 Oct 2026 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791814936; cv=none; b=QlYHKk93QKvFftLDQWPFWUVXjq8E0CvuskRUQypoX+yOxYDgyNVVgzA6Y1hXay4Egd4vGwaRzibNOARyCTMxy6i0P/v/1Ul9rOaZnqLgVOilLwXvvU3V10htDSeQa2NZsJWLOheHZ0zLw4Dyh0nZKgb24oav88W+s0BDZwmLb2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791814936; c=relaxed/simple;
	bh=K8NAlWXsljbSN0u1oiF5wMOM5EePLcn8w1FtQNh4w8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=giet7c1oG1dpPDPMK+RU4AwS+r3SyN9wTehOFL0vKNwMQoV0va6ZcZaEzuQ6Nxco0O7oNi6+hU3LcRrMl9X7qKptBPCg4/0thwZpazrKjIlTqDg4G3kzJwWqKeFZt8fIEQABZK9122mWn1AUZD3X6h1jC7fuLLFQ8lLoU3jB88E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IRfeXFKs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IRfeXFKs"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEBF0182461;
	Mon, 12 Oct 2026 14:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vOaDKD
	p6lwQMkiDYlYmhc/OzCHeUB5nTLZULW46vxoc=; b=IRfeXFKsp2NZpqW0zAQNkS
	34y8v/e/q5axdAGqE7tYcbje/uMxBTq5+DUgZ4DvhE1Lhx1ZQ47oKW0Mm6v7gbjt
	DH/771pRWxh8DpazHTKOTmYqKMZeWJEpmg5hCb202CTUTPXftMmNm7xjBl5kjWH3
	l368+ha3YRbk79ADF1AXMdlSJBTOq42QOBuMkl2hSjo+hwJJVcrcwNtPT6tdgNba
	6bkz1M5PYAVKSQVuRWt4++tYTQrjzSnBGH98LoBTXkVi6UA8NAt7Fdgxx6flfKmm
	pptZvaPujOuWXrobgig/Uvd2pLVantHcvn9G4R65+PkXQUTyuNZ1aTt16/IOOgsA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv39aty-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:22:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC56ll1212143;
	Mon, 12 Oct 2026 14:22:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h80pjnhba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 14:22:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CEM2Pv49086864
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 14:22:02 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D64220040;
	Mon, 12 Oct 2026 14:22:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49DD720043;
	Mon, 12 Oct 2026 14:22:02 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 14:22:02 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Mon, 12 Oct 2026 16:21:50 +0200
Subject: [PATCH v2 2/3] s390/pci: Use 32-bit fh outside of inline asm
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261012-rpcit_trcfh_upstream-v2-2-1812db73dfa5@linux.ibm.com>
References: <20261012-rpcit_trcfh_upstream-v2-0-1812db73dfa5@linux.ibm.com>
In-Reply-To: <20261012-rpcit_trcfh_upstream-v2-0-1812db73dfa5@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Farhan Ali <alifm@linux.ibm.com>, Cam Miller <cam@linux.ibm.com>,
        Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev, Gerd Bayer <gbayer@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oRF2PEeBQdqVAYez2C7H7fmVX_DWhwXW
X-Proofpoint-ORIG-GUID: oRF2PEeBQdqVAYez2C7H7fmVX_DWhwXW
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6acced0f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=HPUu_hiRgLFouTOKksYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfXx7rL8Ml2bgMW
 zBnEiPwYdcGspYJsSQFQA5N7WlV2000n4t0IuMwBsCLYOfQNown2l2mSGmdHQY6djmHKTWAVAqH
 lXTV1x3QBbsJFRTj9X7IsXkz+X5waNA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NiBTYWx0ZWRfX+RF00t74aWTb
 v+MaJ0/3wJkT2cFJnNgFRkPpUMe33T1ShkNe2/jRX/yShWiZONbCtyymQNY4sL2X79mDcNS5w4I
 nDhCgn2mxuF+Wp4HXIkmhyr1cZ96WB6Sl3KEdNmNqNq+CJPOXUqw7nxA76jXdtI7KENI9xejvuV
 wpUcjUayFlocVFPk/kKj7rSXJu3YHlI5S+QEflYPGWjjrRSGK0BqyNPG23P8KpsLsXReVQxIl9L
 3/XDWlW8sAGTzT08piLCe+E9r51Gqu8qN2Mkceby5KFQbMomWuR89CH6tyvd5Z2hP9EHwgdvoHW
 bXlAcpjwEw8l961nTrDlnv36fX3xt1ABgS9wnBIgd9wXCaYC72dR/jhgLwoDtQ66np7GTaz99V1
 Us5Qxim5h2h4u+Nns8sDtDHETZLBTvPKUfDjni0aNJsloQZIVQZt/C/vv9f9ZIJD0AA4a3vBTMP
 LQDXoj+KIkSxL/Acp7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120056

zpci_refresh_trans() declared the PCI function handle as a u64 type just
because the actual RPCIT machine instruction required that in a 64bit
register, while the function handle is architected as a 32bit type and
defined as such in the zpci_dev struct.

Push the extension from u32 to u64 down in the call chain to just before
calling the RPCIT wrapper function. Since the struct of the typical
req's matches the format expected by RPCIT, too, create one of those to
pass along.

Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/include/asm/pci_insn.h | 2 +-
 arch/s390/pci/pci_insn.c         | 5 +++--
 drivers/iommu/s390-iommu.c       | 8 +++-----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/pci_insn.h b/arch/s390/include/asm/pci_insn.h
index 025c6dcbf893..e6613b037f93 100644
--- a/arch/s390/include/asm/pci_insn.h
+++ b/arch/s390/include/asm/pci_insn.h
@@ -147,7 +147,7 @@ union zpci_sic_iib {
 DECLARE_STATIC_KEY_FALSE(have_mio);
 
 u8 zpci_mod_fc(u64 req, struct zpci_fib *fib, u8 *status);
-int zpci_refresh_trans(u64 fn, u64 addr, u64 range);
+int zpci_refresh_trans(u32 fh, u64 addr, u64 range);
 int __zpci_load(u64 *data, u64 req, u64 offset);
 int zpci_load(u64 *data, const volatile void __iomem *addr, unsigned long len);
 int __zpci_store(u64 data, u64 req, u64 offset);
diff --git a/arch/s390/pci/pci_insn.c b/arch/s390/pci/pci_insn.c
index 1089b539aeb6..3e55adc085c3 100644
--- a/arch/s390/pci/pci_insn.c
+++ b/arch/s390/pci/pci_insn.c
@@ -116,13 +116,14 @@ static inline u8 __rpcit(u64 fn, u64 addr, u64 range, u8 *status)
 	return CC_TRANSFORM(cc);
 }
 
-int zpci_refresh_trans(u64 fn, u64 addr, u64 range)
+int zpci_refresh_trans(u32 fh, u64 addr, u64 range)
 {
+	u64 req = ZPCI_CREATE_REQ(fh, 0, 0);
 	bool retried = false;
 	u8 cc, status;
 
 	do {
-		cc = __rpcit(fn, addr, range, &status);
+		cc = __rpcit(req, addr, range, &status);
 		if (cc == 2) {
 			udelay(ZPCI_INSN_BUSY_DELAY);
 			if (!retried) {
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 58ca7727b7f2..a280ad4f63b7 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -788,7 +788,7 @@ static struct iommu_device *s390_iommu_probe_device(struct device *dev)
 
 static int zpci_refresh_all(struct zpci_dev *zdev)
 {
-	return zpci_refresh_trans((u64)zdev->fh << 32, zdev->start_dma,
+	return zpci_refresh_trans(zdev->fh, zdev->start_dma,
 				  zdev->end_dma - zdev->start_dma + 1);
 }
 
@@ -819,8 +819,7 @@ static void s390_iommu_iotlb_sync(struct iommu_domain *domain,
 	rcu_read_lock();
 	list_for_each_entry_rcu(zdev, &s390_domain->devices, iommu_list) {
 		atomic64_inc(&s390_domain->ctrs.sync_rpcits);
-		zpci_refresh_trans((u64)zdev->fh << 32, gather->start,
-				   size);
+		zpci_refresh_trans(zdev->fh, gather->start, size);
 	}
 	rcu_read_unlock();
 }
@@ -837,8 +836,7 @@ static int s390_iommu_iotlb_sync_map(struct iommu_domain *domain,
 		if (!zdev->tlb_refresh)
 			continue;
 		atomic64_inc(&s390_domain->ctrs.sync_map_rpcits);
-		ret = zpci_refresh_trans((u64)zdev->fh << 32,
-					 iova, size);
+		ret = zpci_refresh_trans(zdev->fh, iova, size);
 		/*
 		 * let the hypervisor discover invalidated entries
 		 * allowing it to free IOVAs and unpin pages

-- 
2.53.0

