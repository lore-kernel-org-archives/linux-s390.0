Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v12 0/2] s390: virtio: let arch validate VIRTIO features
Date: Thu, 10 Sep 2020 10:53:48 +0200
Message-Id: <1599728030-17085-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

Hi all,

The goal of the series is to give a chance to the architecture
to validate VIRTIO device features.

I changed VIRTIO_F_IOMMU_PLATFORM to VIRTIO_F_ACCESS_PLATFORM
I forgot in drivers/virtio/Kconfig, and put back the inclusion
of virtio_config.h for the definition of the callback in
arch/s390/mm/init.c I wrongly removed in the last series.

Regards,
Pierre


Pierre Morel (2):
  virtio: let arch advertise guest's memory access restrictions
  s390: virtio: PV needs VIRTIO I/O device protection

 arch/s390/Kconfig             |  1 +
 arch/s390/mm/init.c           | 11 +++++++++++
 drivers/virtio/Kconfig        |  6 ++++++
 drivers/virtio/virtio.c       | 15 +++++++++++++++
 include/linux/virtio_config.h | 10 ++++++++++
 5 files changed, 43 insertions(+)

-- 
2.25.1

to v12
- replaced VIRTIO_F_IOMMU_PLATFORM with VIRTIO_F_ACCESS_PLATFORM
  in drivers/virtio/Kconfig
  (Halil)

- suppress inaccurate part of the comment in patch 2
  (Halil)

- added back virtio_config.h to define
  arch_has_restricted_virtio_memory_access
  (kernel robot)

to v11:
- replaced VIRTIO_F_IOMMU_PLATFORM with VIRTIO_F_ACCESS_PLATFORM

to v10:
- removed virtio_config.h unnecessary include
- wording
  (Connie)

to v9:

- move virtio tests back to virtio_finalize_features
  (Connie)

- remove virtio device argument

to v8:

- refactoring by using an optional callback
  (Connie)

to v7:

- typo in warning message
  (Connie)
to v6:

- rewording warning messages
  (Connie, Halil)

to v5:

- return directly from S390 arch_validate_virtio_features()
  when the guest is not protected.
  (Connie)

- Somme rewording
  (Connie, Michael)

- moved back code from arch/s390/ ...kernel/uv.c to ...mm/init.c
  (Christian)

to v4:

- separate virtio and arch code
  (Pierre)

- moved code from arch/s390/mm/init.c to arch/s390/kernel/uv.c
  (as interpreted from Heiko's comment)

- moved validation inside the arch code
  (Connie)

- moved the call to arch validation before VIRTIO_F_1 test
  (Michael)

to v3:

- add warning
  (Connie, Christian)

- add comment
  (Connie)

- change hook name
  (Halil, Connie)

to v2:

- put the test in virtio_finalize_features()
  (Connie)

- put the test inside VIRTIO core
  (Jason)

- pass a virtio device as parameter
  (Halil)
