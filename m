Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:1664 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbgEGJal (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 7 May 2020 05:30:41 -0400
From: Niklas Schnelle <schnelle@linux.ibm.com>
Subject: [PATCH 0/2] Enable PF-VF linking with pdev->no_vf_scan (s390)
Date: Thu,  7 May 2020 11:30:32 +0200
Message-Id: <20200507093034.56143-1-schnelle@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>

Hello Kernel Hackers,

the following series enables PF-VF linking for architectures using the
pdev->no_vf_scan flag (currently just s390). This includes kernel internal
linking with pdev->physfn as well as creation of the relevant sysfs links.
The former are required for example by libvirt to manage VFs.

The series consists of two patches against the featuress branch of
git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git

- PCI/IOV: Introduce pci_iov_sysfs_link() function

This patch factors the sysfs link creation out of pci_iov_add_virtfn() and
into a new pci_iov_sysfs_link() function. On its own it also applies
cleanly on v5.7-rc4.

- s390/pci: create links between PFs and VFs

This patch makes use of the pci_iov_sysfs_link() function introduced in the
first patch to create the sysfs PF-VF links. It exploits recent work for
multi-function support on s390 that gives us the real devfnto identify the
parent PF of a given VF.
Apart from these s390 specific support contained within arch/s390/ it also
removes the fencing off of pci_iov_remove_virtfn() by the pdev->no_vf_scan
flag making use of the common code path for clean VF removal.
While this is common code s390 is currently the only case where
pdev->no_vf_scan is true I can of course split this into a separate patch
if requested but wanted to keep this together for the discussion.
This patch will go via the s390 tree once the first patch landed.

Best regards and your feedback is welcome,
Niklas Schnelle

Changes since the RFC:
- Addressed commit message feedback (thanks Bjorn Helgaas)
- Addressed style feedback (thanks Bjorn Helgaas)
- Add Acked-by
- Fixed struct field name collision for reserved in second patch.
  (Was added as style fix).

Niklas Schnelle (2):
  PCI/IOV: Introduce pci_iov_sysfs_link() function
  s390/pci: create links between PFs and VFs

 arch/s390/include/asm/pci.h     |  3 +-
 arch/s390/include/asm/pci_clp.h |  3 +-
 arch/s390/pci/pci_bus.c         | 69 ++++++++++++++++++++++++++++++++-
 arch/s390/pci/pci_clp.c         |  1 +
 drivers/pci/iov.c               | 39 ++++++++++++-------
 include/linux/pci.h             |  8 ++++
 6 files changed, 106 insertions(+), 17 deletions(-)

-- 
2.17.1
