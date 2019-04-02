Return-Path: <linux-doc-owner@vger.kernel.org>
From: Collin Walling <walling@linux.ibm.com>
Subject: [PATCH v3 0/2] Use DIAG318 to set Control Program Name & Version Codes
Date: Tue,  2 Apr 2019 13:46:34 -0400
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190402174636.15175-1-walling@linux.ibm.com>
Sender: linux-doc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-doc/>
List-Post: <mailto:linux-doc@vger.kernel.org>
To: pbonzini@redhat.com, david@redhat.com, cohuck@redhat.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Changelog:

    v3
        - kernel patch for diag 0x318 instruction call fixup
            - this is to support QEMU changes found here:
              https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg00328.html
        - removed CPU model code
        - cleaned up diag318_info struct
        - cpnc is no longer unshadowed as it was not needed
        - rebased on 5.1.0-rc3

This instruction call is executed once-and-only-once during Kernel setup.
The availability of this instruction depends on Read SCP Info byte 134, bit 0.
Diagnose318's functionality is also emulated by KVM, which means we can 
enable this feature for a guest even if the host kernel cannot support it.

The CPNC and CPVC are used for problem diagnosis and allows IBM to identify 
control program information by answering the following question:

    "What environment is this guest running in?" (CPNC)
    "What are more details regarding the OS?" (CPVC)

In the future, we will implement the Control Program Version Code (CPVC) to
convey more information about the OS. For now, we set this field to 0 until
we come up with a solid plan.

Collin Walling (2):
  s390/setup: diag318: remove bit check and refactor struct
  s390/kvm: diagnose 318 handling

 Documentation/virtual/kvm/devices/vm.txt | 14 ++++
 arch/s390/include/asm/diag.h             |  6 +-
 arch/s390/include/asm/kvm_host.h         |  7 +-
 arch/s390/include/uapi/asm/kvm.h         |  4 ++
 arch/s390/kernel/setup.c                 | 12 ++--
 arch/s390/kvm/diag.c                     | 17 +++++
 arch/s390/kvm/kvm-s390.c                 | 83 ++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.h                 |  1 +
 arch/s390/kvm/vsie.c                     |  2 +
 9 files changed, 134 insertions(+), 12 deletions(-)

-- 
2.20.1
