Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52476 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726559AbgIBTq5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Sep 2020 15:46:57 -0400
From: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v4 2/3] s390/pci: Mark all VFs as not implementing MSE bit
Date: Wed,  2 Sep 2020 15:46:35 -0400
Message-Id: <1599075996-9826-3-git-send-email-mjrosato@linux.ibm.com>
In-Reply-To: <1599075996-9826-1-git-send-email-mjrosato@linux.ibm.com>
References: <1599075996-9826-1-git-send-email-mjrosato@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, bhelgaas@google.com
Cc: schnelle@linux.ibm.com, pmorel@linux.ibm.com, mpe@ellerman.id.au, oohall@gmail.com, cohuck@redhat.com, kevin.tian@intel.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org

For s390 we can have VFs that are passed-through without
the associated PF.  Firmware provides an emulation layer
to allow these devices to operate independently, but is
missing emulation of the MSE bit.  For these as well as
linked VFs, mark a dev_flags bit that specifies these
devices do not implement the MSE bit.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 arch/s390/pci/pci_bus.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index 5967f30..73789a7 100644
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
+		pdev->dev_flags |= PCI_DEV_FLAGS_FORCE_COMMAND_MEM;
+	}
 }
 
 static int zpci_bus_add_device(struct zpci_bus *zbus, struct zpci_dev *zdev)
-- 
1.8.3.1
