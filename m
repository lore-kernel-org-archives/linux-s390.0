From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 00/11] KVM: s390: Several changes for 3.19 (kvm/next)
Date: Fri, 28 Nov 2014 14:25:28 +0100
Message-ID: <1417181139-25623-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

here is a bunch of changes dealing mostly with architectural compliance.
I have deferred the TOD clock interface (as well as a storage key
read/write) as we found some issues in our final internal review.
Depending on Linus schedule these might have to wait for the next merge
window or might still come next week as I want to gives other a chance
to comment on interface changes.

The following changes since commit b65d6e17fe2239c9b2051727903955d922083fbf:

  kvm: x86: mask out XSAVES (2014-11-23 18:33:37 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-20141128

for you to fetch changes up to fc2020cfe9f8102d17dad79ed96dc68a9d84b19e:

  KVM: s390: allow injecting all kinds of machine checks (2014-11-28 13:59:05 +0100)

----------------------------------------------------------------
KVM: s390: Several fixes,cleanups and reworks

Here is a bunch of fixes that deal mostly with architectural compliance:
- interrupt priorities
- interrupt handling
- intruction exit handling

We also provide a helper function for getting the guest visible storage key.

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: trigger the right CPU exit for floating interrupts

David Hildenbrand (1):
      KVM: s390: external param not valid for cpu timer and ckc

Jason J. Herne (1):
      KVM: S390: Create helper function get_guest_storage_key

Jens Freimann (6):
      KVM: s390: refactor interrupt injection code
      KVM: s390: add defines for virtio and pfault interrupt code
      KVM: s390: refactor interrupt delivery code
      KVM: s390: add bitmap for handling cpu-local interrupts
      KVM: s390: handle pending local interrupts via bitmap
      KVM: s390: allow injecting all kinds of machine checks

Thomas Huth (2):
      KVM: s390: Small fixes for the PFMF handler
      KVM: s390: Fix rewinding of the PSW pointing to an EXECUTE instruction

 arch/s390/include/asm/kvm_host.h |   90 +++-
 arch/s390/include/asm/pgalloc.h  |    1 +
 arch/s390/kvm/intercept.c        |   20 +-
 arch/s390/kvm/interrupt.c        | 1037 +++++++++++++++++++++++++-------------
 arch/s390/kvm/kvm-s390.c         |   14 +-
 arch/s390/kvm/kvm-s390.h         |   11 +-
 arch/s390/kvm/priv.c             |   23 +-
 arch/s390/kvm/sigp.c             |   36 +-
 arch/s390/mm/pgtable.c           |   39 ++
 9 files changed, 872 insertions(+), 399 deletions(-)
