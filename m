Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD463DB314;
	Tue, 30 Jun 2026 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838102; cv=none; b=sVFyy6SL5Ct+VdJcNfDVw4MqP8yY6qOZRNwmJ68o46Uzx/NWqJKYbfoymOJnKvcmNQ4rN6x7b/cEuO18YXqhxXsDMO3UijSTKLzEFLtr6NaZDolP/io7yaHSzcUXYyFwt4qC73GP3ZjNJ5OFwVk4g0P1LI4abtcpt3j4QUVbvlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838102; c=relaxed/simple;
	bh=gKQYf74xPpytI8rbZnvPeewbN3H/KzF0nc088tK6OYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j3auipmKID5/KYkKLdiTpeFd0WOaj8EVOA4RZSj63xeFbFP+lHpxGA4hRjrHcmIc03o9MCtSr4KD83LDnQj0v1VI+lDmDF7eNGbhxNuBMs4FLBZSkWQoxA/2zkEWAgXZPFNhP2Mh8tWWTM2KRiUwqJtjg071t+8WI5OBAx8NpkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bKBn8yiw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bKBn8yiw"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIH6K2288478;
	Tue, 30 Jun 2026 16:48:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=q3mWEO+m7Q0z7JDH5
	ZGSHJF5tisumNe9dB4cIXGURIs=; b=bKBn8yiw3azk9i9nGFGZTAImB6O9+EpZk
	byLDsLPV0iC9XdBnMxDBtNrV6swNcvJ3yDoXJ/MnkJoAsGbiS+K3r1R7a4CHgGDQ
	76E9Y2Pr7TR8GW+gNqO91hWsdrQzrB7B+aEk+yJr6sUQuhlizbPksPR3pYGaQmVi
	dPJlYjemSdBcIUzAGnaX7cx2zVcHD303VSJDP4oKMKHcaEYwzDVRbE+V2s89tqV1
	CjKr9Dnd1P4IL0ArtF6jZNXnztVynx1V+JtczOOUz+YuQZxpbiNjJWMN21YpKike
	Ihkf5eMypJ6iVn3vmXkQ85EyrX4AcxNYNvqiXOjnK+ac85HAmzGLA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe00xj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 16:48:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UGhAr8026978;
	Tue, 30 Jun 2026 16:48:16 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2uhyb00p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 16:48:15 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UGmEmH24707788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 16:48:14 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4648B58058;
	Tue, 30 Jun 2026 16:48:14 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 384FF5805C;
	Tue, 30 Jun 2026 16:48:13 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.250.12])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 16:48:13 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, stable@vger.kernel.org,
        Thomas Gleixner <tglx@kernel.org>
Subject: [PATCH v21 4/4] PCI/MSI: Enable memory decoding before restoring MSI-X messages
Date: Tue, 30 Jun 2026 09:48:07 -0700
Message-ID: <20260630164807.643-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630164807.643-1-alifm@linux.ibm.com>
References: <20260630164807.643-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gynBASBXoYL22XMEwbLu4mO8n90zXUMB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfX8K13WtQDCbGB
 vclCbW1gVhGfiGsSqoXygFHxxR4UhuxYkGzYEx2FBSBOQiThzCi40Rwu5p0IdNyt0iUuxCKC7OW
 mi5we6+hcnVCTJWBvAScFOYhnuTBQw8=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a43f350 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=di-imCqyroNM6h0WoG0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfX+QKgj5Eu/7Fz
 4gDnY2seQEIFJOUOUNDrb7Fo23F7+JsKdHdSYJhk/GQKPoF10sq0324EFr/wz1m55Uy3nDT7m0o
 8miZ5P2luOdj4Udpxo5YYRdr/RLEfpvV9sgr1YGhBjB7wUM6Te0bZ0RshJ/qu/wlujbDFTasHJQ
 tgsXRw/qpV39NimQihd3WDsmzMoxY0u/Cm6cYbdjq/sfD9Gq9EPppcfuOtCru3S8iLua+GUhiRF
 yCg2VbBpRPFcr9RLdnjk10OVPyZqNgrO42djT10YYN95gvKrFL/nOrVunMHHVeS981rktPtYfYs
 +T1HLviZcToBa5DKthqjzXKB2k2UFK/xHPelCiKUiUczkIS+lHvcl9D7fRrhLHfU3Kh14R14euT
 6qgbthQfmk43c98s0S41KLqE39Cml4+qgbmLCsoRoITdK0kRkZ1cTKDtlRShvrViO6esfZKwq1I
 o6IrrxVkSkiXi2i4EPQ==
X-Proofpoint-ORIG-GUID: gynBASBXoYL22XMEwbLu4mO8n90zXUMB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300160

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

