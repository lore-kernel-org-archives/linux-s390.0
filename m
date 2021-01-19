Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17452 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729879AbhASUYS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 19 Jan 2021 15:24:18 -0500
From: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 0/4] vfio-pci/zdev: Fixing s390 vfio-pci ISM support
Date: Tue, 19 Jan 2021 15:02:26 -0500
Message-Id: <1611086550-32765-1-git-send-email-mjrosato@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, cohuck@redhat.com, schnelle@linux.ibm.com
Cc: pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

Today, ISM devices are completely disallowed for vfio-pci passthrough as
QEMU will reject the device due to an (inappropriate) MSI-X check.
However, in an effort to enable ISM device passthrough, I realized that the
manner in which ISM performs block write operations is highly incompatible
with the way that QEMU s390 PCI instruction interception and
vfio_pci_bar_rw break up I/O operations into 8B and 4B operations -- ISM
devices have particular requirements in regards to the alignment, size and
order of writes performed.  Furthermore, they require that legacy/non-MIO
s390 PCI instructions are used, which is also not guaranteed when the I/O
is passed through the typical userspace channels.

As a result, this patchset proposes a new VFIO region to allow a guest to
pass certain PCI instruction intercepts directly to the s390 host kernel
PCI layer for execution, pinning the guest buffer in memory briefly in
order to execute the requested PCI instruction.

Changes from RFC -> v1:
- No functional changes, just minor commentary changes -- Re-posting along
with updated QEMU set.

Matthew Rosato (4):
  s390/pci: track alignment/length strictness for zpci_dev
  vfio-pci/zdev: Pass the relaxed alignment flag
  s390/pci: Get hardware-reported max store block length
  vfio-pci/zdev: Introduce the zPCI I/O vfio region

 arch/s390/include/asm/pci.h         |   4 +-
 arch/s390/include/asm/pci_clp.h     |   7 +-
 arch/s390/pci/pci_clp.c             |   2 +
 drivers/vfio/pci/vfio_pci.c         |   8 ++
 drivers/vfio/pci/vfio_pci_private.h |   6 ++
 drivers/vfio/pci/vfio_pci_zdev.c    | 160 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h           |   4 +
 include/uapi/linux/vfio_zdev.h      |  34 ++++++++
 8 files changed, 222 insertions(+), 3 deletions(-)

-- 
1.8.3.1
