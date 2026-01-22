Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AB7387597;
	Thu, 22 Jan 2026 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769111122; cv=none; b=ILAANqaGLRD3Qjf/PfdUyI2sgXJuSJ0/faui5Pc+1KXN1ASY0UihCax567c0qjY5U1D6cQaz0kZpbk3VrTw0Mo7dKee8X+o1iSzyQtc2DlS+JTM0ZdBMm0Lh8q3Fv0IwpdvsXU7VtuMaQ41l64BTM6DE8mNxRJMamxzxv4MBDwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769111122; c=relaxed/simple;
	bh=GDZAjiH5XdtX4onMuH1IiC67RRALM5b5a+nsV2ECRgU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gKTB8jA1JdCHrTvak9Tl/e2lKDRQpYDhdc9fqPtmZsHGrjCP+VUNLGA1l8Ad/52Tpcu2E87fJIBB5XPwGkHYyDiTN+P9b3GVm78wOrsVN3IyBfRWz/lT8bORWcppktel0Fn3nF9IFBqSxrlM6SQkUqjIwrXFBRAPvLZRrkndD2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KsxYmKL4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KsxYmKL4"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60MII1Zk007604;
	Thu, 22 Jan 2026 19:44:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=3TyrxEiRSJ0hxwj9f
	M9XUyOEsX3cDVm7CHqiQQUO200=; b=KsxYmKL4rv/2E6IoQMZASTHSNHd41OD4w
	4zk7KOvK8mUsLyeUVfcHIJe9vigmuLFyeJ69HbueoAcm4e4CZIJgTJOQEYVBdnnq
	aXPMVLBUuWz1sp+4IjdaBBSCWxbrb7UhYkos9Cz9ZzgoV5nlFTIFk8bYjWigqRXb
	cwGHgL9qlc+xNnEyfaEiKhgTi45rpnZpaJ7qbQzDduyTP0Bg5heSSbrofYbknjTV
	Hh0f77WViN7o59TPOuLOEg/X9/0CDNPPLJVFpBGj0U8I0EckP5uQL8PK4JKGvsPg
	v+r70g+kLCAB5Y5++yu1SFKzUE4hjd0hqCRIpjynr8HNoFFgH+j3w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bus1prby7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 19:44:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60MIwopP009377;
	Thu, 22 Jan 2026 19:44:49 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brp8kme8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Jan 2026 19:44:49 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60MJilc827394646
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 19:44:47 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7FDC58060;
	Thu, 22 Jan 2026 19:44:47 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBEF858056;
	Thu, 22 Jan 2026 19:44:46 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.216])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 22 Jan 2026 19:44:46 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, julianr@linux.ibm.com
Subject: [PATCH v8 8/9] vfio: Add a reset_done callback for vfio-pci driver
Date: Thu, 22 Jan 2026 11:44:36 -0800
Message-ID: <20260122194437.1903-9-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122194437.1903-1-alifm@linux.ibm.com>
References: <20260122194437.1903-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Umi-9944ogRBAjgU2DQbrQ8t3WFnXHR1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDE0OCBTYWx0ZWRfX1KukSXJYJMRc
 vbUJhPJfnNHvsXIulc/BLu9XFkXQV3IAzeMMB5Cvgzbz9rSdnjznjR/Fm9eUPx7lm9clQwYvYAk
 YUl5OHiX0QHpoJwrFYYHfxjJkHUSs2QzOhK4gbwKzkdRB+WB4YyQ9D0pKLFA/YbZppPGxdMJ9Kd
 XqFwkFNlhlBtlUvdOtVvmVBs4b2PFmed6WBfmnOttjrijLkPV+JvX8lGcDhrzY5+yuNEk1etx0x
 WK2DfykZGzKoBmCG+ccKlv9mj1jP9n1axeSKy4ge9E626b7n9FXntscjVQbdF+NXjOXfBNAzRxo
 O6fit+gLpZaklQTiD4u4RuJcB6ecUltxtV7hlifJ+mcrWlGcH/b8yv8VuGnZKPQi7lBXQGJsGAs
 AEntxPMQHJSshTGCqKetWfhWGuex6pvPGDOJzgjYklnCNV4gxDHMLpKEA5k8LJma7P5s4cT+mL9
 fM5L7MsQ9EZD4sIgVyg==
X-Proofpoint-GUID: Umi-9944ogRBAjgU2DQbrQ8t3WFnXHR1
X-Authority-Analysis: v=2.4 cv=GY8aXAXL c=1 sm=1 tr=0 ts=69727e31 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=hcTHx3Z5Akp3fEzgVBYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_04,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220148

On error recovery for a PCI device bound to vfio-pci driver, we want to
recover the state of the device to its last known saved state. The callback
restores the state of the device to its initial saved state.

Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index f677705921e6..c92c6c512b24 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2249,6 +2249,17 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 }
 EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
 
+static void vfio_pci_core_aer_reset_done(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+
+	if (!vdev->pci_saved_state)
+		return;
+
+	pci_load_saved_state(pdev, vdev->pci_saved_state);
+	pci_restore_state(pdev);
+}
+
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 				  int nr_virtfn)
 {
@@ -2313,6 +2324,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 
 const struct pci_error_handlers vfio_pci_core_err_handlers = {
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.reset_done = vfio_pci_core_aer_reset_done,
 };
 EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
 
-- 
2.43.0

