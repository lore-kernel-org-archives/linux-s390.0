From: frank.blaschka@de.ibm.com
Subject: [RFC patch 6/6] vfio: make vfio run on s390 platform
Date: Fri, 19 Sep 2014 13:54:35 +0200
Message-ID: <20140919115940.596533004@de.ibm.com>
References: <20140919115429.557279920@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline; filename=104-qemu_vfio.patch
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: alex.williamson@redhat.com, pbonzini@redhat.com, agraf@suse.de
List-ID: <linux-s390.vger.kernel.org>

From: Frank Blaschka <frank.blaschka@de.ibm.com>

Following changes are made because of platform differences:

1) s390 does not support mmap'ing of PCI BARs so we have to go via slow path
2) no intx support
3) no classic MSIX interrupts. The pci hw understands the concept
   of requesting MSIX irqs but irqs are delivered as s390 adapter irqs.
   Introduce s390 specific functions for msix notification (slow path) and
   msi routes (kvm fast path).
4) Use type1 iommu but register only for iommu address space

Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---
 hw/misc/vfio.c |   24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

--- a/hw/misc/vfio.c
+++ b/hw/misc/vfio.c
@@ -40,6 +40,9 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
 #include "hw/misc/vfio.h"
+#ifdef TARGET_S390X
+#include "hw/s390x/s390-pci-bus.h"
+#endif
 
 /* #define DEBUG_VFIO */
 #ifdef DEBUG_VFIO
@@ -51,7 +54,11 @@
 #endif
 
 /* Extra debugging, trap acceleration paths for more logging */
+#ifdef TARGET_S390X
+#define VFIO_ALLOW_MMAP 0
+#else
 #define VFIO_ALLOW_MMAP 1
+#endif
 #define VFIO_ALLOW_KVM_INTX 1
 #define VFIO_ALLOW_KVM_MSI 1
 #define VFIO_ALLOW_KVM_MSIX 1
@@ -554,6 +561,10 @@ static int vfio_enable_intx(VFIODevice *
     struct vfio_irq_set *irq_set;
     int32_t *pfd;
 
+#ifdef TARGET_S390X
+    return 0;
+#endif
+
     if (!pin) {
         return 0;
     }
@@ -664,7 +675,11 @@ static void vfio_msi_interrupt(void *opa
 #endif
 
     if (vdev->interrupt == VFIO_INT_MSIX) {
+#ifdef TARGET_S390X
+        s390_msix_notify(&vdev->pdev, nr);
+#else
         msix_notify(&vdev->pdev, nr);
+#endif
     } else if (vdev->interrupt == VFIO_INT_MSI) {
         msi_notify(&vdev->pdev, nr);
     } else {
@@ -730,7 +745,11 @@ static void vfio_add_kvm_msi_virq(VFIOMS
         return;
     }
 
+#ifdef TARGET_S390X
+    virq = s390_irqchip_add_msi_route(&vector->vdev->pdev, kvm_state, *msg);
+#else
     virq = kvm_irqchip_add_msi_route(kvm_state, *msg);
+#endif
     if (virq < 0) {
         event_notifier_cleanup(&vector->kvm_interrupt);
         return;
@@ -3702,8 +3721,13 @@ static int vfio_connect_container(VFIOGr
         container->iommu_data.type1.listener = vfio_memory_listener;
         container->iommu_data.release = vfio_listener_release;
 
+#ifdef TARGET_S390X
+        memory_listener_register(&container->iommu_data.type1.listener,
+                                 container->space->as);
+#else
         memory_listener_register(&container->iommu_data.type1.listener,
                                  &address_space_memory);
+#endif
 
         if (container->iommu_data.type1.error) {
             ret = container->iommu_data.type1.error;
