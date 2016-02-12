From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 00/18] KVM: s390: Fixes and features for kvm/next (4.6)
Date: Fri, 12 Feb 2016 14:22:44 +0100
Message-ID: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

here is the first set of patches for s390/kvm targetting the next merge 
window for 4.6 (kvm/next)
This time with less testing than usual on the branch itself, as 4.5-rc3
is broken in several ways (with fixes or workarounds or people working on
the issues). So this time these patches have been partially tested against
a 4.4 base and partially tested agains kvm/next :-/

The following changes since commit bce87cce88c71957c56479809db8316a836ec8b1:

  KVM: x86: consolidate different ways to test for in-kernel LAPIC (2016-02-09 16:57:45 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.6-1

for you to fetch changes up to 1763f8d09d522b3ac998229dcf038476e88b78fc:

  KVM: s390: bail out early on fatal signal in dirty logging (2016-02-10 13:12:57 +0100)

----------------------------------------------------------------
KVM: s390: Fixes and features for kvm/next (4.6)

1. also provide the floating point registers via sync regs
2. Separate out intruction vs. data accesses
3. Fix program interrupts in some cases
4. Documentation fixes
5. dirty log improvements for huge guests

----------------------------------------------------------------
Christian Borntraeger (3):
      KVM: s390: do not take mmap_sem on dirty log query
      KVM: s390: do not block CPU on dirty logging
      KVM: s390: bail out early on fatal signal in dirty logging

Cornelia Huck (1):
      KVM: s390: usage hint for adapter mappings

David Hildenbrand (14):
      KVM: s390: allow sync of fp registers via vregs
      KVM: s390: sync of fp registers via kvm_run
      KVM: s390: PSW forwarding / rewinding / ilc rework
      KVM: s390: migration / injection of prog irq ilc
      KVM: s390: gaccess: introduce access modes
      KVM: s390: gaccess: implement instruction fetching mode
      KVM: s390: read the correct opcode on SIE faults
      KVM: s390: clean up prog irq injection on prog irq icpts
      KVM: s390: irq delivery should not rely on icptcode
      KVM: s390: provide prog irq ilc on SIE faults
      KVM: s390: instruction-fetching exceptions on SIE faults
      KVM: s390: remove old fragment of vector registers
      KVM: s390: add documentation of KVM_S390_VM_TOD
      KVM: s390: add documentation of KVM_S390_VM_CRYPTO

 Documentation/virtual/kvm/devices/s390_flic.txt |  2 +
 Documentation/virtual/kvm/devices/vm.txt        | 52 +++++++++++++++++
 arch/s390/include/asm/kvm_host.h                |  8 +--
 arch/s390/include/uapi/asm/kvm.h                |  8 ++-
 arch/s390/kvm/gaccess.c                         | 57 +++++++++---------
 arch/s390/kvm/gaccess.h                         | 38 ++++++++++--
 arch/s390/kvm/intercept.c                       | 78 +++++++++++++++----------
 arch/s390/kvm/interrupt.c                       | 40 ++++++-------
 arch/s390/kvm/kvm-s390.c                        | 55 +++++++++++------
 arch/s390/kvm/kvm-s390.h                        | 17 +++++-
 arch/s390/kvm/priv.c                            | 13 +++--
 include/uapi/linux/kvm.h                        |  8 ++-
 12 files changed, 254 insertions(+), 122 deletions(-)
