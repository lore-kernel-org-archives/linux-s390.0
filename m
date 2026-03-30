Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638EF38D688;
	Mon, 30 Mar 2026 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892426; cv=none; b=Wg/nLlpabEptLs5zaUj0637Nw5M8WznGRgkzKAAXeZPjAZtE0P+qog0H9Iu+G5gFtRT6/cgRPOcYynReImdOMst4TrMIC7BDJcjBrYlS8m4zcfpX41mVsBPUVmQjnrjIoYUmuhODVr1Vu9Tkl/aONFnyRiu5PxC/wEIMD5VWNHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892426; c=relaxed/simple;
	bh=mmhhEmNgf0L6OutmX2iSilVBQzGt179alZvuZKoJ+h8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s+VHxCrrtq9U4ImybT2evZ+546b64O7VkwqmrxMe7jE5VBCvZlO7luHF7YKv2AbBJLTRF18Xrv+Io/mbNTzzzgmC3inajob9DRYo3Cr1HovBliDpYzWULjp3hpZ8FEIZ8t4/3ZqTnbHfHfgIDInju7cS0U030blODYwJt3o1lmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ppDcMwrS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ppDcMwrS"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UHOw6Q780846;
	Mon, 30 Mar 2026 17:40:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9r3GMtRRVN9NDnxi+
	yXa+BzqmgUun9/32ps74J+SGc4=; b=ppDcMwrSvJ/NF10er68PeQeX9hNrbHbe9
	rK0tXr5ZWS2zmBqfoWsFt6gE5HwGLkL3gqy6MpMD2GxnontM1MwmDVITfyHRx05H
	UVT6qLuf/hJMhIO38romctqGWHp0+dVlkwQ+cfoRqtbSpDlBolV1r70azt6ci/kH
	K6N/PiTkGpX/zMbyIOYkjh8iMTFRI7Lk710kC4rMd98ecCpA4Ehx0x9acGjyWeXi
	mbtbqxGOJCfA6W9eyTwRBg9H7tFyyvUSBn90JOhs0GKnZSd5wSV9YXkD6gulJ66r
	ec/CzTWpu8F604nHRx2FHKPTlxmbiVMpf1YmvFwwzHm4t/6fW+lMA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66nnfyaq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 17:40:18 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62UDsFns021665;
	Mon, 30 Mar 2026 17:40:17 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d6sase0vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 17:40:17 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62UHeGWn44761472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 17:40:16 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DFB345805A;
	Mon, 30 Mar 2026 17:40:15 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0CCB558052;
	Mon, 30 Mar 2026 17:40:15 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.243.214])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 17:40:14 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        kbusch@kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v12 2/7] PCI: Avoid saving config space state if inaccessible
Date: Mon, 30 Mar 2026 10:40:06 -0700
Message-ID: <20260330174011.1161-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260330174011.1161-1-alifm@linux.ibm.com>
References: <20260330174011.1161-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 1nvvEz1FMKTcC96MiRiKntJPf_JoAhIg
X-Authority-Analysis: v=2.4 cv=KslAGGWN c=1 sm=1 tr=0 ts=69cab583 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=qS04rNcGil1I7-YeviAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE0MSBTYWx0ZWRfX2LoiLtIfYQRd
 8ctAvhavEKReXWvNAS9GV/VWgS7kJJ6cmyfYSQHp58mJvIGX+40+GTO1j41yVTIXFqsjzyoN8nA
 QKAujNnX4OiSuAHYbLY2UJDuHqJBMp/k74YSQcfnUxFHaaFpMxC9ZZb1iWaYe/lJqI3sIxWG68s
 U/faDWnS8JPfJ5hwL2gqrPsJveYM9tPV8cs/8tX4N8fPNq4sbFb+qXnHU6oviWOd+Qu50qyxGJD
 /7qwg/0xLYfW79WWxvfvgcjphzizU7jGaKf5HV1HYjnQuD5W7pSXhww4CHuYoMj18xUNmY1fXxW
 W2RuUK1X0HGBu1Slwk4M2F6ZKE1dXivAx+ErsadAcCacISIAb28hbI/hqI2SPdKl/GcDpWZnpbr
 FJmvMcOrIRCC4wDVaO1TNXt6k2FrquRz5GnzvimZimMZzRgMxCtIS5AjSaglBVgpJ26UhSe1q4J
 M1HCBL5yZqx2Objnr+g==
X-Proofpoint-ORIG-GUID: QoSLrto0LqV-5eMEgcOapwr4n5JqPDhe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 phishscore=0 adultscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603300141

The current reset process saves the device's config space state before
reset and restores it afterward. However errors may occur unexpectedly and
it may then be impossible to save config space because the device may be
inaccessible (e.g. DPC). This results in saving invalid values that get
written back to the device during state restoration.

With a reset we want to recover/restore the device into a functional state.
So avoid saving the state of the config space when the device config space
is inaccessible.

Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 70162f15a72c..b36263834289 100644
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
@@ -5029,6 +5050,9 @@ static void pci_dev_save_and_disable(struct pci_dev *dev)
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

