Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BC23E3C4A;
	Tue,  5 May 2026 20:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778011525; cv=none; b=L9V/z1ZPVJebQYbqEZow/5V7XIbCmiYk+MYIkiNNyF/zt/lUMtqksyqnNhodst5ctyeFv283LkGgQtTHeTJBAGiRrvRhKsU6G5ZzBTqgLA75ATWeJrL1q7cTX8KJob97XAhY9wJdbSMi5140IKnK+D/IKAIGLT3nUWzhCVzL2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778011525; c=relaxed/simple;
	bh=P42YvZxGI5G2cnEEMsTCKfL+1dhOLbI9ogZtc8OaZ64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LJXYpdVR7mt49YQ2BcUDEVKVQWNLaHReCOuAhvoKNSW23LhO+utLES3gl+0D8UwzlkmmnETnmxT2m1kY3fMaIjpi+V7BswAgO3mZ/bsssMfweFIDmPkGKb199pRCZYB9v1+aOsbBgezBB7t0mk7jZDxqXKNgkJqXwqFRBqXzPzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s+K+Mxcc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s+K+Mxcc"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645DdqgS2469637;
	Tue, 5 May 2026 20:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HZIwTW1oOFUsiUCSp
	EO91NJ3o0zlBjIUbldT7Oqbc5g=; b=s+K+Mxcc3fY4Tvkd0t6IUqTEpR9tfCHbE
	GsjFOroXF7Q6LtXkfGDt0p+VKExNwlItZ0tnQ6K6e1voeXuKwsbwtmdOWTR5XxSB
	MXOA3VwLLzWn8gVjChScOOmivCP60ziuYdwa6mZU1uHaYYZ8JeiWbuvOc0toezAT
	ibBJwAlLU4T2S1SvHd0KZtSAUwoiaGTCq0tlkAqrBhjaJL48nP60q+AUIS0DF2n/
	irXEbqunKYzZgDxpf6cIQ16J1rIPa1zTrU4SPq4R3+dr6GZOIylQLP6nh4CzOZvL
	ZMu6wKuoXfBzwKmTjr3KaRsTvY2f8AddlnpFbs2o1UKLL5pe4W0dA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9xxn3ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 20:05:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645JsgWv013147;
	Tue, 5 May 2026 20:05:17 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dwuyw3bmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 20:05:17 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645K5GN13998346
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 20:05:16 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51C3D5805D;
	Tue,  5 May 2026 20:05:16 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9872658060;
	Tue,  5 May 2026 20:05:15 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.242.219])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 20:05:15 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v15 6/7] vfio/pci: Add a reset_done callback for vfio-pci driver
Date: Tue,  5 May 2026 13:05:09 -0700
Message-ID: <20260505200510.2954-7-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505200510.2954-1-alifm@linux.ibm.com>
References: <20260505200510.2954-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE5MSBTYWx0ZWRfX3mX120J6Q3xL
 Dfi5+s+Jzk12KZNfHRaNu9UO4ybgZDQKtiZSX3ghDeiUOL3a7fneCO8Xy4mTmbQrt5nfydlg9jm
 LzMwam5y8xwPjEt7OBtxxW254e+y3wxUYusoQSX5C4S7W//RPiDl9wYeCfR0KCTvzbfJHXt3OCF
 6YQ3NCYjLDv2GgdhJigET8T0owE5JDZkPYFUoDqX2yA+hvYXK3Nqq6X+HvT/QnSNG85caskQilg
 GDV4QfemHX+YswlGnPZAcSSegO1ZNq0JPm5Bszdyt33hdGEJ+cDmYpT8jMYTPORqiZmqy95AuMB
 NoWnbE0WZ8Gmp378kkADu3v39X0eN50wYCogfrmXrp5xUiSiKMqB5i3ar0StfeNdzUVemh7x95L
 ZvDy0r4VSpZLhoDhBhTqg/AXcJqSCcTWausUrvNHcoP9lnPik7ROSRPq/dCyWMrlwgzshdEmXIP
 WYHCvABTYtq7loXybMQ==
X-Proofpoint-ORIG-GUID: mXvRgWpr4PJ_MctRSkRuhMhCef3wRSFk
X-Proofpoint-GUID: mXvRgWpr4PJ_MctRSkRuhMhCef3wRSFk
X-Authority-Analysis: v=2.4 cv=ctWrVV4i c=1 sm=1 tr=0 ts=69fa4d7e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=hcTHx3Z5Akp3fEzgVBYA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 clxscore=1015
 suspectscore=0 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050191

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
index f47a49ca67fa..6358b59fab2b 100644
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

