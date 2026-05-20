Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67BB3BC680;
	Wed, 20 May 2026 22:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779315224; cv=none; b=kBXOLSyEDBdnLLZE6UByeCEtxUWOebmU3JJG06s1xIObcVlBl10NGtM+eM1BZKH6xvqll/HwwlwofH+wAvq8fAQmY9oE7n6+3LmgPgl/G+XNwyEjs+H6zrW7ZSQalcYf/y7tyd7I2RI0yvge5Uj8GoDS3Zg355YmHQrnf/DcUco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779315224; c=relaxed/simple;
	bh=cxFKF1uQ8sXtBuLecwnfAqbeXGEn+xLM2QbVkFG0hNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPNAF7pgk93Whzb8JoSQvyxIBksHHcF01CocC6vuYJaVlUozDej5o+/Vu2W/OZl/kxCqB5C7BM9NPbeOpGDkMhjcegySybSo+sIIVjRy1NTVBFbVBFq5CpY6QvZHA6yPYLlpF7TYV+ITctl5Wx7+6HvlCyVK8QBIoynhQfOMSkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UG/JnJ7E; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UG/JnJ7E"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KCF7Oe130203;
	Wed, 20 May 2026 22:13:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=U6Usfd8i3/homWF3gnhKhYGoqHmZe/mo7+UAjaY/t
	Ss=; b=UG/JnJ7Emc8+Bo0bYnaMqDlXKw5sh3mwvZr+SImvtMRm7qm1BVAoLKoZw
	03nHmaFkuYuZwKXFxdYSzLvIRxa76b75UBCscmNvrPIpcWoBZ4VYN1EfaedXbP2Y
	0Oq5eWlsJ/Yaql9MHrt4oHKykdmWStx+5o+nF0KD2Yw3OgjmIJMn5kH79cysGzPi
	g7zvBB3gUzcNvL4YV50EXlMXOzX7LXnr+2uXivCl4ctPZ8zxvS7UXfBG9kVwr47E
	wiPJQcJjAt3Y8DIlzU0X47IhvVcirTrODTnUxav1PkyspDfpm/drRlvl8HdbDj7t
	4DZ9fVcsXDb4pYfEnOqWBWh8Pz14Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88k4xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 22:13:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KM9EJR026940;
	Wed, 20 May 2026 22:13:36 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e73wk9d1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 22:13:36 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KMDZaA6882094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 22:13:35 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4197158059;
	Wed, 20 May 2026 22:13:35 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7D6058043;
	Wed, 20 May 2026 22:13:34 +0000 (GMT)
Received: from IBM-GVXK264.ibm.com (unknown [9.61.240.144])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 22:13:34 +0000 (GMT)
From: Ramesh Errabolu <ramesh@linux.ibm.com>
To: linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>
Subject: [PATCH v4] PCI: hotplug: Add 'uevent' sysfs attribute to trigger slot events
Date: Wed, 20 May 2026 17:13:20 -0500
Message-ID: <20260520221320.99788-1-ramesh@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: VqPSy3HQuENZTb1XgzfHW685e_cUUF6R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDIxNyBTYWx0ZWRfXy99Nr7JhQOP/
 qZXskUDHRaxXWn5L4C/6YNM7oXTtrCv+HMADqjl4V3tWPUi1oy7QREXNy0xcFTGGoPAwai6i7Mo
 DsRZegmg2r3P3CIKcNGn/Mp7BoeedeBthakqvN8XL9DgcmczFSUMiAukOsC3wc9hv1jbC+Ioj+M
 txCgvWFL/qO76IsVM40OYOl+WO+yCKEoPR9WlmI0Dvijo7x8+eeU6Wtp7dgoV0xZE/aK7oHIibG
 2VBALVQ/Rs7PXuV/mEJKVtoaiI3/WqRDUu/yh0Ago1ZOP6gctELMf1sl/aHQ9wT+8mSzFdR5ZSl
 7tTJJS+QoPCjN4ywujoVR8V1JjvMT58i1/ercWF7ojTFVTXeb2W6XJapTJF2r2Eb52cP9EQpRO2
 TibGwmf124SAJPSmyQ00LIeTph8ztdZ/N9BueMDmZFGbEmMsHru/waAChDlkd1p5ZqG05nFjo1h
 lMAV0Y+gWbzIiKQfVfA==
X-Proofpoint-GUID: WgUQnLKx_cs1VXxb4oHrTe2kyXUEf9-y
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0e3211 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RLFbKyCAV2Q4rzo76dmsHbHSXqs=:19 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=EZCWm4vck40sK4hgDfAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605200217

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

