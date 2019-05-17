Return-Path: <SRS0=60ZI=TR=vger.kernel.org=kvm-owner@kernel.org>
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v2 0/4] Retrieving zPCI specific info with VFIO
Date: Fri, 17 May 2019 18:16:46 +0200
Message-Id: <1558109810-18683-1-git-send-email-pmorel@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: sebott@linux.vnet.ibm.com
Cc: gerald.schaefer@de.ibm.com, pasic@linux.vnet.ibm.com, borntraeger@de.ibm.com, walling@linux.ibm.com, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, kvm@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, robin.murphy@arm.com
List-ID: <linux-s390.vger.kernel.org>

Using the PCI VFIO interface allows userland, a.k.a. QEMU, to retrieve
ZPCI specific information without knowing Z specific identifiers
like the function ID or the function handle of the zPCI function
hidden behind the PCI interface.

By using the VFIO_IOMMU_GET_INFO ioctl we enter the vfio_iommu_type1
ioctl callback and can insert there the treatment for a new Z specific
capability.

Once in vfio_iommu_type1 we can retrieve the real iommu device,
s390_iommu and call the get_attr iommu operation's callback
in which we can retrieve the zdev device and start clp operations
to retrieve Z specific values the guest driver is concerned with.

To share the code with arch/s390/pci/pci_clp.c the original functions
in pci_clp.c to query PCI functions and PCI functions group are
modified so that they can be exported.

A new function clp_query_pci() replaces clp_query_pci_fn() and
the previous calls to clp_query_pci_fn() and clp_query_pci_fngrp()
are replaced with calls to zdev_query_pci_fn() and zdev_query_pci_fngrp()
using a zdev pointer as argument.


Pierre Morel (4):
  s390: pci: Exporting access to CLP PCI function and PCI group
  vfio: vfio_iommu_type1: Define VFIO_IOMMU_INFO_CAPABILITIES
  s390: iommu: Adding get attributes for s390_iommu
  vfio: vfio_iommu_type1: implement VFIO_IOMMU_INFO_CAPABILITIES

 arch/s390/include/asm/pci.h     |   3 +
 arch/s390/pci/pci_clp.c         |  70 ++++++++++++-----------
 drivers/iommu/s390-iommu.c      |  77 +++++++++++++++++++++++++
 drivers/vfio/vfio_iommu_type1.c | 122 +++++++++++++++++++++++++++++++++++++++-
 include/linux/iommu.h           |   4 ++
 include/uapi/linux/vfio.h       |  67 ++++++++++++++++++++++
 6 files changed, 308 insertions(+), 35 deletions(-)

-- 
2.7.4

Changelog
From V1:
- no export of the symbol of the new zPCI CLP functions
(Robin)
- adding descriptions for the VFIO capabilities
(Alex)
- defining the structure of the data retrieved through
  VFIO_IOMMU_GET_INFO
(Alex)
- code modifications to allow architecture independence
  for the capabilities
(Alex)
