Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9503F395D8B;
	Mon, 13 Apr 2026 21:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114417; cv=none; b=EnSBLXy/TtWLlIvef589A7Du3kDGTbB+yVG7lJBa1ZelQixGXuVL9k4A/xWYO2XE4fdwT1UApQHd7KtUC/RdIW0LnMs2+/HKODijN8XwAL5MvyRUbAjDUEG3uAMo0hpztW1Cht0RfDQXBhXxeJYjk3gsfq0w3+7fFd2RSXcAFtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114417; c=relaxed/simple;
	bh=RQ7upiRfX+foiPulhHXu+Aw1uutRmHWJ0l3TcJW8bxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p6ShmQBfzEWiZZSp3Fe9jFloCOTYVxJ3WzjQafcWa4N8ZECWPt0zh2V9+kUZ/kL4ZLG5S3pZNrEhQaBMlzNzs+wOQa8cSNVtmiqCd7qoQLa+98hwul3L0KoWNLDJxjxo3XFYsTVbDS3dKlL8KrcAX86Hlax+jsJ+I8S6fqcTqYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=e1h1y/d9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="e1h1y/d9"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DEZ1xg3239865;
	Mon, 13 Apr 2026 21:06:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=l4yp/nvZGr9Da+6Zm
	RXwpQEFsXLYyw/698zFD8SAETM=; b=e1h1y/d9FYN8S8FHPwT+jc56rCE6cdc3N
	5MIlulKICXtWP4hzFqvDYve6uBHCSYhlDVoRKpTE1ZHPh/0WSdkYuDD4kHbQsa31
	EBzovO2q2iBYcvvjcTI/Cbubp6zKvGHCJ3nzlMzaAtZErMSEyDBIk3purQ3oWUmi
	Oehaoq2A1XgEl6F/E4YNeA9POeF4q5DDYpAQBj4qohPMegrDiZdrZh7mFgoxqjPL
	gfRpZGKzHYOydmpUCyU8beIoT23IW8aQbJcLwxB9LDEhOCb0cwoleERVSvgLpJNw
	RbtfEdtS9CYgRDzBOxgeKWlUdV6uE9TqZyfLzJAYjD+GnYAhUSVTQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfe17sr4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 21:06:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63DI0ZLu004569;
	Mon, 13 Apr 2026 21:06:20 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg24k6sqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 21:06:20 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DL6J1K26542604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 21:06:19 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 116705805D;
	Mon, 13 Apr 2026 21:06:19 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC8D95805A;
	Mon, 13 Apr 2026 21:06:17 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.131])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 21:06:17 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        kbusch@kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v13 6/7] vfio/pci: Add a reset_done callback for vfio-pci driver
Date: Mon, 13 Apr 2026 14:06:07 -0700
Message-ID: <20260413210608.2912-7-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413210608.2912-1-alifm@linux.ibm.com>
References: <20260413210608.2912-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDIwNSBTYWx0ZWRfX/uWGCs6paNcH
 UGS4aOioLSMmG94g8LQx+X98dtaC8M2pgQIosJe7Yr4dxnoUrq2L2YhUxwOzcABuwefDJCLnn9z
 lR7iDtlT00ePBKFy/XSE2eA/StH+vj5r9bXieWNIJtN7HYV1Fwzv0s/qM6sKEVtbw2cBxaSK5OG
 xreDaTkYGfl37oT6WVxHVE3uz4kt+ebHckFFtAxpX9XmSh6iGBj67+PUYUIfpes0ZfwZjl8yomF
 JVHSGA5O5DDmPex5iZDCRoQjRoOrzLsc64ADkVN4ZpyQJDOPP3R6FNhYRu+Ej+C4ZyS1CPgVllx
 wWitNLLlKs9gHm7b/VrHXo0dY7HRapz60zNHEdciWdWH06+xS6BEvd4RxHhQoi3dUTTSQXn72L1
 abjiK7WFgpReBbhIlNmgxxthenVCybKQpeUCBHgVuwSCW1AdYsBxVkplS01TcKyemJNhTeQKLka
 s0jtNsJZ8quLFnZzuDQ==
X-Proofpoint-ORIG-GUID: 2mCHqnnhgccoAOpnpjXWDmTjpLROSXDB
X-Proofpoint-GUID: 2mCHqnnhgccoAOpnpjXWDmTjpLROSXDB
X-Authority-Analysis: v=2.4 cv=SrOgLvO0 c=1 sm=1 tr=0 ts=69dd5acd cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=hcTHx3Z5Akp3fEzgVBYA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015 bulkscore=0
 phishscore=0 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130205

On error recovery for a PCI device bound to vfio-pci driver, we want to
recover the state of the device to its last known saved state. The callback
restores the state of the device to its initial saved state.

Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Acked-by: Alex Williamson <alex@shazbot.org>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index 5403730786a1..4485d85e4419 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2255,6 +2255,17 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
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
@@ -2319,6 +2330,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 
 const struct pci_error_handlers vfio_pci_core_err_handlers = {
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.reset_done = vfio_pci_core_aer_reset_done,
 };
 EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
 
-- 
2.43.0

