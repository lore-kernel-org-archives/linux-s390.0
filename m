Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023083A7F70;
	Tue,  7 Apr 2026 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775556786; cv=none; b=gNq0+4cwgTGxOUlczsbSJSs/GnvU53v5E7ONOqHngY2d6Lq2M1L80G4IKUz4hOfQ05X/rGivH8uh+5LSS850adFg3aP5ZIjBOUUGv+K7+iLN0cryidm/RQpKiDNlxxUPPjtkfTKbmMGczf9cnGj8cRZxVuK8eXL8G5gB57tzHdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775556786; c=relaxed/simple;
	bh=0yuT2PoffZdjEVj1tBN1P+Mh4nvHudhGqJL377+tL3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mwprgElzp9RTb7nhUDCZACJR3vL5gmhKYCSiDSiss26UrgZli0IpWk1wzM5xd7ioULhKWpTiGOwmGZRjLZbV22cDVLuUPEZYrdFAP8NSBvnpALNAjtD4AhM+TbSxxqlPhgk9seW8nj0k5um+RfmfLaKpQfqK75hlwfWnZ/9Kexo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FspZ9CHz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FspZ9CHz"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LnXDr2318763;
	Tue, 7 Apr 2026 10:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pdvkY4
	dACeoVC7oRMfy5m9NQZqSPkdfdV71ylaqPRj8=; b=FspZ9CHzBBB5eeYtqL/eU0
	6wxaWnCkJ7YDcgHVxykZEXujrCvTRmamQBft+zYVqf5zcv8/OGLsW1KquskYNk4U
	5Un4JRXQ/xZQU5zLZmicFsoxitndMEA8rZo7OIgN+fs/QuBxiYCp/MjsaA/qZ7F9
	lPcqKowsQHPfvCnZ/5ol+6ajJZ7sNzBP7zDp62EyiddfZeZ0wZoDYTZYBgfLg47B
	d8cyNpcY9cMZYw/9ZkCFJ3kij3RBVF2b5ee78dz7YWfnQExlkKILkeg43TOteHXP
	5auF5MKzYJ6tXlBVjN9jIKrhSzS9Y+k7WsaDRrSHE3kqQE8Eay+QnaXV6DGqR2Dg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2ftby6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 10:13:02 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63790uHw018961;
	Tue, 7 Apr 2026 10:13:01 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9a30t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 10:13:01 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637ACxZf36962896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 10:12:59 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A1C758043;
	Tue,  7 Apr 2026 10:12:59 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 619D25805E;
	Tue,  7 Apr 2026 10:12:56 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 10:12:56 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 07 Apr 2026 12:12:34 +0200
Subject: [PATCH v7 2/2] PCI: s390: Expose the UID as an arch specific PCI
 slot attribute
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-uid_slot-v7-2-e50f7976124e@linux.ibm.com>
References: <20260407-uid_slot-v7-0-e50f7976124e@linux.ibm.com>
In-Reply-To: <20260407-uid_slot-v7-0-e50f7976124e@linux.ibm.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lukas Wunner <lukas@wunner.de>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Farhan Ali <alifm@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-s390@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5423;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=0yuT2PoffZdjEVj1tBN1P+Mh4nvHudhGqJL377+tL3U=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDKv3JgtkqReJ3TMYEaMfqXHGVVzsT2LFK/kn979oDXVU
 YPxv49HRykLgxgXg6yYIsuiLme/dQVTTPcE9XfAzGFlAhnCwMUpABNR02FkeNuZxL29meOg6Dzl
 9RVxfjt1kqfLHikw+OMw466WfLToToY/vIyWbrmno6VEJzHL79BQvqSZUDlr42qWX4vnWcuIsRS
 wAQA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FKArAeos c=1 sm=1 tr=0 ts=69d4d8ae cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=WU3I-MCEZjdC1qMpAq0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1xXOhKbJbU_OXJGKiKN4YORWDfI-ORGF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA5MCBTYWx0ZWRfXw/+LXR2t4dOH
 HlLWWXnK1zn42CSU3P4VkJEgdQq8AMO6j36/4Ji63ht2/5G+5s9AUTW3vqWNqchmOIM6dz2i6JJ
 nVNhJFRSN7xMyLkVuZdD8Of4GYPANhebGKFvUKVJfDhvfXSxHN/qxCMR4JgMqRil760NmMn2G0G
 qbrsiNg/F5YlcQHfBRnx3CKV/yBOrwDggpQeqxminM3MeH8Q+4fdbscJFzJmxpnztSnC7B7j4fU
 L04DCEer55mvaL1h1/flL10XrQcqpHf+9JGHtmY5xMuIRxIiB9A5epHjuGuotrGMVzUalmGFYan
 m1lnFQgH3HKnLC2UUdu50F95pxWsAG0WfRK9ZYJK41b4jZCmm5Al24mvLB7bTDqCTD6uOVnKKu2
 oeEh+IT2EDHkV9IGaYAHdCt870oNosN6y+ZfsdsuTBHlzEaHe8pFhAl7rgGBdHQDMXPLvz2UXgs
 EJg8B5qYmtRsgbOxIbA==
X-Proofpoint-GUID: rcMw0VczlAcIRkwukXl9KuvAf6E6hyZG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 adultscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070090

On s390, an individual PCI function can generally be identified by two
identifiers, the FID and the UID. Which identifier is used depends on
the scope and the platform configuration.

The first identifier, the FID, is always available and identifies a PCI
device uniquely within a machine. The FID may be virtualized by
hypervisors, but on the LPAR level, the machine scope makes it
impossible to create the same configuration based on FIDs on two
different LPARs of the same machine, and difficult to reuse across
machines.

Such matching LPAR configurations are useful, though, allowing
standardized setups and booting a Linux installation on different LPARs.
To this end the UID, or user-defined identifier, was introduced. While
it is only guaranteed to be unique within an LPAR and only if indicated
by firmware, it allows users to replicate PCI device setups.

On s390, which uses a machine hypervisor, a per PCI function hotplug
model is used. The shortcoming with the UID then is, that it is not
visible to the user without first attaching the PCI function and
accessing the "uid" device attribute. The FID, on the other hand, is
used as the slot name and is thus known even with the PCI function in
standby.

Remedy this shortcoming by providing the UID as an attribute on the slot
allowing the user to identify a PCI function based on the UID without
having to first attach it. Do this via a macro mechanism analogous to
what was introduced by commit 265baca69a07 ("s390/pci: Stop usurping
pdev->dev.groups") for the PCI device attributes.

Reviewed-by: Gerd Bayer <gbayer@linux.ibm.com>
Reviewed-by: Julian Ruess <julianr@linux.ibm.com>
Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 Documentation/arch/s390/pci.rst |  7 +++++++
 arch/s390/include/asm/pci.h     |  4 ++++
 arch/s390/pci/pci_sysfs.c       | 20 ++++++++++++++++++++
 drivers/pci/slot.c              | 13 ++++++++++++-
 4 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/s390/pci.rst b/Documentation/arch/s390/pci.rst
index 8cb0a1e784a7cfc5df1e04a4154ba02c9ecf46cc..a620cf694c6f6c0bbd4f77ea4768cce7cc42c963 100644
--- a/Documentation/arch/s390/pci.rst
+++ b/Documentation/arch/s390/pci.rst
@@ -58,6 +58,13 @@ Entries specific to zPCI functions and entries that hold zPCI information.
 
   - /sys/bus/pci/slots/XXXXXXXX/power
 
+  In addition to using the FID as the name of the slot, the slot directory
+  also contains the following s390-specific slot attributes.
+
+  - uid:
+    The User-defined identifier (UID) of the function which may be configured
+    by this slot. See also the corresponding attribute of the device.
+
   A physical function that currently supports a virtual function cannot be
   powered off until all virtual functions are removed with:
   echo 0 > /sys/bus/pci/devices/DDDD:BB:dd.f/sriov_numvf
diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
index c0ff19dab5807c7e1aabb48a0e9436aac45ec97d..5dcf35f0f325f5f44b28109a1c8d9aef18401035 100644
--- a/arch/s390/include/asm/pci.h
+++ b/arch/s390/include/asm/pci.h
@@ -208,6 +208,10 @@ extern const struct attribute_group zpci_ident_attr_group;
 			    &pfip_attr_group,		 \
 			    &zpci_ident_attr_group,
 
+extern const struct attribute_group zpci_slot_attr_group;
+
+#define ARCH_PCI_SLOT_GROUPS (&zpci_slot_attr_group)
+
 extern unsigned int s390_pci_force_floating __initdata;
 extern unsigned int s390_pci_no_rid;
 
diff --git a/arch/s390/pci/pci_sysfs.c b/arch/s390/pci/pci_sysfs.c
index c2444a23e26c4218832bb91930b5f0ffd498d28f..d98d97df792adb3c7e415a8d374cc2f3a65fbb52 100644
--- a/arch/s390/pci/pci_sysfs.c
+++ b/arch/s390/pci/pci_sysfs.c
@@ -187,6 +187,17 @@ static ssize_t index_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(index);
 
+static ssize_t zpci_uid_slot_show(struct pci_slot *slot, char *buf)
+{
+	struct zpci_dev *zdev = container_of(slot->hotplug, struct zpci_dev,
+					     hotplug_slot);
+
+	return sysfs_emit(buf, "0x%x\n", zdev->uid);
+}
+
+static struct pci_slot_attribute zpci_slot_attr_uid =
+	__ATTR(uid, 0444, zpci_uid_slot_show, NULL);
+
 static umode_t zpci_index_is_visible(struct kobject *kobj,
 				     struct attribute *attr, int n)
 {
@@ -243,6 +254,15 @@ const struct attribute_group pfip_attr_group = {
 	.attrs = pfip_attrs,
 };
 
+static struct attribute *zpci_slot_attrs[] = {
+	&zpci_slot_attr_uid.attr,
+	NULL,
+};
+
+const struct attribute_group zpci_slot_attr_group = {
+	.attrs = zpci_slot_attrs,
+};
+
 static struct attribute *clp_fw_attrs[] = {
 	&uid_checking_attr.attr,
 	NULL,
diff --git a/drivers/pci/slot.c b/drivers/pci/slot.c
index 787311614e5b6ebb39e7284f9b9f205a0a684d6d..2f8fcfbbec24e73d0bb6e40fd04c05a94f518045 100644
--- a/drivers/pci/slot.c
+++ b/drivers/pci/slot.c
@@ -96,7 +96,18 @@ static struct attribute *pci_slot_default_attrs[] = {
 	&pci_slot_attr_cur_speed.attr,
 	NULL,
 };
-ATTRIBUTE_GROUPS(pci_slot_default);
+
+static const struct attribute_group pci_slot_default_group = {
+	.attrs = pci_slot_default_attrs,
+};
+
+static const struct attribute_group *pci_slot_default_groups[] = {
+	&pci_slot_default_group,
+#ifdef ARCH_PCI_SLOT_GROUPS
+	ARCH_PCI_SLOT_GROUPS,
+#endif
+	NULL,
+};
 
 static const struct kobj_type pci_slot_ktype = {
 	.sysfs_ops = &pci_slot_sysfs_ops,

-- 
2.51.0

