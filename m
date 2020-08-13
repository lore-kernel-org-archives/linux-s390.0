Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726305AbgHMPk5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 13 Aug 2020 11:40:57 -0400
From: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v3] PCI: Introduce flag for detached virtual functions
Date: Thu, 13 Aug 2020 11:40:43 -0400
Message-Id: <1597333243-29483-2-git-send-email-mjrosato@linux.ibm.com>
In-Reply-To: <1597333243-29483-1-git-send-email-mjrosato@linux.ibm.com>
References: <1597333243-29483-1-git-send-email-mjrosato@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, bhelgaas@google.com
Cc: schnelle@linux.ibm.com, pmorel@linux.ibm.com, mpe@ellerman.id.au, oohall@gmail.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org

s390x has the notion of providing VFs to the kernel in a manner
where the associated PF is inaccessible other than via firmware.
These are not treated as typical VFs and access to them is emulated
by underlying firmware which can still access the PF.  After
the referened commit however these detached VFs were no longer able
to work with vfio-pci as the firmware does not provide emulation of
the PCI_COMMAND_MEMORY bit.  In this case, let's explicitly recognize
these detached VFs so that vfio-pci can allow memory access to
them again.

Fixes: abafbc551fdd ("vfio-pci: Invalidate mmaps and block MMIO access on disabled memory")
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
---
 arch/s390/pci/pci_bus.c            | 13 +++++++++++++
 drivers/vfio/pci/vfio_pci_config.c |  8 ++++----
 include/linux/pci.h                |  4 ++++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/arch/s390/pci/pci_bus.c b/arch/s390/pci/pci_bus.c
index 642a993..1b33076 100644
--- a/arch/s390/pci/pci_bus.c
+++ b/arch/s390/pci/pci_bus.c
@@ -184,6 +184,19 @@ static inline int zpci_bus_setup_virtfn(struct zpci_bus *zbus,
 }
 #endif
 
+void pcibios_bus_add_device(struct pci_dev *pdev)
+{
+	struct zpci_dev *zdev = to_zpci(pdev);
+
+	/*
+	 * If we have a VF on a non-multifunction bus, it must be a VF that is
+	 * detached from its parent PF.  We rely on firmware emulation to
+	 * provide underlying PF details.
+	 */
+	if (zdev->vfn && !zdev->zbus->multifunction)
+		pdev->detached_vf = 1;
+}
+
 static int zpci_bus_add_device(struct zpci_bus *zbus, struct zpci_dev *zdev)
 {
 	struct pci_bus *bus;
diff --git a/drivers/vfio/pci/vfio_pci_config.c b/drivers/vfio/pci/vfio_pci_config.c
index d98843f..98f93d1 100644
--- a/drivers/vfio/pci/vfio_pci_config.c
+++ b/drivers/vfio/pci/vfio_pci_config.c
@@ -406,7 +406,7 @@ bool __vfio_pci_memory_enabled(struct vfio_pci_device *vdev)
 	 * PF SR-IOV capability, there's therefore no need to trigger
 	 * faults based on the virtual value.
 	 */
-	return pdev->is_virtfn || (cmd & PCI_COMMAND_MEMORY);
+	return dev_is_vf(&pdev->dev) || (cmd & PCI_COMMAND_MEMORY);
 }
 
 /*
@@ -420,7 +420,7 @@ static void vfio_bar_restore(struct vfio_pci_device *vdev)
 	u16 cmd;
 	int i;
 
-	if (pdev->is_virtfn)
+	if (dev_is_vf(&pdev->dev))
 		return;
 
 	pci_info(pdev, "%s: reset recovery - restoring BARs\n", __func__);
@@ -521,7 +521,7 @@ static int vfio_basic_config_read(struct vfio_pci_device *vdev, int pos,
 	count = vfio_default_config_read(vdev, pos, count, perm, offset, val);
 
 	/* Mask in virtual memory enable for SR-IOV devices */
-	if (offset == PCI_COMMAND && vdev->pdev->is_virtfn) {
+	if ((offset == PCI_COMMAND) && (dev_is_vf(&vdev->pdev->dev))) {
 		u16 cmd = le16_to_cpu(*(__le16 *)&vdev->vconfig[PCI_COMMAND]);
 		u32 tmp_val = le32_to_cpu(*val);
 
@@ -1713,7 +1713,7 @@ int vfio_config_init(struct vfio_pci_device *vdev)
 	vdev->rbar[5] = le32_to_cpu(*(__le32 *)&vconfig[PCI_BASE_ADDRESS_5]);
 	vdev->rbar[6] = le32_to_cpu(*(__le32 *)&vconfig[PCI_ROM_ADDRESS]);
 
-	if (pdev->is_virtfn) {
+	if (dev_is_vf(&pdev->dev)) {
 		*(__le16 *)&vconfig[PCI_VENDOR_ID] = cpu_to_le16(pdev->vendor);
 		*(__le16 *)&vconfig[PCI_DEVICE_ID] = cpu_to_le16(pdev->device);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 8355306..7c062de 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -445,6 +445,7 @@ struct pci_dev {
 	unsigned int	is_probed:1;		/* Device probing in progress */
 	unsigned int	link_active_reporting:1;/* Device capable of reporting link active */
 	unsigned int	no_vf_scan:1;		/* Don't scan for VFs after IOV enablement */
+	unsigned int	detached_vf:1;		/* VF without local PF access */
 	pci_dev_flags_t dev_flags;
 	atomic_t	enable_cnt;	/* pci_enable_device has been called */
 
@@ -1057,6 +1058,8 @@ struct resource *pci_find_parent_resource(const struct pci_dev *dev,
 void pci_sort_breadthfirst(void);
 #define dev_is_pci(d) ((d)->bus == &pci_bus_type)
 #define dev_is_pf(d) ((dev_is_pci(d) ? to_pci_dev(d)->is_physfn : false))
+#define dev_is_vf(d) ((dev_is_pci(d) ? (to_pci_dev(d)->is_virtfn || \
+					to_pci_dev(d)->detached_vf) : false))
 
 /* Generic PCI functions exported to card drivers */
 
@@ -1764,6 +1767,7 @@ static inline struct pci_dev *pci_get_domain_bus_and_slot(int domain,
 
 #define dev_is_pci(d) (false)
 #define dev_is_pf(d) (false)
+#define dev_is_vf(d) (false)
 static inline bool pci_acs_enabled(struct pci_dev *pdev, u16 acs_flags)
 { return false; }
 static inline int pci_irqd_intx_xlate(struct irq_domain *d,
-- 
1.8.3.1
