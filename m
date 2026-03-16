Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D433ED5DF;
	Mon, 16 Mar 2026 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688572; cv=none; b=Nj9KXea0b08Qs8xFf5bECD7oUlmd76WpprI1tFvNg3Qswsr8AwQ8cezVGMC2sCL0ifRXLKAaouKEJ6XP+8UgplRPwDPDS7Qo6OC5ZT6cp+87ihi5WLkIA0hUThgfP3/oVWQ/PkAdVlO4+Kij4fCg+3xHWLam6dRhNLkK6J+ecek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688572; c=relaxed/simple;
	bh=JU2S/D1vIdNZRnF3thIXfdANBZsmsxh8AT3Bc52zZ5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BngEJ5b+jAdzJbVf/t90ZMEI030m1h/mvxF9L5BEApzLlwbwdyUN3GG1dn9N6EC0gkVNz66hZia+JNKJUOqPH26S+J0UVtwYs9aIOkQxvERqZxKi047+3F1nHFnvIflRs0MPf6IGPkGlmKTyplNxQi3GwlQOmGEfHzyV08eItjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rF/FMSqC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rF/FMSqC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GHFZCE1394708;
	Mon, 16 Mar 2026 19:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/Q3cbR0hn2isfELGq
	liRAPHKU4vVJLMuvRD4mjbhUEM=; b=rF/FMSqCnl/06s2nlKvoZXut/49YagOnw
	RMK/w9XlHhUnDIw9GaX8YmlyEkVtnpthrW+HOsLwumQBS7LczIpjYjOUsp/oRzOP
	RxIcXB1/gPrMkTol6QBiNTBWTLw452mIxXC5sbUNNf9l0qqi3WIK5qjrLBKsUwCU
	tUCSL/yyt1x6F34yc14SozIWvf7aIyP1Q39GqqG+YdBVum222t2XM/cukkJYIRT4
	TQs2eZ4J/0amBapTST+O0Salrci2HL5W0FTjqNvK57E89uAe7LPr2BL117RVXtUg
	IpR5xhix9KbC4UaOL2WTOuNEbaeteOYRyeLLoBYeKCCkLnM8LDgww==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfbp58-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 19:16:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GEbpsV004575;
	Mon, 16 Mar 2026 19:16:03 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s65h9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 19:16:03 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GJFcUY30409372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 19:15:38 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4482958059;
	Mon, 16 Mar 2026 19:16:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8FA458055;
	Mon, 16 Mar 2026 19:15:59 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.131])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 19:15:59 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, kbusch@kernel.org,
        clg@redhat.com, stable@vger.kernel.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v11 8/9] vfio: Add a reset_done callback for vfio-pci driver
Date: Mon, 16 Mar 2026 12:15:43 -0700
Message-ID: <20260316191544.2279-9-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316191544.2279-1-alifm@linux.ibm.com>
References: <20260316191544.2279-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: d0Eq198Gl0u3s4BeRktP9Pcm8bQ_L656
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69b856f3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=hcTHx3Z5Akp3fEzgVBYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE1MyBTYWx0ZWRfX+IC7SASBoomk
 ngI0s4sS6XqXms73hUSAzoaGgu+DdTAMjg8q8Ly24zWgmBiVu2a4YJmu6GGeHoGXA9uL73+TdTI
 HnT+eJsiZbXVEjaOIxhJi0iSsK4mft8f9CY3a46+a9DoWFIC+jfQO4MzI/rMrFXMHoRwM/0ReUO
 /8yYuCu13GW920cLSFzeo8rELyGW2t8MfuioXxVBr/MjqJAriOx9ZmMXvohFWzX6PXZBOtVnxhX
 yq6qLmKgEln7q01gz5x2jkODE5APlhPh8hvHH0t1GzSpZW0mt8bLuU5fkIj939vLht/S0J7yyvs
 winKX3BW0LKAc5lqQfcvdeVCLTumyjWF1qcAuT2QRoVo9pZVzeT6N7jxn/Cx7cggAS9qnHaxae6
 EReyHquXDYnkfnuAVGXS0GesAOoyRxOTTo3EbriBWaIhC8puXtpelCFLiLQ/j8DlwJG6SFnvgLL
 WLzJdjDb/Ll5e6FK06w==
X-Proofpoint-GUID: d0Eq198Gl0u3s4BeRktP9Pcm8bQ_L656
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160153

On error recovery for a PCI device bound to vfio-pci driver, we want to
recover the state of the device to its last known saved state. The callback
restores the state of the device to its initial saved state.

Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index bbdb625e35ef..f1bd1266b88f 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2257,6 +2257,17 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
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
@@ -2321,6 +2332,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 
 const struct pci_error_handlers vfio_pci_core_err_handlers = {
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.reset_done = vfio_pci_core_aer_reset_done,
 };
 EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
 
-- 
2.43.0

