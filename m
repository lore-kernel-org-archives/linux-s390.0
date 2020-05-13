Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25416 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730276AbgEMWRU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 May 2020 18:17:20 -0400
From: Collin Walling <walling@linux.ibm.com>
Subject: [PATCH v6 0/2] Use DIAG318 to set Control Program Name & Version Codes
Date: Wed, 13 May 2020 18:15:55 -0400
Message-Id: <20200513221557.14366-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com

Changelog:

    v6
	- KVM disables diag318 get/set by default
	- added new IOCTL to tell KVM to enable diag318
	- removed VCPU event message in favor of VM_EVENT only

    v5
        - s/cpc/diag318_info in order to make the relevant data more clear
        - removed mutex locks for diag318_info get/set

    v4
        - removed setup.c changes introduced in bullet 1 of v3
        - kept diag318_info struct cleanup
        - analogous QEMU patches:
            https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00164.html

    v3
        - kernel patch for diag 0x318 instruction call fixup [removed in v4]
        - removed CPU model code
        - cleaned up diag318_info struct
        - cpnc is no longer unshadowed as it was not needed
        - rebased on 5.1.0-rc3

This instruction call is executed once-and-only-once during Kernel setup.
The availability of this instruction depends on Read Info byte 134, bit 0.

DIAG 318's functionality is also emulated by KVM, which means we can enable 
this feature for a guest even if the host kernel cannot support it. This
feature is made available starting with the zEC12-full model (see analogous
QEMU patches).

The diag318_info is composed of a Control Program Name Code (CPNC) and a
Control Program Version Code (CPVC). These values are used for problem 
diagnosis and allows IBM to identify control program information by answering 
the following question:

    "What environment is this guest running in?" (CPNC)
    "What are more details regarding the OS?" (CPVC)

In the future, we will implement the CPVC to convey more information about the 
OS. For now, we set this field to 0 until we come up with a solid plan.

Collin Walling (2):
  s390/setup: diag318: refactor struct
  s390/kvm: diagnose 318 handling

 Documentation/virt/kvm/devices/vm.rst | 29 +++++++++
 arch/s390/include/asm/diag.h          |  6 +-
 arch/s390/include/asm/kvm_host.h      |  6 +-
 arch/s390/include/uapi/asm/kvm.h      |  5 ++
 arch/s390/kernel/setup.c              |  3 +-
 arch/s390/kvm/diag.c                  | 20 ++++++
 arch/s390/kvm/kvm-s390.c              | 89 +++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.h              |  1 +
 arch/s390/kvm/vsie.c                  |  2 +
 9 files changed, 154 insertions(+), 7 deletions(-)

-- 
2.21.3
