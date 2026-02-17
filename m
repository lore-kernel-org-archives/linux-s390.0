Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CF337107F;
	Tue, 17 Feb 2026 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771352597; cv=none; b=BNdxT4ongBcY1fIVEmt62EaFy/H/BkXhhGKVyYAYXaUrvPSVPyHivXK1YW7CotFzPUFZ0c8lUPVx1eXpie9XCX37ATHhb5SMRZoQfetYzRIVHNaAvMOlvTbivHBjO00XyaPWuQ+AQ+Ux+CI1PPNqmmfLIQS7Loti17C+jLnULd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771352597; c=relaxed/simple;
	bh=Xid8R4gHvI88ihdo6DRFEgg5qiwwHbf0Un/oa6/KwDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sBj2jX4djin4ya0qrgwDSGNx8cLKb9QqKil1EyPlhhxAYpMefUo835n0zMuz/ImMishRa99ua82B46BC/LAlUKTF5I1IL+AtTjBhcFPhQ12EWeJl5eB12SmmnCLIg1tSf96D5XRJ94V8tMsTU6DNO9Kn+bu4Qx9dtOKl3lzANWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FrBmF62C; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FrBmF62C"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61HIGN0F3786237;
	Tue, 17 Feb 2026 18:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=S6CRg4XI/HP2JPfFX
	QTrwNGbnRuOd4l4vQum+Ps0JjY=; b=FrBmF62CB101CuwF3ZRsEfLWsiEE/c+q7
	tGydGOmbCI2e245jIti2SP1LJarxknd82U+f83/HZjx7s0BKMVbFvZW2jgtpVZ8h
	fhaFGjZGZK/z+ThOmE4W7N29B76Px8i0i3hpQKYSRgDLh++GaPH2/5SNsEe4+aFj
	LBjX2Dl5KmDHmiqgY40OSZ37a0x8ZDFmjdsNyrebqWVkMxFdLCsOTbV2+7gb6vDc
	ZfRi84VBOFOcB8rCn5lq+GKhstSa82/Iq5laEAqiL62sdB+9sVy0QJlE5KoO07qc
	cuEI70jK5CYKlzpKwD+x88fJ37ADljMYnwULzvG6HTfXh5YKD9/SA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj644qef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 18:23:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61HFvcS3001391;
	Tue, 17 Feb 2026 18:23:08 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb2bc3yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Feb 2026 18:23:08 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61HIN6fe31720134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Feb 2026 18:23:07 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F24D58056;
	Tue, 17 Feb 2026 18:23:06 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B03F158052;
	Tue, 17 Feb 2026 18:23:05 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.242.249])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Feb 2026 18:23:05 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        stable@vger.kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, Julian Ruess <julianr@linux.ibm.com>
Subject: [PATCH v9 8/9] vfio: Add a reset_done callback for vfio-pci driver
Date: Tue, 17 Feb 2026 10:22:56 -0800
Message-ID: <20260217182257.1582-9-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217182257.1582-1-alifm@linux.ibm.com>
References: <20260217182257.1582-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: j_l0QhMQFpkKMYN00hmld6xWk-H_OX4l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjE3MDE0OCBTYWx0ZWRfX19Tn4qheoodh
 J0vcIMgIhaGVcZ3zMf9iLvUiYFZiIKHa46OHYpthocIF2w6xpfIB/zGtFdDi9vqEO27Bc8k/EEl
 iBp8fexaTSsqDa+H/zFAJVO4fl94bT8hafNh/2JpcVLQExHSI5GBbpdKL4pEm0h2nZEfU3deP59
 +IWmk7CAnlCs4cneHZfozqu9bDJmhYo5COGs2hVLaXClHpOjISnmVgzd+V44DT1idnqdUBkg/RY
 TeTdNZY+4wM9WA/Qz6kE1LYiR7k2cVvwul7oWwDhQnpZqGE/ODhgU9UTc6j17hikjzRqh7z9aE3
 Sr2Gheblu0Fwutyo9z+RMpf/k6tpmcBQtsjUa2rL2k7kdwElJFbNCrQenvVp4EVd5/PWEf4UD3d
 X3kzIEihdruqChukVGeAWNWwQJxqLT224k9UMd6HyXOtQ3dxhxhoIRRaDLQ04WXiecmu95Ra+Bu
 IpuJIZVvIYMFv9CvtMg==
X-Proofpoint-GUID: j_l0QhMQFpkKMYN00hmld6xWk-H_OX4l
X-Authority-Analysis: v=2.4 cv=U+mfzOru c=1 sm=1 tr=0 ts=6994b20d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=hcTHx3Z5Akp3fEzgVBYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-17_03,2026-02-16_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602170148

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
index d2cb498c026b..8f7eb3636075 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -2258,6 +2258,17 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
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
@@ -2322,6 +2333,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 
 const struct pci_error_handlers vfio_pci_core_err_handlers = {
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.reset_done = vfio_pci_core_aer_reset_done,
 };
 EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
 
-- 
2.43.0

