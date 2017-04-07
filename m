From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/9] KVM: s390: features for 4.12 (via kvm/next)
Date: Fri,  7 Apr 2017 12:47:53 +0200
Message-ID: <1491562082-6392-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

here are 4.12 features for s390.

Two things to consider:
1. the guarded storage kvm patch is based on the kernel patch from
   Martin. So I merged a topic branch from Martin that is based on
   torvalds/master between rc3 and rc4. So this pull request will
   effectively bump kvm/next from 4.11-rc3 to 4.11-rc3+. This will
   also result in diffstat looking different from belows diffstat.
2. To avoid another clash with the powerpc changes I did not fixup the
   numbers for KVM_CAP_S390_GS and KVM_CAP_S390_AIS. So there will be
   a merge conflict. Please fixup those numbers when merging.


The following changes since commit 916cda1aa1b412d7cf2991c3af7479544942d121:

  s390: add a system call for guarded storage (2017-03-22 08:14:25 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.12-1

for you to fetch changes up to 47a4693e1d3eb09e523c223753fb5a97721f49b8:

  KVM: s390: introduce AIS capability (2017-04-07 09:11:11 +0200)

----------------------------------------------------------------
KVM: s390: features for 4.12

1. guarded storage support for guests
   This contains an s390 base Linux feature branch that is necessary
   to implement the KVM part
2. Provide an interface to implement adapter interruption suppression
   which is necessary for proper zPCI support
3. Use more defines instead of numbers
4. Provide logging for lazy enablement of runtime instrumentation

----------------------------------------------------------------
Christian Borntraeger (3):
      KVM: s390: log runtime instrumentation enablement
      KVM: s390: Handle sthyi also for instruction intercept
      Merge remote-tracking branch 's390/guarded-storage' into kvms390/next

David Hildenbrand (1):
      KVM: s390: use defines for execution controls

Fan Zhang (1):
      KVM: s390: gs support for kvm guests

Farhan Ali (1):
      KVM: s390: Use defines for intercept code

Fei Li (2):
      KVM: s390: interface for suppressible I/O adapters
      KVM: s390: introduce ais mode modify function

Yi Min Zhao (2):
      KVM: s390: introduce adapter interrupt inject function
      KVM: s390: introduce AIS capability

 Documentation/virtual/kvm/api.txt               |  17 +++
 Documentation/virtual/kvm/devices/s390_flic.txt |  41 +++++++-
 arch/s390/include/asm/kvm_host.h                |  40 +++++++-
 arch/s390/include/uapi/asm/kvm.h                |  25 ++++-
 arch/s390/kvm/gaccess.c                         |   6 +-
 arch/s390/kvm/intercept.c                       |  24 ++---
 arch/s390/kvm/interrupt.c                       | 131 ++++++++++++++++++++++--
 arch/s390/kvm/kvm-s390.c                        | 127 +++++++++++++++++++----
 arch/s390/kvm/kvm-s390.h                        |   3 +-
 arch/s390/kvm/priv.c                            |  31 +++++-
 arch/s390/kvm/sthyi.c                           |   3 +
 arch/s390/kvm/trace-s390.h                      |  52 ++++++++++
 arch/s390/kvm/vsie.c                            |  72 ++++++++++---
 include/uapi/linux/kvm.h                        |   2 +
 14 files changed, 503 insertions(+), 71 deletions(-)
