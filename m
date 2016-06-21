From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 00/51] KVM: s390: vSIE (nested virtualization) feature for 4.8 (kvm/next)
Date: Tue, 21 Jun 2016 15:12:38 +0200
Message-ID: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

here is the first shot of nested virtualization for kvm/s390.
It requires an updated qemu[1] and the nested module parameter to
work. We are able to start multiple nested guests and are also
able to run nested under nested. As there are certainly still
some rough edges, the default of the nested paramter is off.

[1] https://github.com/cohuck/qemu/tree/cpumodel-s390x

This request has 
1. a change in include/linux/page_ref.h (with an ack from Andrew)
2. several changes in s390 base memory managedment (patches are either
   from Martin or acked-by martin)
3. a potential conflict with Paolos "speed up context-tracking system calls"
   series.

The following changes since commit 64672c95ea4c2f7096e519e826076867e8ef0938:

  kvm: vmx: hook preemption timer support (2016-06-16 10:07:50 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.8-2

for you to fetch changes up to a411edf1320ed8fa3b4560902ac4e033c4a72bcf:

  KVM: s390: vsie: add module parameter "nested" (2016-06-21 09:43:47 +0200)

----------------------------------------------------------------
KVM: s390: vSIE (nested virtualization) feature for 4.8 (kvm/next)

With an updated QEMU this allows to create nested KVM guests
(KVM under KVM) on s390.

s390 memory management changes from Martin Schwidefsky or
acked by Martin. One common code memory management change (pageref)
acked by Andrew Morton.

The feature has to be enabled with the nested medule parameter.

----------------------------------------------------------------
David Hildenbrand (45):
      s390/mm: flush tlb of shadows in all situations
      s390/mm: shadow pages with real guest requested protection
      s390/mm: avoid races on region/segment/page table shadowing
      s390/mm: fix races on gmap_shadow creation
      s390/mm: take the mmap_sem in kvm_s390_shadow_fault()
      s390/mm: protection exceptions are corrrectly shadowed
      s390/mm: take ipte_lock during shadow faults
      s390/mm: push ste protection down to shadow pte
      s390/mm: prepare for EDAT1/EDAT2 support in gmap shadow
      s390/mm: support EDAT1 for gmap shadows
      s390/mm: support EDAT2 for gmap shadows
      s390/mm: push rte protection down to shadow pte
      s390/mm: support real-space for gmap shadows
      s390/mm: limit number of real-space gmap shadows
      s390/mm: remember the int code for the last gmap fault
      s390/mm: allow to check if a gmap shadow is valid
      s390/mm: don't fault everything in read-write in gmap_pte_op_fixup()
      KVM: s390: fast path for shadow gmaps in gmap notifier
      KVM: s390: backup the currently enabled gmap when scheduled out
      s390: introduce page_to_virt() and pfn_to_virt()
      mm/page_ref: introduce page_ref_inc_return
      KVM: s390: vsie: initial support for nested virtualization
      KVM: s390: vsie: optimize gmap prefix mapping
      KVM: s390: vsie: support setting the ibc
      KVM: s390: vsie: support edat1 / edat2
      KVM: s390: vsie: support host-protection-interruption
      KVM: s390: vsie: support STFLE interpretation
      KVM: s390: vsie: support aes dea wrapping keys
      KVM: s390: vsie: support transactional execution
      KVM: s390: vsie: support vectory facility (SIMD)
      KVM: s390: vsie: support run-time-instrumentation
      KVM: s390: vsie: support 64-bit-SCAO
      KVM: s390: vsie: support shared IPTE-interlock facility
      KVM: s390: vsie: support guest-PER-enhancement
      KVM: s390: vsie: support guest-storage-limit-suppression
      KVM: s390: vsie: support intervention-bypass
      KVM: s390: vsie: support conditional-external-interception
      KVM: s390: vsie: support IBS interpretation
      KVM: s390: vsie: try to refault after a reported fault to g2
      KVM: s390: vsie: speed up VCPU irq delivery when handling vsie
      KVM: s390: don't use CPUSTAT_WAIT to detect if a VCPU is idle
      KVM: s390: vsie: speed up VCPU external calls
      KVM: s390: vsie: correctly set and handle guest TOD
      KVM: s390: vsie: add indication for future features
      KVM: s390: vsie: add module parameter "nested"

Martin Schwidefsky (6):
      s390/kvm: page table invalidation notifier
      s390/mm: use RCU for gmap notifier list and the per-mm gmap list
      s390/mm: extended gmap pte notifier
      s390/mm: add reference counter to gmap structure
      s390/mm: add shadow gmap support
      s390/mm: add kvm shadow fault function

 arch/s390/include/asm/gmap.h        |   82 +-
 arch/s390/include/asm/kvm_host.h    |   21 +-
 arch/s390/include/asm/mmu.h         |   11 +-
 arch/s390/include/asm/mmu_context.h |    3 +-
 arch/s390/include/asm/page.h        |    2 +
 arch/s390/include/asm/pgalloc.h     |    2 +
 arch/s390/include/asm/pgtable.h     |   10 +-
 arch/s390/include/asm/processor.h   |    2 +
 arch/s390/include/uapi/asm/kvm.h    |   12 +
 arch/s390/kvm/Makefile              |    2 +-
 arch/s390/kvm/gaccess.c             |  239 ++++++
 arch/s390/kvm/gaccess.h             |    3 +
 arch/s390/kvm/interrupt.c           |    5 +
 arch/s390/kvm/kvm-s390.c            |  111 ++-
 arch/s390/kvm/kvm-s390.h            |   10 +-
 arch/s390/kvm/priv.c                |    1 +
 arch/s390/kvm/sigp.c                |   10 +-
 arch/s390/kvm/vsie.c                | 1091 ++++++++++++++++++++++++
 arch/s390/mm/fault.c                |    2 +
 arch/s390/mm/gmap.c                 | 1590 +++++++++++++++++++++++++++++++++--
 arch/s390/mm/pgalloc.c              |   39 +-
 arch/s390/mm/pgtable.c              |  103 ++-
 include/linux/page_ref.h            |    9 +
 23 files changed, 3219 insertions(+), 141 deletions(-)
 create mode 100644 arch/s390/kvm/vsie.c
