From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 14 Jun 2016 18:56:37 +0000
Subject: [GIT PULL 00/52] KVM: s390: Features and fixes for 4.8 part1
Message-Id: <201606141857.u5EIs204036654@mx0b-001b2d01.pphosted.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

here is part1 of the s390 patches for 4.8. This time a big chunk - with
more to come in part2.

All base s390 change have the proper ack of the maintainers (or are kvm
specific code in a common file).

There is one patch with cc stable (40/52 s390/mm: don't drop errors in 
get_guest_storage_key) - which in theory would make it more of a candidate
for master instead of next. As we replace that code with a following patch
anyway I want to avoid yet another merge conflict as this pull request 
already has two simple things against the s390-next tree.

The following changes since commit dca4d728773a2f48e999c8617524bbf8dee4807f:

  kvm/x86: remove unnecessary header file inclusion (2016-06-03 15:28:19 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.8-1

for you to fetch changes up to a7e19ab55ffdd82f1a8d12694b9a0c0beeef534c:

  KVM: s390: handle missing storage-key facility (2016-06-10 12:07:31 +0200)

----------------------------------------------------------------
KVM: s390: Features and fixes for 4.8 part1

Four bigger things:
1. The implementation of the STHYI opcode in the kernel. This is used
   in libraries like qclib [1] to provide enough information for a
   capacity and usage based software licence pricing. The STHYI content
   is defined by the related z/VM documentation [2]. Its data can be
   composed by accessing several other interfaces provided by LPAR or
   the machine. This information is partially sensitive or root-only
   so the kernel does the necessary filtering.
2. Preparation for nested virtualization (VSIE). KVM should query the
   proper sclp interfaces for the availability of some features before
   using it. In the past we have been sloppy and simply assumed that
   several features are available. With this we should be able to handle
   most cases of a missing feature.
3. CPU model interfaces extended by some additional features that are
   not covered by a facility bit in STFLE. For example all the crypto
   instructions of the coprocessor provide a query function. As reality
   tends to be more complex (e.g. export regulations might block some
   algorithms) we have to provide additional interfaces to query or
   set these non-stfle features.
4. Several fixes and changes detected and fixed when doing 1-3.

All features change base s390 code. All relevant patches have an ACK
from the s390 or component maintainers.

The next pull request for 4.8 (part2) will contain the implementation
of VSIE.

[1] http://www.ibm.com/developerworks/linux/linux390/qclib.html
[2] https://www.ibm.com/support/knowledgecenter/SSB27U_6.3.0/com.ibm.zvm.v630.hcpb4/hcpb4sth.htm

----------------------------------------------------------------
Alexander Yarygin (1):
      KVM: s390: Add mnemonic print to kvm_s390_intercept_prog

Christian Borntraeger (2):
      KVM: s390: provide logging for diagnose 0x500
      KVM: s390: fixup I/O interrupt traces

David Hildenbrand (41):
      KVM: s390: interface to query and configure cpu features
      KVM: s390: forward ESOP if available
      KVM: s390: gaccess: store guest address on ALC prot exceptions
      KVM: s390: gaccess: function for preparing translation exceptions
      KVM: s390: gaccess: convert kvm_s390_check_low_addr_prot_real()
      KVM: s390: gaccess: convert guest_translate_address()
      KVM: s390: gaccess: convert guest_page_range()
      KVM: s390: gaccess: convert get_vcpu_asce()
      s390/crypto: allow to query all known cpacf functions
      KVM: s390: interface to query and configure cpu subfunctions
      s390/sclp: detect 64-bit-SCAO facility
      KVM: s390: handle missing 64-bit-SCAO facility
      s390/sclp: detect guest-PER enhancement
      KVM: s390: guestdbg: signal missing hardware support
      s390/sclp: detect cmma
      KVM: s390: enable CMMA if the interpration is available
      KVM: s390: provide CMMA attributes only if available
      s390/sclp: detect guest-storage-limit-suppression
      KVM: s390: handle missing guest-storage-limit-suppression
      s390/sclp: detect intervention bypass facility
      KVM: s390: enable ib only if available
      s390/sclp: detect conditional-external-interception facility
      KVM: s390: enable cei only if available
      s390/sclp: detect PFMF interpretation facility
      KVM: s390: enable PFMFI only if available
      s390/sclp: detect interlock-and-broadcast-suppression facility
      KVM: s390: enable ibs only if available
      KVM: s390: enable host-protection-interruption only with ESOP
      KVM: s390: turn on tx even without ctx
      s390/mm: don't drop errors in get_guest_storage_key
      s390/mm: simplify get_guest_storage_key
      s390/mm: return key via pointer in get_guest_storage_key
      KVM: s390: storage keys fit into a char
      KVM: s390: pfmf: fix end address calculation
      KVM: s390: pfmf: MR and MC are ignored without CSSKE
      KVM: s390: pfmf: take care of amode when setting reg2
      KVM: s390: pfmf: support conditional-sske facility
      KVM: s390: pfmf: handle address overflows
      s390/sclp: detect storage-key facility
      KVM: s390: trace and count all skey intercepts
      KVM: s390: handle missing storage-key facility

Janosch Frank (7):
      s390: hypfs: Move diag implementation and data definitions
      s390: Make cpc_name accessible
      s390: Make diag224 public
      KVM: s390: Add operation exception interception handler
      KVM: s390: Extend diag 204 fields
      KVM: s390: Add sthyi emulation
      KVM: s390: Limit sthyi execution

Martin Schwidefsky (1):
      s390/mm: set and get guest storage key mmap locking

 Documentation/virtual/kvm/api.txt        |   2 +
 Documentation/virtual/kvm/devices/vm.txt |  87 +++++-
 arch/s390/hypfs/hypfs_diag.c             | 375 +++++++-----------------
 arch/s390/include/asm/cpacf.h            |  10 +
 arch/s390/include/asm/diag.h             | 149 ++++++++++
 arch/s390/include/asm/kvm_host.h         |  10 +-
 arch/s390/include/asm/page.h             |   7 +-
 arch/s390/include/asm/pgtable.h          |   7 +-
 arch/s390/include/asm/sclp.h             |  23 +-
 arch/s390/include/uapi/asm/kvm.h         |  29 ++
 arch/s390/include/uapi/asm/sie.h         |   1 +
 arch/s390/kernel/diag.c                  |  37 +++
 arch/s390/kvm/Makefile                   |   2 +-
 arch/s390/kvm/diag.c                     |   5 +
 arch/s390/kvm/gaccess.c                  | 152 +++++-----
 arch/s390/kvm/intercept.c                |  15 +
 arch/s390/kvm/interrupt.c                |  26 +-
 arch/s390/kvm/kvm-s390.c                 | 255 +++++++++++++++--
 arch/s390/kvm/kvm-s390.h                 |   9 +
 arch/s390/kvm/priv.c                     | 219 +++++++++++---
 arch/s390/kvm/sthyi.c                    | 471 +++++++++++++++++++++++++++++++
 arch/s390/kvm/trace.h                    |  49 +++-
 arch/s390/mm/pgtable.c                   | 110 ++++++--
 drivers/s390/char/sclp_early.c           |  12 +-
 drivers/s390/char/sclp_ocf.c             |  23 +-
 25 files changed, 1623 insertions(+), 462 deletions(-)
 create mode 100644 arch/s390/kvm/sthyi.c
