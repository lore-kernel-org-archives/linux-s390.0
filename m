Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40221340D9D;
	Mon, 22 Jun 2026 17:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782148731; cv=none; b=XmEprylydwTOJUz7V14GZDEnNcjs7/3qzPEKKr2YhfZ366WKmQT+NSHf1eEjKiXgBDgD1FT6nTgE97zjX7QrZPH1rafRB6/n0QZ8lwZ9vXAz0IErpz+Of/5meBQ/TTMhX6MB8Br6KS1vTY7m0Bq9dKvcwWxdotWjS1xp8E8s9z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782148731; c=relaxed/simple;
	bh=kDMLUv+qGFXTZff8n7B9SWz1eb0xmrDVNGip6EZGbB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIkgRf9mSvJlkS7T+KgfJPFnLdOHO+gV7fgMMUI7nOmFmyYo2yQ5QF2/GUVL4txtbVYvMH25nt0xWUZTX92CNo8AUCLJKKyKVF98gg5wPDbBMAGYQALSZ9ry3fTVaMH63+ZiuMay5Wf/4VGjY2l/oKzVfMxbBuyfvxw4Oqi3h2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K9yb3cME; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K9yb3cME"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MFmAFo3398085;
	Mon, 22 Jun 2026 17:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=RsjEQ+ztMbfg0FMP3
	X8XOwCXQZzCQzdBTpV6PYewqs8=; b=K9yb3cMEgEAk+Ssu5f0yu+CSkBUT/TVJe
	ColH84+LTxo4WDCBOv8bGqb0jRhq68SCEXXLTEiXpb7nBICEHVvlEfrQezfFNC7B
	2o9LjUaSDjTvlne5slshlmNAGxsWUmVAUpenY2jfjhqa4CBXMWs/h9q9hP3zdUnB
	iESACaBeP77y0FpEBrvAArpEGLGvRYcOyMVxYDGH2v+yIlKC51T1nSNlyStzBl8m
	1RrP/LXvaZTpcxxgEiTQiMuRmmSCLNCDuDiTjWXjQH5GcgM+p58kkTOWc3Un2atN
	4c1kUPol3zR21CbPNu9RJMsvERpQT+VMyCQmQlFuL4pLT8/aj0UnA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4afbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 17:18:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MH4cQd030905;
	Mon, 22 Jun 2026 17:18:44 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jw7dqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 17:18:44 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MHIA5w27460234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 17:18:11 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F24858056;
	Mon, 22 Jun 2026 17:18:43 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5AF7558052;
	Mon, 22 Jun 2026 17:18:42 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.248.203])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 17:18:42 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v20 2/4] PCI: Avoid saving config space state if inaccessible
Date: Mon, 22 Jun 2026 10:18:38 -0700
Message-ID: <20260622171840.1618-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260622171840.1618-1-alifm@linux.ibm.com>
References: <20260622171840.1618-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE2OSBTYWx0ZWRfX1vbdIHKCoElS
 lGmxYj0Zc510ZL4LawEUsdZRj63v74jHZ0xLNKpPywZGD+o7TNO80YaoWI1w9V/l6hmhFEv4+VG
 uFcUCdao1oaZiO2O47k3Rll5GlL3Ovs=
X-Proofpoint-ORIG-GUID: pvSC-VAbgmIWs8qT4k5AYsdvbdQ-qQNL
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a396e76 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=qS04rNcGil1I7-YeviAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE2OSBTYWx0ZWRfX3HXUlHaa+8f9
 2vzqDxxvum3zL6Q7Fc8Qpqm8BikQEs2sg7P0b6PX7jxIQfyCS7bzw4yuM/BegOVJegpmXAmZJL2
 l5yXu/PQP8wDZCqSD9HMYVEG+QN1m09/bsB7VgFQOA2TmNXZUtsu6QwXuO8/wZbby7SVKVmR/AG
 YaCes38Wlv66h7lBc3o2qx1MA3NALGzmXkYu3Wv51Np2FW7OpxS7mgKqQSflsBPppcO/yBTikY/
 KTJI9srcpUvhHyuM2Me/P5k3Q6NJ7tpZqUfaDUtKJb6XfRHu3RVFIJBalxZRnI/lZO7Y3UHjkTe
 cRSXimUrE92DZB4eQ05pxi5PZhqwJMSt6btmSHNQg+rIXj5QfcK9h+QxlwPaJynYjU8KTM6s+My
 TGfYQC/IriywI+cOJwS3gfiuwgFNoB82k2XndwG3XYTDhy0pLhfksWeBSNcLaA0Jpe51MyRUZKy
 dKeJr2PmHmrmUh/S/WQ==
X-Proofpoint-GUID: fNY43lNOKLT8Cyp2CjvwMJIccwsaeSGV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_03,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220169

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

