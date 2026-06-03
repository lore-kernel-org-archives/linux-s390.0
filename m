Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1333E3173;
	Wed,  3 Jun 2026 18:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780510628; cv=none; b=vGZJhBD6uCnI12O1JvGb9rjk5PF/GYAaKM35YgjA9D3JiJOoA1qJjGaAo+bMXpC81S+aTmS8qXKJFtGwqy2d5UUTNjYifyzcgXo85d7uUyBMtOOHlaOmHxQ8/FrnXKiFWajArvuLmDUDPxCMJU+wIhAg9tD/AMHDY5+AKu2WOTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780510628; c=relaxed/simple;
	bh=kDMLUv+qGFXTZff8n7B9SWz1eb0xmrDVNGip6EZGbB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fy0roi4r64dmBaJeRQ3pvYzvVp8f9bKF3R6AQLDGuTqVUyFAjIB5zmaxctP7EM3TwwLWI2nJCrEF4SPPJcDfU+RCZCnN0fq1+uwBJ5yLsWqCjrbNS0ikMFI9hAL9R5ajfd4mVCjR+KqoVHq7SYMsdpvWz9094FVAGIJztDraIgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pe2EHtE0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pe2EHtE0"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6539FnJf2292567;
	Wed, 3 Jun 2026 18:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RsjEQ+ztMbfg0FMP3
	X8XOwCXQZzCQzdBTpV6PYewqs8=; b=Pe2EHtE0yjR3GuEuGxiG8Q48PjHn5YzIy
	YFkEXlbONxW5INBlqvFoQ7pJitn7QNhJ9g2RjC6aZ/t6rCUYRxIyn0V6zqyaFMqb
	EeqBBfkI9sQLdXapexWsj42pyZ7205jiuWTeOjL0JADvVzEvjY0YksQXGMFGheju
	DRMeS6NZKjueHq1JVDOyQi/xMdUsxIO6cz9Omae/KlSW9YIk49tODSwZynliTXKm
	7FEEWCJ24NiV0+Le5LRfn8h/fPC6WcsVwRED70v8Jqyc9o4sdCYxpOFNNLBzXfFK
	4ppbfH2dLBtCnPHvcnYlJWeoZ1dgvwDm1MWwx0Ud8HnnENDLvydsw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqjqcbcs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 18:16:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 653I96X6005390;
	Wed, 3 Jun 2026 18:16:54 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egb7k9h9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jun 2026 18:16:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 653IGrbD27132442
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jun 2026 18:16:53 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 08DBE5805A;
	Wed,  3 Jun 2026 18:16:53 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DF9C5803F;
	Wed,  3 Jun 2026 18:16:52 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.14])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jun 2026 18:16:52 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v18 2/3] PCI: Avoid saving config space state if inaccessible
Date: Wed,  3 Jun 2026 11:16:46 -0700
Message-ID: <20260603181647.2215-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260603181647.2215-1-alifm@linux.ibm.com>
References: <20260603181647.2215-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: Rbvb8IFXtLofnQZw6WEWeDl6ERvsKcE0
X-Proofpoint-GUID: b2zhbloSJuo_LC9MWO_uxhVP138E5WAU
X-Authority-Analysis: v=2.4 cv=bcVbluPB c=1 sm=1 tr=0 ts=6a206f97 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=qS04rNcGil1I7-YeviAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAzMDE3NSBTYWx0ZWRfXxe0epcBG0jdx
 ofl9o7RzVk0rNPV5R/aT1jefcb0POs77ZpZmq4u6fM7l18GTkO7LnQ6fnZy0SSfSim2uRase/dM
 wjd3YGvRfn9b9IsDouXWqf1BEF07oPd5CTeXfZ2yUh4L+qPBtudhsigzSx3lTgzEOjjSYQqpKKD
 rYuyrIFz86t5NYY8HOLsB7/Dad+OnrOnOfNZR+kjT0eAYwNaOvn+wKQvymmG9/U1b8RolAMUzQ3
 gLzPo6Ol9kPgwuSA/dw4sDsPSZjSsCjwAOAt9CHN+AtOdKwMCvQhTTbe8JdN3GzMt7zfAzeotWU
 ggXoLG91kW8eQeLcc6+wzDwtLs/UjiUFXV2whVwTSndOsnAen5Rdh8ogZY8a9fIJTwluwaa7li7
 jWnIV6v68ePWki5H6FCyvD4UnhcVeNO8V36dzhVFqTB1VyYO7O7ntcUTisai3NLZt2baLUXm3Jn
 7MDwm2kKP+D+ZHSoiWQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-03_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606030175

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

