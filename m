Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8197224B17;
	Fri, 24 Jan 2025 20:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737749924; cv=none; b=r2TpUK/ktaeYsyabmWJMfKL8fiXw8S1579lmgBSoHx1yc3XVcCAfWweAk719UgDqyidF8phvBr42b9cZ/97viSk0nYWk8PuIOIqsT9kzXvydvzY4SFa1BPRFYohtt82PRwqG2uoP5dJ4S8P4nmg4+DZk61wlgXzZrHRCf+p2WgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737749924; c=relaxed/simple;
	bh=gFJlh5FpxadZvFF3Fp2bfM3iiP6nkjXh+Fp/SHKkURw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lua95gPoVcyKQSrYyelPKcZfGg4oTVjysrdGJhL1uGtKZ0hyREYNpDwHA39Le8pSlcaG6IE2wYVMtCiWWovRk35JBLbXlQ08Nq1uB17YCvF9Nik/nr1AzQvn3X+S0tPq8FjGIcR8KEaFvxQeGBNJhjgyYOu6i8NuSsLa+9irxAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rW6Pqu6L; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rW6Pqu6L"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50OF1LXW017670;
	Fri, 24 Jan 2025 20:18:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Z9hyEFCw+pPfD8qKo
	QnIAw7Ga05MM/IzXe254/5QcuY=; b=rW6Pqu6LCvt6xv7ycadYyUb3WpaBWhzd3
	vpHdnd8V0K3ewk80nZhebh7nW9UZgCSH9iRbHoroUhBqgOkXfnk3cWeyUYc53/Fq
	RAQ/ysFxdoDqE6+gHXDmYZ/7GwU4+Ytt4SxU4Ys8/tzOT3kI2rrmRszy8XoIb82D
	01n4hU9lXk9XvRy49WKyLDmz/sX2cbIe0I/PfZFOluq9Pzky84HLvOtK811dDhmK
	e34Nlq8f2LMEP9/eOkyPLW9HYDNfKE8wBftGD3j1oDgJv4C1z2JFVsRC54KuP7Ef
	+FtKQsXts5FAePuRgBOFUwESI3r3rKuIt6NAED07olMSRZJHJhWEw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44cd4yhjey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 20:18:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50OH7SpP032266;
	Fri, 24 Jan 2025 20:18:31 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 448ruk4wcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jan 2025 20:18:31 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50OKIV5525559804
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jan 2025 20:18:31 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CEAE58051;
	Fri, 24 Jan 2025 20:18:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F2BDA5805E;
	Fri, 24 Jan 2025 20:18:29 +0000 (GMT)
Received: from li-2311da4c-2e09-11b2-a85c-c003041e9174.ibm.com.com (unknown [9.61.77.196])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jan 2025 20:18:29 +0000 (GMT)
From: Matthew Rosato <mjrosato@linux.ibm.com>
To: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clegoate@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH v2 2/6] s390/pci: set appropriate IOTA region type
Date: Fri, 24 Jan 2025 15:18:22 -0500
Message-ID: <20250124201826.348848-3-mjrosato@linux.ibm.com>
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
X-Proofpoint-GUID: 7J6feF3Qa4MpwosWhym7kHYUkclKfYFJ
X-Proofpoint-ORIG-GUID: 7J6feF3Qa4MpwosWhym7kHYUkclKfYFJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-24_08,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=873 priorityscore=1501 adultscore=0 malwarescore=0
 phishscore=0 mlxscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2411120000 definitions=main-2501240137

When registering the I/O Translation Anchor, use the current table type
stored in the zdev to set the apporpriate region type indication.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/pci/pci.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 88f72745fa59..9f7adf913729 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -116,6 +116,21 @@ int pci_proc_domain(struct pci_bus *bus)
 }
 EXPORT_SYMBOL_GPL(pci_proc_domain);
 
+static u64 zpci_get_iota_region_flag(struct zpci_dev *zdev)
+{
+	switch (zdev->origin_type) {
+	case ZPCI_TABLE_TYPE_RTX:
+		return ZPCI_IOTA_RTTO_FLAG;
+	case ZPCI_TABLE_TYPE_RSX:
+		return ZPCI_IOTA_RSTO_FLAG;
+	case ZPCI_TABLE_TYPE_RFX:
+		return ZPCI_IOTA_RFTO_FLAG;
+	default:
+		WARN_ONCE(1, "Invalid IOMMU table (%x)\n", zdev->origin_type);
+		return 0;
+	}
+}
+
 /* Modify PCI: Register I/O address translation parameters */
 int zpci_register_ioat(struct zpci_dev *zdev, u8 dmaas,
 		       u64 base, u64 limit, u64 iota, u8 *status)
@@ -131,7 +146,7 @@ int zpci_register_ioat(struct zpci_dev *zdev, u8 dmaas,
 		fib.pal = limit + (1 << 12);
 	else
 		fib.pal = limit;
-	fib.iota = iota | ZPCI_IOTA_RTTO_FLAG;
+	fib.iota = iota | zpci_get_iota_region_flag(zdev);
 	fib.gd = zdev->gisa;
 	cc = zpci_mod_fc(req, &fib, status);
 	if (cc)
-- 
2.48.1

