Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC70389E07;
	Thu, 14 May 2026 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778781673; cv=none; b=t5McArjBui1FibGL23vOfIBJC35kY9Cx3QfiYyfjqDGpUpAPvRpoytUNusSWLzp2Ly+U3rQ5ejLZCD0B3SjOhnl/HnLkWzEJUFTBY/t/MRxJfgM8mP1EDXNamFxBOho793nN6Ztr5fGpbFpdmgzAyjZjyKpojdcFSs3xCsPP45Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778781673; c=relaxed/simple;
	bh=kDMLUv+qGFXTZff8n7B9SWz1eb0xmrDVNGip6EZGbB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tiwV7iDsr62HC9RvxVyOVjVaD07EOilyUHsDN2xlA1nlOjeWB9YI56ko+nE/c0I8phFn6RAFpOpnfsO4y+2/e8l0YtQD41eYRUwYsO9fUKi8Ai7egKu6M4SOtVFhxKhsZsKZG9AQ1nYixve92KuG+9cvcsfZUbp4vZJxb2RODvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WBYvJsMy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WBYvJsMy"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64E7mXC93186674;
	Thu, 14 May 2026 18:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RsjEQ+ztMbfg0FMP3
	X8XOwCXQZzCQzdBTpV6PYewqs8=; b=WBYvJsMyOHwRXbg1DQexBc2VgZy6zChxv
	eT0KXjn0Qh7wo+YiKDMB1TOwyvg+rGdSLeKjphXGtP93UpYRFo+q1u0n8miA00TE
	n6fA8UleeP08yBVfz9CyoIwT23eNUoxZ/jG8MR8Hy/1U0R0Wl7WsOCXORvl8cDZX
	xR3+av+wIeEgxjblV9mHH+pey0sHHIeI+g6+MP5MSZLOgEuoDEjSxB+4Uk3C4xye
	bOsqZPaoFSh9H/PhOl4u2hCzqOx5QjZMhWMZ2QdTIUk5Ft8X1GlTo0tB/SR2ivw3
	TzmZK6wxwEHy83jWK6y5hGa9+lQPFZZLfyBJHgcWRKxJp8Qu8bEuw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv5nuu7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 18:01:07 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64EHsUCI009299;
	Thu, 14 May 2026 18:01:06 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgwjra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 May 2026 18:01:06 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64EI15xf19661502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 May 2026 18:01:05 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EC5E58045;
	Thu, 14 May 2026 18:01:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7948C58050;
	Thu, 14 May 2026 18:01:04 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.43])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 May 2026 18:01:04 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v16 2/7] PCI: Avoid saving config space state if inaccessible
Date: Thu, 14 May 2026 11:00:54 -0700
Message-ID: <20260514180059.1553-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514180059.1553-1-alifm@linux.ibm.com>
References: <20260514180059.1553-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=cPHQdFeN c=1 sm=1 tr=0 ts=6a060de4 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=qS04rNcGil1I7-YeviAA:9
X-Proofpoint-ORIG-GUID: QMf3C7PdemcaBX480hwyCkQwKvLer5D0
X-Proofpoint-GUID: QfCtP6nNE0shYgRYuZNpwYgVRV_tbQha
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE3NiBTYWx0ZWRfX3O/kgijq806E
 6n2q0LrCls8goPT9X7f01rRhVv9diqDbYOjV6DWdzB4+YNxDQC7v0KE/cTjIRDcC6Pw3cB2xA8Y
 f19w0QD9dcx9jdycJSUacNSY0tEkOLDjZNACXhtNLkFWBs75sSSk3vqUGjyOuqBhnC+nYxMJgXv
 jedaXo8vX0yMADq1bLp7qqJhPEPfimX3CiHgVc19fHG55jJMeW+oucdVeauUPnl/MidNG08hs7X
 iR767h0nLACPDGuJ/Ll3zvXneuGGsygZA8//9B8MMWc3JAh8uvbB6ODO5Xf9B+vbDxpUqn04Mmw
 2wIUni3s3SfHvelHiafxiwk6ynjLm1CiyqJqbax50cG9IcYOKDzLGtIJz/P5KJiI9N80vncjib+
 OlEIq/kEv6vzd1dMMClGbWcaXkqhzqDSHWuYcAcpoFd5uEdJRECRmrTriYv9l/GIvMfSoBfCvjh
 2l6pvxsFeYYCpCTu9pg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1015 spamscore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140176

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
index f5f8291482b0..973d23e41c48 100644
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

