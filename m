Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A15A3B7752;
	Tue,  7 Apr 2026 13:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775568306; cv=none; b=QvMIiXvz25O9keiMBXgXG5TtI5VV1lR53ReDSa9DUzp4POjCRaOsxUziu4kSFfxol9jwmrL70CExV3JFLos80sdj1aERyAFkrAQEbqI3lmWHS/uHNhjiFwkoT063KsJf/ZMhI04D5CCvKcnv/Y0NHzE3T6Bll8EYf0whI5nExTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775568306; c=relaxed/simple;
	bh=eJ+f5VtW06hjPWQhL+mxU1tuQeMXPch8iPmbd9Za310=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rvIIsHwY8xQgeCyK+nOl+j/TYe7M1SNQkNwgc56Iq7LKvtq6NRSLAfwI+MDIhkStro3YV8ThtVPCDFFZ0KnkXaxmN2Mu+UtFobmVxfymxrA+QdX6Mp5PuSKeE3PA/79AET2aV2VgS5F4/3QXHd4qfuWt2sNaJMnjoMKp5FDRpGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tSYiyPaj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tSYiyPaj"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636NQ5tk2401288;
	Tue, 7 Apr 2026 13:25:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/lcr96
	SrwFC1B6RU1s1QLzKzJb5TcyudQnEV0SzV2eQ=; b=tSYiyPaj5CqVOvfG4X1Rt1
	gVc+TaWQo4DSNcuourGu/NmbSqPbDx05TCV6lIiy3B7gRJyVoKar6kqKKyP9V/6J
	mBcIpU1UHPlOskv+W0qDJvVm/m7++NUvbRD8IT7QQv+wqYwb0POz9OdyM978FBWb
	3g23GHyWI1jpn+vgCYpn4OmPncuwi+N+uyyWJ/NvVMuBTlSQ6XtVdOntYQXSGC+O
	vrEvfwsXgIKVV3vjk85ItjWDvPi7GlW02bPjDFoVMEeZzpQ3FdToecwFs4eL6dUh
	XwlI4Am7AKx/fE2D3Mo0yfLZLt1pjOp53TmNA1vtMyaUxe6lpRmM5ftSkUKCfGkA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2hav1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 13:25:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 637BNAKM029863;
	Tue, 7 Apr 2026 13:25:01 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7bab2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Apr 2026 13:25:01 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 637DP0OY21824210
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Apr 2026 13:25:00 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CC6C58060;
	Tue,  7 Apr 2026 13:25:00 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9D8E05803F;
	Tue,  7 Apr 2026 13:24:57 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  7 Apr 2026 13:24:57 +0000 (GMT)
From: Niklas Schnelle <schnelle@linux.ibm.com>
Date: Tue, 07 Apr 2026 15:24:46 +0200
Subject: [PATCH v8 2/2] PCI: s390: Expose the UID as an arch specific PCI
 slot attribute
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-uid_slot-v8-2-15ae4409d2ce@linux.ibm.com>
References: <20260407-uid_slot-v8-0-15ae4409d2ce@linux.ibm.com>
In-Reply-To: <20260407-uid_slot-v8-0-15ae4409d2ce@linux.ibm.com>
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
 bh=eJ+f5VtW06hjPWQhL+mxU1tuQeMXPch8iPmbd9Za310=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGDKvsi5qmLBp3QreRKb5D4/+2vpOZKK9UtusTJYnqdP+X
 jy8069fs6OUhUGMi0FWTJFlUZez37qCKaZ7gvo7YOawMoEMYeDiFICJbGhkZDimZaXasfWD8lvp
 6pKtv5l7RWw0Pc9+t/sqFud1SPL/xL8Mf3ifnfzhk7fTaUVovJD62WWW5vybDM/8bfB+FDdjlt4
 RNzYA
X-Developer-Key: i=schnelle@linux.ibm.com; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDEyNSBTYWx0ZWRfX5tYDnBUKYrg2
 ZmfaJjr1ZmknHjEnKi4z6LP6CuwUIiXdDyuX3I6z+n3s8vexTnY3c6Q87wlLbR5aAsG2CFaA6hw
 jlujSWb5ydTuX5opBAW9F9UZa2d4FMVAAx0F+1FFmPvyvKRU6a484NrSrLFMerRuGsKHg+VF88P
 nQHELiMK5OQZe4JwQNUrDXSoIGJ07p5VP4ePgwc16syfqgCzobVMxpmnQ6hY/oBo+mSYQXnOu8V
 BEg7fi+7Rm3K7nZQz13jLYi5P7jLmgt17LBcZvDOahO+oslijInfB9Uu2Xo7oUnGDMmMHs0nNjf
 mopk91/rIdXsak0xWH/XpCg4ZNfeBOad7QV3Dqj1J2nclxyjMQwKyYnf2a3CfY7+JD8JVzYT0HW
 9CNcDgteC1jxr392nJEUcH7Xmpy3QZ7xaf8pIdmnPEIyw0PwgAXeEAdj3Qtr1dXotcknhBlBMD1
 86nr2ZAZ1DSQ5Y9ZmYw==
X-Proofpoint-GUID: VyT9t5m2ehuyfEPkLtPSnDHfdh4nrn6x
X-Authority-Analysis: v=2.4 cv=a/wAM0SF c=1 sm=1 tr=0 ts=69d505ae cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=WU3I-MCEZjdC1qMpAq0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: vIs2OYqdjfg5CNNaBCf1RdBJ7NoiH80F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070125

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
index c3476de4f03278d07099aa32cbea0f868b6e9c9c..80f4ba19315994da056a10b4d216d61ff22ea5aa 100644
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

