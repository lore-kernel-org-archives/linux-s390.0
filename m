Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726449AbgISP2r (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Sat, 19 Sep 2020 11:28:47 -0400
From: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH 0/4] Pass zPCI hardware information via VFIO
Date: Sat, 19 Sep 2020 11:28:34 -0400
Message-Id: <1600529318-8996-1-git-send-email-mjrosato@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, cohuck@redhat.com, schnelle@linux.ibm.com
Cc: pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

This patchset provides a means by which hardware information about the
underlying PCI device can be passed up to userspace (ie, QEMU) so that
this hardware information can be used rather than previously hard-coded
assumptions. A new VFIO region type is defined which holds this
information. 

A form of these patches saw some rounds last year but has been back-
tabled for a while.  The original work for this feature was done by Pierre
Morel. I'd like to refresh the discussion on this and get this finished up
so that we can move forward with better-supporting additional types of
PCI-attached devices.  The proposal here presents a completely different
region mapping vs the prior approach, taking inspiration from vfio info
capability chains to provide device CLP information in a way that allows 
for future expansion (new CLP features).

This feature is toggled via the CONFIG_VFIO_PCI_ZDEV configuration entry.

Matthew Rosato (4):
  s390/pci: stash version in the zpci_dev
  s390/pci: track whether util_str is valid in the zpci_dev
  vfio-pci/zdev: define the vfio_zdev header
  vfio-pci/zdev: use a device region to retrieve zPCI information

 arch/s390/include/asm/pci.h         |   4 +-
 arch/s390/pci/pci_clp.c             |   2 +
 drivers/vfio/pci/Kconfig            |  13 ++
 drivers/vfio/pci/Makefile           |   1 +
 drivers/vfio/pci/vfio_pci.c         |   8 ++
 drivers/vfio/pci/vfio_pci_private.h |  10 ++
 drivers/vfio/pci/vfio_pci_zdev.c    | 242 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h           |   5 +
 include/uapi/linux/vfio_zdev.h      | 116 +++++++++++++++++
 9 files changed, 400 insertions(+), 1 deletion(-)
 create mode 100644 drivers/vfio/pci/vfio_pci_zdev.c
 create mode 100644 include/uapi/linux/vfio_zdev.h

-- 
1.8.3.1
