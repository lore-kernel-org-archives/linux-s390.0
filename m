From: Collin Walling <walling@linux.ibm.com>
Date: Thu, 06 Dec 2018 22:30:03 +0000
Subject: [PATCH v2 0/2] Use DIAG318 to set Control Program Name & Version Codes
Message-Id: <1544135405-22385-1-git-send-email-walling@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Changelog

    RFC -> v1
        - set distro_id to 0 for now and will be introduced properly as a follow-on
            patch with further details wrt its usage
        - created diag318 union structure to contain CPC data in kvm
        - removed VCPU_EVENT from diag318 handler (we still see a VM_EVENT)

     v1 -> v2
        - set_cpc now uses kvm_block_all
        - s/VM_MISC/VM_MACHINE
        - SCB shadowing / unshadowing of cpnc
        - added r-b's to patch 1

A new diagnose instruction, 318, allows the kernel to set an 8-byte "Control 
Program Code" (CPC) that is composed of:

    1-byte Control Program Name Code (CPNC)
    7-byte Control Program Version Code (CPVC) composed of:
        3-bytes for Linux Kernel version (determined at build-time)
        3-bytes for *Distribution Identifier (currently set to 0)
        1-byte trailing NULL

*The distribution identifier will be introduced as a follow-on patch.

This instruction call is executed once-and-only-once during Kernel setup.
The availability of this instruction depends on Read SCP Info byte 134, bit 0.
Diagnose318's functionality is also emulated by KVM, which means we can 
enable this feature for a guest even if the host kernel cannot support it.

The CPNC and CPVC are used for problem diagnosis and allows IBM to identify 
control program information by answering the following questions:

    "What environment is this guest running in?" (CPNC)
    "What linux version is this guest running?" (CPVC)

Collin Walling (2):
  s390/setup: set control program code via diag 318
  s390/kvm: handle diagnose 318 instruction call

 arch/s390/include/asm/diag.h     | 12 ++++++
 arch/s390/include/asm/kvm_host.h | 13 +++++-
 arch/s390/include/asm/sclp.h     |  1 +
 arch/s390/include/uapi/asm/kvm.h |  5 +++
 arch/s390/kernel/diag.c          |  1 +
 arch/s390/kernel/setup.c         | 21 +++++++++
 arch/s390/kvm/diag.c             | 12 ++++++
 arch/s390/kvm/kvm-s390.c         | 92 ++++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.h         |  1 +
 arch/s390/kvm/vsie.c             |  7 +++
 drivers/s390/char/sclp.h         |  4 +-
 drivers/s390/char/sclp_early.c   |  2 +
 12 files changed, 169 insertions(+), 2 deletions(-)

-- 
2.7.4
