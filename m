From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/9] KVM: s390: fixes and improvements for 4.15
Date: Fri, 10 Nov 2017 09:00:04 +0100
Message-ID: <20171110080013.111004-1-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

my small pull request for 4.15 for s390. It also contains a merge of
Martins/Heikos s390/sthyi branch to avoid potential merge conflicts.
This branch move the sthyi logic out of KVM into a shared function that
is now used by KVM and linux. I posted these patches here for reference,
the branch is already part of the s390/features branch of Martin/Heiko.

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.15-1

for you to fetch changes up to da9a1446d248f673a8560ce46251ff620214ab7b:

  KVM: s390: provide a capability for AIS state migration (2017-11-09 16:48:51 +0100)

----------------------------------------------------------------
KVM: s390: fixes and improvements for 4.15

- Some initial preparation patches for exitless interrupts and crypto
- New capability for AIS migration
- Fixes
- merge of the sthyi tree from the base s390 team, which moves the sthyi
out of KVM into a shared function also for non-KVM

----------------------------------------------------------------
Christian Borntraeger (3):
      Merge branch 'sthyi' of git://git.kernel.org/.../s390/linux into kvms390/next
      KVM: s390: document memory ordering for kvm_s390_vcpu_wakeup
      KVM: s390: provide a capability for AIS state migration

David Hildenbrand (1):
      KVM: s390: vsie: use common code functions for pinning

Michael Mueller (2):
      KVM: s390: abstract conversion between isc and enum irq_types
      KVM: s390: clear_io_irq() requests are not expected for adapter interrupts

QingFeng Hao (3):
      s390/sthyi: reorganize sthyi implementation
      s390/sthyi: add cache to store hypervisor info
      s390/sthyi: add s390_sthyi system call

Tony Krowiak (1):
      KVM: s390: SIE considerations for AP Queue virtualization

 Documentation/virtual/kvm/api.txt               |   9 ++
 Documentation/virtual/kvm/devices/s390_flic.txt |   5 +
 arch/s390/include/asm/kvm_host.h                |  26 +++-
 arch/s390/include/asm/sysinfo.h                 |   1 +
 arch/s390/include/uapi/asm/sthyi.h              |   6 +
 arch/s390/include/uapi/asm/unistd.h             |   3 +-
 arch/s390/kernel/Makefile                       |   2 +-
 arch/s390/kernel/compat_wrapper.c               |   1 +
 arch/s390/kernel/entry.h                        |   1 +
 arch/s390/{kvm => kernel}/sthyi.c               | 184 +++++++++++++++---------
 arch/s390/kernel/syscalls.S                     |   1 +
 arch/s390/kvm/Makefile                          |   2 +-
 arch/s390/kvm/intercept.c                       |  56 ++++++++
 arch/s390/kvm/interrupt.c                       |  26 +++-
 arch/s390/kvm/kvm-s390.c                        |   3 +-
 arch/s390/kvm/kvm-s390.h                        |   5 +-
 arch/s390/kvm/vsie.c                            |  50 +++----
 include/linux/kvm_host.h                        |   1 +
 include/uapi/linux/kvm.h                        |   1 +
 virt/kvm/kvm_main.c                             |   4 +-
 20 files changed, 268 insertions(+), 119 deletions(-)
 create mode 100644 arch/s390/include/uapi/asm/sthyi.h
 rename arch/s390/{kvm => kernel}/sthyi.c (77%)
