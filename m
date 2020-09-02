Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10742 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726594AbgIBTq5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 2 Sep 2020 15:46:57 -0400
From: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v4 0/3] vfio/pci: Restore MMIO access for s390 detached VFs
Date: Wed,  2 Sep 2020 15:46:33 -0400
Message-Id: <1599075996-9826-1-git-send-email-mjrosato@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: alex.williamson@redhat.com, bhelgaas@google.com
Cc: schnelle@linux.ibm.com, pmorel@linux.ibm.com, mpe@ellerman.id.au, oohall@gmail.com, cohuck@redhat.com, kevin.tian@intel.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-pci@vger.kernel.org

Since commit abafbc551fdd ("vfio-pci: Invalidate mmaps and block MMIO
access on disabled memory") VFIO now rejects guest MMIO access when the
PCI_COMMAND_MEMORY (MSE) bit is OFF.  This is however not the case for
VFs (fixed in commit ebfa440ce38b ("vfio/pci: Fix SR-IOV VF handling
with MMIO blocking")).  Furthermore, on s390 where we always run with at
least a bare-metal hypervisor (LPAR) PCI_COMMAND_MEMORY, unlike Device/
Vendor IDs and BARs, is not emulated when VFs are passed-through to the
OS independently.

Based upon Bjorn's most recent comment [1], I investigated the notion of
setting is_virtfn=1 for VFs passed-through to Linux and not linked to a
parent PF (referred to as a 'detached VF' in my prior post).  However,
we rapidly run into issues on how to treat an is_virtfn device with no
linked PF. Further complicating the issue is when you consider the guest
kernel has a passed-through VF but has CONFIG_PCI_IOV=n as in many 
locations is_virtfn checking is ifdef'd out altogether and the device is
assumed to be an independent PCI function.

The decision made by VFIO whether to require or emulate a PCI feature 
(in this case PCI_COMMAND_MEMORY) is based upon the knowledge it has 
about the device, including implicit expectations of what/is not
emulated below VFIO. (ex: is it safe to read vendor/id from config
space?) -- Our firmware layer attempts similar behavior by emulating
things such as vendor/id/BAR access - without these an unlinked VF would
not be usable. But what is or is not emulated by the layer below may be
different based upon which entity is providing the emulation (vfio,
LPAR, some other hypervisor)

So, the proposal here aims to fix the immediate issue of s390
pass-through VFs becoming suddenly unusable by vfio by using a dev_flags
bit to identify a VF feature that we know is hardwired to 0 for any
VF (PCI_COMMAND_MEMORY) and de-coupling the need for emulating
PCI_COMMAND_MEMORY from the is_virtfn flag. The exact scope of is_virtfn
and physfn for bare-metal vs guest scenarios and identifying what
features are / are not emulated by the lower-level hypervisors is a much
bigger discussion independent of this limited proposal.

Changes from v3:
- Propose a dev_flags model for the MSE bit
- Set the bit for typical iov linking
- Also set the bit for s390 VFs (linked and unlinked)
- Modify vfio-pci to look at the dev_flags bit instead of is_virtfn

[1]: https://marc.info/?l=linux-pci&m=159856041930022&w=2

Matthew Rosato (3):
  PCI/IOV: Mark VFs as not implementing MSE bit
  s390/pci: Mark all VFs as not implementing MSE bit
  vfio/pci: Decouple MSE bit checks from is_virtfn

 arch/s390/pci/pci_bus.c            |  5 +++--
 drivers/pci/iov.c                  |  1 +
 drivers/vfio/pci/vfio_pci_config.c | 20 +++++++++++++-------
 include/linux/pci.h                |  2 ++
 4 files changed, 19 insertions(+), 9 deletions(-)

-- 
1.8.3.1
