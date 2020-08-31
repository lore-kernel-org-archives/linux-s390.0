Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28458 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728165AbgHaJKG (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 31 Aug 2020 05:10:06 -0400
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v10 0/2] s390: virtio: let arch validate VIRTIO features
Date: Mon, 31 Aug 2020 11:09:44 +0200
Message-Id: <1598864986-13875-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: pasic@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, mst@redhat.com, jasowang@redhat.com, cohuck@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com, david@gibson.dropbear.id.au, linuxram@us.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com

Hi all,

The goal of the series is to give a chance to the architecture
to validate VIRTIO device features.

The tests are back to virtio_finalize_features.

No more argument for the architecture callback which only reports
if the architecture needs guest memory access restrictions for
VIRTIO.


I renamed the callback to arch_has_restricted_virtio_memory_access,
and the config option to ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS.

Regards,
Pierre

Pierre Morel (2):
  virtio: let arch advertise guest's memory access restrictions
  s390: virtio: PV needs VIRTIO I/O device protection

 arch/s390/Kconfig             |  1 +
 arch/s390/mm/init.c           | 10 ++++++++++
 drivers/virtio/Kconfig        |  6 ++++++
 drivers/virtio/virtio.c       | 15 +++++++++++++++
 include/linux/virtio_config.h |  9 +++++++++
 5 files changed, 41 insertions(+)

-- 
2.25.1

Changelog

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
