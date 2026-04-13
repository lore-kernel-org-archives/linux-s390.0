Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72B3939A4;
	Mon, 13 Apr 2026 21:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776114382; cv=none; b=tkszk42oyxyGHZo9oXo2ex9m/syt/tgiJDL0E9VZ6iBcwCqcdHcygE87BRPQDWtzm+b2bo/+qV7821YAX4gNi/0RPtSaBqWm43n3fQ4lq8iBp5JPFoBjso+8RN7yEkrHN1XYbEJ8cBfCzuACLIlvaafR8oofuJFeVQVMd9zHzzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776114382; c=relaxed/simple;
	bh=POORsXRkk4nOKnrZRpviXSsULTny9Rnzj8bxogy/6pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbz8l0xrZomChCOQ7Y6AHdrnTbTkJymv4Ysk6XSLzwQZoeO/rCT5RzyEvfiKlfJvMD/CzEE2St+hzXbu3Nyv5+zf+quu2W1NjvEoHzxR68ZlwuSPfCwgOG9dMVLDJ003CnMcVt1ROeYb/DG+tY7790bVYygk3dPWvJszjySMldA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o8h+GjpC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o8h+GjpC"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63DG3m183430311;
	Mon, 13 Apr 2026 21:06:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=B03ES7Gw4vOtbWqO6
	B3bh3UMTVIWbkYsdM5+gP6DaHk=; b=o8h+GjpCCNNspgx4cqSKhQHaZRZb/B8ad
	FL6EUIwUC0G8xijUWB4YuVnjWlAm3Ei3A3PgzwBl/oE8Lip46/aDHkaamhUjCS9/
	rRpThy+M9R37I2mcsVXAnM0sccUo6iGGdmS3JPiQ5ARsS5ygPaBbzDe3aBsdB7fO
	qjzNoFD9hswRLbUHDNIgK3hY2rkH3wXrQnJ+RtYk3QykDKTZC/94doXctBCWAKC5
	PzNY3UfTW6f+FyEWEx84kc+sGcmoY+mWf4opjzkIDm0m7YxHss1mvlvxaoIh9+Tg
	R7TPU+81tyQpUsnWjljr50yieSCqhUjTlvwl8gvZvjOAgT8vpcUvQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dfcqf1c06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 21:06:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63DHF0Xs031106;
	Mon, 13 Apr 2026 21:06:14 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg10y6ymr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Apr 2026 21:06:14 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63DL6DWT19792514
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Apr 2026 21:06:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3433058054;
	Mon, 13 Apr 2026 21:06:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD0725805A;
	Mon, 13 Apr 2026 21:06:11 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.254.131])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Apr 2026 21:06:11 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        kbusch@kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v13 2/7] PCI: Avoid saving config space state if inaccessible
Date: Mon, 13 Apr 2026 14:06:03 -0700
Message-ID: <20260413210608.2912-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260413210608.2912-1-alifm@linux.ibm.com>
References: <20260413210608.2912-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDEzMDIwNSBTYWx0ZWRfXzDHj9vBP0TeQ
 pXkTOB2W7YPfhOYl099O9D0QX8Rvk1mu+qLTwh7hkI/LIwf6xiRaROPgpu10fjGAcXTDXvVHeP8
 ys1Wo8wSnp1Y4SZM1C9VOK4fricwrjcrp4pwwgsBNAqvUrGiAzGmgsAsp9puiNlEh1sEcBA73xW
 jjFKTqQY2UmJ+veWtfvbT8tRcdnMdLzDts13Vx/ghvEGjAlSXXcrKBs0aaNc9p5y8mQH0iTGKvU
 /Csq+HludxiB+f7ZTjwiBEXKQpsXo4VH9MHbnpYdZ06jf1tI8rM4FOtGzGxHHCIPcprQF06Thk+
 rVTFNswxoH+QNrga93xzI3/vX1Y4JZPPRh1hWdSMKXxYsIjCQwrT7T49ZsHCtV+05jTo3BmDK/q
 G1mhtZ1HT5Bm9VhCT8bKbd14y96GAITrqoF/VDziDYljOwQmaReLvviWh90nNizJCkoJAf94fH/
 pO9JDFEIH+VbtU0mNgQ==
X-Proofpoint-GUID: sENcbDER-SnREitPnUnRtymFyQoEx2Iu
X-Proofpoint-ORIG-GUID: kfYcxr6v0-NRyAeQK0vVsAsWlu0AbjoH
X-Authority-Analysis: v=2.4 cv=YemNIQRf c=1 sm=1 tr=0 ts=69dd5ac7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=1XWaLZrsAAAA:8
 a=qS04rNcGil1I7-YeviAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-13_03,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604130205

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

