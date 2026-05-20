Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371033F5BE1;
	Wed, 20 May 2026 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297089; cv=none; b=C2bXSlx4hY4H5Nw1utsZhzIaQ5Wa1I4p10CgzbzWw0s1iL3NoEI/T1x9sA+TxElbMbl+ZGTngAm37//E8kLLYQ7XfaNNsi1S2YEtmBkkC8ehMRmrzHt5H2hxzeif/fY4Abp5gpHmsYrLX8jkp4s+X4xXFGb606nLKItOjXdN7hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297089; c=relaxed/simple;
	bh=DPuQiBFXmj6qUVY/YkNJPHp+MeEXaiSp/X7OtW8VYs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VzP7nsQu4yDEoWb0v615QgsJYZP1wLy8HpIcOD1S8bpZe2ojg2/AwBByqMJgMjB4k2jPjPx0POkSafFKYkiK7FD9DX9i3C+Pcc4oHYYDkMxVCrZE5ebD4vSAQDSSCS3CrLfqXY/MLNNJFsAPV3gV7ezJEZ5JLYFeMcK4zGYRsLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fYuYGY/P; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fYuYGY/P"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KBXoN1685729;
	Wed, 20 May 2026 17:11:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RGkv2CTMss9f/2VtB
	3Jlrn9K0Sa5hXqXwOD6mlaP8jA=; b=fYuYGY/PylYHDgLJwmDS3UTYi7tOsBJj/
	5wJ3ytQpn56FAW00bct735WwJsiH+hABu4KEOzFKrtw+5HpjxaZUcmWUy8yrDFKN
	NAV81ExfVSCofgBKvwL5w2DqnWOEeDaTj1zOo/ZvJegLXMlEZ5MzZoxCf6JbHD4m
	rTXr6AfGhOAlN50ehZUa3BUQFR/JlRVeWnwHll0MfQ5pcpDYlbBz9751ZbZBHjuC
	qCAsPVhzc6RexOkNoGFKhVSP3qfbbSDD54ztyqVC+XtmtlFz+TKrj5n8g8yrWfr0
	hHSqFJuVwGEnJAebA7PZi7rys2bh4EMnrX+fWUPWHLFJA97tK3Yeg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88j51y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 17:11:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KGsA9n013500;
	Wed, 20 May 2026 17:11:23 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk8agc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 17:11:23 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KHBM4Y28377808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 17:11:22 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E5B45804B;
	Wed, 20 May 2026 17:11:22 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5D19D58055;
	Wed, 20 May 2026 17:11:21 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.255.46])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 17:11:21 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v17 6/7] vfio/pci: Add a reset_done callback for vfio-pci driver
Date: Wed, 20 May 2026 10:11:12 -0700
Message-ID: <20260520171113.1111-7-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520171113.1111-1-alifm@linux.ibm.com>
References: <20260520171113.1111-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3gS-ICtnaATCTbyQVeOR8JsakyBDLE1X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE2NiBTYWx0ZWRfXzBWnZVkmoMkv
 UI2tw3/ctZGeREQqIZjv58fY9PRXAjqELd5f9Dectu7VWvY9DnyIpmZIpl/vUt3pWNipUNiSmub
 6LvujH8SB1SIQOAV8eSPtnFLiJjup1yHGN2nvlG17ViYL1jUBdtV88ZYfmVWzmnUNuCcX4as/TN
 T+YhdNfzPHME+yXlKW07OcT6DaBih9LjGg4ccotqJExLMlF/RMKCugEIPbKbHk4UeyxP4qU3kU/
 JJkzk/uLBFnDUeaN5XWcQotnGjg6/rjoXPD/BwHQJq+RyyxIS7xO7ThL88ktuPWjYmrBiyz9zvm
 qIRN2yY3dhuW1blmyxAlFcw2Lz4BpXCQTytFfb/2WuY92C2wuIr4EiLodhYFV+sXVClZQU6JsZI
 mAhPkAHgVVcWShkbMckVguLcqQZqEueNOh5yY1sEURSs4wGKkyAUeKbKXmekKdiCPtZ7/0FLoUe
 zVOHFBJLsK6W/Z84uGg==
X-Proofpoint-GUID: 3gS-ICtnaATCTbyQVeOR8JsakyBDLE1X
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0deb3c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=hcTHx3Z5Akp3fEzgVBYA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200166

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
index 27642f10fe97..95af3e827ee0 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2290,6 +2290,17 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
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
@@ -2354,6 +2365,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 
 const struct pci_error_handlers vfio_pci_core_err_handlers = {
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.reset_done = vfio_pci_core_aer_reset_done,
 };
 EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
 
-- 
2.43.0

