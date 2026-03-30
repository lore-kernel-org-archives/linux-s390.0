Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2F33DE431;
	Mon, 30 Mar 2026 17:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892428; cv=none; b=tGWs++r1xav1zyoBlBMwtdBQHBH6Ij22ZYdHbX0nMd1Sq3fwd5s2nc5RsjNQHYODuky56lbvmyCT5u+oR00ogn54SzockZWn6NbcnrSq3opJDYJ0IZTFvYg1RpQXL5pxMv+4gy+4WXrpmH9UJFm0ZSnD/9NU/tzbsgOVytMTyiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892428; c=relaxed/simple;
	bh=iPN+v1mim8Hv7SJUwZwOOOS7raEFHwlZTxZO+j7qdtY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K5VLggTP3InFy4SF5akTC8KRmMz1ANDWWcwgHXC4P0OJhCFI1fgsx/0e+miewWI+kKC0bgKcHRm1oORma5ZfBlzTcLFHSXoKqXYMIDaYZmMAVaSExsVvvnchDin2MKnj9krOGaypXpXcXBoh7a1EGCDU+siYnO7JYFwv3uN/2Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s0IBOdyV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s0IBOdyV"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UD0xVW3941833;
	Mon, 30 Mar 2026 17:40:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Hn/Vjkeac+whHfM35
	QQdZ0Xk4r5QnW9zqV2bRKPxP2k=; b=s0IBOdyVHHdP3MiqXqC8OhHYmrDNiRXps
	oi4iRWMSfWpqRYVDAf9GYwzaNTmULZekrlxGvRaAjI+3oWwsM1/nzVzmr6JiTzni
	tAzb+oc7zw9kS55EaiaFG9yW6qQez84migV/EwiTIBR6cLv7NDOhEtVGqyfD7iuv
	BzskXWGElfpd9zsw9kNS6B/BXGD25r1amAGdlHH95m5nPNfLsboYfhww6s88G6DX
	xH5xk8tn0dHK3nypN9+VBYJrvxCJ9eiIHAqvYqTG6+uAu02WY3hI0CTbkDERVCdU
	GcQKqiPa8XMsa+J8JiTnIQtv6TrWd8O1+RA8+WS006s7JdnJ3vFag==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66mrykgv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 17:40:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62UE7di5021651;
	Mon, 30 Mar 2026 17:40:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sase0w2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 17:40:20 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62UHeJMm31326760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 17:40:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BD90B58052;
	Mon, 30 Mar 2026 17:40:19 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DEE6D5805A;
	Mon, 30 Mar 2026 17:40:18 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.243.214])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 17:40:18 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        kbusch@kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v12 6/7] vfio/pci: Add a reset_done callback for vfio-pci driver
Date: Mon, 30 Mar 2026 10:40:10 -0700
Message-ID: <20260330174011.1161-7-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330174011.1161-1-alifm@linux.ibm.com>
References: <20260330174011.1161-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cab585 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=r1p2_3pzAAAA:8
 a=hcTHx3Z5Akp3fEzgVBYA:9 a=r_pkcD-q9-ctt7trBg_g:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE0MSBTYWx0ZWRfX5TReCklgnDoq
 aTjLnTv9p6zskaLSZdPa/ms4kgMCiQrCT+GxuwrCs2WycxrKE8JXUzxJzNyk0IJerpC/RtUMN/Z
 s2SLketo9H3HO3hhz1pvgOQS5wYuOKHzZFrnpXO7nxnQSXcz+qIxmYEuMqUtMt/+e4IBJSi8eSp
 bBTf7hiwHzDheHbgBDOCaSpT5qD7zPAJfAnRM7eFG8N45fZWUHpOoTt4krW7EYrHyP/AoQhiYTq
 10JE1V3FZcfx4nEzSTJduo3J4BAcEnyQeskIm1bcXHA3Npj96wKzNaM64XAXiW1m1fJ5QcI+lVW
 p0MRWs/aZZdAC1zw1cAQ4CoXR8pDlkmvM7ASv+ewbfDJ0AY33RVdqB682aEqLN3EWb0cKS7tdXD
 1ssEMEESY05MTqA1g+7pKX0/QlV24sG88doi4FWFOTXLvRH9GMAr82xxqWiaKF/YyNKv0llDKKH
 7M/IURwKv7OqevTuG6A==
X-Proofpoint-GUID: GnhA2mP7a_3IrJQaviWvTQCxzzDuDoKz
X-Proofpoint-ORIG-GUID: GnhA2mP7a_3IrJQaviWvTQCxzzDuDoKz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300141

On error recovery for a PCI device bound to vfio-pci driver, we want to
recover the state of the device to its last known saved state. The callback
restores the state of the device to its initial saved state.

Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Acked-by: Alex Williamson <alex@shazbot.org>
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

