Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAFF37DE85;
	Mon,  2 Mar 2026 20:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772483622; cv=none; b=AzJF25mRs2+a/SoE0oYRT2CXY8hKR0wW90rDXIYSs0Heclg5WOGpNAPpKNACAcZBgz23bmP4t10+/vhpNITQTcXhiNc6yO4N+hFdAXLiDwpojRQxbNNFPCbEHjU6z1dXY+QGvx6lKQ64r1lc3GzwpmnbdJaCgRTKW4QUvgk+ED8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772483622; c=relaxed/simple;
	bh=YhMjb/UNnC49ZtdnrN3awZkC7cL4VLUUSXKJTq4yGLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tV/ppliL5egHRWbDHowCX1/fQxY1MkFCkZ9a6kPU8ueTwj6YIDD7a0jW1MMsfNPBXwcp5Gy8fI0C3pr628yeCk8bvlX+Pl3jX1WhFc2B/Bfh7lqyzVuOnLGfGUr4yuoAyK9j1H6jmfy1LDv5H8YoAJHW15u2nV6HpAFurFUCbUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RC8sU/SD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RC8sU/SD"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 622EJu7p2166769;
	Mon, 2 Mar 2026 20:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=c43eaOrCUMS978Urc
	kknSWwXnr7+gE9biC3IcpIolDU=; b=RC8sU/SDQ4N0b5jOWdtdqYiT4zVHKZTQc
	t+IPfnptuJFlbZh0f90yXuvG7Ztkz3l/LBbPWLTQjfs6Ngemc6d2FIbK6uFOqZ1n
	OPaxsWD60YMHAFaFAmvBdf2Vz7vwQaaAd6DDHuGnyGhf/En9X4AomrZefrn/5+5o
	1HFNa5xFvQGouZc2NdbkBbbIqeyHbLRc89uwiuCbBwNmM11bAkzgmJukwiS4JqKc
	c0LHunHx5JOj3Css1dmy6uo5SjDPL/HyQEuF5Gr+lja+dCC1zrTBJYBXXUszSy5C
	eGflZUZzablC85A4EhtQgCy8Du319F8UPTzI+C5r8qTYtv/LCY+cQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskbr4mv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 20:33:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 622HS7BW016802;
	Mon, 2 Mar 2026 20:33:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cmbpmym1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 20:33:35 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 622KXYfg8586120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Mar 2026 20:33:34 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D04258053;
	Mon,  2 Mar 2026 20:33:34 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD9EF58043;
	Mon,  2 Mar 2026 20:33:32 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.18])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Mar 2026 20:33:32 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, kbusch@kernel.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v10 5/9] s390/pci: Update the logic for detecting passthrough device
Date: Mon,  2 Mar 2026 12:33:20 -0800
Message-ID: <20260302203325.3826-6-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260302203325.3826-1-alifm@linux.ibm.com>
References: <20260302203325.3826-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FXyF-veY1TI3sVJ5iDI4LldKhxVcXEWY
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69a5f420 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=MtaQWmmsotiDqj5H3ecA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDE1NSBTYWx0ZWRfX244qFZMqJnfC
 lkkFkBFOYPbMrRDEBps5DTS4jqvP68fF5yFUJwYYSevKvWdQqtTWfwXZyB/Tw1jECEuOKJ9SpVG
 T4rHJCMRO+VTHbrW1rxbUQyfiL/4Ngc8kURYp7AzhPzXc1YLJ3G4U6dvcY7XDWZI9XLjSy8JmyC
 HKJgB+PAWf3cqdTo8s+Qq8D1aMI92uqgyNqre0QAylLUPD0F/7ZeR13mnOdPJQQR5DplyWZR3ob
 1Vd9HVlC6Oysalc5VE7nIFkIGHK922AJIB3tTDJEElLn9ggb918PnZ2Uh4mAesFsjOJINDyN8ZD
 G3ekPk2GEK+jvx/wKO+g/Kv+LXcGAZ68cpEwMfgV1nIZdR86MGaQgGnpuuIyhywpsVs6yPAzbBa
 Qefj0pI5cF2G9K/hbBzqnH+W/alVXOcmVGLEseur4GZd/+YxPmYiM6Hvyb9OJ3QdhpJgUcUdDhL
 vger/ie0qn7/n6oD65Q==
X-Proofpoint-GUID: FXyF-veY1TI3sVJ5iDI4LldKhxVcXEWY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_05,2026-03-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020155

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

