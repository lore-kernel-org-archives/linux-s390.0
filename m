From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH 00/22] KVM/s390: Hugetlbfs enablement
Date: Mon,  6 Nov 2017 23:29:38 +0100
Message-ID: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Since the z10 s390 does support 1M pages, but whereas hugetlbfs
support was added quite fast, KVM always used standard 4k pages for
guest backings.

This patchset adds full support for 1M huge page backings for s390
KVM guests. I.e. we also support VSIE (nested vms) for these guests
and are therefore able to run all combinations of backings for all
layers of guests.

When running a VSIE guest in a huge page backed guest, we need to
split some huge pages to be able to set granular protection. This way
we avoid a prot/unprot cycle if prefixes and VSIE pages containing
level 3 gmap DAT tables share the same segment, as the prefix has to
be accessible at all times and the VSIE page has to be write
protected.

TODO:
* Cleanups & Documentation
* Refactoring to get rid of a lot of indents
* Storage key support for split pages
* Regression testing
* Testing large setups
* Testing multi level VSIE

Accomplished testing:
l2: KVM guest
l3: nested KVM guest

* 1m l2 guests
* VSIE (l3) 4k and 1m guests on 1m l2
* 1m l2 -> l2 migration with 4k/1m l3 guests
* l3 -> l2 migration
* postcopy works every second try, seems to be QEMU or my setup


The initial prototype was started by Dominik Dingel. I had the
pleasure of adding the VSIE part, the protection transfers and the
optimizations. A huge thanks to Christian and Martin who review(ed)
and helped debugging/designing.


Dominik Dingel (2):
  s390/mm: hugetlb pages within a gmap can not be freed
  s390/mm: clear huge page storage keys on enable_skey

Janosch Frank (20):
  s390/mm: make gmap_protect_range more modular
  s390/mm: Abstract gmap notify bit setting
  s390/mm: add gmap PMD invalidation notification
  s390/mm: Add gmap pmd invalidation and clearing
  s390/mm: Introduce gmap_pmdp_xchg
  RFC: s390/mm: Transfer guest pmd protection to host
  s390/mm: Add huge page dirty sync support
  s390/mm: Add huge pmd storage key handling
  s390/mm: Remove superfluous parameter
  s390/mm: Add gmap_protect_large read protection support
  s390/mm: Make gmap_read_table EDAT1 compatible
  s390/mm: Make protect_rmap EDAT1 compatible
  s390/mm: GMAP read table extensions
  s390/mm: Add shadow segment code
  s390/mm: Add VSIE reverse fake case
  s390/mm: Remove gmap_pte_op_walk
  s390/mm: Split huge pages if granular protection is needed
  s390/mm: Enable gmap huge pmd support
  KVM: s390: Add KVM HPAGE capability
  RFC: s390/mm: Add gmap lock classes

 arch/s390/include/asm/gmap.h    |   39 +-
 arch/s390/include/asm/pgtable.h |   12 +-
 arch/s390/kvm/gaccess.c         |   64 +-
 arch/s390/kvm/kvm-s390.c        |   18 +-
 arch/s390/mm/fault.c            |   10 +-
 arch/s390/mm/gmap.c             | 1296 +++++++++++++++++++++++++++++++++++----
 arch/s390/mm/pageattr.c         |    6 +-
 arch/s390/mm/pgtable.c          |  143 ++++-
 include/uapi/linux/kvm.h        |    1 +
 9 files changed, 1421 insertions(+), 168 deletions(-)

-- 
2.7.4
