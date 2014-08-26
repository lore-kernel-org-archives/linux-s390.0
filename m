From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 00/15] KVM: s390: Features and fixes for next (3.18)
Date: Tue, 26 Aug 2014 10:28:12 +0200
Message-ID: <1409041707-39938-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

The following changes since commit ab3f285f227fec62868037e9b1b1fd18294a83b8:

  KVM: s390/mm: try a cow on read only pages for key ops (2014-08-25 14:35:28 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-20140825

for you to fetch changes up to f079e9521464aa522d56af2a58a1666ca126bf6f:

  KVM: s390/mm: remove outdated gmap data structures (2014-08-26 10:09:03 +0200)


NOTE:
There is one non-s390 change in patch " KVM: clarify the idea of kvm_dirty_regs"
to Documentation/virtual/kvm/api.txt but this is actually an interface that is 
currently only used for s390. This update better describes the way it was intended
(and implemented) some years ago.

----------------------------------------------------------------
KVM: s390: Fixes and features for 3.18 part 1

1. The usual cleanups: get rid of duplicate code, use defines, factor
   out the sync_reg handling, additional docs for sync_regs, better
   error handling on interrupt injection
2. We use KVM_REQ_TLB_FLUSH instead of open coding tlb flushes
3. Additional registers for kvm_run sync regs. This is usually not
   needed in the fast path due to eventfd/irqfd, but kvm stat claims
   that we reduced the overhead of console output by ~50% on my system
4. A rework of the gmap infrastructure. This is the 2nd step towards
   host large page support (after getting rid of the storage key
   dependency). We introduces two radix trees to store the guest-to-host
   and host-to-guest translations. This gets us rid of most of
   the page-table walks in the gmap code. Only one in __gmap_link is left,
   this one is required to link the shadow page table to the process page
   table. Finally this contains the plumbing to support gmap page tables
   with less than 5 levels.

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: no special machine check delivery

David Hildenbrand (4):
      KVM: clarify the idea of kvm_dirty_regs
      KVM: s390: clear kvm_dirty_regs when dropping to user space
      KVM: s390: synchronize more registers with kvm_run
      KVM: s390: implement KVM_REQ_TLB_FLUSH and make use of it

Jens Freimann (4):
      KVM: s390: add defines for pfault init delivery code
      KVM: s390: factor out get_ilc() function
      KVM: s390: return -EFAULT if lowcore is not mapped during irq delivery
      KVM: s390: don't use kvm lock in interrupt injection code

Martin Schwidefsky (6):
      KVM: s390/mm: readd address parameter to pgste_ipte_notify
      KVM: s390/mm: readd address parameter to gmap_do_ipte_notify
      KVM: s390/mm: cleanup gmap function arguments, variable names
      KVM: s390/mm: use radix trees for guest to host mappings
      KVM: s390/mm: support gmap page tables with less than 5 levels
      KVM: s390/mm: remove outdated gmap data structures

 Documentation/virtual/kvm/api.txt |   4 +
 arch/s390/include/asm/pgalloc.h   |   8 +-
 arch/s390/include/asm/pgtable.h   |  72 ++--
 arch/s390/include/asm/tlb.h       |   2 +-
 arch/s390/include/uapi/asm/kvm.h  |  10 +
 arch/s390/kvm/diag.c              |   8 +-
 arch/s390/kvm/interrupt.c         | 145 +++-----
 arch/s390/kvm/kvm-s390.c          |  99 ++++--
 arch/s390/kvm/kvm-s390.h          |   5 +-
 arch/s390/kvm/priv.c              |  11 +-
 arch/s390/mm/fault.c              |  25 +-
 arch/s390/mm/pgtable.c            | 695 ++++++++++++++++++--------------------
 arch/s390/mm/vmem.c               |   2 +-
 13 files changed, 501 insertions(+), 585 deletions(-)
