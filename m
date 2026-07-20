Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FB33AC0F0;
	Mon, 20 Jul 2026 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575517; cv=none; b=BkKBCSVfV19gFtERxqVHfY/DLX6Na4F3D+8qC6gMDlZdV6BsMb0Aci5OAJlwAVIplvoka5AFSjy3SBg3DDcNe113zEskJtm9QNk0XmLSLKFfCcxGzLXvwdO8ciT7nchMp4TbvJBhg4O+JLa43VRzGVZuOlBE2reJ/P5ozJyivow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575517; c=relaxed/simple;
	bh=S2J6GfTA17MRPi8hVmy1uCqMXutp4PYcAl3ULfkwQ5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9QS7lYzJP/zsyilzcXA+bqFmd4fkyDmQ/ankS8PHQB91bupMhII3C0uq8lMBEJ3K/KsQO/NWr08V+CqwL/RmqerneOCWeyxmJwcJg0PkKVCgD6iLymw/FYuG8Q3Q8EvdJ/pKp62sqnAEg//mJu4s6N0KQhzKWBFsihEOXpAI5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OZ4vWrEp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OZ4vWrEp"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHBlca2713249;
	Mon, 20 Jul 2026 19:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=12J8MB6C2cv981QXO
	JBi1IBshXR9vjAE306Ivlw7e6Y=; b=OZ4vWrEpPT6vUbAlWlGg7U9SfcPj49h+M
	y1kh3hLZUojTEeNnEGx7YZrCdDqLF5xvSetqti1M854cylNZHOfoyoMrwHcdrJkA
	YblbaXQOwv6hSjk/ycK/uinwdDd5zcdFhxFaptHmyOGFIOzzGtnuW8dFfBOsq9Uc
	dnW4XT2k+zb8UHXlLVs6N5ATl5aQ7qyyDjKoTG+CSguNRAt6oqp5yJLNBe+LX9X+
	VQzg6pbmXs9N5/bZTfsePTy5imfspkKIu3QLDXlSH4MzwZFuU+1nRzBtkYRL55yg
	Q5lS6hTas7C1eVAAHAbvumaHfgbpCTDMxNeVtAts1EGeNUNRQTOzA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78g0u17-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 19:25:11 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KJJj07031559;
	Mon, 20 Jul 2026 19:25:10 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnagxypc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 19:25:10 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KJP9W217629856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 19:25:09 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15B9058059;
	Mon, 20 Jul 2026 19:25:09 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AA7658058;
	Mon, 20 Jul 2026 19:25:08 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.255.209])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 19:25:07 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v22 2/4] PCI: Avoid saving config space state if inaccessible
Date: Mon, 20 Jul 2026 12:25:03 -0700
Message-ID: <20260720192505.2957-3-alifm@linux.ibm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIwOSBTYWx0ZWRfX7sREyUsQcyUF
 raefviX4KSF+Ek0V8Kt/CUpVoTQa7guo6B+d9erxIVIdZnmyYcaS5sJ0yUyW9kTf8I1V18uE9WB
 Fs7P+nvJAHu1Na1Te7SEN+wjU7yUW0Nn3Qjcqu45WeYWzE2UXBzzl3Rzk6kWFrUJGji2j8/ek0N
 h3wc/iut9dXW0kdg2uYG211QB54d8XZYZhoO81TfanJEf3q7hyIYmNDRJX+MIi3DLEtnMuw/iM6
 4uQNNGGlsI/8ZNgk5Jg0gIFwrqp0WQM5FigZHTZKHVxJ4RqPVHU7pCLvjUtgxs1k5GPQQ1/beOI
 eFYBzeNB3AWvgDJy6zihhnUqoPu7n8k+yq7gRLu6xO9DBwoKluaUeMF17Ydn5plmKOzVcCgiNP1
 Ahw+k26MB4rq/tSWgra6s+Q44pU3epG9Td523gdQCDcBsltKK6sdhcfx42xWgSTH2gEGaqBzkqr
 whuhC3FKPApt+Cr9/5A==
X-Proofpoint-GUID: FxK6uxDDzsXrxsanppR8FXEokdRY4pUM
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a5e7617 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=qS04rNcGil1I7-YeviAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIwOSBTYWx0ZWRfX3WVSfM3Vqw2d
 yKjl4ZJwVY5JFYlXVNMMJtOx0CI8pWclY9/dreol5PM29ZG9hzjaBuQvn65mm41hP5rh08NvUnq
 HuVqMu0TUxHyy80JXe1KWPgYwzWBZrI=
X-Proofpoint-ORIG-GUID: Xw6RySL16AKrwomTYiDoKYbPajI0ovp2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200209

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
index 350bae907ebf..e8d7de77241a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -713,6 +713,27 @@ u16 pci_find_dvsec_capability(struct pci_dev *dev, u16 vendor, u16 dvsec)
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
@@ -5059,6 +5080,9 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
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

