Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2610D3DA5AB;
	Tue, 30 Jun 2026 16:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782838100; cv=none; b=JFhmVLAhswTV0NleT1oi4Z5iwUmVwmQCmlyzK7PPKp7jqzJqDxpSbxps9s42SCl8wb+M6fdqAE9s4EwNc+JKiBTai4LPS92lGxAwfS+VuCI0m7w1Pai4SdLvrs4PEO0lfF4RhCgL7/MShl3EqY0k9ikm/lV28iRaJcxg7wOtUJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782838100; c=relaxed/simple;
	bh=S2J6GfTA17MRPi8hVmy1uCqMXutp4PYcAl3ULfkwQ5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l1Qo/+EnBtpg0dGrNawj3iPnpx3RYDBgbuV/9Cpe+DcXAHVmTFj4OqwUZ0Cd0CI3+EVwBsafARmzuC07Fa/T21fHDNR7x4J4UR+uWgMiHS4fekD8oAXkPBkUAu7pT+38L4stKvsnEwAS0MVMJ8Brg1PvVFkAtgujhiHS+TFVTSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eVLNJZzt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eVLNJZzt"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UEIHBd2288480;
	Tue, 30 Jun 2026 16:48:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=12J8MB6C2cv981QXO
	JBi1IBshXR9vjAE306Ivlw7e6Y=; b=eVLNJZztXX7gci5EJC9l7+13EMtlfoIi1
	M6mXQo68c9Irgoc6II+UEuaPtCl3PjggvU9mBUsfaIyMRKj0+tvPOSUGfc15Ro7o
	PT9sYjd9NarqhNlxISjkUePQQo0X/8PzSiezrxFfeG/w16cLgzjXRBVV8UYHMEmv
	TqpFvOr8LGh0fL0wv7qhovHr2UHdYBRRs9e2tBdnEzq5GpFO0ZlYpoQAwQW+6tl2
	RdY035CZdU2lgT5Q6OldZeDtHvvVw2xaBENdnBL9IMaab1zE2YD0UTeTbwMV/Ncp
	cziayLo3lgVlTHgTGjjKUaXx44utEm7rFpgN8M1vbGvBa1l/BL0Hw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe00x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 16:48:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UGYhTU019051;
	Tue, 30 Jun 2026 16:48:13 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2s7w3b5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 16:48:13 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UGlcHm10551896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 16:47:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D185158058;
	Tue, 30 Jun 2026 16:48:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBF8558059;
	Tue, 30 Jun 2026 16:48:10 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.250.12])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 16:48:10 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v21 2/4] PCI: Avoid saving config space state if inaccessible
Date: Tue, 30 Jun 2026 09:48:05 -0700
Message-ID: <20260630164807.643-3-alifm@linux.ibm.com>
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
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: aUcHZSmeJFeiMJxLD4CtH-QWaigave2k
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfX0G1hjNTAv3q5
 ugrzeVvOue7IDnCWv/9QHlMIG5oVOdmxIqE471D6qEhsWR/K1mqLHDDB3ww+CZSa9qUMt3G69/d
 +GQIVhupvlT3y+vGSgoatdwMq0PurQU=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a43f34e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=qS04rNcGil1I7-YeviAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE2MCBTYWx0ZWRfXz5b23qUkFxzz
 UvKref9UGBQEVxJpUpKBJyaZV5yoIHd34ENTPC7WySmSOUHw1M9ukQTizswGgOpsiYPYn+wMIn8
 b0CjSaK9bJCsqLcSxVKetsda0xN+BpASeo1xWBzbnE97ObryxP9mVrfHcuBSz9hv9MTw2NHhJyy
 gDTMN5PpHsAZO1B1npNLNhn3GLV5vdF+NlVJ/DIgeoYzXKB6UKF+pEpnp6owo80UDh/FG0ePFOm
 Jo7tlQKxypmpjGbwugwA2RF3LSSSQu9MGPDIkMOjnbYgtVfathhfqQ9FM9t4cPfA5FyJ1ZBZh09
 3bt7uUEeqMq0Ok8oTNH/EMzUECSgT1+FeYZuzJQhY4Mtd3qYkdPHHCQe9x0p1ZskSUCiQLxZnm8
 ILfY3wmEPLgL+9kBDVIy91mStQWBxS5C1ZcfjN7vC6+y2IZNk0NLtEqNpJLRdQ7Im1Dnx3CCvvA
 g15gDBAPfEydWBw+2Vg==
X-Proofpoint-ORIG-GUID: vVrv1unXpcgrS73CHwgk8Aw6PAZggu0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300160

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

