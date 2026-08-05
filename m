Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB8547045E;
	Wed,  5 Aug 2026 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948938; cv=none; b=hKfZKeeKFg8K+PW3pbC5xn0MSkzL74MkRKDcgn+kIFj0ES81eugMCoL1x7MaNDSKH8T4rbjP7J0Jb0m6O0GUzbZ9O4LYES9P2h4fjoylbb1iwCKhFfIYhFZNszcK2/SFAfgBX8w7MAvoRoo2p6o0AL5mEVl4XHRRM9EXBKJbisc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948938; c=relaxed/simple;
	bh=gKQYf74xPpytI8rbZnvPeewbN3H/KzF0nc088tK6OYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FYiGJB2e/v8lR0LKwvD7o+n8rX62VsS47DSnHkEFSDKfMEMlBf24m4ClkzuoX6MpI1AYHjJ/p0R8MJcOOEEZVt1MyaspPYv/AbsZazHgOAvx5X7U6CfLg9RWsGa/VqsFV+b8ym7Jal1++MKhIYi4x1Ot/h1iqoTk++lkuAz2MKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oZ8oAVrI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oZ8oAVrI"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675FldwX2397846;
	Wed, 5 Aug 2026 16:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=q3mWEO+m7Q0z7JDH5
	ZGSHJF5tisumNe9dB4cIXGURIs=; b=oZ8oAVrIrFfn/eImqsVg0VHQbO82iT8SR
	XWlNlDPHRg3CIuHpF7EDyb3Z3BBgeJoODkJZ9gp6OFtxC5cSZ7G77tQ6l0kTvw9R
	JEgx7Dtpd4yvHC7Mm9YHSvt3b82mVGqxhmrUs6F6M9qDUHcKEQdZo5xhPSB+Mlls
	7/0R5KROV1q8WstJk/3URbxnJVYXTzSeBDF70ZLvF5ZCiX0zNDodEj64DAaW74rY
	vtuE7uJu5JkFytZYFiTDhjTHkYAiHJI2ONUIPe3w1xCa+VojTlstfBVXD9cmJwKW
	FymLYYKVTOrOcIT/zOc55pu84BbCzzDT8HTUTUPvjBVfuQ6B7TDGg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqv1hp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 16:55:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675GfRtG014995;
	Wed, 5 Aug 2026 16:55:28 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyq6pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 16:55:28 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675GtRBn60752262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 16:55:27 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E5DD58043;
	Wed,  5 Aug 2026 16:55:27 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0EE458053;
	Wed,  5 Aug 2026 16:55:25 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.193])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 16:55:25 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, stable@vger.kernel.org,
        Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH v23 5/5] PCI/MSI: Enable memory decoding before restoring MSI-X messages
Date: Wed,  5 Aug 2026 09:55:18 -0700
Message-ID: <20260805165518.794-6-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805165518.794-1-alifm@linux.ibm.com>
References: <20260805165518.794-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 7YHdNf-BmoHkdZzl1lDc47tngexues5m
X-Proofpoint-ORIG-GUID: 7YHdNf-BmoHkdZzl1lDc47tngexues5m
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEzNyBTYWx0ZWRfX63aB1dHFPIyz
 Bwqxmy2B2wI7Fs5GCACykjnRNPZG9MueP1CpvGFB+dBVY8aVonFHu5oS7vgaFcudRWhPBqKDm9M
 bQLkX+WqDb5GHgqMsmV1YLgwxlgl4Dg=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a736b01 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=di-imCqyroNM6h0WoG0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEzNyBTYWx0ZWRfXyc8zsJ3r0mvE
 iyWitw8NJaPir5V3bFnIeAasNpLC3J4ouCs1B8Vvv2U84Ax8vU3tmWg6x69k9SXRqn9/bAhnWNd
 VCipv3KVFcQffuF+9tZE7i8hHaQM2QA7LlWReLfBd2Vpoz8HlWvCZQtp0o+lo2lppKiuK8njW4/
 2TVYSpiY4VmJ6k2e3WU3Yhv4z9IPRyTV23Vo+XYxVK7sbh8p//IIyx0K1XSbqlfJh/ZlIF083Gv
 BuY6YtsQ9sgmy9wJV5ZDp71OplHoJIgfUgyZ6Yf9RO8F204cjOSkfOG6MhzB7CRyP2Csjt4VWYB
 G30XybtbzSkCicVn9Qlkcd4fy3ZzsQ8CrbeTLc/LVygGLtugJPk9MsRxil/wOWrJVwfpJDG8afj
 tnxzPGQR4cCMq2KHKT35zu1j6YwbzFXAs4Iy2/JEm4UVFhQZ+EmwTDeVsfJuMO/g12KMSmX9cof
 j+/hWK6akK/2igoigjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050137

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

