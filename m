From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 19 Sep 2018 08:47:48 +0000
Subject: [RFC 00/14] KVM: s390: Huge page splitting and shadowing
Message-Id: <20180919084802.183381-1-frankja@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Let's continue with the hpage updates and introduce splitting as well
as VSIE support. A lot of problems have been fixed since I introduced
these patches the last time. Swapping and loaded migration tests have
been successful.

The locking is now done via the userspace mm pmd lock instead of the
guest_table_lock, which fixed a lot of potential locking problems
between pgtable.c and gmap.c functions.

VSIE handling has been slightly redesigned to handle all combinations
instead of only edge cases.

Split pages are being modified by common pgtable.c functions as much
as possible and got pgste locking before modifications.

There's still a lot of cleanup and documentation to do, but let's put
it out there.

Branch:
git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git hlp_vsie
https://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git/log/?h=hlp_vsie

Janosch Frank (14):
  s390/mm: Code cleanups
  s390/mm: Improve locking for huge page backings
  s390/mm: Take locking out of gmap_protect_pte
  s390/mm: split huge pages in GMAP when protecting
  s390/mm: Split huge pages when migrating
  s390/mm: Provide vmaddr to pmd notification
  s390/mm: Add gmap_idte_global
  s390/mm: Make gmap_read_table EDAT1 compatible
  s390/mm: Make gmap_protect_rmap EDAT1 compatible
  s390/mm: Add simple ptep shadow function
  s390/mm: Add gmap shadowing for large pmds
  s390/mm: Add gmap lock classes
  s390/mm: Pull pmd invalid check in gmap_pmd_op_walk
  KVM: s390: Allow the VSIE to be used with huge pages

 Documentation/virtual/kvm/api.txt |   7 +-
 arch/s390/include/asm/gmap.h      |  31 +-
 arch/s390/include/asm/pgtable.h   |   5 +
 arch/s390/kvm/gaccess.c           |  52 ++-
 arch/s390/kvm/kvm-s390.c          |  14 +-
 arch/s390/mm/gmap.c               | 905 ++++++++++++++++++++++++++++----------
 arch/s390/mm/pgtable.c            |  61 ++-
 7 files changed, 806 insertions(+), 269 deletions(-)

-- 
2.14.3
