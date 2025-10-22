Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608F8270EBB;
	Wed, 22 Oct 2025 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761151662; cv=none; b=OrRUcxrXe1L2a5V8+XRPU0fIiapYrJTKPYMbdehb8UqP2m2OHbX+XRJUpwSr1YdixKhv1ZtK5UWfWsRO9hRYxOcjBNEakAfzXyQ3zmpMvaKL6e69YOzJ+Qhw7WPEe1TwV8B8eqUav4y9vvLtoumMc1MilVTuQ07uoJ1l95CBDVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761151662; c=relaxed/simple;
	bh=ZGKj/X+4kfRisKLKyIIFymXu5/w8VYUlbMsRM3JhQzE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCOvj2wVsTDQrfMSHI+VaBDVamFEyKflYjg/b7wk8YOKPuwylngkHQfmCaI7W485pnOamhszH0N6aFyZZNYP719A+UkRYnTUu6gKqhxrXyFrPy5oZx+6ZL3s8xAlgTC2Bh1c4n0GtUTQACqaXEKk00LHv7klFRYdDFH0bFj2ikU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sqliODd1; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sqliODd1"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MD1NBe027261;
	Wed, 22 Oct 2025 16:47:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=DoZrReXIg69lxw6JXyfiUB5ZF9wUO3Aag26A4LoBY
	+Y=; b=sqliODd12JAFb00H88QYMR2nTzsYb3UUchPo2quWa057liJERfe0/58Kn
	GemDwzEXlPOwsMM3cysMt4ykFU46w3mORRdH0dGjkBej/4XlVtYIYXZphR5fE4Lr
	YJuAlcUpzbCR7nuukUW/4but/jYqyxcyE4AlfbVLAqxdzu4w5f8s9hKAtucvWVyG
	Q5k4p+dry0AyB3ZgaGA8VZhZF01MWDaxdJnhdKuer4u4NC9VH75OKsFVWUF2j1gH
	JnCoCOynh4tlWYiKA86/wXZ8uSwTq4EOkjKDgKhitov2odgqMO50I0YCuvNa8IVm
	g7nkARG6y0K080fUCO4q4le66dxTg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33fdx6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 16:47:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MEFruF032099;
	Wed, 22 Oct 2025 16:47:30 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vp7n1byk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 16:47:30 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MGlTOC23003886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 16:47:29 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 048C45805D;
	Wed, 22 Oct 2025 16:47:29 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 031D45805F;
	Wed, 22 Oct 2025 16:47:28 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.243.77])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 16:47:27 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: alifm@linux.ibm.com, schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        agordeev@linux.ibm.com, gor@linux.ibm.com, hca@linux.ibm.com
Subject: [PATCH v1 1/1] s390/pci: Restore IRQ unconditionally for the zPCI device
Date: Wed, 22 Oct 2025 09:47:26 -0700
Message-ID: <20251022164727.882-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f90aab cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=ove13Onh8FEOJJhcmoIA:9
X-Proofpoint-GUID: -oAVz4vN4esdr7QcQdgIEV8te4QGVYb6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX0YCe4N6YHTOr
 y2pFQDgXxY0XpawUQhfqEcSJSRWTjgO7G7YIjuMZHrr1EqExb3mIV4noCZTVtYamRRCryOY87vC
 kf/98lg9XWFEBodRzaU+ckA3FX29tn3/Zy3QMXXe1cptwWlXpBETi1ObXSG4b9mE5NiPdwr6pTC
 l9eenI0CzvA+WN6QVRVhQJ6BjgWLSldRaE5e6LD7bwmt4zDjPgF9rcLPCxR1pRA6eHh6r6J0OSJ
 D/i7t5zivgRYe5FF43WArALJbXZ45uSnsb8QbsesFz3LyIcQdweSq1lIyngs+X024rADOKaNzww
 6MccYL9l8lsDyUcT89Zb4zebs/OD+LMaN20IO/eh+2Ys5+QPrffeQOk06OlS77nYQ2b04pzXnMa
 2W0w6eI1I0pFTmDZep7yXde1FyN8fg==
X-Proofpoint-ORIG-GUID: -oAVz4vN4esdr7QcQdgIEV8te4QGVYb6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

Commit c1e18c17bda6 ("s390/pci: add zpci_set_irq()/zpci_clear_irq()"),
introduced the zpci_set_irq() and zpci_clear_irq(), to be used while
resetting a zPCI device.

Commit da995d538d3a ("s390/pci: implement reset_slot for hotplug slot"),
mentions zpci_clear_irq() being called in the path for zpci_hot_reset_device().
But that is not the case anymore and these functions are not called
outside of this file. Instead zpci_hot_reset_device() relies on
zpci_disable_device() also clearing the IRQs, but misses to reset the
zdev->irqs_registered flag.

However after a CLP disable/enable reset, the device's IRQ are
unregistered, but the flag zdev->irq_registered does not get cleared. It
creates an inconsistent state and so arch_restore_msi_irqs() doesn't
correctly restore the device's IRQ. This becomes a problem when a PCI
driver tries to restore the state of the device through
pci_restore_state(). Restore IRQ unconditionally for the device and remove
the irq_registered flag as its redundant.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/include/asm/pci.h | 1 -
 arch/s390/pci/pci_irq.c     | 9 +--------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index 6890925d5587..a32f465ecf73 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -145,7 +145,6 @@ struct zpci_dev {
 	u8		has_resources	: 1;
 	u8		is_physfn	: 1;
 	u8		util_str_avail	: 1;
-	u8		irqs_registered	: 1;
 	u8		tid_avail	: 1;
 	u8		rtr_avail	: 1; /* Relaxed translation allowed */
 	unsigned int	devfn;		/* DEVFN part of the RID*/
diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
index 84482a921332..e73be96ce5fe 100644
--- a/arch/s390/pci/pci_irq.c
+++ b/arch/s390/pci/pci_irq.c
@@ -107,9 +107,6 @@ static int zpci_set_irq(struct zpci_dev *zdev)
 	else
 		rc = zpci_set_airq(zdev);
 
-	if (!rc)
-		zdev->irqs_registered = 1;
-
 	return rc;
 }
 
@@ -123,9 +120,6 @@ static int zpci_clear_irq(struct zpci_dev *zdev)
 	else
 		rc = zpci_clear_airq(zdev);
 
-	if (!rc)
-		zdev->irqs_registered = 0;
-
 	return rc;
 }
 
@@ -427,8 +421,7 @@ bool arch_restore_msi_irqs(struct pci_dev *pdev)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 
-	if (!zdev->irqs_registered)
-		zpci_set_irq(zdev);
+	zpci_set_irq(zdev);
 	return true;
 }
 
-- 
2.43.0

