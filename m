Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4A43D524E;
	Mon,  6 Jul 2026 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783368177; cv=none; b=PuQWVLdqrDc9usRIt1euZwWbUMESueonUFkreSUsnBOVdS0DtFx86j7XiI/AMptyQJNNeHmO+kTu/ZPdRt8cGW1dotyz5AyG6l+LUA6jkRd/dXcknG7DJsKavYFj9DiOdTWaCa9oI1O9jH4Cphdw9BiWO+RI1ZcLQePGkD6cMDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783368177; c=relaxed/simple;
	bh=cxFKF1uQ8sXtBuLecwnfAqbeXGEn+xLM2QbVkFG0hNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uDS/orsyu7wAsvoUAna2+wapdjn53tlb/moIIe6l8zDpWj4/pW2QmUL57acGA4ppWD2SFF/PhTOEFIyj6QS1gwQk0aLwhn8bvIRfj0e4FtAGDeRn43OUA31MsN0LwOJz8ePWPNpwDAm8P8sTcjIeozcM4eDxBNIGf8zuy6R7TLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CurLZwnL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CurLZwnL"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666FIJ0p507358;
	Mon, 6 Jul 2026 20:02:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=U6Usfd8i3/homWF3g
	nhKhYGoqHmZe/mo7+UAjaY/tSs=; b=CurLZwnLLP51BKjVlqrY5ZuCZanP2WexM
	GQFEliRTMg9tQDoxo0hl1cLr0oVXEddPZ5S6DX1UOn3JG574SlTcZj7EKW804T+N
	eSIzNCdIL8BVnJlnh4XmN0MTIC9vaTDVdTLN4Pgf8VG94EQUbOyVB1Krc9111uq+
	RYe0amsciTpAOJ1896/0kJIchUNEDoJWISAfNk9RzUIjfjdVq42Hn85xbvtviEnJ
	+u+APy/yf3NqttReCK5bTR7JkF8Dl6djEiwRt6ZEgD8eoM87+bJWWaZss9XJS6J1
	WWHUPiLEAJ3tIYV2RgIZ9ZcPy1xBeOlscAqU8AN9x6C1GW5fCVekA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4k6nw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 20:02:51 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666JnaYg024239;
	Mon, 6 Jul 2026 20:02:50 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7cgpy8m5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 20:02:50 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666K2mtQ67043738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 20:02:48 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA19358056;
	Mon,  6 Jul 2026 20:02:48 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 62A6158052;
	Mon,  6 Jul 2026 20:02:48 +0000 (GMT)
Received: from IBM-GVXK264.atx-us.ibm.com (unknown [9.16.47.12])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 20:02:48 +0000 (GMT)
From: Ramesh Errabolu <ramesh@linux.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        driver-core@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Leon Romanovsky <leon@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>
Subject: [PATCH v5 1/1] PCI: hotplug: Add 'uevent' sysfs attribute to trigger slot events
Date: Mon,  6 Jul 2026 15:02:44 -0500
Message-ID: <20260706200244.91130-2-ramesh@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706200244.91130-1-ramesh@linux.ibm.com>
References: <20260706200244.91130-1-ramesh@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: I2geCtfitfia2aIRc5imbofIbM7AExP6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIwMCBTYWx0ZWRfX8QtLWMBdgACy
 YJONj55GLAoGZdrjER7PedP4caznzdxyPRe3vctIKqW0XWxVzwXNlPO/CPgJwtwJfDZbvuH2q8s
 mgXFLeImWX0joabw2yJOdUGu0zj1Z+otVXdPd0fmEEI5EwxumYwt3SGdYM/Qccgp512jSN4oHuF
 BXg+5L7buOuComzEBSkbQMAbfCoV53ya2dHY6WtuXJnBPko8pWXzTweECQG2j1HF31AWxwPgTSD
 620j1xPKkNHPXcWQcFyommrGYdtWkMS0xvF/+22tbzoZZNwBUHPBplUjtlSDRH0dt961gYCDl+3
 glGBVVSdF5OPFvtkn20mLWymA1qZy6wGukmYRSvnlMRcPolKRiukVmsADNV2FXMFS4OxFOZSwkr
 5699No256HjkTA3Jtqk82xqOwMeqLBv0CS1Dlf1ci2SeBYgN2PfRFnmYVxK+/MSH/86W6aWlo9Z
 1cZMlBEoAZuiyaIiCkw==
X-Proofpoint-ORIG-GUID: AzpBnPsVTJAu1Y96mrqQXj5_k2IkJIPz
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4c09eb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RLFbKyCAV2Q4rzo76dmsHbHSXqs=:19 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=EZCWm4vck40sK4hgDfAA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIwMCBTYWx0ZWRfX1xvRLUq53uci
 DRTJhYVQCn3cKe6ZjAz2q1guz9UZJjgzA6Ie/3ldAYzGxqaM5VqOe9Cbx0VChQaKlsdwvG1zGvD
 qOlbqgtLDTepyk2LWUUq6G2+jvui9sg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1011 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060200

Add a write-only 'uevent' sysfs attribute for synthesizing
uevents for a PCI slot. This extends the existing uevent
support which emits a KOBJ_ADD uevent in pci_hp_add() with
the ability to replay such uevents for cold plugged devices.
As such events are only emitted by hotplug capable PCI slots
so is the support for synthesizing them.

The change was validated by manually triggering 'add' uevent
for a specific hotplug PCI slot:

    $ echo "add $(uuidgen)" | sudo tee   \
                /sys/bus/pci/slots/<slot-id>/uevent

Signed-off-by: Ramesh Errabolu <ramesh@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/pci/hotplug/pci_hotplug_core.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
index fadcf98a8a66..c3634b1cc7a8 100644
--- a/drivers/pci/hotplug/pci_hotplug_core.c
+++ b/drivers/pci/hotplug/pci_hotplug_core.c
@@ -173,12 +173,27 @@ static ssize_t presence_read_file(struct pci_slot *pci_slot, char *buf)
 
 static struct pci_slot_attribute hotplug_slot_attr_presence = {
 	.attr = {.name = "adapter", .mode = S_IFREG | S_IRUGO},
 	.show = presence_read_file,
 };
 
+static ssize_t uevent_write_file(struct pci_slot *slot,
+				 const char *buf, size_t len)
+{
+	int rc;
+
+	rc = kobject_synth_uevent(&slot->kobj, buf, len);
+	return rc ? rc : len;
+}
+
+static struct pci_slot_attribute hotplug_slot_attr_uevent = {
+	.attr = {.name = "uevent", .mode = S_IFREG | 0200},
+	.show = NULL,
+	.store = uevent_write_file
+};
+
 static ssize_t test_write_file(struct pci_slot *pci_slot, const char *buf,
 			       size_t count)
 {
 	struct hotplug_slot *slot = pci_slot->hotplug;
 	unsigned long ltest;
 	u32 test;
@@ -251,12 +266,17 @@ static int fs_add_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
 		if (retval)
 			dev_err(&pci_slot->bus->dev,
 				"Error creating sysfs link (%d)\n", retval);
 		kobject_put(kobj);
 	}
 
+	retval = sysfs_create_file(&pci_slot->kobj,
+				   &hotplug_slot_attr_uevent.attr);
+	if (retval)
+		goto exit_uevent;
+
 	if (has_power_file(slot)) {
 		retval = sysfs_create_file(&pci_slot->kobj,
 					   &hotplug_slot_attr_power.attr);
 		if (retval)
 			goto exit_power;
 	}
@@ -303,19 +323,24 @@ static int fs_add_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
 		sysfs_remove_file(&pci_slot->kobj,
 				  &hotplug_slot_attr_attention.attr);
 exit_attention:
 	if (has_power_file(slot))
 		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_power.attr);
 exit_power:
+	sysfs_remove_file(&pci_slot->kobj,
+			  &hotplug_slot_attr_uevent.attr);
+exit_uevent:
 	sysfs_remove_link(&pci_slot->kobj, "module");
 exit:
 	return retval;
 }
 
 static void fs_remove_slot(struct hotplug_slot *slot, struct pci_slot *pci_slot)
 {
+	sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_uevent.attr);
+
 	if (has_power_file(slot))
 		sysfs_remove_file(&pci_slot->kobj, &hotplug_slot_attr_power.attr);
 
 	if (has_attention_file(slot))
 		sysfs_remove_file(&pci_slot->kobj,
 				  &hotplug_slot_attr_attention.attr);
-- 
2.43.0

