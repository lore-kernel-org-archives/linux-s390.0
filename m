Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06637471D0B;
	Wed,  7 Oct 2026 11:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791371282; cv=none; b=H8BIRbpt8wiOVst352hpWE+aNroslSp+/XZxBE3/cyFe5rj1LBvpFOcxrYaWpLhYhk/KniOveykaxQASdl1J7oT3DjJbJyIsepwV/dh+FQRVBJjH9BEyRqfAMfYknByW81xvto3I/NBel08mCs3uHZuJqLAPiSkg7imQIhh/YQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791371282; c=relaxed/simple;
	bh=6dbWrzWe99gtpClM8Jac9G78rddxxTZt/zlqaSS9AqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eo3bBEcO7idU90VA7kS0AEWq+PFFrP7WV3oWmsVNyEt5IHN65DaYVJS61COgMZ9Eni3xjTRlWVePloTWFuRuYEyTB7d9xlDbyePN4AUdUiJDI8Xw0RtsjwcusMAAGBmJoA7ecAUuxJrKekAhc4YXtvizeMT+6GktSzzRj8PYzvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b72GAw8E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b72GAw8E"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69785eFJ1949236;
	Wed, 7 Oct 2026 11:07:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JIO32L
	Vp/DKGp83FztyjC4zu5Pog+bzQ/Z92n09AB24=; b=b72GAw8Eo1XErVOVqv4vDX
	zsnQplGVNOTglYNFncf6qE7gSIwzPmRSGOAw/CjaU+knjFQsJh5EDhCvD1jt6k/T
	zSX28IgPORq5OW4rOTx7QWsMOiC5M97fLJc5/C4oLFnG6CjhgdN3Q5Eg9W7Joxsu
	qogAQKaCajjeGEcT1ATgGhtDIavR+5uNm7uWd1s5Hv8aDK8SrAWVfuFwEqtckMmW
	K+/CsvyUH3m/kRX80CqO/Pyh5CJRJZ6SLPs4cU7z0Nc26AxhNycT1pO/elvUR+MR
	FXTDD6MCEts+OcEUjfih+2yzjv5HmDYFXOGGzpf/YUTtLlG1BGoAziS8SDbUu67A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2se5n0jj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:07:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69782RA81562410;
	Wed, 7 Oct 2026 11:07:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3cdvxbvq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Oct 2026 11:07:11 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 697B77dW30933630
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Oct 2026 11:07:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B5AC2004E;
	Wed,  7 Oct 2026 11:07:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E4DE320043;
	Wed,  7 Oct 2026 11:07:06 +0000 (GMT)
Received: from [127.0.1.1] (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  7 Oct 2026 11:07:06 +0000 (GMT)
From: Gerd Bayer <gbayer@linux.ibm.com>
Date: Wed, 07 Oct 2026 13:07:03 +0200
Subject: [PATCH 2/3] s390/pci: Use 32-bit fh outside of inline asm
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-rpcit_trcfh_upstream-v1-2-8a2718cfb90b@linux.ibm.com>
References: <20261007-rpcit_trcfh_upstream-v1-0-8a2718cfb90b@linux.ibm.com>
In-Reply-To: <20261007-rpcit_trcfh_upstream-v1-0-8a2718cfb90b@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0NCBTYWx0ZWRfX26UnW7RslBct
 BVS1bzrR34NFR13CpJmUMZmF6Z/jPlID9tpymV5Ssha0Sj0zvrwjQ+AWq2cNIbESPXdIHqhq4qV
 6dEg2iNw3C4qeGrPvJ7NuoElkzQhIQ4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0NCBTYWx0ZWRfXw4argaX+Knuc
 YAIqDmmtjl9Wv6JsAjSdYedYyhtHsyUcs/PHYah+OGHMEtVTFXYXsYknroZ3VmGYni4WWIJJdiT
 Xv969yyCFTHy9oWqa2VK5A5d4DzHx+Ec9f0PAQg8yeC+KekdA68FeDvw3eyxpTgSy89Rpqcud9t
 uRL30vFGR+0CXzKoLKhk1snKWcJ1EuauQCDjSwtlMxoBf1f89DItcpkiaNLYpt3DznXQY8FYrLu
 Io/5lNzeNPGKHkgj+Ozl3JpsdgAbXW2Vv5/LRPvBErf4Nrpkahw7o+nWgtWIpOI+MMpr3xI4Cgm
 sAgHcjvWrscS0zrGUKlt0FH+DX0aa/bwBl/MiDtPjZiTq4cj/jgMg74/xWPRvnWcDMUg+Xm9O0W
 i9P2hqHCYerYdlSxnBNOZCYiLqZBISM4v2dGkJ680EWJA9BwbwGXJiEzuHWG3l6hi0D2XpX1SDt
 tH48SSh6T//9BE7TJXg==
X-Proofpoint-GUID: a1xq5eNb32OAEstraAA_FlBtsRsx6CN1
X-Authority-Analysis: v=2.4 cv=UNRIjyfy c=1 sm=1 tr=0 ts=6ac627e0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=HPUu_hiRgLFouTOKksYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: a1xq5eNb32OAEstraAA_FlBtsRsx6CN1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070044

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
index 2ba787e2304b..053afb3e7a99 100644
--- a/arch/s390/pci/pci_insn.c
+++ b/arch/s390/pci/pci_insn.c
@@ -117,13 +117,14 @@ static inline u8 __rpcit(u64 fn, u64 addr, u64 range, u8 *status)
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

