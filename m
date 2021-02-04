Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234315AbhBDJol (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Feb 2021 04:44:41 -0500
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [RFC v2 1/1] PCI: Add s390 specific UID uniqueness attribute
Date: Thu,  4 Feb 2021 10:43:53 +0100
Message-Id: <20210204094353.63819-2-schnelle@linux.ibm.com>
In-Reply-To: <20210204094353.63819-1-schnelle@linux.ibm.com>
References: <20210204094353.63819-1-schnelle@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Peter Oberparleiter <oberpar@linux.ibm.com>, Viktor Mihajlovski <mihajlov@linux.ibm.com>

The global UID uniqueness attribute exposes whether the platform
guarantees that the user-defined per-device UID attribute values
(/sys/bus/pci/device/<dev>/uid) are unique and can thus be used as
a global identifier for the associated PCI device. With this commit
it is exposed at /sys/bus/pci/zpci/unique_uids

Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 Documentation/ABI/testing/sysfs-bus-pci |  9 +++++++++
 drivers/pci/pci-sysfs.c                 | 21 +++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-pci b/Documentation/ABI/testing/sysfs-bus-pci
index 25c9c39770c6..812dd9d3f80d 100644
--- a/Documentation/ABI/testing/sysfs-bus-pci
+++ b/Documentation/ABI/testing/sysfs-bus-pci
@@ -375,3 +375,12 @@ Description:
 		The value comes from the PCI kernel device state and can be one
 		of: "unknown", "error", "D0", D1", "D2", "D3hot", "D3cold".
 		The file is read only.
+What:		/sys/bus/pci/zpci/unique_uids
+Date:		February 2021
+Contact:	Niklas Schnelle <schnelle@linux.ibm.com>
+Description:
+		This attribute exposes the global state of UID Uniqueness on an
+		s390 Linux system. If this file contains '1' the per-device UID
+		attribute is guaranteed to provide a unique user defined
+		identifier for that PCI device. If this file contains '0' UIDs
+		may collide and do not provide a unique identifier.
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index fb072f4b3176..61de66ab59cf 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -425,6 +425,24 @@ static ssize_t rescan_store(struct bus_type *bus, const char *buf, size_t count)
 }
 static BUS_ATTR_WO(rescan);
 
+#if defined(CONFIG_S390)
+static ssize_t unique_uids_show(struct bus_type *bus, char *buf)
+{
+	return sprintf(buf, "%i\n", zpci_unique_uid);
+}
+static BUS_ATTR_RO(unique_uids);
+
+static struct attribute *zpci_bus_attrs[] = {
+	&bus_attr_unique_uids.attr,
+	NULL,
+};
+
+static struct attribute_group zpci_bus_group = {
+	.name = "zpci",
+	.attrs = zpci_bus_attrs,
+};
+#endif
+
 static struct attribute *pci_bus_attrs[] = {
 	&bus_attr_rescan.attr,
 	NULL,
@@ -436,6 +454,9 @@ static const struct attribute_group pci_bus_group = {
 
 const struct attribute_group *pci_bus_groups[] = {
 	&pci_bus_group,
+#if defined(CONFIG_S390)
+	&zpci_bus_group,
+#endif
 	NULL,
 };
 
-- 
2.17.1
