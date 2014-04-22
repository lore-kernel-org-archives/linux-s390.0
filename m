From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/54] KVM: s390: Features and Fixes for 3.16
Date: Tue, 22 Apr 2014 13:32:09 +0200
Message-ID: <1398166331-50704-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Marcelo, Gleb, Paolo,

here is an updated PULL request combining the previous pull requests
rebased against the new kvm/next.

As a followup email only the patches containing the device API documentation
are send everything else is the same or contains minor fixups/rebase changes.

See the tag message below for a summary of changes.

Christian

The following changes since commit 0f689a33ad17845363acdc6d52783befd6ad116c:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux (2014-04-16 11:28:25 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-20140422

for you to fetch changes up to e325fe69aa37b485635521568651642791d6d140:

  KVM: s390: Factor out handle_itdb to handle TX aborts (2014-04-22 13:24:54 +0200)

----------------------------------------------------------------
Lazy storage key handling
-------------------------
Linux does not use the ACC and F bits of the storage key. Newer Linux
versions also do not use the storage keys for dirty and reference
tracking. We can optimize the guest handling for those guests for faults
as well as page-in and page-out by simply not caring about the guest
visible storage key. We trap guest storage key instruction to enable
those keys only on demand.

Migration bitmap

Until now s390 never provided a proper dirty bitmap.  Let's provide a
proper migration bitmap for s390. We also change the user dirty tracking
to a fault based mechanism. This makes the host completely independent
from the storage keys. Long term this will allow us to back guest memory
with large pages.

per-VM device attributes
------------------------
To avoid the introduction of new ioctls, let's provide the
attribute semanantic also on the VM-"device".

Userspace controlled CMMA
-------------------------
The CMMA assist is changed from "always on" to "on if requested" via
per-VM device attributes. In addition a callback to reset all usage
states is provided.

Proper guest DAT handling for intercepts
----------------------------------------
While instructions handled by SIE take care of all addressing aspects,
KVM/s390 currently does not care about guest address translation of
intercepts. This worked out fine, because
- the s390 Linux kernel has a 1:1 mapping between kernel virtual<->real
 for all pages up to memory size
- intercepts happen only for a small amount of cases
- all of these intercepts happen to be in the kernel text for current
  distros

Of course we need to be better for other intercepts, kernel modules etc.
We provide the infrastructure and rework all in-kernel intercepts to work
on logical addresses (paging etc) instead of real ones. The code has
been running internally for several months now, so it is time for going
public.

GDB support
-----------
We provide breakpoints, single stepping and watchpoints.

Fixes/Cleanups
--------------
- Improve program check delivery
- Factor out the handling of transactional memory  on program checks
- Use the existing define __LC_PGM_TDB
- Several cleanups in the lowcore structure
- Documentation

NOTES
-----
- All patches touching base s390 are either ACKed or written by the s390
  maintainers
- One base KVM patch "KVM: add kvm_is_error_gpa() helper"
- One patch introduces the notion of VM device attributes

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: Drop pending interrupts on guest exit

Cornelia Huck (1):
      KVM: s390: reinject io interrupt on tpi failure

David Hildenbrand (8):
      KVM: s390: extract irq parameters of intercepted program irqs
      KVM: s390: deliver program irq parameters and use correct ilc
      KVM: s390: emulate stctl and stctg
      KVM: s390: kernel header addition for guest debugging
      KVM: s390: hardware support for guest debugging
      KVM: s390: add documentation for diag 501
      KVM: s390: move timer interrupt checks into own functions
      KVM: s390: no timer interrupts when single-stepping a guest

Dominik Dingel (8):
      KVM: s390: Adding skey bit to mmu context
      KVM: s390: Clear storage keys
      KVM: s390: Allow skeys to be enabled for the current process
      KVM: s390: Don't enable skeys by default
      KVM: s390/mm: new gmap_test_and_clear_dirty function
      KVM: s390: Per-vm kvm device controls
      KVM: s390: make cmma usage conditionally
      KVM: s390: Exploiting generic userspace interface for cmma

Heiko Carstens (27):
      KVM: add kvm_is_error_gpa() helper
      KVM: s390: export test_vfacility()
      s390/ptrace: add struct psw and accessor function
      s390/ctl_reg: add union type for control register 0
      KVM: s390: add kvm_s390_logical_to_effective() helper
      KVM: s390: add 'pgm' member to kvm_vcpu_arch and helper function
      KVM: s390: add lowcore access functions
      KVM: s390: add architecture compliant guest access functions
      KVM: s390/sclp: correctly set eca siif bit
      KVM: s390: make use of ipte lock
      KVM: s390: convert __do_deliver_interrupt()
      KVM: s390: convert handle_stfl()
      KVM: s390: convert pfault code
      KVM: s390: convert handle_prog()
      KVM: s390: convert kvm_s390_store_status_unloaded()
      KVM: s390: convert __sigp_set_prefix()/handle_set_prefix()
      KVM: s390: convert handle_set_clock()
      KVM: s390: convert handle_store_prefix()
      KVM: s390: convert handle_store_cpu_address()
      KVM: s390: convert handle_test_block()
      KVM: s390: convert handle_tpi()
      KVM: s390: convert handle_lpsw[e]()
      KVM: s390: convert handle_stidp()
      KVM: s390: convert handle lctl[g]()
      KVM: s390: convert handle_stsi()
      KVM: s390: remove old guest access functions
      KVM: s390: cleanup kvm_s390_real_to_abs()

Jason J. Herne (1):
      KVM: s390: Add proper dirty bitmap support to S390 kvm.

Jens Freimann (5):
      KVM: s390: allow injecting every kind of interrupt
      KVM: s390: convert local irqs in  __do_deliver_interrupt()
      s390: fix name of lowcore field at offset 0xa3
      s390: rename and split lowcore field per_perc_atmid
      s390: add fields to lowcore definition

Martin Schwidefsky (1):
      KVM: s390/mm: use software dirty bit detection for user dirty tracking

Michael Mueller (2):
      KVM: s390: replace TDB_ADDR by __LC_PGM_TDB
      KVM: s390: Factor out handle_itdb to handle TX aborts

 Documentation/virtual/kvm/api.txt        |   8 +-
 Documentation/virtual/kvm/devices/vm.txt |  26 ++
 Documentation/virtual/kvm/s390-diag.txt  |   2 +
 arch/s390/include/asm/ctl_reg.h          |  14 +
 arch/s390/include/asm/kvm_host.h         | 149 ++++++-
 arch/s390/include/asm/lowcore.h          |  10 +-
 arch/s390/include/asm/mmu.h              |   2 +
 arch/s390/include/asm/mmu_context.h      |   1 +
 arch/s390/include/asm/pgalloc.h          |   3 +-
 arch/s390/include/asm/pgtable.h          | 169 ++++----
 arch/s390/include/asm/ptrace.h           |  44 +++
 arch/s390/include/asm/sclp.h             |   7 +-
 arch/s390/include/uapi/asm/kvm.h         |  28 ++
 arch/s390/kernel/asm-offsets.c           |  14 +-
 arch/s390/kernel/entry.S                 |   4 +-
 arch/s390/kernel/entry64.S               |   4 +-
 arch/s390/kvm/Makefile                   |   4 +-
 arch/s390/kvm/diag.c                     |  15 +-
 arch/s390/kvm/gaccess.c                  | 645 +++++++++++++++++++++++++++++++
 arch/s390/kvm/gaccess.h                  | 373 ++++++++++++++----
 arch/s390/kvm/guestdbg.c                 | 481 +++++++++++++++++++++++
 arch/s390/kvm/intercept.c                | 110 +++++-
 arch/s390/kvm/interrupt.c                | 339 +++++++++++-----
 arch/s390/kvm/kvm-s390.c                 | 373 +++++++++++++-----
 arch/s390/kvm/kvm-s390.h                 |  59 ++-
 arch/s390/kvm/priv.c                     | 272 +++++++++----
 arch/s390/kvm/sigp.c                     |  12 +-
 arch/s390/kvm/trace.h                    |  39 ++
 arch/s390/mm/pgtable.c                   |  93 ++++-
 drivers/s390/char/sclp_early.c           |  22 +-
 include/linux/kvm_host.h                 |   7 +
 include/uapi/linux/kvm.h                 |   1 +
 virt/kvm/kvm_main.c                      |   2 -
 33 files changed, 2831 insertions(+), 501 deletions(-)
 create mode 100644 Documentation/virtual/kvm/devices/vm.txt
 create mode 100644 arch/s390/kvm/gaccess.c
 create mode 100644 arch/s390/kvm/guestdbg.c
