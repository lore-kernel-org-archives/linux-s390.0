Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E22484239;
	Wed,  5 Aug 2026 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948940; cv=none; b=LdDgc+t6hDfTYZ4S5xJJCQA6KpDLJRWAteUrWcWhZr8ekwjnCa1QD3F6c//iI4NwgbG/rexh+XrtyfnZrrCdnmffSueSERuKJBxkqxYw26Ocdnu6BOB7lItxQAo1KQ7ITVSQrYfbG4hQ6tpfv9FhRqcHCmFTsmfFC/8QAS99AjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948940; c=relaxed/simple;
	bh=mwyL+uTOIizoOJ1dR3CUCfAzaqvs8OoK/rzdHk5LGxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GPZsse+BKxjE016ilqJCX7mlwb2isHoQU1KgJJqj7GtRgjnIqHwW+sCar6oJfqXDP9YjOs2r8qfSjOuktHBtESVbt7MUaZ8nuy4Vaz/r6P4G0q/K4ZQRBXcBshsspsEvicyL9RT93vsoCdqemXkarEghMvTF2BO831nXG3bI3OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SATKCLOD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SATKCLOD"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675Fn8aA4182910;
	Wed, 5 Aug 2026 16:55:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/paASlYgCKWMyLSDO
	c0pQbQXYk5kkShdCoGGj0vuXPM=; b=SATKCLODdcvriAnpXrOQAWVpn1VRa8gG1
	phGvxAF2tjFWCdrzDHn4gWWkAfNS15HXWUys6oMVgv47qmw5pOB1E7mQPWzgeQ4K
	NWXeOSHEGKR3RGXKYviW2IMDMz3sZVntNxb1qYijrAz0CrS5EdIiM/KxNXR64ve5
	SPXg0biQTZkeBH8EuKpz0+Zawg0tt99Kz3ukswWvL+sfTEdzFyY4JW6eroqnCF8B
	mx6ZYEk6fJxPhieNYAryfiG4mmVDP4iUpG7FFRVnrlpBrAYR4n567yYpDBgnILCm
	qVx+SWIi7pUNfKA5xYzyKaAv6PR82NvgIm8jzLacztmguJs8CrMfQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gbq1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 16:55:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 675GfG2a023471;
	Wed, 5 Aug 2026 16:55:23 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw7hnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 16:55:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 675GtMds28443270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 16:55:22 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D56058043;
	Wed,  5 Aug 2026 16:55:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB41958053;
	Wed,  5 Aug 2026 16:55:20 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.241.193])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 16:55:20 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc: helgaas@kernel.org, alex@shazbot.org, alifm@linux.ibm.com,
        schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v23 1/5] PCI: Introduce PCI_SLOT_PLACEHOLDER constant for slot_nr placeholder value
Date: Wed,  5 Aug 2026 09:55:14 -0700
Message-ID: <20260805165518.794-2-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260805165518.794-1-alifm@linux.ibm.com>
References: <20260805165518.794-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEzNyBTYWx0ZWRfX0C1OW3il8F1U
 iimGAvtihsBd6wh/pMhH7yPtZpNQ5fi2sfccOJblgtmLv6eckbnjOdRvnfAz7MwV9VlTPOO3At5
 ou7AwYx5B363ehmW5R6GUEkZ8TpBtoj2OaYzDC/nixWN6alEMgzyu1wLo6mHDSG29ULU3eI24TY
 skb4KJ0hpmcgVIpc8WpPzJS6bQfnec8f6F1EZD2UNPi7jh/Vp7FrQMx5sc011T23jl60SiSwPav
 CVGc1rhE1HQnCzW1UknLIiUmsyE5f34uP3a4DF9oE0/QizZMCgMJq8xnep4sG5VUYCIL5Gkrd0r
 UoHrJWIeuh/S+lTbWZxuSpfbia266ZCWrbLfyHl5P8TNfYKuqCiWPS96yHX6Blu9/1q3Kw6VxVn
 fNNp6I4+A/S3VIa8jGS5OUHIAKZA/LOxBKQjhC+L5Z0uIVoaYM3lrnQyIAmrEUrfvlaFCF9eNdo
 e+DiEAoecOkOOiZIq5A==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a736afc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=voM4FWlXAAAA:8 a=1XWaLZrsAAAA:8
 a=t8iQWNR-jnTgK4UFVGYA:9 a=IC2XNlieTeVoXbcui8wp:22
X-Proofpoint-GUID: 2N6UDDSNodACujrYcP2WQu8UbnarNusk
X-Proofpoint-ORIG-GUID: 7Co9pH3paRsnpcDW5DfjTNqiWdjOuVgX
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEzNyBTYWx0ZWRfX+jHqWNeQGxCq
 JrcW1NfxhUMPnsVKQtOhvxqdk2RYSWZzhgoY+pNZrIE+boEOEIKFsjqWJWpG1IIyMx/rbTFZfzM
 n/mtrkg5PsnFomhWDmAi8EoAoOJcLJc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050137

Introduce a constant for placeholder value and update the kerneldoc for
pci_create_slot() to reference PCI_SLOT_PLACEHOLDER instead of -1
throughout. No functional change.

Cc: Madhavan Srinivasan <maddy@linux.ibm.com>
Cc: Tyrel Datwyler <tyreld@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 drivers/pci/hotplug/pnv_php.c     |  2 +-
 drivers/pci/hotplug/rpaphp_slot.c |  2 +-
 drivers/pci/slot.c                | 21 +++++++++++----------
 include/linux/pci.h               |  3 +++
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
index ff92a5c301b8..37299d59f906 100644
--- a/drivers/pci/hotplug/pnv_php.c
+++ b/drivers/pci/hotplug/pnv_php.c
@@ -808,7 +808,7 @@ static struct pnv_php_slot *pnv_php_alloc_slot(struct device_node *dn)
 	if (dn->child && PCI_DN(dn->child))
 		php_slot->slot_no = PCI_SLOT(PCI_DN(dn->child)->devfn);
 	else
-		php_slot->slot_no = -1;   /* Placeholder slot */
+		php_slot->slot_no = PCI_SLOT_PLACEHOLDER;   /* Placeholder slot */
 
 	kref_init(&php_slot->kref);
 	php_slot->state	                = PNV_PHP_STATE_INITIALIZED;
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
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 6d5cd37bfb1e..42ff66461f74 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -37,7 +37,7 @@ static const struct sysfs_ops pci_slot_sysfs_ops = {
 
 static ssize_t address_read_file(struct pci_slot *slot, char *buf)
 {
-	if (slot->number == 0xff)
+	if (slot->number == PCI_SLOT_PLACEHOLDER)
 		return sysfs_emit(buf, "%04x:%02x\n",
 				  pci_domain_nr(slot->bus),
 				  slot->bus->number);
@@ -210,7 +210,7 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
 /**
  * pci_create_slot - create or increment refcount for physical PCI slot
  * @parent: struct pci_bus of parent bridge
- * @slot_nr: PCI_SLOT(pci_dev->devfn), -1 for placeholder, or
+ * @slot_nr: PCI_SLOT(pci_dev->devfn), PCI_SLOT_PLACEHOLDER for placeholder, or
  *	PCI_SLOT_ALL_DEVICES
  * @name: user visible string presented in /sys/bus/pci/slots/<name>
  * @hotplug: set if caller is hotplug driver, NULL otherwise
@@ -236,15 +236,16 @@ static struct pci_slot *get_slot(struct pci_bus *parent, int slot_nr)
  * In most cases, @pci_bus, @slot_nr will be sufficient to uniquely identify
  * a slot. There is one notable exception - pSeries (rpaphp), where the
  * @slot_nr cannot be determined until a device is actually inserted into
- * the slot. In this scenario, the caller may pass -1 for @slot_nr.
+ * the slot. In this scenario, the caller may pass PCI_SLOT_PLACEHOLDER for @slot_nr.
  *
  * The following semantics are imposed when the caller passes @slot_nr ==
- * -1. First, we no longer check for an existing %struct pci_slot, as there
- * may be many slots with @slot_nr of -1.  The other change in semantics is
- * user-visible, which is the 'address' parameter presented in sysfs will
- * consist solely of a dddd:bb tuple, where dddd is the PCI domain of the
- * %struct pci_bus and bb is the bus number. In other words, the devfn of
- * the 'placeholder' slot will not be displayed.
+ * PCI_SLOT_PLACEHOLDER. First, we no longer check for an existing %struct
+ * pci_slot, as there may be many slots with @slot_nr of
+ * PCI_SLOT_PLACEHOLDER. The other change in semantics is user-visible,
+ * which is the 'address' parameter presented in sysfs will consist solely
+ * of a dddd:bb tuple, where dddd is the PCI domain of the %struct pci_bus
+ * and bb is the bus number. In other words, the devfn of the 'placeholder'
+ * slot will not be displayed.
  *
  * Bus-wide slots:
  * For PCIe hotplug, the physical slot encompasses the entire secondary
@@ -267,7 +268,7 @@ struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
 
 	mutex_lock(&pci_slot_mutex);
 
-	if (slot_nr == -1)
+	if (slot_nr == PCI_SLOT_PLACEHOLDER)
 		goto placeholder;
 
 	/*
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 64b308b6e61c..b628787e9485 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -81,6 +81,9 @@
  */
 #define PCI_SLOT_ALL_DEVICES	0xfe
 
+/* Used to identify a slot as a placeholder */
+#define PCI_SLOT_PLACEHOLDER	0xff
+
 /* pci_slot represents a physical slot */
 struct pci_slot {
 	struct pci_bus		*bus;		/* Bus this slot is on */
-- 
2.43.0

