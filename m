Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44688 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726488AbgHLOud (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 12 Aug 2020 10:50:33 -0400
From: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH] PCI: Identifying detached virtual functions
Date: Wed, 12 Aug 2020 10:50:16 -0400
Message-Id: <1597243817-3468-1-git-send-email-mjrosato@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, bhelgaas@google.com
Cc: schnelle@linux.ibm.com, pmorel@linux.ibm.com, mpe@ellerman.id.au, oohall@gmail.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org

As discussed previously in a qemu-devel thread:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg725141.html

s390x has the notion of unlinked VFs being available at the LPAR-level
(Virtual Functions where the kernel does not have access to the associated
Physical Function).  These devices are currently not marked as is_virtfn.
There seems to be some precedent (ex: in powerpc, eeh_debugfs_break_device())
where pdev->is_virtfn && pdev->physfn == 0 is used to detect these sort of
detached VFs.  We toyed with the idea of doing this but it causes additional
fallout as various other areas of kernel code have an expectation that
is_virtfn=1 implies there is a linked PF available to the kernel. 

In the s390x case, the firmware layer underneath handles the VF emulation
as it still has access to the PF that the LPAR (and thus the kernel) cannot
see.  But one thing this firmware layer does not do is emulate the
PCI_COMMAND_MEMORY bit, which was OK until vfio-pci started enforcing it
via abafbc55.  The vfio-pci check is waived for VFs as of ebfa440c, but
vfio-pci can't actually tell that these particular devices are VFs.

The proposed patch attempts to identify these detached VFs and subsequently
provide this information to vfio-pci so that it knows to also accept the
lack of PCI_COMMAND_MEMORY for these sorts of devices.  For now the bit is
only set for s390x but other architectures could opt in to it as well if
needed.

Matthew Rosato (1):
  PCI: Introduce flag for detached virtual functions

 arch/s390/pci/pci.c                | 8 ++++++++
 drivers/vfio/pci/vfio_pci_config.c | 3 ++-
 include/linux/pci.h                | 1 +
 3 files changed, 11 insertions(+), 1 deletion(-)

-- 
1.8.3.1
