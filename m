Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68373D16E8;
	Tue,  5 May 2026 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778011521; cv=none; b=bzzPBtwN04PAIiyP5+Ll1gJt+2Jquehh9vxDSx2qvzgKgvPX+ZrCvL1yTLFpTFCnkVAZW2B+vjxcIB1rq8BRCseQUm9ajqcZFP4uBDxtSQoYIpfF5larwGRBTxK2VYVHBCarPWm7r9cX46b8XYyhOTFmni5PBQMQlUpI1qf/ITo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778011521; c=relaxed/simple;
	bh=POORsXRkk4nOKnrZRpviXSsULTny9Rnzj8bxogy/6pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ohC2ExqeuFpA2X4CmWCQllO5K4PyWIdOatOujHs8M4JcBDA4x2sKq0djr296BxifkkuIdW7rjHWI9+DgrCV/FkOOL+IKkz7UmFTM/e+Kqv3uhFzaA+hdELkVrmOkggrafx8a0XaKkULO5BgJK0h32am2NNN6JvbsZ0NMo+OQqKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RDRytMSA; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RDRytMSA"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 645JZ2sl2503246;
	Tue, 5 May 2026 20:05:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=B03ES7Gw4vOtbWqO6
	B3bh3UMTVIWbkYsdM5+gP6DaHk=; b=RDRytMSADtZzrrCs+czNYBnEwOCh5/izY
	sK9l21+5xyfambjShaP4sPfmzAhO2tStR9xM30nhu1ZM3RfyugKDukrGZt2X+vuS
	DGTXmBhtSQKTSICGKLbIoDokdn570AHOu4zcEPVHh2n/VUKbAf/449EIha9j8pS8
	+St1FBWYQI48PqjVYcg7vlMhfxSLGU8kZ3PpZEjikA9DaJvj1LpQvRBRZ7z2rA0N
	81kqG2w+mW1XM6kHBe+sk+1D7h258TriDPnVxbX9TYl9MzJ06qtjygeKGAUKVq/v
	3jalBsj/Rl3B7/OsuSgRnbNQPyiT50oTouTOnBpvzc07tY37lgq9Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1djc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 20:05:15 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 645JsQHC014200;
	Tue, 5 May 2026 20:05:14 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dwwtgb3a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 May 2026 20:05:14 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 645K5D7Y6095480
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 May 2026 20:05:13 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F264D58055;
	Tue,  5 May 2026 20:05:12 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 412D358043;
	Tue,  5 May 2026 20:05:12 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.242.219])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  5 May 2026 20:05:12 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v15 2/7] PCI: Avoid saving config space state if inaccessible
Date: Tue,  5 May 2026 13:05:05 -0700
Message-ID: <20260505200510.2954-3-alifm@linux.ibm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: OlQFPTi-dFiVRUYeV-TvfQmb6J1Zuig4
X-Proofpoint-GUID: 0xxM-q5CxHDTfDTNwc7tIXdg-KpWYxSO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE5MSBTYWx0ZWRfX52DbAk3jKuaB
 PhpgAZYe2FxCjNkOfOSIygzYP2L4UbgZMLFWGD+NxYKCbzIk3nI7LtPrkBxSGO41VzCIIT42CSO
 yP2mTMpdpmdbmfa/W3Y5vU2YWkpjT/SEutXlpvuGBK+lYZ5+GGM+gKpOr6zIh2A5Ygm3sLtpYKt
 QLvS5dV+ofglw0+54Hc47Yyu1qMJ0a6/KYebpiLuZs233KU0JuBoE4D+1KY/fm/Wl9k1cWft0i2
 DvEYiV9dBijmM5TQFAidqMAZkDs50Y2xy7vTaTwLSiwsBVzXzVD0FGiK3jp3oxaeEM1vO4qtqVf
 /Wn5sKtGTWKeHnK1lI/9UMXT2qdUHkQnVXX8lnBGvEzVEtt5mH8il5cjTQCV0dhnJeKs1QliDlG
 XS/ahPHPi7ijpT3BHPXQcI8fjQdLtWsfr4PVNQ+NaAZXtnZLMucp7yw/69XMxqehXydVK3ycSCz
 izbmcb0t9JlIdIRZQWg==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fa4d7b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=qS04rNcGil1I7-YeviAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050191

The current reset process saves the device's config space state before
reset and restores it afterward. However errors may occur unexpectedly and
it may then be impossible to save config space because the device may be
inaccessible (e.g. DPC). This results in saving invalid values that get
written back to the device during state restoration.

With a reset we want to recover/restore the device into a functional state.
So avoid saving the state of the config space when the device config space
is inaccessible.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/pci.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d0c9f0166af5..e71b81415392 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -722,6 +722,27 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
 }
 EXPORT_SYMBOL_GPL(pci_find_dvsec_capability);
 
+static bool pci_dev_config_accessible(struct pci_dev *dev, char *msg)
+{
+	u32 val;
+
+	/*
+	 * If device's config space is inaccessible it can return ~0 for
+	 * any reads. Since VFs can also return ~0 for Device and Vendor ID
+	 * check Command and Status registers. Note that this is racy
+	 * because the device may become inaccessible partway through
+	 * next access.
+	 */
+	pci_read_config_dword(dev, PCI_COMMAND, &val);
+	if (PCI_POSSIBLE_ERROR(val)) {
+		pci_warn(dev, "Device config space inaccessible; unable to %s\n",
+				msg);
+		return false;
+	}
+
+	return true;
+}
+
 /**
  * pci_find_parent_resource - return resource region of parent bus of given
  *			      region
@@ -5027,6 +5048,9 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
 	 */
 	pci_set_power_state(dev, PCI_D0);
 
+	if (!pci_dev_config_accessible(dev, "save state"))
+		return;
+
 	pci_save_state(dev);
 	/*
 	 * Disable the device by clearing the Command register, except for
-- 
2.43.0

