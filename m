Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04505331A63;
	Thu,  7 May 2026 08:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141305; cv=none; b=vEpzNVm9gE3+VZRnlrtup8dI9TjwL+PTNh1k+3EphkNSIMmDLwN1r+QwHDZwG7+91hrSfUS4Ez12otyZRnH0Z+89WXWNkTckl1FWDZqOQUWq48IhsE6gteLMw+R6YGbmyNotHg9dXrJU+f7i18cfAPxqhFC30LxkzZDPzyI8FFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141305; c=relaxed/simple;
	bh=yjrj84kdqhwjCGSGMyg/+Vae1rKAgVTdw39SxsPSJfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JYjFcctK9AtGP85hOdt0oLocjsIh9hStDzyXCuo+5WRbJtQKgfxtbINxzxykJ4h0nsrnBQNEM7YLapOkAG9RYAenN+RXjfeW/ByeKhJ9gi2juX0t9e5fDa6KSGXxGFCW/fhdXTbzuVjzmCsi1EhduFfh7/zaJmMiQW0zCG4+9Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Bb/AvMxe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Bb/AvMxe"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646IHhRq2197452;
	Thu, 7 May 2026 08:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=ngM2xZXstaL18Z562b4cx/ebx6oq
	5+jEYS9FV3beDa4=; b=Bb/AvMxeHfuRUEw9Hku1QVNZUQLF33jBw4KselbGwanj
	oGp+kfESOwZLC2X8La9pKvq5B9j7nV6l3PBsVAOFmqwbFALqMAc0pFMwKxA9gkS2
	ZbzX78QRGUJt5xSYYTf3/R32S0cUJhRKdjxOa4+cMHQ9NP0/2/VqAVT6jyInimNi
	1wPJpSJdUF2OQRZSeQd5VBpgqi8OiAKGooZCRkQiZrGChOZ6vB8gp5SWdeVCj6ID
	PMKUnm4atCmFAsd0iN++iTUmhXqzjL7JKJhhgKxYUvRSXLwFCrtAdo65g4Yinorf
	EbPqrOdu4x11vzDpicn8B+Ynhy87CbwgxrOGBCrwsA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9w6m05g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 08:08:22 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6477sURJ003178;
	Thu, 7 May 2026 08:08:22 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwx9yhupx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 May 2026 08:08:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64788Ij835127704
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 May 2026 08:08:18 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 879102004E;
	Thu,  7 May 2026 08:08:18 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B9492004B;
	Thu,  7 May 2026 08:08:18 +0000 (GMT)
Received: from [9.52.198.32] (unknown [9.52.198.32])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  7 May 2026 08:08:18 +0000 (GMT)
From: Christoph Schlameuss <schlameuss@linux.ibm.com>
Date: Thu, 07 May 2026 10:07:32 +0200
Subject: [kvm-unit-tests PATCH] s390x: Fix typos
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-typos-v1-1-053d804f27b8@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/y2MQQrCMBAAvxL2bDCNYkq/Ij2kca2LJKnZbamU/
 t2gHocZZgPGQsjQqQ0KLsSUU4XmoCA8fBpR060yWGMv5mydlveUWbvghlPbOtNYhNpOBe+0fj9
 XeC5Rz4lEC7Iw9D9f8DXXvfyjwTPqkGMk6VQuNFI6Rs+CBfp9/wDQPVaqmAAAAA==
X-Change-ID: 20260427-typos-7c7b3887012e
To: linux-s390@vger.kernel.org
Cc: kvm@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        =?utf-8?q?Nico_B=C3=B6hr?= <nrb@linux.ibm.com>,
        Christoph Schlameuss <schlameuss@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2395;
 i=schlameuss@linux.ibm.com; h=from:subject:message-id;
 bh=yjrj84kdqhwjCGSGMyg/+Vae1rKAgVTdw39SxsPSJfM=;
 b=owGbwMvMwCUmoqVx+bqN+mXG02pJDJl/PEImfgrturX9imt/bvSrjW93xvV9erZQTvXV0iKXy
 suLPVKmdpSyMIhxMciKKbJUi1vnVfW1Lp1z0PIazBxWJpAhDFycAjCRDHOG/wUBPzdLqxy9oche
 dUxxYrPr1J5dP+e+uT9dOnuy4sbblzcx/FPeU7n3cYYZb4vCzmU2rUocthdOLQ1Nb2qaI178Vsz
 UiB0A
X-Developer-Key: i=schlameuss@linux.ibm.com; a=openpgp;
 fpr=0E34A68642574B2253AF4D31EEED6AB388551EC3
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XPQAjwhE c=1 sm=1 tr=0 ts=69fc4876 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=1_14vDzSKYOnwgG9MkgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: kt0v24p8i-E1Gz6tmrSQtHSJK6PK1cs_
X-Proofpoint-GUID: kt0v24p8i-E1Gz6tmrSQtHSJK6PK1cs_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDA3OSBTYWx0ZWRfX+/zTbDFytIB7
 8lUXQfQMGw7NlRJ5rQGrRVZMIafV+OJNNqYGos6D7nawk19PjLPiBXBw2NfTmHIgQAAzm6jn2vU
 DRntyQj298K0qPz+mXo+RA424SXZp7OXe4nBuF1hksGuKOgGBVJU3h6I/D55qZjiOtDCdd/iUpU
 HT0yl22IY81qbm4S+RdN4Sg1AcGFBEf0YE8mNwQCYCjhVLO/ohNP8ML5FWG8KpWLKDxjzATgU69
 uGP/R7hF6tv7tH08ftBhW9w1NqwCKaTic8ZHCYCgqm4U/raOgAEOfkppjrdJFf1SoddQXvMKOFM
 EJwBN8Co19o5n0xMjkKj/HiyIS0akS+DWCcEp+2cRsawL23/ckY4nniIYWqRqhH3GzPnkoDGigE
 iofPynw7M/lxN7ZXix1+058DHT3B7Sl7MtjRFQGSTjh+YoyTvtqFJFGr8jxoXdmzTmW+3UoB1hx
 tUd8B0qm+ak+HmY+cpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070079

Fix typos that have been discovered with the "codespell" utility.

Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
---
 lib/acpi.c           | 2 +-
 lib/s390x/css_dump.c | 4 ++--
 s390x/adtl-status.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/acpi.c b/lib/acpi.c
index 0440cddb9b54..4c820e1759c7 100644
--- a/lib/acpi.c
+++ b/lib/acpi.c
@@ -79,7 +79,7 @@ void *find_acpi_table_addr(u32 sig)
 		return xsdt;
 
 	/*
-	 * When the system implements APCI 2.0 and above and XSDT is valid we
+	 * When the system implements ACPI 2.0 and above and XSDT is valid we
 	 * have use XSDT to find other ACPI tables, otherwise, we use RSDT.
 	 */
 	if (xsdt) {
diff --git a/lib/s390x/css_dump.c b/lib/s390x/css_dump.c
index 2268086514ed..86f84e0cbcd3 100644
--- a/lib/s390x/css_dump.c
+++ b/lib/s390x/css_dump.c
@@ -12,9 +12,9 @@
  * - ORB  : Operation request block, describes the I/O operation and points to
  *          a CCW chain
  * - CCW  : Channel Command Word, describes the command, data and flow control
- * - IRB  : Interuption response Block, describes the result of an operation;
+ * - IRB  : Interruption response Block, describes the result of an operation;
  *          holds a SCSW and model-dependent data.
- * - SCHIB: SubCHannel Information Block composed of:
+ * - SCHIB: SubChannel Information Block composed of:
  *   - SCSW: SubChannel Status Word, status of the channel.
  *   - PMCW: Path Management Control Word
  * You need the QEMU ccw-pong device in QEMU to answer the I/O transfers.
diff --git a/s390x/adtl-status.c b/s390x/adtl-status.c
index 2db650a13fec..aa1c4e9e06be 100644
--- a/s390x/adtl-status.c
+++ b/s390x/adtl-status.c
@@ -265,7 +265,7 @@ static void __store_adtl_status_vector_lc(unsigned long lc)
 	 * To avoid the floating point/vector registers being cleaned up, we
 	 * stopped CPU1 right in the middle of a function. Hence the cleanup of
 	 * the function didn't run yet and the stackpointer is messed up.
-	 * Destroy and re-initalize the CPU to fix that.
+	 * Destroy and re-initialize the CPU to fix that.
 	 */
 	smp_cpu_destroy(1);
 	smp_cpu_setup(1, PSW_WITH_CUR_MASK(test_func));

---
base-commit: c634d671b1801a97b774e6601a9f6774557541d8
change-id: 20260427-typos-7c7b3887012e

Best regards,
-- 
Christoph Schlameuss <schlameuss@linux.ibm.com>

