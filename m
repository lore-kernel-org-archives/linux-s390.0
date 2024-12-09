Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3101A0BC0;
	Mon,  9 Dec 2024 19:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733772372; cv=none; b=ZnoMwa82GQ+CfdJxLkyI0W3VOsMIq01xmH+NqoWxMd1zhznBcZIRr10VdmcrWLM3GfjT5muwS3HHFIw6QzGUXNqiqj0f38E6zbCjlMnQszLI6itCVODXCcFfJL+BEDVnFb0MBFTm0DThbw1kGi3BBAy9OfNssmavk87teRSztkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733772372; c=relaxed/simple;
	bh=Ctkvp9MYU5c6ZxozXGYpe/mnjejPZAZzg2dizRoLEYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tiQ2Ii1/eGIeXpZ1epi5KB1UrgcX+vzFvLFoJiaCUt6jdK4Gq+/ICMFhhrCJF96zMTcZQN0VOGITZcN+0V7Uzvjn3qhpvi06mWx6WR05E8M31w85oo/f9DwVP7328JM0Zuk4YkcA94BTdsrOBKkRn2EuRPUswkWJ2jTD9zyOc9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OdRt1gT+; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OdRt1gT+"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9AD9qX019481;
	Mon, 9 Dec 2024 19:26:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lD+okMqmTBth5ZV/u
	A89GNS+iS4rJ2NggJAIkLOozw0=; b=OdRt1gT+aH6G81lA210FGLd3aV28SLCmH
	Cu+57u9GraGNQ/AQ17skgZVeL/2lKNfo6IzF+jFKcBlZPuWpDzAXPyvyDYKMHDTc
	RmzTArnJAbsjaN9/Nyp/8FMSBjPI7M1L71pQMT6OzMEYjWCOlGrUpUoJYYys4r3g
	+UpNXrjukCFnlm52+KQkfAGajmR96Je8Zp5n4ZG4HPqCTIcOz53U2i4XsYD8x0x6
	/BfsRvTtZmrHKoDQLIrSf7Dq6R33zvHmiG2g5hc4YqMVedTdDsZ1Df3kamlfxJcY
	wyXX1MlC9fRphyf6f/RQKU3+zWUPOjoOSz+heRyRFm+CmZRgAKBhA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43cdv8k7ne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:25:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9Ix6jv018636;
	Mon, 9 Dec 2024 19:25:58 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43d26k80hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Dec 2024 19:25:58 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4B9JPvXS24772966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 9 Dec 2024 19:25:57 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 627A758059;
	Mon,  9 Dec 2024 19:25:57 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4EE4758043;
	Mon,  9 Dec 2024 19:25:56 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.107.222])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  9 Dec 2024 19:25:56 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clegoate@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 5/7] iommu/s390: support iova_to_phys for additional table regions
Date: Mon,  9 Dec 2024 14:25:47 -0500
Message-ID: <20241209192549.107226-6-mjrosato@linux.ibm.com>
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
X-Proofpoint-GUID: xS6pYYbtkqR_yZuNEQe-__wljMJsgX6g
X-Proofpoint-ORIG-GUID: xS6pYYbtkqR_yZuNEQe-__wljMJsgX6g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 mlxscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxlogscore=969
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412090143

The origin_type of the dma_table is used to determine how many table
levels must be traversed for the translation.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 drivers/iommu/s390-iommu.c | 42 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index 5782f329cae9..cea528bf61db 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -744,6 +744,43 @@ static int s390_iommu_map_pages(struct iommu_domain *domain,
 	return rc;
 }
 
+static unsigned long *get_rto_from_iova(struct s390_domain *domain,
+					dma_addr_t iova)
+{
+	unsigned long *rfo, *rso, *rto;
+	unsigned long rfe, rse;
+	unsigned int rfx, rsx;
+
+	switch (domain->origin_type) {
+	case ZPCI_TABLE_TYPE_RFX:
+		rfo = domain->dma_table;
+		goto itp_rf;
+	case ZPCI_TABLE_TYPE_RSX:
+		rso = domain->dma_table;
+		goto itp_rs;
+	case ZPCI_TABLE_TYPE_RTX:
+		return domain->dma_table;
+	default:
+		return NULL;
+	}
+
+itp_rf:
+	rfx = calc_rfx(iova);
+	rfe = READ_ONCE(rfo[rfx]);
+	if (!reg_entry_isvalid(rfe))
+		return NULL;
+	rso = get_rf_rso(rfe);
+
+itp_rs:
+	rsx = calc_rsx(iova);
+	rse = READ_ONCE(rso[rsx]);
+	if (!reg_entry_isvalid(rse))
+		return NULL;
+	rto = get_rs_rto(rse);
+
+	return rto;
+}
+
 static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
 					   dma_addr_t iova)
 {
@@ -757,10 +794,13 @@ static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
 	    iova > domain->geometry.aperture_end)
 		return 0;
 
+	rto = get_rto_from_iova(s390_domain, iova);
+	if (!rto)
+		return 0;
+
 	rtx = calc_rtx(iova);
 	sx = calc_sx(iova);
 	px = calc_px(iova);
-	rto = s390_domain->dma_table;
 
 	rte = READ_ONCE(rto[rtx]);
 	if (reg_entry_isvalid(rte)) {
-- 
2.47.0

