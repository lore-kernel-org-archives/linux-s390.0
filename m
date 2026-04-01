Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E8381B02;
	Wed,  1 Apr 2026 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775055055; cv=none; b=eZ49ez+gQmYFKOa53+jamEKn93bKSLGRSZjV/i71ba52IS89Xx/xzGKJscYavrEsV5J4gQpP3Rw27SHZEYoqMUR2DoiRO3EKHny+VeQFpevSFNi2+TlvEx1skwJJrQg4JoGehB8Ub7zhRvnjaWAZjJ9PJzushSJ8P56sGsk0HvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775055055; c=relaxed/simple;
	bh=lcKUqKVpDGrlKtZ0l0bIByKGI3a2642T2eSarw23m4E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pF0S9aTIsNfV6sPbOupKujYavBvB5qe8laE65GkiOr4WLfxomqb28CbXIHmUezdfwO32PAZSLPJkB8rd6804+NuSt4ZOT3LSuXEZWDa6xTxOa2of2KT+uPk+jKavmLO/cYB4R8dIN2Bl08mPnaXHDuj8QGo3fEsv7HgWEHHDblk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p3lzUE99; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p3lzUE99"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 631BFgL74187356;
	Wed, 1 Apr 2026 14:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pp1; bh=0+jGhCGksYaZ1jZMwVWLjJny3Cre
	wAyGcX1Jm8Ui6Ak=; b=p3lzUE99FhcLYrIcTN5lWSIxWNF3TjQEbJZ1b6+vm1SY
	q4zPZ+Vt5NxJxp4534uQCYNunIP/san+ZhmGqvssG2CZOQ66Cqp/rDLzN09cwiQx
	IgrsfNaWbh8OJK2FdHrOgIXkpyORj2NG28M5O8OIq1LVn7F3TL/f/DV9vS+USuxI
	I/VUd/rqkZ6Kv3gZbknxQdPy9hrvtloyJT1yD3c64Ppwxek3lU+p9XVa/YDHjYLA
	7HFf33GN+4vfEKKo5xLonn49hZVdfU84Zhqk2hFAx1jopKUfLY4Q/9mJlnokmIze
	xkguGNIaeqP6lFZJmUlIJpr86zHvMaZ05biM6glyDA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d66ms7wxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 14:50:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 631AplZC005910;
	Wed, 1 Apr 2026 14:50:47 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d6spy659u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 14:50:47 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 631Eoknu19661440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 1 Apr 2026 14:50:46 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7744F58058;
	Wed,  1 Apr 2026 14:50:46 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA0C35806E;
	Wed,  1 Apr 2026 14:50:43 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  1 Apr 2026 14:50:43 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Wed, 01 Apr 2026 16:50:37 +0200
Subject: [PATCH v5] PCI: s390: Expose the UID as an arch specific PCI slot
 attribute
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-uid_slot-v5-1-e73036c74bf6@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIALwwzWkC/23Q0WoDIRAF0F8JPtego1O1T/2PUopOxkZIdsuaL
 Clh/71uKO2y7MvAHTx3wLuoPBSu4mV3FwOPpZa+awGfdoKOsftkWQ4tC1CAKoCR13L4qKf+Itk
 gBspI0SjRnn8NnMvtUfX23vKx1Es/fD+aRz1vN0pGLbU0DoGio+yjeT2V7nrbl3TeU3+ee3+RX
 SEVIiubrSd0KzRfH+HvolbKLzA0zBmA2nDO6i1sFljjApuGrTU++ICkU9rC9h+DdgtsG57/jBO
 GFJ/DGk/T9APT6nhOkAEAAA==
X-Change-ID: 20250923-uid_slot-e3559cf5ca30
To: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Lukas Wunner <lukas@wunner.de>, Shuah Khan <skhan@linuxfoundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6086;
 i=schnelle@linux.ibm.com; h=from:subject:message-id;
 bh=lcKUqKVpDGrlKtZ0l0bIByKGI3a2642T2eSarw23m4E=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDLPGhzmii1ZZFf86cKiDx2u5p4xJ+fHnkvjvZBozVVW1
 hyzouJlRykLgxgXg6yYIsuiLme/dQVTTPcE9XfAzGFlAhnCwMUpABOZ2svwPyDEgIHF26xzR0Lp
 ljNvP+/j6Zav0Ematu7QkcfBd8XTHzMyzHrwLtdC8byFnZFf1JozS3ouHOW/oFXLc+pGofFqrZW
 ajAA=
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=J6enLQnS c=1 sm=1 tr=0 ts=69cd30c8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WU3I-MCEZjdC1qMpAq0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDEzOCBTYWx0ZWRfX0EAbxOS8kx7Q
 qxC+W28toOtUoYxbUlywoanoaOGqlYArziHslv8D93iWdeidOb7Xy7A/98EOGMjJ9mPMyPdj604
 lNuLA+d5Fl7MpC/rsoIlw35bd9ojjUhL997wIy+PtIo7e4uvXUF/wruG5utfyd9mr0k4QU/b1m7
 KibDlwmcJBH1AQXgGkDBCPAXdP7veb79c0OqbqZtZQ0dlVM1IOGSuOfWzSdw2cQeAx1q8REO+o5
 pJzT3AmnQjnz6NmKNc//zjKDO/xDvSvluBatMoqZqqWkTpAAj3PC5eU0e+7E8fT5Mu9jC63kBoI
 6+lRI+4ql+s+R+f3VpeEaeJIEYgXTDnjGAYmg9+pqAHNxlZ27nDSwN1ZNT04t9kXPQZBqZFZvVU
 O4bidXfFt3kxAPnzHoB+NWgmH9nco3XZTLjZyRshB+qpLH85+Ci8WGt65vxqrZxzE9eITdQmgNU
 1hvNG6rC+tML2sMqrOw==
X-Proofpoint-GUID: H8SQZchlgABax1JS-L70tt96XqisY21f
X-Proofpoint-ORIG-GUID: ScCIqmZfyLmQsBK7PpRPH-q3Z_TNyxm6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_04,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604010138

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
Note: I considered adding the UID as a generic slot index attribute
analogous to the PCI device index attribute (SMBIOS index / s390 UID)
but decided against it as this seems rather s390 specific.

v4->v5:
- Rebase on v7.0-rc6
- Reworded note
- Add documentation for the new attribute
- Link to v4: https://lore.kernel.org/r/20251217-uid_slot-v4-1-559ceb59ba69@linux.ibm.com

v3->v4:
- Rebase on v6.19-rc1
- Collect R-bs
- Link to v3: https://lore.kernel.org/r/20251015-uid_slot-v3-1-44389895c1bb@linux.ibm.com
---

---
 Documentation/arch/s390/pci.rst |  7 +++++++
 arch/s390/include/asm/pci.h     |  4 ++++
 arch/s390/pci/pci_sysfs.c       | 20 ++++++++++++++++++++
 drivers/pci/slot.c              | 13 ++++++++++++-
 4 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/Documentation/arch/s390/pci.rst b/Documentation/arch/s390/pci.rst
index d5755484d8e75c7bf67a350e61bbe04f0452a2fa..03afb57ece4df90a75597cb34c1f048c2e162b67 100644
--- a/Documentation/arch/s390/pci.rst
+++ b/Documentation/arch/s390/pci.rst
@@ -55,6 +55,13 @@ Entries specific to zPCI functions and entries that hold zPCI information.
 
   - /sys/bus/pci/slots/XXXXXXXX/power
 
+  In addition to using the FID as the name of the slot the slot directory
+  also contains the following s390 specific slot attributes
+
+  - uid
+    The User-defined identifier (UID) of the function which may be configured
+    by this slot. See also the corresponding attribute of the device.
+
   A physical function that currently supports a virtual function cannot be
   powered off until all virtual functions are removed with:
   echo 0 > /sys/bus/pci/devices/XXXX:XX:XX.X/sriov_numvf
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

---
base-commit: 7aaa8047eafd0bd628065b15757d9b48c5f9c07d
change-id: 20250923-uid_slot-e3559cf5ca30

Best regards,
-- 
Niklas Schnelle

