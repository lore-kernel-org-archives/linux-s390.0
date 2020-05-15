Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726212AbgEOWUC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 15 May 2020 18:20:02 -0400
From: Collin Walling <walling@linux.ibm.com>
Subject: [PATCH v7 0/3] Use DIAG318 to set Control Program Name & Version Codes
Date: Fri, 15 May 2020 18:19:32 -0400
Message-Id: <20200515221935.18775-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org
Cc: pbonzini@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com, imbrenda@linux.ibm.com, heiko.carstens@de.ibm.com, gor@linux.ibm.com, thuth@redhat.com

Changelog:

    v7

    • Removed diag handler, as it will now take place within userspace
    • Removed KVM_S390_VM_MISC_ENABLE_DIAG318 (undoes first bullet in v6)
    • Misc clean ups and fixes
        - introduced a new patch to s/diag318/diag_318 and s/byte_134/fac134
          to keep things consistent with the rest of the code

    v6

    • KVM disables diag318 get/set by default [removed in v7]
    • added new IOCTL to tell KVM to enable diag318 [removed in v7]
    • removed VCPU event message in favor of VM_EVENT only

    v5
    
    • s/cpc/diag318_info in order to make the relevant data more clear
    • removed mutex locks for diag318_info get/set

    v4
    
    • removed setup.c changes introduced in bullet 1 of v3
    • kept diag318_info struct cleanup
    • analogous QEMU patches:
        https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00164.html

    v3
    
    • kernel patch for diag 0x318 instruction call fixup [removed in v4]
    • removed CPU model code
    • cleaned up diag318_info struct
    • cpnc is no longer unshadowed as it was not needed
    • rebased on 5.1.0-rc3

-------------------------------------------------------------------------------

This instruction call is executed once-and-only-once during Kernel setup.
The availability of this instruction depends on Read Info byte 134 (aka fac134),
bit 0.

DIAG 0x318's is handled by userspace and may be enabled for a guest even if the
host kernel cannot support it.

The diag318_info is composed of a Control Program Name Code (CPNC) and a
Control Program Version Code (CPVC). The CPNC is stored in SIE blocks, and
the CPNC & CPVC pair is stored in the kvm_arch struct. 

These values are used for problem diagnosis and allows IBM to identify control
program information by answering the following question:

    "What environment is this guest running in?" (CPNC)
    "What are more details regarding the OS?" (CPVC)

In the future, we will implement the CPVC to convey more information about the 
OS (such as Linux version and potentially some value denoting a specific 
distro + release). For now, we set this field to 0 until we come up with a solid 
plan.

Collin Walling (3):
  s390/setup: diag 318: refactor struct
  s390: keep diag 318 variables consistent with the rest
  s390/kvm: diagnose 0x318 get/set handling

 Documentation/virt/kvm/devices/vm.rst | 21 +++++++
 arch/s390/include/asm/diag.h          |  8 +--
 arch/s390/include/asm/kvm_host.h      |  5 +-
 arch/s390/include/asm/sclp.h          |  2 +-
 arch/s390/include/uapi/asm/kvm.h      |  4 ++
 arch/s390/kernel/setup.c              |  9 ++-
 arch/s390/kvm/kvm-s390.c              | 82 +++++++++++++++++++++++++++
 arch/s390/kvm/vsie.c                  |  2 +
 drivers/s390/char/sclp.h              |  2 +-
 drivers/s390/char/sclp_early.c        |  2 +-
 10 files changed, 123 insertions(+), 14 deletions(-)

-- 
2.21.3
