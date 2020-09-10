Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35854 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730755AbgIJPAR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 11:00:17 -0400
From: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v5 2/3] s390/pci: Mark all VFs as not implementing PCI_COMMAND_MEMORY
Date: Thu, 10 Sep 2020 10:59:56 -0400
Message-Id: <1599749997-30489-3-git-send-email-mjrosato@linux.ibm.com>
In-Reply-To: <1599749997-30489-1-git-send-email-mjrosato@linux.ibm.com>
References: <1599749997-30489-1-git-send-email-mjrosato@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, bhelgaas@google.com
Cc: schnelle@linux.ibm.com, pmorel@linux.ibm.com, mpe@ellerman.id.au, oohall@gmail.com, cohuck@redhat.com, kevin.tian@intel.com, hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org

For s390 we can have VFs that are passed-through without the associated
PF. Firmware provides an emulation layer to allow these devices to
operate independently, but is missing emulation of the Memory Space
Enable bit.  For these as well as linked VFs, set no_command_memory
which specifies these devices do not implement PCI_COMMAND_MEMORY.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.ibm.com>
---
 arch/s390/pci/pci_bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index 5967f30..c93486a 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -197,9 +197,10 @@ void pcibios_bus_add_device(struct pci_dev *pdev)
 	 * With pdev->no_vf_scan the common PCI probing code does not
 	 * perform PF/VF linking.
 	 */
-	if (zdev->vfn)
+	if (zdev->vfn) {
 		zpci_bus_setup_virtfn(zdev->zbus, pdev, zdev->vfn);
-
+		pdev->no_command_memory = 1;
+	}
 }
 
 static int zpci_bus_add_device(struct zpci_bus *zbus, struct zpci_dev *zdev)
-- 
1.8.3.1
