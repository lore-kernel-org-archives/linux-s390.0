Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27903AC0E4;
	Mon, 20 Jul 2026 19:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575521; cv=none; b=lZ/Y8LR34gXD1xyw+ccw5DbdJvi3oy8+r/Jj4K3m16xxZQ6KyaQ49D5/HsaM9ID04+q55CGzhHTPESMZFSSo/rEiBIfSttDt8b+xLxaKV6L1ALc1hICLjCGj48XkrdR/xd9q5aIolXpl87lhQjgr9AD9hYSjvmpO5qYXQ55fRnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575521; c=relaxed/simple;
	bh=gKQYf74xPpytI8rbZnvPeewbN3H/KzF0nc088tK6OYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CfxPKfIBJYhyTU0BK+OPSd3U5Nqb37vgnyccYLcnPTgQkSj2IsTn06o2aYGdz7PwXXwauWNVjHEEcFu94xif9mY8dc1cG2du8jjJT5KSlE9Nuj/gNs9Zo7R3eBYA1y3lKFmOXduXX2fJCVF+kTJhS5K9tZv1Xp9JsrFTi8tg+UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P28roB36; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P28roB36"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHBhJY2810925;
	Mon, 20 Jul 2026 19:25:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=q3mWEO+m7Q0z7JDH5
	ZGSHJF5tisumNe9dB4cIXGURIs=; b=P28roB36tWt0OAZwdpubO0IfOHngdfLN6
	L8UQavWBwn1QULINcft3H5tU3R9BYrojIr1xkWYIVyB8cP14dDZ/IjQ/fQULQkMD
	1nO9nMYyTbGFGMD4h2S4+dzo5suQH0PEO0wMTi8mLwFXm9X9u2q7oEWhGTlcL/Z4
	k88J4DD/RWpfodrYRk0iaLzAdodLjbqZiZDxLdorvfgRb9yacBnwPSWO3cEPRUrH
	dPXGeqE3C2muBEYPeRREef2KaUay1XxQ74OKlN/Qbwtm2yVMKShWoTw6QxZkJQpV
	JY/K4aKISY6wmau8XDF14Ttx7zcRNobc2gryioIrG5jMgbCX8tWow==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ah0u2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 19:25:13 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KJJiXM015870;
	Mon, 20 Jul 2026 19:25:12 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1g6u21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 19:25:12 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KJPBwA24510990
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 19:25:11 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85A1A5805B;
	Mon, 20 Jul 2026 19:25:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7083958061;
	Mon, 20 Jul 2026 19:25:10 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.255.209])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 19:25:10 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, stable@vger.kernel.org,
        Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH v22 4/4] PCI/MSI: Enable memory decoding before restoring MSI-X messages
Date: Mon, 20 Jul 2026 12:25:05 -0700
Message-ID: <20260720192505.2957-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720192505.2957-1-alifm@linux.ibm.com>
References: <20260720192505.2957-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IgoQ5nNaDeEei3wx9TEk3XecY-FOnh7K
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIwOSBTYWx0ZWRfX7qa2XaBjK0fu
 gddfoajBFQTVs0Fg5Q19OFFXID/+o9ZucDnrlMdDmVu8vqK7L+3nfnmZpspThvWUHY9NKle1OOj
 lR1VS46f7uwBR/CBtFtWleghDRPmnFxNLv+7LYeCtLGlaYHzKPp2p5BzVVNK4uBtXqCf93j93rr
 gbx8/pmIkkswVr+xA7JWkFtzkTHNPGfwjn3CxB1IwWbCkea7uHH7hPFIQs/cM0U0gYhNEYsOIAG
 TskAqToZIlBsTFjb585x5ph3RUUNv0pHAewtz7TUlCdqyXFxabaMavViWl6SggUOdHwbVmp6QRV
 3s6WeiebwZ15bs0Ovd8pdtnXtRuLpUV07YjyzZVymlgpoencZv5sr7hDgYoGYt26I8iY5Tqt4Dm
 Fhj1GLZHpK5pZuFyXHpMHBu0H4iMeQHvU4FTwXJlLWfLzKSGhUPRN49JqGf504PdmeVPZnLB33s
 hd7pXvlGITa1fHu1vNg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIwOSBTYWx0ZWRfXx5WdqgslS806
 llWygAz3HDOCTjosWPEudO0DAMxAxlHSLWJ6W27d26QBwysqrsw4sNOs06HhZAXSFp+V8zBGD32
 B2iz7okkL8OVcsDPoZX2fXcZmGDmwVo=
X-Proofpoint-GUID: IgoQ5nNaDeEei3wx9TEk3XecY-FOnh7K
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a5e7619 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=di-imCqyroNM6h0WoG0A:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200209

The current MSI-X restoration path assumes the Command register Memory bit
is enabled when writing MSI-X messages. But it's possible the last saved
and restored state of a device may not have the Memory bit enabled, even if
a device driver later enables Memory bit and MSI-X. Attempting to access
Memory space without Memory bit enabled can lead to Unsupported Request
(UR) from the device. Fix this by enabling Memory bit and restore it
afterwards.

Fixes: 41017f0cac92 ("[PATCH] PCI: MSI(X) save/restore for suspend/resume")
Cc: stable@vger.kernel.org
Reviewed-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/msi/msi.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 209373c92e9e..79c7e84d314b 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -870,6 +870,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
 {
 	struct msi_desc *entry;
 	bool write_msg;
+	u16 cmd;
 
 	if (!dev->msix_enabled)
 		return;
@@ -879,6 +880,14 @@ void __pci_restore_msix_state(struct pci_dev *dev)
 	pci_msix_clear_and_set_ctrl(dev, 0,
 				PCI_MSIX_FLAGS_ENABLE | PCI_MSIX_FLAGS_MASKALL);
 
+	/*
+	 * The restored device state may not have Memory decoding enabled
+	 * in the Command register. Since the MSI-X was enabled for the
+	 * device, enable Memory decoding before restoring MSI-X.
+	 */
+	pci_read_config_word(dev, PCI_COMMAND, &cmd);
+	pci_write_config_word(dev, PCI_COMMAND, cmd | PCI_COMMAND_MEMORY);
+
 	write_msg = arch_restore_msi_irqs(dev);
 
 	scoped_guard (msi_descs_lock, &dev->dev) {
@@ -889,6 +898,7 @@ void __pci_restore_msix_state(struct pci_dev *dev)
 		}
 	}
 
+	pci_write_config_word(dev, PCI_COMMAND, cmd);
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 }
 
-- 
2.43.0

