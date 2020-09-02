Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64852 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgIBTq7 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Sep 2020 15:46:59 -0400
From: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v4 3/3] vfio/pci: Decouple MSE bit checks from is_virtfn
Date: Wed,  2 Sep 2020 15:46:36 -0400
Message-Id: <1599075996-9826-4-git-send-email-mjrosato@linux.ibm.com>
In-Reply-To: <1599075996-9826-1-git-send-email-mjrosato@linux.ibm.com>
References: <1599075996-9826-1-git-send-email-mjrosato@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, bhelgaas@google.com
Cc: schnelle@linux.ibm.com, pmorel@linux.ibm.com, mpe@ellerman.id.au, oohall@gmail.com, cohuck@redhat.com, kevin.tian@intel.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org

While it is true that devices with is_virtfn=1 will have an
MSE that is hard-wired to 0, this is not the only case where
we see this behavior -- For example some bare-metal hypervisors
lack MSE bit emulation for devices not setting is_virtfn (s390).
Fix this by instead checking for the newly-added
PCI_DEV_FLAGS_FORCE_COMMAND_MEM flag which directly denotes the
need for MSE bit emulation in vfio.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
---
 drivers/vfio/pci/vfio_pci_config.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index d98843f..47fb3c7 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -406,7 +406,8 @@ bool __vfio_pci_memory_enabled(struct vfio_pci_device *vdev)
 	 * PF SR-IOV capability, there's therefore no need to trigger
 	 * faults based on the virtual value.
 	 */
-	return pdev->is_virtfn || (cmd & PCI_COMMAND_MEMORY);
+	return (pdev->dev_flags & PCI_DEV_FLAGS_FORCE_COMMAND_MEM) ||
+	       (cmd & PCI_COMMAND_MEMORY);
 }
 
 /*
@@ -520,8 +521,9 @@ static int vfio_basic_config_read(struct vfio_pci_device *vdev, int pos,
 
 	count = vfio_default_config_read(vdev, pos, count, perm, offset, val);
 
-	/* Mask in virtual memory enable for SR-IOV devices */
-	if (offset == PCI_COMMAND && vdev->pdev->is_virtfn) {
+	/* Mask in virtual memory enable */
+	if ((offset == PCI_COMMAND) &&
+	    (vdev->pdev->dev_flags & PCI_DEV_FLAGS_FORCE_COMMAND_MEM)) {
 		u16 cmd = le16_to_cpu(*(__le16 *)&vdev->vconfig[PCI_COMMAND]);
 		u32 tmp_val = le32_to_cpu(*val);
 
@@ -589,9 +591,11 @@ static int vfio_basic_config_write(struct vfio_pci_device *vdev, int pos,
 		 * shows it disabled (phys_mem/io, then the device has
 		 * undergone some kind of backdoor reset and needs to be
 		 * restored before we allow it to enable the bars.
-		 * SR-IOV devices will trigger this, but we catch them later
+		 * SR-IOV devices will trigger this - for mem enable let's
+		 * catch this now and for io enable it will be caught later
 		 */
-		if ((new_mem && virt_mem && !phys_mem) ||
+		if ((new_mem && virt_mem && !phys_mem &&
+		    !(pdev->dev_flags & PCI_DEV_FLAGS_FORCE_COMMAND_MEM)) ||
 		    (new_io && virt_io && !phys_io) ||
 		    vfio_need_bar_restore(vdev))
 			vfio_bar_restore(vdev);
@@ -1734,9 +1738,11 @@ int vfio_config_init(struct vfio_pci_device *vdev)
 				 vconfig[PCI_INTERRUPT_PIN]);
 
 		vconfig[PCI_INTERRUPT_PIN] = 0; /* Gratuitous for good VFs */
-
+	}
+	if (pdev->dev_flags & PCI_DEV_FLAGS_FORCE_COMMAND_MEM) {
 		/*
-		 * VFs do no implement the memory enable bit of the COMMAND
+		 * VFs and devices that set PCI_DEV_FLAGS_FORCE_COMMAND_MEM
+		 * do not implement the memory enable bit of the COMMAND
 		 * register therefore we'll not have it set in our initial
 		 * copy of config space after pci_enable_device().  For
 		 * consistency with PFs, set the virtual enable bit here.
-- 
1.8.3.1
