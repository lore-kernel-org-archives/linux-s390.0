Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50638 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727305AbgBGLkJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Feb 2020 06:40:09 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 00/35] KVM: s390: Add support for protected VMs
Date: Fri,  7 Feb 2020 06:39:23 -0500
Message-Id: <20200207113958.7320-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>


Upfront: This series contains a "pretty small" common code memory
management change that will allow paging, guest backing with files etc
almost just like normal VMs. It should be a no-op for all architectures
not opting in. And it should be usable for others that also try to get
notified on "the pages are in the process of being used for things like
I/O"

I CCed linux-mm (and Andrew as mm maintainer and Andrea as he was
involved in some design discussions) on the first patch (common code
mm). I also added the CC to some other patches that make use of this
infrastructure or are dealing with arch-specific memory management.

The full patch queue is on the linux-s390 and kvm mailing list.  It
would be good to get an ACK for this patch. I can then carry that via
the s390 tree.

Overview
--------
Protected VMs (PVM) are KVM VMs, where KVM can't access the VM's state
like guest memory and guest registers anymore. Instead the PVMs are
mostly managed by a new entity called Ultravisor (UV), which provides
an API, so KVM and the PV can request management actions.

PVMs are encrypted at rest and protected from hypervisor access while
running. They switch from a normal operation into protected mode, so
we can still use the standard boot process to load a encrypted blob
and then move it into protected mode.

Rebooting is only possible by passing through the unprotected/normal
mode and switching to protected again.

All patches are in the protvirtv3 branch of the korg s390 kvm git
https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/?h=protvirtv3

Claudio presented the technology at his presentation at KVM Forum
2019.

https://static.sched.com/hosted_files/kvmforum2019/3b/ibm_protected_vms_s390x.pdf


RFCv2 -> v1 (you can diff the protvirtv2 and the protvirtv3 branch)
- tons of review feedback integrated (see mail thread)
- memory management now complete and working
- Documentation patches merged
- interrupt patches merged
- CONFIG_KVM_S390_PROTECTED_VIRTUALIZATION_HOST removed
- SIDA interface integrated into memop
- for merged patches I removed reviews that were not in all patches

Christian Borntraeger (3):
  KVM: s390/mm: Make pages accessible before destroying the guest
  KVM: s390: protvirt: Add SCLP interrupt handling
  KVM: s390: protvirt: do not inject interrupts after start

Claudio Imbrenda (3):
  mm:gup/writeback: add callbacks for inaccessible pages
  s390/mm: provide memory management functions for protected KVM guests
  KVM: s390/mm: handle guest unpin events

Janosch Frank (23):
  KVM: s390: add new variants of UV CALL
  KVM: s390: protvirt: Add initial lifecycle handling
  KVM: s390: protvirt: Add KVM api documentation
  KVM: s390: protvirt: Secure memory is not mergeable
  KVM: s390: protvirt: Handle SE notification interceptions
  KVM: s390: protvirt: Instruction emulation
  KVM: s390: protvirt: Handle spec exception loops
  KVM: s390: protvirt: Add new gprs location handling
  KVM: S390: protvirt: Introduce instruction data area bounce buffer
  KVM: s390: protvirt: handle secure guest prefix pages
  KVM: s390: protvirt: Write sthyi data to instruction data area
  KVM: s390: protvirt: STSI handling
  KVM: s390: protvirt: disallow one_reg
  KVM: s390: protvirt: Only sync fmt4 registers
  KVM: s390: protvirt: Add program exception injection
  KVM: s390: protvirt: Add diag 308 subcode 8 - 10 handling
  KVM: s390: protvirt: UV calls diag308 0, 1
  KVM: s390: protvirt: Report CPU state to Ultravisor
  KVM: s390: protvirt: Support cmd 5 operation state
  KVM: s390: protvirt: Add UV debug trace
  KVM: s390: protvirt: Mask PSW interrupt bits for interception 104 and
    112
  KVM: s390: protvirt: Add UV cpu reset calls
  DOCUMENTATION: Protected virtual machine introduction and IPL

Michael Mueller (2):
  KVM: s390: protvirt: Add interruption injection controls
  KVM: s390: protvirt: Implement interruption injection

Ulrich Weigand (1):
  KVM: s390/interrupt: do not pin adapter interrupt pages

Vasily Gorbik (3):
  s390/protvirt: introduce host side setup
  s390/protvirt: add ultravisor initialization
  s390/mm: add (non)secure page access exceptions handlers

 .../admin-guide/kernel-parameters.txt         |   5 +
 Documentation/virt/kvm/api.txt                |  67 ++-
 Documentation/virt/kvm/index.rst              |   2 +
 Documentation/virt/kvm/s390-pv-boot.rst       |  79 +++
 Documentation/virt/kvm/s390-pv.rst            | 116 +++++
 MAINTAINERS                                   |   1 +
 arch/s390/boot/Makefile                       |   2 +-
 arch/s390/boot/uv.c                           |  21 +-
 arch/s390/include/asm/gmap.h                  |   3 +
 arch/s390/include/asm/kvm_host.h              | 114 ++++-
 arch/s390/include/asm/mmu.h                   |   2 +
 arch/s390/include/asm/mmu_context.h           |   1 +
 arch/s390/include/asm/page.h                  |   5 +
 arch/s390/include/asm/pgtable.h               |  35 +-
 arch/s390/include/asm/uv.h                    | 267 +++++++++-
 arch/s390/kernel/Makefile                     |   1 +
 arch/s390/kernel/pgm_check.S                  |   4 +-
 arch/s390/kernel/setup.c                      |   7 +-
 arch/s390/kernel/uv.c                         | 274 ++++++++++
 arch/s390/kvm/Makefile                        |   2 +-
 arch/s390/kvm/diag.c                          |   1 +
 arch/s390/kvm/intercept.c                     | 109 +++-
 arch/s390/kvm/interrupt.c                     | 371 +++++++++++---
 arch/s390/kvm/kvm-s390.c                      | 477 ++++++++++++++++--
 arch/s390/kvm/kvm-s390.h                      |  39 ++
 arch/s390/kvm/priv.c                          |  11 +-
 arch/s390/kvm/pv.c                            | 292 +++++++++++
 arch/s390/mm/fault.c                          |  86 ++++
 arch/s390/mm/gmap.c                           |  65 ++-
 include/linux/gfp.h                           |   6 +
 include/uapi/linux/kvm.h                      |  42 +-
 mm/gup.c                                      |   2 +
 mm/page-writeback.c                           |   1 +
 33 files changed, 2325 insertions(+), 185 deletions(-)
 create mode 100644 Documentation/virt/kvm/s390-pv-boot.rst
 create mode 100644 Documentation/virt/kvm/s390-pv.rst
 create mode 100644 arch/s390/kernel/uv.c
 create mode 100644 arch/s390/kvm/pv.c

-- 
2.24.0
