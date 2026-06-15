Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3B737F729;
	Mon, 15 Jun 2026 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781548535; cv=none; b=b6vlJc0FHQOu7uAYuGS2t8N1CbotgKfophB1j7/ffTYsCKIgG+QM7fywtcwTaJ5OLrQlTb5pBxI0lSlFbvWM7ZCiNqufMdE2vM5L0sDBWq78mLY489B2wOez0BhRltdhM7yB/9apSHCUG4mXZk9GPuaoMYeQ7suyj3+9gs2UQXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781548535; c=relaxed/simple;
	bh=k4KMELZOZMjReqUINd6UWjfPtFpSJBooYrdFY9fuOQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjNWrb/nlQxZOM/yQFAKwjjpkbNQaJ/v5zRxU87oSe2Qd/t2MXc/vMiN2KJA8ibf1G4vj+zdDG96+7DrWfa44EeXd9ssZU/iva4z0FS2/CIWICPVzN3XifBwUPwdaGbkTSeYFJnjr62/n7hyfGDFHDuLGicKUADWmJZPuwmxCBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VKM6rBWL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VKM6rBWL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFmIcl2897101;
	Mon, 15 Jun 2026 18:35:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SsYY2v5J0FFWddj+V
	ekcEqqu1s6FY7VRl+LYEUz+cfQ=; b=VKM6rBWLgfWOiPc84oqxc1ew+TUO72FWF
	mub6HS7wP6JZ4QSIdEJbdHvf5UtpisEnGckvMbwFojscQVIxkO/fapNprXSfoCkU
	mlEAuvvDCDnzx2oNv9mwHJOkhCIs8vIp8V70u8LYDzv+5qIcN0Q5DkHX0dWkYDiw
	3NXFL+MZMnmemVYSjcepvslfjQiLlBYwCsEYqX045uFx0lpiCB9P12eKJveXkMra
	B6ocKMmgrnYH9cu/GZnoBtHcDKPuQsj0KqQHAtQRprxoz0s3fH3qGbjArnxHusRq
	fjQFbmHrbtwNO1UiYMvZOBlY6xL1SNE9kX0PLDcEFHQVQMXzQIQmw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h825j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 18:35:30 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FIYfat003273;
	Mon, 15 Jun 2026 18:35:29 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshwvyy9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 18:35:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FIZSCn57213184
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 18:35:28 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA5E05804E;
	Mon, 15 Jun 2026 18:35:27 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32E5D5803F;
	Mon, 15 Jun 2026 18:35:26 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.253.186])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 18:35:26 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v19 1/4] PCI: Allow per function PCI slots to fix slot reset on s390
Date: Mon, 15 Jun 2026 11:35:21 -0700
Message-ID: <20260615183524.2880-2-alifm@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE5NCBTYWx0ZWRfX3D6vXcFyTlNy
 YJGJVlwo0WehhBOKbAj7Klmci3w6CajRUK0RYN8o1hE5A0116wpKFhQ48hWpkrtPgbSj//ngUSm
 SADpNTuKWhdpF4MfiliiV2wBI9P7neo=
X-Proofpoint-ORIG-GUID: LKdtwLalrfMIUAkEYKvdAYDCbypKSJjg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE5NCBTYWx0ZWRfX8PZBsoBDUCcZ
 pFsBbFdCpBfOV8m1kLhqPZsE12OCFdyufrCf9Kd2JyZGS2wDEGL4YWcmPLHLNNXspvjx7PtlT20
 CUoWqSbgHL7dJ0Y9WmhW21JMHaoOCW4lF+ePsk4bJFa+/RXFDa7qSVkJRAnH1AAl3XWc2YDov25
 OAJQpAphL/8ycSCiMkFJ1YAd3cIurlm46xo1CHK32YJQNOah6X9kexCe3HKmZoms3hGlVFi1DqJ
 tmSwJHjnuE5c9BgPMH1RoGstulHuh95oyxGnlkyhZ1y7mZ/zgYT2RVTGcpZrrQNuHHoSs2xmaXt
 dgC3RhOSxYhbofDoTnbwJLYotRKXNiYwEi4JF9+iZ5+vrQLm78dMLxPSOs1zonF8vdGtg6L7eYq
 kGtRqmtfffl9lf7Q0dRzap0QgI0tLXHm3dpBESqJz8bOlRgRIJOY89P2yBqbQlz6hXYJV9oCnVk
 m7jWMPw1NBGNAWbWrVw==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a3045f2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=9_SSeoq7eJPDN4OswFYA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-GUID: LKdtwLalrfMIUAkEYKvdAYDCbypKSJjg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150194

On s390 systems, which use a machine level hypervisor, PCI devices are
always accessed through a form of PCI pass-through which fundamentally
operates on a per PCI function granularity. This is also reflected in the
s390 PCI hotplug driver which creates hotplug slots for individual PCI
functions. Its reset_slot() function, which is a wrapper for
zpci_hot_reset_device(), thus also resets individual functions.

Currently, the kernel's PCI_SLOT() macro assigns the same pci_slot object
to multifunction devices. This approach worked fine on s390 systems that
only exposed virtual functions as individual PCI domains to the operating
system.  Since commit 44510d6fa0c0 ("s390/pci: Handling multifunctions")
s390 supports exposing the topology of multifunction PCI devices by
grouping them in a shared PCI domain. This creates a problem when resetting
a function through the hotplug driver's slot_reset() interface.

When attempting to reset a function through the hotplug driver, the shared
slot assignment causes the wrong function to be reset instead of the
intended one. It also leaks memory as we do create a pci_slot object for
the function, but don't correctly free it in pci_slot_release().

Add a flag for struct pci_slot to allow per function PCI slots for
functions managed through a hypervisor, which exposes individual PCI
functions while retaining the topology. Since we can use all 8 bits
for slot 'number' (for ARI devices), change slot 'number' u16 to
account for special values -1 and PCI_SLOT_ALL_DEVICES.

Fixes: 44510d6fa0c0 ("s390/pci: Handling multifunctions")
Cc: stable@vger.kernel.org
Suggested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/hotplug/rpaphp_slot.c |  2 +-
 drivers/pci/pci.c                 |  5 +++--
 drivers/pci/slot.c                | 33 +++++++++++++++++++++++--------
 include/linux/pci.h               |  8 ++++++--
 4 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/hotplug/rpaphp_slot.c b/drivers/pci/hotplug/rpaphp_slot.c
index 67362e5b9971..92eabf5f61b9 100644
--- a/drivers/pci/hotplug/rpaphp_slot.c
+++ b/drivers/pci/hotplug/rpaphp_slot.c
@@ -84,7 +84,7 @@ int rpaphp_register_slot(struct slot *slot)
 	struct hotplug_slot *php_slot = &slot->hotplug_slot;
 	u32 my_index;
 	int retval;
-	int slotno = -1;
+	int slotno = PCI_SLOT_PLACEHOLDER;
 
 	dbg("%s registering slot:path[%pOF] index[%x], name[%s] pdomain[%x] type[%d]\n",
 		__func__, slot->dn, slot->index, slot->name,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d34266651ad0..f5f8291482b0 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4865,8 +4865,9 @@ static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, bool probe)
 
 static int pci_dev_reset_slot_function(struct pci_dev *dev, bool probe)
 {
-	if (dev->multifunction || dev->subordinate || !dev->slot ||
-	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET)
+	if (dev->subordinate || !dev->slot ||
+	    dev->dev_flags & PCI_DEV_FLAGS_NO_BUS_RESET ||
+	    (dev->multifunction && !dev->slot->per_func_slot))
 		return -ENOTTY;
 
 	return pci_reset_hotplug_slot(dev->slot->hotplug, probe);
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 6d5cd37bfb1e..894d6213ed30 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -37,7 +37,7 @@ static const struct sysfs_ops pci_slot_sysfs_ops = {
 
 static ssize_t address_read_file(struct pci_slot *slot, char *buf)
 {
-	if (slot->number == 0xff)
+	if (slot->number == (u16)PCI_SLOT_PLACEHOLDER)
 		return sysfs_emit(buf, "%04x:%02x\n",
 				  pci_domain_nr(slot->bus),
 				  slot->bus->number);
@@ -72,6 +72,23 @@ static ssize_t cur_speed_read_file(struct pci_slot *slot, char *buf)
 	return bus_speed_read(slot->bus->cur_bus_speed, buf);
 }
 
+static bool pci_dev_matches_slot(struct pci_dev *dev, struct pci_slot *slot)
+{
+	if (slot->per_func_slot)
+		return dev->devfn == slot->number;
+
+	return slot->number == PCI_SLOT_ALL_DEVICES ||
+		PCI_SLOT(dev->devfn) == slot->number;
+}
+
+static bool pci_slot_enabled_per_func(void)
+{
+	if (IS_ENABLED(CONFIG_S390))
+		return true;
+
+	return false;
+}
+
 static void pci_slot_release(struct kobject *kobj)
 {
 	struct pci_dev *dev;
@@ -82,8 +99,7 @@ static void pci_slot_release(struct kobject *kobj)
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &slot->bus->devices, bus_list)
-		if (slot->number == PCI_SLOT_ALL_DEVICES ||
-		    PCI_SLOT(dev->devfn) == slot->number)
+		if (pci_dev_matches_slot(dev, slot))
 			dev->slot = NULL;
 	up_read(&pci_bus_sem);
 
@@ -187,8 +203,7 @@ void pci_dev_assign_slot(struct pci_dev *dev)
 
 	mutex_lock(&pci_slot_mutex);
 	list_for_each_entry(slot, &dev->bus->slots, list)
-		if (slot->number == PCI_SLOT_ALL_DEVICES ||
-		    PCI_SLOT(dev->devfn) == slot->number)
+		if (pci_dev_matches_slot(dev, slot))
 			dev->slot = slot;
 	mutex_unlock(&pci_slot_mutex);
 }
@@ -267,7 +282,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 
 	mutex_lock(&pci_slot_mutex);
 
-	if (slot_nr == -1)
+	if (slot_nr == PCI_SLOT_PLACEHOLDER)
 		goto placeholder;
 
 	/*
@@ -298,6 +313,9 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 	slot->bus = pci_bus_get(parent);
 	slot->number = slot_nr;
 
+	if (pci_slot_enabled_per_func())
+		slot->per_func_slot = 1;
+
 	slot->kobj.kset = pci_slots_kset;
 
 	slot_name = make_slot_name(name);
@@ -318,8 +336,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &parent->devices, bus_list)
-		if (slot_nr == PCI_SLOT_ALL_DEVICES ||
-		    PCI_SLOT(dev->devfn) == slot_nr)
+		if (pci_dev_matches_slot(dev, slot))
 			dev->slot = slot;
 	up_read(&pci_bus_sem);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2c4454583c11..d58982aa8730 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -78,14 +78,18 @@
  * and, if ARI Forwarding is enabled, functions may appear to be on multiple
  * devices.
  */
-#define PCI_SLOT_ALL_DEVICES	0xfe
+#define PCI_SLOT_ALL_DEVICES	0xfeff
+
+/* Used to identify a slot as a placeholder */
+#define PCI_SLOT_PLACEHOLDER	-1
 
 /* pci_slot represents a physical slot */
 struct pci_slot {
 	struct pci_bus		*bus;		/* Bus this slot is on */
 	struct list_head	list;		/* Node in list of slots */
 	struct hotplug_slot	*hotplug;	/* Hotplug info (move here) */
-	unsigned char		number;		/* Device nr, or PCI_SLOT_ALL_DEVICES */
+	u16			number;		/* Device nr, or PCI_SLOT_ALL_DEVICES */
+	unsigned int		per_func_slot:1; /* Allow per function slot */
 	struct kobject		kobj;
 };
 
-- 
2.43.0

