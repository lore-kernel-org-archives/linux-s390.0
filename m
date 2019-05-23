Return-Path: <SRS0=0NiW=TX=vger.kernel.org=kvm-owner@kernel.org>
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 0/3] Retrieving zPCI specific info with VFIO
Date: Thu, 23 May 2019 14:25:23 +0200
Message-Id: <1558614326-24711-1-git-send-email-pmorel@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: sebott@linux.vnet.ibm.com
Cc: gerald.schaefer@de.ibm.com, pasic@linux.vnet.ibm.com, borntraeger@de.ibm.com, walling@linux.ibm.com, linux-s390@vger.kernel.org, iommu@lists.linux-foundation.org, joro@8bytes.org, linux-kernel@vger.kernel.org, alex.williamson@redhat.com, kvm@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, robin.murphy@arm.com
List-ID: <linux-s390.vger.kernel.org>

We define a new configuration entry for VFIO/PCI, VFIO_PCI_ZDEV
to configure access to a zPCI region dedicated for retrieving
zPCI features.

When the VFIO_PCI_ZDEV feature is configured we initialize
a new device region, VFIO_REGION_SUBTYPE_ZDEV_CLP, to hold
the information from the ZPCI device the userland needs to
give to a guest driving the zPCI function.


Note that in the current state we do not use the CLP instructions
to access the firmware but get the information directly from
the zdev device.

-This means that the patch 1, "s390: pci: Exporting access to CLP PCI
function and PCI group" is not used and can be let out of this series
without denying the good working of the other patches.
- But we will need this later, eventually in the next iteration
  to retrieve values not being saved inside the zdev structure.
  like maxstbl and the PCI supported version

To share the code with arch/s390/pci/pci_clp.c the original functions
in pci_clp.c to query PCI functions and PCI functions group are
modified so that they can be exported.

A new function clp_query_pci() replaces clp_query_pci_fn() and
the previous calls to clp_query_pci_fn() and clp_query_pci_fngrp()
are replaced with calls to zdev_query_pci_fn() and zdev_query_pci_fngrp()
using a zdev pointer as argument.


Pierre Morel (3):
  s390: pci: Exporting access to CLP PCI function and PCI group
  vfio: zpci: defining the VFIO headers
  vfio: pci: Using a device region to retrieve zPCI information

 arch/s390/include/asm/pci.h         |  3 ++
 arch/s390/pci/pci_clp.c             | 70 ++++++++++++++++---------------
 drivers/vfio/pci/Kconfig            |  7 ++++
 drivers/vfio/pci/Makefile           |  1 +
 drivers/vfio/pci/vfio_pci.c         |  9 ++++
 drivers/vfio/pci/vfio_pci_private.h | 10 +++++
 drivers/vfio/pci/vfio_pci_zdev.c    | 83 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h           |  4 ++
 include/uapi/linux/vfio_zdev.h      | 34 +++++++++++++++
 9 files changed, 187 insertions(+), 34 deletions(-)
 create mode 100644 drivers/vfio/pci/vfio_pci_zdev.c
 create mode 100644 include/uapi/linux/vfio_zdev.h

-- 
2.7.4
