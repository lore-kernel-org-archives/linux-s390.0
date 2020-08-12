Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42188 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgHLTVY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Aug 2020 15:21:24 -0400
From: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v2] PCI: Introduce flag for detached virtual functions
Date: Wed, 12 Aug 2020 15:21:11 -0400
Message-Id: <1597260071-2219-2-git-send-email-mjrosato@linux.ibm.com>
In-Reply-To: <1597260071-2219-1-git-send-email-mjrosato@linux.ibm.com>
References: <1597260071-2219-1-git-send-email-mjrosato@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, bhelgaas@google.com
Cc: schnelle@linux.ibm.com, pmorel@linux.ibm.com, mpe@ellerman.id.au, oohall@gmail.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org

s390x has the notion of providing VFs to the kernel in a manner
where the associated PF is inaccessible other than via firmware.
These are not treated as typical VFs and access to them is emulated
by underlying firmware which can still access the PF.  After
abafbc55 however these detached VFs were no longer able to work
with vfio-pci as the firmware does not provide emulation of the
PCI_COMMAND_MEMORY bit.  In this case, let's explicitly recognize
these detached VFs so that vfio-pci can allow memory access to
them again.

Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/pci/pci.c                |  8 ++++++++
 drivers/vfio/pci/vfio_pci_config.c | 11 +++++++----
 include/linux/pci.h                |  1 +
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 3902c9f..04ac76d 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -581,6 +581,14 @@ int pcibios_enable_device(struct pci_dev *pdev, int mask)
 {
 	struct zpci_dev *zdev = to_zpci(pdev);
 
+	/*
+	 * If we have a VF on a non-multifunction bus, it must be a VF that is
+	 * detached from its parent PF.  We rely on firmware emulation to
+	 * provide underlying PF details.
+	 */
+	if (zdev->vfn && !zdev->zbus->multifunction)
+		pdev->detached_vf = 1;
+
 	zpci_debug_init_device(zdev, dev_name(&pdev->dev));
 	zpci_fmb_enable_device(zdev);
 
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index d98843f..ee45216 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -406,7 +406,8 @@ bool __vfio_pci_memory_enabled(struct vfio_pci_device *vdev)
 	 * PF SR-IOV capability, there's therefore no need to trigger
 	 * faults based on the virtual value.
 	 */
-	return pdev->is_virtfn || (cmd & PCI_COMMAND_MEMORY);
+	return pdev->is_virtfn || pdev->detached_vf ||
+	       (cmd & PCI_COMMAND_MEMORY);
 }
 
 /*
@@ -420,7 +421,7 @@ static void vfio_bar_restore(struct vfio_pci_device *vdev)
 	u16 cmd;
 	int i;
 
-	if (pdev->is_virtfn)
+	if (pdev->is_virtfn || pdev->detached_vf)
 		return;
 
 	pci_info(pdev, "%s: reset recovery - restoring BARs\n", __func__);
@@ -521,7 +522,8 @@ static int vfio_basic_config_read(struct vfio_pci_device *vdev, int pos,
 	count = vfio_default_config_read(vdev, pos, count, perm, offset, val);
 
 	/* Mask in virtual memory enable for SR-IOV devices */
-	if (offset == PCI_COMMAND && vdev->pdev->is_virtfn) {
+	if ((offset == PCI_COMMAND) &&
+	    (vdev->pdev->is_virtfn || vdev->pdev->detached_vf)) {
 		u16 cmd = le16_to_cpu(*(__le16 *)&vdev->vconfig[PCI_COMMAND]);
 		u32 tmp_val = le32_to_cpu(*val);
 
@@ -1734,7 +1736,8 @@ int vfio_config_init(struct vfio_pci_device *vdev)
 				 vconfig[PCI_INTERRUPT_PIN]);
 
 		vconfig[PCI_INTERRUPT_PIN] = 0; /* Gratuitous for good VFs */
-
+	}
+	if (pdev->is_virtfn || pdev->detached_vf) {
 		/*
 		 * VFs do no implement the memory enable bit of the COMMAND
 		 * register therefore we'll not have it set in our initial
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8355306..23a6972 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -445,6 +445,7 @@ struct pci_dev {
 	unsigned int	is_probed:1;		/* Device probing in progress */
 	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
 	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
+	unsigned int	detached_vf:1;		/* VF without local PF access */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
-- 
1.8.3.1
