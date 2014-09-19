From: frank.blaschka@de.ibm.com
Subject: [RFC patch 3/6] vfio: make vfio build on s390
Date: Fri, 19 Sep 2014 13:54:32 +0200
Message-ID: <20140919115940.253423024@de.ibm.com>
References: <20140919115429.557279920@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline; filename=007-s390_vfio-3.16.patch
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: alex.williamson@redhat.com, pbonzini@redhat.com, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <frank.blaschka@de.ibm.com>

This patch adds some small changes to make vfio build on s390.

Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 drivers/vfio/Kconfig             |    2 +-
 drivers/vfio/pci/vfio_pci_rdwr.c |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

--- a/drivers/vfio/Kconfig
+++ b/drivers/vfio/Kconfig
@@ -16,7 +16,7 @@ config VFIO_SPAPR_EEH
 menuconfig VFIO
 	tristate "VFIO Non-Privileged userspace driver framework"
 	depends on IOMMU_API
-	select VFIO_IOMMU_TYPE1 if X86
+	select VFIO_IOMMU_TYPE1 if (X86 || S390)
 	select VFIO_IOMMU_SPAPR_TCE if (PPC_POWERNV || PPC_PSERIES)
 	select VFIO_SPAPR_EEH if (PPC_POWERNV || PPC_PSERIES)
 	select ANON_INODES
--- a/drivers/vfio/pci/vfio_pci_rdwr.c
+++ b/drivers/vfio/pci/vfio_pci_rdwr.c
@@ -177,6 +177,13 @@ ssize_t vfio_pci_bar_rw(struct vfio_pci_
 	return done;
 }
 
+#ifdef CONFIG_NO_IOPORT_MAP
+ssize_t vfio_pci_vga_rw(struct vfio_pci_device *vdev, char __user *buf,
+			size_t count, loff_t *ppos, bool iswrite)
+{
+	return -EINVAL;
+}
+#else
 ssize_t vfio_pci_vga_rw(struct vfio_pci_device *vdev, char __user *buf,
 			       size_t count, loff_t *ppos, bool iswrite)
 {
@@ -236,3 +243,4 @@ ssize_t vfio_pci_vga_rw(struct vfio_pci_
 
 	return done;
 }
+#endif
