Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D883ED103;
	Mon, 16 Mar 2026 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773688560; cv=none; b=unYPZnH7D5OfpjvefwANpye1UPLQFijVixaOUC+opyKE4oT9gWc5j7/CoFtE80pU9V1KZEkTJB0gFxPpwcIrKG7MhT45RWSr7pzujJi16FDso8xXVhpFVuER0Dt/k0hvGA6n1DjvVaXaqfQbnSljk26cmYgABuK2KLg0cNuaejk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773688560; c=relaxed/simple;
	bh=WbS9ppjv+BWD5+OBgelpWAZisi3St0uwIJHgGu/41Wg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYiQrLU6maWKAoWDKYDjiY75Pg5HFVmYrBVUXOOwrqNyCqNq8DQavXHhT3ZpCmHtCMh1ceVbFnyM3ej6BMgMcTWJWUAK7997rs1XOYb0PFPzY+KpxsCdAiH/hFwtiX/pJfKR541xiUoXc5CYjZyo77sez94d6XMKGJu0gE+FQSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HxabpsIb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HxabpsIb"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62GEoeNl829867;
	Mon, 16 Mar 2026 19:15:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=4SsCqPZIE1eZZDBJi
	q/Cg2OwRL2zymGQXlyBRYwxd6M=; b=HxabpsIbdPfUMyZrRaRmOLgtVkh7f+fPQ
	CZcksvNXrUPj9bvja8DwQruPvlWZ9ZJ+PVNV+6KX8Gsu/NY6P6XKuwmXs9aLtX/5
	E4/Un03FmHqYGWvjt012g5zFxL+3zeB8Rmjt/vd7Rfjr3qh1SHFa8wl6tD0YPaRX
	Cy51i1FlsFBeF3yMishHcOpDwd1TmgaAtnu8OGpyTdxOx+tXIphY7nG1xqBv9z/p
	KYrfSQ5s5/trSCp139BGYZVOvs6L23/Cm54MEG/9CnROn/cvQOkrCqjXu8l6jhnJ
	FLDxGlOAg0MRm2OjvhCTF4Nadmn2Z+X5Xdd4Efkl/QX4gKHzDwRCA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyau8yh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 19:15:53 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GF0OiK028708;
	Mon, 16 Mar 2026 19:15:52 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgk602u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 19:15:52 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GJFpY232506418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 19:15:51 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0161B58055;
	Mon, 16 Mar 2026 19:15:51 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A55EE5804B;
	Mon, 16 Mar 2026 19:15:49 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.131])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 19:15:49 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, lukas@wunner.de, alex@shazbot.org, kbusch@kernel.org,
        clg@redhat.com, stable@vger.kernel.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com
Subject: [PATCH v11 1/9] PCI: Allow per function PCI slots
Date: Mon, 16 Mar 2026 12:15:36 -0700
Message-ID: <20260316191544.2279-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316191544.2279-1-alifm@linux.ibm.com>
References: <20260316191544.2279-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDE1MyBTYWx0ZWRfX3J/mq3cLYch+
 wlq5K5+AvvY+WXIcSJlaEGq3tHtnEzLMkizxd++583xrJ0n5k1Bsb7AgfGNOzG6vEMccqiMAGdz
 rr2mH4rIBlB0rRYDp51+7fbntALrLJTiT5D1OSfPi/2HIotHu1g+oUzGQd16XszNmafaAuGqQP9
 d7W8lH/7RpOjPRQGxou//GcDrpPS42RgfZBQUFqN0HQYUIWCpMSIVdfi4QoYbLL/2F86QweeljB
 vQofwa6kDsRZdbH+hQ884JSDE+IH+2T68H807JQqplCRUew+03lK4/li/3Yo884WxgEAWAPPF7N
 OmgxKeqFUXIzbv44B1AJaXT5Vvcu5jdr6c3k18nABxoSVcj2v8Xqm0m9XsSO8mYLBSmjTuOAbzz
 BYUu0/6TbET09No0+5De8FMmuqv9fZxktCJf6mwr+LWRf1QJN7ORoXkBbMQawcM6P+07jV7LffJ
 yKwX42gAlVllqwzkeVA==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b856e9 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=dQWU-RC_n072PXZGCE0A:9 a=O8hF6Hzn-FEA:10
X-Proofpoint-ORIG-GUID: F4n-XmIq92N3nWAAO2mt-UA3WmIWVx6G
X-Proofpoint-GUID: F4n-XmIq92N3nWAAO2mt-UA3WmIWVx6G
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_05,2026-03-16_06,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160153

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
grouping them in a shared PCI domain. When attempting to reset a function
through the hotplug driver, the shared slot assignment causes the wrong
function to be reset instead of the intended one. It also leaks memory as
we do create a pci_slot object for the function, but don't correctly free
it in pci_slot_release().

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
 drivers/pci/pci.c   |  5 +++--
 drivers/pci/slot.c  | 31 ++++++++++++++++++++++++-------
 include/linux/pci.h |  5 +++--
 3 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 115e5c11bab3..a93084053537 100644
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
index e0b7fb43423c..8842fa069392 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -37,7 +37,7 @@ static const struct sysfs_ops pci_slot_sysfs_ops = {
 
 static ssize_t address_read_file(struct pci_slot *slot, char *buf)
 {
-	if (slot->number == 0xff)
+	if (slot->number == (u16)-1)
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
index 8861eeb4381d..50a84bba3c91 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -78,14 +78,15 @@
  * and, if ARI Forwarding is enabled, functions may appear to be on multiple
  * devices.
  */
-#define PCI_SLOT_ALL_DEVICES	0xfe
+#define PCI_SLOT_ALL_DEVICES	0xfeff
 
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

