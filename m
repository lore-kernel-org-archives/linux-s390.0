Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661C63976A7;
	Mon, 20 Jul 2026 19:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784575516; cv=none; b=U0rP+PWnxDwGEFqhJgk3oJ4sQa/eigPqVrNLhkOWoXfLnQHWst6Ue43f2G+N3b1ov5rBPHBhPJOLsqvtl8b7v7isGO0tyqcMyiTU9hnRnfnq7RmyMOxOyzkjrImlJixF38Aa8GQTK7Zhf7YKri+GtfydtPyEJNPFQlub9JkB9Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784575516; c=relaxed/simple;
	bh=6CRJnd0/Ymbiy3TKzN1Eum5qPgq+Fefp0E09H7dsQoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JS30kiQZ8dwUCJYodJ/cjLHPl0FV7cYRMWUYWSN5dkFy5HHSoJN+Tm8tTi9UMrUmExhwZpSv5Og0RzSptd2NfGVVp1mXdIpHBAeLrF2yT9Lyx4QbxsZM/+b260jRyHVQfwrWUfjgYXvvQMcHGhehdEZyEOxqP+4fbs/t1nZZI6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=phdLzT/l; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="phdLzT/l"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KHBkdY2816018;
	Mon, 20 Jul 2026 19:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kHEufnb1gKWmIpNJc
	HNQTLEhjMPk//7ya5bzvIwvv8c=; b=phdLzT/limwNbOfB7Yd/18E/IJIFQMGA0
	ntNcEWVRF8W9cVvOBHXv0n1Bsb65wwnBrKZi3O8XLP1e8AdtrxgevgZYqOXBDD05
	FuImvOBAQEcjkMx+IqopgjIAR30/fr8cS1T9+V+svz4CToSxXesGzx6W9QFQ9lbw
	pM78WfN1qSuFMESd4eAuTBi5uXNLE61vK1sxLhtbhUSrZcu5xLDeTpMWO6CDtzD2
	SjrGoOPRkSYngXPzGKMUUYgZ3b8MVhMxIv8jeTziKXJXvrBgJgAttc2urJKs8nbQ
	R6kCSzTDXdofuMFaZLUWuAJstWEaUnVO6Pslqt5DJDmg5ovRFnRFQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg790s56t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 19:25:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66KJ4bFU014874;
	Mon, 20 Jul 2026 19:25:09 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgmtjq11m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Jul 2026 19:25:09 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66KJP7Xf13369918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Jul 2026 19:25:08 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE6335805C;
	Mon, 20 Jul 2026 19:25:07 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CEF4658058;
	Mon, 20 Jul 2026 19:25:06 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.255.209])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Jul 2026 19:25:06 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com, stable@vger.kernel.org
Subject: [PATCH v22 1/4] PCI: Allow per function PCI slots to fix slot reset on s390
Date: Mon, 20 Jul 2026 12:25:02 -0700
Message-ID: <20260720192505.2957-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720192505.2957-1-alifm@linux.ibm.com>
References: <20260720192505.2957-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7EKvy9ykML73rqI7o2edkAi4PgIzOOyw
X-Authority-Analysis: v=2.4 cv=V6RNF+ni c=1 sm=1 tr=0 ts=6a5e7616 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=9_SSeoq7eJPDN4OswFYA:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDIwOSBTYWx0ZWRfX0DuK3ex/U0Jf
 yQu5tzzupcNHfVyrdSKjHBXXhaYKheBZLrSYhQe9xG62Hge9buErByIqm0taWMwnSVUW3pq2eKS
 xL4hUV7smlGDf1So37cp3wVvmTUiLiI=
X-Proofpoint-GUID: 7EKvy9ykML73rqI7o2edkAi4PgIzOOyw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDIwOSBTYWx0ZWRfX2rNHjYIhQyrn
 9ZbjOhoJo8SPmo9iLbC9ZpLayBeQNrauH029Hn4I2EL2Mfl9HIuimbLOIgnHTpH9YrOTo6qhk6C
 aZVyq2mEoOTAvOQxDLCRTxo7dHPCNyRe+ZXgx5vX3/99zLYjvoHLwZOmP3Ebxxt198zmPDRbpfp
 L3Y6P/IEvpl8olY0HHQity4o1l0BDLlu9Z+7lhYt5acboT4D/JeIe7vrexubhfi+jcWcMVNJzKc
 IWaJIGKhiFJKVyWw/6sk0O0BMDBN4DXqi00ltSnsqyHnmr1kQVQ8iOEXrDuJFO4wYSa2X3XAJW0
 LqxD+o6BoTQwOPUYkmSum63juAhfN6FMwesngXs2v/YBKL/JoSmkUmHCf5FxfqVgrkpLkAEIVD+
 7yd/+US5y2Bq8Uiorp5lduQ4X9L3J/7UDvZ31PZl9A+plFXVA/uKX8yJelh1ooQe6zO+fgpKJMp
 y7RlB1Jk5IFViyGEHbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607200209

On s390 systems, which use a machine level hypervisor, PCI devices are
always accessed through a form of PCI pass-through which fundamentally
operates on a per PCI function granularity. This is also reflected in the
s390 PCI hotplug driver which creates hotplug slots for individual PCI
functions. Its reset_slot() function, which is a wrapper for
zpci_hot_reset_device(), thus also resets individual functions.

Currently, the pci_create_slot() assigns the same pci_slot object to
multifunction devices. This approach worked fine on s390 systems that only
exposed virtual functions as individual PCI domains to the operating
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
functions while retaining the topology. Since we can use all 8 bits for
slot 'number' (for ARI devices), change slot 'number' u16 to account for
special values -1 and PCI_SLOT_ALL_DEVICES.

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
index 77b17b13ee61..350bae907ebf 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4897,8 +4897,9 @@ static int pci_reset_hotplug_slot(struct hotplug_slot *hotplug, bool probe)
 
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
index 64b308b6e61c..6141787f7417 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -79,14 +79,18 @@
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

