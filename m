Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CDC37AA92;
	Mon, 30 Mar 2026 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774892426; cv=none; b=eE777gd6ootDlUmG3jQtmg7Sy4GVEGTWGiahXQHHKkqLpVcMMpt8i4Nx+Kq20eG1I651j7pV3ZvT18h5jH1Eoc9qwnPAIVFvhJ652OuTFTS66KTYWqUXCjxe1fKntj6Ilm9MkeEsShoDTZAbU9JYmpM93vo23/Bogsxt1wzbweg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774892426; c=relaxed/simple;
	bh=0iH3MUitFeOyf1ic+RqGv4TaaeNJKKzzb/3Mdf36bPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6FFR8nSzcfX4OKsLtyVd21xSaw2TLeEpnpSyNExSQHKt/n+//FffwiJLWUGgYqtsCaN1xGpIBpktcopK790BMyDiV83jziJP3M71qTL70XXbpRFLIZ4xQN9ZpyvKyOUaivW6tNB3DsPYafWs/4NPs5OrOskSFPknp1ltJ20Pb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SUEirvHq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SUEirvHq"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62UAmkTQ3763981;
	Mon, 30 Mar 2026 17:40:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ko/PYRrBP1ZwZASqm
	mI5y0jvQ0bTno6kHMlVWd5SD+U=; b=SUEirvHq5e8vxhSb2lL5oXWAuR1zmAIww
	5lzK7wLugSxXOwzDqUXyQyY0P2bgfiF54Ot0xRi4hpQve3/iMdg4fTBAOtwGSvEH
	Enwd4Na68BHxDmQUUI7j4OV/26iOTPXZSYZ7q1GbAXfDk2iHB95KULoCMd04n8F8
	22F4Df8csh/c/DlE1/RswN0rtZR+MikhxdWp8JsJDYfTRKYpwZSd8vemkt6OQ/1j
	176xQfz07PSoWr5cwjvJ1IvWa4cA7eekD8ZxAW0hbskcjvpAlwj/15HpkbsLPnz7
	zVJtr5rKseW+nWTuWuwjATPT3JORMISMmAWBUY6L620dcNSuODYxw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66g1r13s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 17:40:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62UFJ9i7014339;
	Mon, 30 Mar 2026 17:40:16 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6ttkdsfp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Mar 2026 17:40:16 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62UHeFQx63308198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Mar 2026 17:40:15 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E28EC58056;
	Mon, 30 Mar 2026 17:40:14 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 131E958052;
	Mon, 30 Mar 2026 17:40:14 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.243.214])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 30 Mar 2026 17:40:13 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, clg@redhat.com,
        kbusch@kernel.org, alifm@linux.ibm.com, schnelle@linux.ibm.com,
        mjrosato@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v12 1/7] PCI: Allow per function PCI slots to fix slot reset on s390
Date: Mon, 30 Mar 2026 10:40:05 -0700
Message-ID: <20260330174011.1161-2-alifm@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=Fdo6BZ+6 c=1 sm=1 tr=0 ts=69cab581 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=9_SSeoq7eJPDN4OswFYA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: xghHOGXHJ9l2VuVo-LHV-Uha4e3hn4WT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDE0MSBTYWx0ZWRfX3lL/S9qx6GCQ
 wB5PXo7ImWWXutYIPJXmaPwj5u6C0jPbzhIVLi0tCGTPVjW0HIopAoxkkhzwvSIICiZiMVJBrn4
 s3oDht6sHLMUvmYRJhi8lqaW2Jx3EORuQzBH4gBjU4VCb7jul7X1CfjmNI2E75p36VmYjnP5MAe
 krYw8fzpIm7/aezDcfVnVrqRY5IrQZiniVBeC2h+gSR8oPBBuLdpUR1Uy2k70GJuztbm7BLfVCe
 WMvo3TOLNz06LxBMqCbc3+8pqmSQj/2R/+E4vTe3a0ZhVpS2KTZue17H9Ld+MP8Ee1ngHOT9dbU
 T+8c3RDDRChVEZqG4ufQ5NK6PAvP3BXKiGeqjPQX8gnSUjh5RcsaSfc2hVjJfhhirZ6JQHzY1An
 9zkVHzP5zPY+dLtP+G+glK2oDMl0BTKsaZfLL+UwDEwcwsJgmXZ5C7S/AUCqk1cIVx4FbdRGnd1
 yZ4Jed+btq/evKwgUxg==
X-Proofpoint-GUID: xghHOGXHJ9l2VuVo-LHV-Uha4e3hn4WT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-29_05,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603300141

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
index b4b99fb32731..70162f15a72c 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4867,8 +4867,9 @@ static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, bool probe)
 
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
index e0b7fb43423c..3f6e5dce27a0 100644
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
 
@@ -176,8 +192,7 @@ void pci_dev_assign_slot(struct pci_dev *dev)
 
 	mutex_lock(&pci_slot_mutex);
 	list_for_each_entry(slot, &dev->bus->slots, list)
-		if (slot->number == PCI_SLOT_ALL_DEVICES ||
-		    PCI_SLOT(dev->devfn) == slot->number)
+		if (pci_dev_matches_slot(dev, slot))
 			dev->slot = slot;
 	mutex_unlock(&pci_slot_mutex);
 }
@@ -256,7 +271,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 
 	mutex_lock(&pci_slot_mutex);
 
-	if (slot_nr == -1)
+	if (slot_nr == PCI_SLOT_PLACEHOLDER)
 		goto placeholder;
 
 	/*
@@ -287,6 +302,9 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 	slot->bus = pci_bus_get(parent);
 	slot->number = slot_nr;
 
+	if (pci_slot_enabled_per_func())
+		slot->per_func_slot = 1;
+
 	slot->kobj.kset = pci_slots_kset;
 
 	slot_name = make_slot_name(name);
@@ -307,8 +325,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 
 	down_read(&pci_bus_sem);
 	list_for_each_entry(dev, &parent->devices, bus_list)
-		if (slot_nr == PCI_SLOT_ALL_DEVICES ||
-		    PCI_SLOT(dev->devfn) == slot_nr)
+		if (pci_dev_matches_slot(dev, slot))
 			dev->slot = slot;
 	up_read(&pci_bus_sem);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8861eeb4381d..ce0f7bff080a 100644
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

