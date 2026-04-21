Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB6237C900;
	Tue, 21 Apr 2026 16:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776789050; cv=none; b=k7NSmmP7ylt9FNKgXhNgrnpLOkesvGD0aKSJaPsZsq4c2mKmbM7dU0VOfO3iUoAUDrSIN6vmyBOQLY4Uwl3G3e7WBdOuBIOZ/2tzS5wn0baoO1LeMC70EbwW4hYtcCwLQIk9MYO4xpmpFfWkYKcOOaFjvGMISxm4PioCXT5TBP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776789050; c=relaxed/simple;
	bh=RQ7upiRfX+foiPulhHXu+Aw1uutRmHWJ0l3TcJW8bxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuDJ31ovQP4Hw7+WeoqJx4sIYKJEyhPky5S9KH7qklDk96VD1ZoHgxGFtKJyehR3ZAHddAEpT/0dzi+TMLuLTGKsIXV8P+intpd7ZFl1whA1wCFpl37vy2wHutfKyCMLtI8UH1rxqdqQIE+ggpoF3oicel1EBvOYInQQZ49++uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DPUBhD66; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DPUBhD66"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63LDOaQe1535627;
	Tue, 21 Apr 2026 16:30:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=l4yp/nvZGr9Da+6Zm
	RXwpQEFsXLYyw/698zFD8SAETM=; b=DPUBhD66kiqq/kwL+P1j3F0iILdYzGEZ4
	sbYaPeGni1lRLyqaZiP5f45FjDn8ADlUOyEYPTUHC+TZ5mPM7Zqdb8+RK389JFmU
	V8g3rQPl7jGSfVbi5LW6GLf6yGGKeS+t9fWV583tfuG4TXJ/MWrjUEoyLQoUWoVa
	uEFUX8f60BfT8Hp1tURNakFyX2u023nRGHRkhjks9XT5zivvkbaa4TWBMhaJtGHt
	gNYU2GU28iN/u7O4HNpcCdvjfuuhj/yVZQbJIyQidtNni9ybSh6CHOHBRogA8eIC
	Sxr+SmZb3wD4Pg6HROUhlUhWTQjca02dAbxR+BWaNUKd9Qj9bglvg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k6mgut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 16:30:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63LGKLwJ019172;
	Tue, 21 Apr 2026 16:30:43 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmm9q1kss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Apr 2026 16:30:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63LGUfeR17564194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Apr 2026 16:30:42 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA26258054;
	Tue, 21 Apr 2026 16:30:41 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 535A55805A;
	Tue, 21 Apr 2026 16:30:40 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.17])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 21 Apr 2026 16:30:40 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        alifm@linux.ibm.com, schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v14 6/7] vfio/pci: Add a reset_done callback for vfio-pci driver
Date: Tue, 21 Apr 2026 09:30:30 -0700
Message-ID: <20260421163031.704-7-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421163031.704-1-alifm@linux.ibm.com>
References: <20260421163031.704-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=L78theT8 c=1 sm=1 tr=0 ts=69e7a633 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=hcTHx3Z5Akp3fEzgVBYA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIxMDE2MiBTYWx0ZWRfX5ee+VRIVOOLt
 kuKTJ367wG23M2vEOJTnRHfIzs1SgRhSdUjBei7kf6nrlWiK3zUl/QrAEBEzKOIqqbdxkx8aiD8
 uLNZQoHvrRclxKJrJoh1AGdMBQfm+yNlVWhYQ2iYRfPo3u6yXDtVg21Vbmb9vchF7pQyqwwh705
 lQ7R0p72eovMKokIiCLv34j7UIAHQYYEd98zpyDCOhWcNzjlTpstRuUHv4zEgJjzG7fFYfjUuqE
 sFUtRNYXE6AtuTmgWwkJFOSaQ8nbc2Uj15+bWFyaTw0bPVx/nnUA4ILTtfOX61GgJ6v3d/K2A90
 8qQ9suOqVaK+YqjtUyD6DOv2iVAME7w4Jszzup8RH2B56oAMa4RFSXR1ngkaFqs80VUWxhEy/+c
 9lYFZ43PBcLtSosat+79/FIq81HFsuIkZGoYGSG8jzb+i94dZhODcTX9uH862grOCAWN/DMumyc
 BTiHdxqY9jKZ3CYXtpA==
X-Proofpoint-GUID: Q0EArPZk0kl_4LXLPh35A7puV7dgxk0g
X-Proofpoint-ORIG-GUID: Q0EArPZk0kl_4LXLPh35A7puV7dgxk0g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-21_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 clxscore=1015 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604210162

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

