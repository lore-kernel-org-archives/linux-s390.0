Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2C8338592;
	Mon, 16 Mar 2026 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688573; cv=none; b=caH6TXC754u4YCAc412jMKCyQXR3A3u9Ht8ML9SGxtvxvTQywCFhVCwcIAANT2c4FXeQ9DtvchLOAgoqz5PJ/qIlKs2cbpcleJffN7iy69oV0D/Um1dTjaFRH03xpjNX8ch/GbCLt9oNz+WhWeT/Gi+7mMq42mhtnGj63OAkgaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688573; c=relaxed/simple;
	bh=YhMjb/UNnC49ZtdnrN3awZkC7cL4VLUUSXKJTq4yGLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CVgnajb6LkKCVG75UqhPnvvHOsXI7erQEiyRG/MGrPqaS26fXliHleYI4EFLW9uybXAZ0clFcUpnJJZxAf/aF2AD/nhaVVgCG6vEBXFp9DekQWdUmOGCealImnuk7XxycPik+xGK1r2BC8VIcXvimZbjZACl9YLNJL/1/+2AoNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YSCuGLmP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YSCuGLmP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GEuSY71200667;
	Mon, 16 Mar 2026 19:16:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=c43eaOrCUMS978Urc
	kknSWwXnr7+gE9biC3IcpIolDU=; b=YSCuGLmPepu16ld3TZqem5G9CVyx4a/S6
	3x5cLRg/mi2VFrn2PkuWsJ4vdQubgVSLBzk2j0AJYXB+w4+FI5G0DGpHXom5pHmC
	zybrhVI7XtgqbZos35cHrk2BhlSlFwsJ3fvGkj3O3oQvaf9MESdF4nKPLKyVg9+j
	S2rnk9g1ZhNK3nna5F5+d5xcp1e3H0d/x5yuZVZAzx2cCIEv+sZQWiYwQIJzZ2DF
	Ubrk1uD07Y+90pfYcB5A9DlVtdSB365ydiunRrPS9ScdZTsK8YDCovp1EsKKpP/W
	6UK6j6nnZo6zaXTiJFgCLLGK5W4R1gp1zuGGGF2qzlsaKsmSYHaIw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvy64hf1g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 19:15:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GFdSjK029194;
	Mon, 16 Mar 2026 19:15:58 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgk6030-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 19:15:58 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GJFvps60096820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 19:15:57 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E43855804B;
	Mon, 16 Mar 2026 19:15:56 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A620858059;
	Mon, 16 Mar 2026 19:15:55 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.131])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 19:15:55 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, kbusch@kernel.org,
        clg@redhat.com, stable@vger.kernel.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v11 5/9] s390/pci: Update the logic for detecting passthrough device
Date: Mon, 16 Mar 2026 12:15:40 -0700
Message-ID: <20260316191544.2279-6-alifm@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: -Q5RPPQY4oXnRssNgRr0KLeydwUdQazV
X-Proofpoint-GUID: -Q5RPPQY4oXnRssNgRr0KLeydwUdQazV
X-Authority-Analysis: v=2.4 cv=KYnfcAYD c=1 sm=1 tr=0 ts=69b856ef cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=MtaQWmmsotiDqj5H3ecA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE1MyBTYWx0ZWRfX4CnzmPCL5QjO
 I0bQ7NhLEaCeTtCpyw3gcMwJ0hwduS9WKtWj+A3SjAM4Gwq/wHC0SgTfNhW54lhzbqncPMTQ0P5
 bJzpxH9+Hyt4Mgamk/2SAUHpV0ByzTvtRgqqyM1jMPUruy7Lo/9/JwPWkpe8tJiSKV9+yjR6zF0
 oBZCWjIja8FoRt828IrVH9+t5OhwPIOvpYndJViJnuEKSKp6IZbc0ot39m+MGfPtKvflOUa25qF
 f0leFQAYLGtVlrIIW8sQMJZiq/9jGAxEl6BdXawMi8CDCBeuazXaROAJpYlEfZ+q9mt6BxX9UmZ
 W1i5erGH03EcaDyqEn++GbVzuGyafJkvCs2NMasaceYi4fXxeD6P60PUxhDlKxvAQP8LmAcrsKA
 3GTPcqeLrVUUQnczQTHYDbN5L0btTqoro+hVLlGHOhDIQ2+UPbxZHwlEKmbr3TqM09fjuL1dYJ2
 9c5Fql58uW4D3cNrtDg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 spamscore=0 impostorscore=0 malwarescore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160153

We can now have userspace drivers (vfio-pci based) on s390x. The userspace
drivers will not have any KVM fd and so no kzdev associated with them. So
we need to update the logic for detecting passthrough devices to not depend
on struct kvm_zdev.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/include/asm/pci.h      |  1 +
 arch/s390/pci/pci_event.c        | 14 ++++----------
 drivers/vfio/pci/vfio_pci_zdev.c |  9 ++++++++-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index c0ff19dab580..ec8a772bf526 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -171,6 +171,7 @@ struct zpci_dev {
 
 	char res_name[16];
 	bool mio_capable;
+	bool mediated_recovery;
 	struct zpci_bar_struct bars[PCI_STD_NUM_BARS];
 
 	u64		start_dma;	/* Start of available DMA addresses */
diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
index 839bd91c056e..de504925f709 100644
--- a/arch/s390/pci/pci_event.c
+++ b/arch/s390/pci/pci_event.c
@@ -60,16 +60,10 @@ static inline bool ers_result_indicates_abort(pci_ers_result_t ers_res)
 	}
 }
 
-static bool is_passed_through(struct pci_dev *pdev)
+static bool needs_mediated_recovery(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
-	bool ret;
-
-	mutex_lock(&zdev->kzdev_lock);
-	ret = !!zdev->kzdev;
-	mutex_unlock(&zdev->kzdev_lock);
-
-	return ret;
+	return zdev->mediated_recovery;
 }
 
 static bool is_driver_supported(struct pci_driver *driver)
@@ -194,7 +188,7 @@ static pci_ers_result_t zpci_event_attempt_error_recovery(struct pci_dev *pdev)
 	}
 	pdev->error_state = pci_channel_io_frozen;
 
-	if (is_passed_through(pdev)) {
+	if (needs_mediated_recovery(pdev)) {
 		pr_info("%s: Cannot be recovered in the host because it is a pass-through device\n",
 			pci_name(pdev));
 		status_str = "failed (pass-through)";
@@ -279,7 +273,7 @@ static void zpci_event_io_failure(struct pci_dev *pdev, pci_channel_state_t es)
 	 * we will inject the error event and let the guest recover the device
 	 * itself.
 	 */
-	if (is_passed_through(pdev))
+	if (needs_mediated_recovery(pdev))
 		goto out;
 	driver = to_pci_driver(pdev->dev.driver);
 	if (driver && driver->err_handler && driver->err_handler->error_detected)
diff --git a/drivers/vfio/pci/vfio_pci_zdev.c b/drivers/vfio/pci/vfio_pci_zdev.c
index 0990fdb146b7..a7bc23ce8483 100644
--- a/drivers/vfio/pci/vfio_pci_zdev.c
+++ b/drivers/vfio/pci/vfio_pci_zdev.c
@@ -148,6 +148,8 @@ int vfio_pci_zdev_open_device(struct vfio_pci_core_device *vdev)
 	if (!zdev)
 		return -ENODEV;
 
+	zdev->mediated_recovery = true;
+
 	if (!vdev->vdev.kvm)
 		return 0;
 
@@ -161,7 +163,12 @@ void vfio_pci_zdev_close_device(struct vfio_pci_core_device *vdev)
 {
 	struct zpci_dev *zdev = to_zpci(vdev->pdev);
 
-	if (!zdev || !vdev->vdev.kvm)
+	if (!zdev)
+		return;
+
+	zdev->mediated_recovery = false;
+
+	if (!vdev->vdev.kvm)
 		return;
 
 	if (zpci_kvm_hook.kvm_unregister)
-- 
2.43.0

