Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D904380FC2;
	Mon, 15 Jun 2026 18:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548537; cv=none; b=qhIQqu++EjyhJqNx4FpSkpsNks7E/YJpNixBr+lY+ywD8ZH0Wt9TBAVAVBkOFyLe+SQOgn2PkMkWNnIZdCu3PmyyOtqNUO3uMEV4Bw8EfuT9b+7rcH+FdYKHykROrXKUQQXq58sWhIJsVqPKm7CuAr2fRKAV/pD1RdVvK4tc9kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548537; c=relaxed/simple;
	bh=kDMLUv+qGFXTZff8n7B9SWz1eb0xmrDVNGip6EZGbB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7xCjgiiHl7fMVEgq5F+nLtTma0VZjOq+8FNo7Uqmw8fb4bDOUPkyDHe37Pm6TYrrr/XKKHWfBDygSo57zBUDvQ+VSia9gzkNMWsu4OHEo7m6cSwqX0lvnKUNY4hGjdy07+SwTr0gt7eP1/eT6e6GMf+AkMACmKJNUlHCnV+1N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rCzeqINJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rCzeqINJ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFmVgi2841750;
	Mon, 15 Jun 2026 18:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RsjEQ+ztMbfg0FMP3
	X8XOwCXQZzCQzdBTpV6PYewqs8=; b=rCzeqINJHP6juBQBmNNZjvWhori/eoM/6
	LNbsuqjiXhTogMj6xHza7rvJKTWsCvTYHANGV/epnJZMacR6WA22hYCmX+XYR7Fy
	S/IJbsi0xRCqP3AGBZDZZwfQ6S97GCbalMMFP2HgzPlckCojpwEGGlTA4vvgf/8R
	Jlz1uH+hJ/I7NZf9siGZV2auB0ml5sIz6ILEis7c7/GNeAil6NIMhVUGCgB/vEXq
	qAVYeJW04/YExVhI+fewgAPdu17w4HHhy22F8KwfMU5qVkbGQYIHdK8yoR66DWKX
	L+xb3XGYK/nJarGBowyYBGwKp+M498iwy9j6Hzqy/l65W72LllysQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nj1q0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 18:35:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FIYgtI014751;
	Mon, 15 Jun 2026 18:35:31 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrg7nu0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 18:35:31 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FIZTcA59441574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 18:35:29 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 78C1B58056;
	Mon, 15 Jun 2026 18:35:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 265325804E;
	Mon, 15 Jun 2026 18:35:28 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.186])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 18:35:28 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v19 2/4] PCI: Avoid saving config space state if inaccessible
Date: Mon, 15 Jun 2026 11:35:22 -0700
Message-ID: <20260615183524.2880-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615183524.2880-1-alifm@linux.ibm.com>
References: <20260615183524.2880-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a3045f4 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=qS04rNcGil1I7-YeviAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE5NCBTYWx0ZWRfXz+jGbphsx8pZ
 oXHITBg8J2l/NWh/sb5vncg9YoNTs9vTQHIo4+y7S1ophBMpgLsRXRx/TiNq34WpsSTLn3kd4Yb
 1mQQ7hW1FpJxdszFj5RNMqdtc57O4O+BJKwsjMMoqIbul3kfqHlD5NoKPrAxzmuPNugS5v0FJ0T
 ziiAwPc5Wnk221Ian8Gtl5nq4GBw66SlnP8hAuHf5RhUSBpgo+Ju3xUV/llmVJC02bTYVXkLPFS
 EAAljVQd+REnM1OyB7wbVnI3j/zlk0K4HVZj/FLNZzhrc3I3ylObDfT0ZsYFY8rGiVOVaiC09W5
 o/6QRo0BVCImf6KFJylXzwdNPdc14y43FTG8uSkAJNKX4zfCRBAsNrq8mt+NVZNt5zUCjGB1r/l
 5uOEOx0RG5h85m61UvWmVt7GZ5dEm7jV7KzFp8Gwf7oc+Gb2SljtNadkWUseR6LyYFrOT0I+uaI
 G6uAJ7E4YxJ/WcFu1xg==
X-Proofpoint-GUID: NFgXUFYCfjNz37BAcxAmv2UhCKwEwJ7H
X-Proofpoint-ORIG-GUID: ejCtdoN0MBXegn7j1CrUU96ebszbr0BJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE5NCBTYWx0ZWRfX9cSYxo3g6s/m
 rwi4QYHsjMHlyZiZV9WzUEFtq78duBS7Ks57zYIoukk+iAW4eRQq5iAo4Sbr+wmdrKHD4weDcLZ
 uBeFKNxBwHUEr0LmtNmV93fTfn83lw0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150194

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

