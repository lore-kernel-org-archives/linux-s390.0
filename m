Return-Path: <SRS0=+MMY=S7=vger.kernel.org=kvm-owner@kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 00/12] KVM: s390: Features and fixes for kvm/next
Date: Mon, 29 Apr 2019 11:09:50 +0200
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20190429091002.71164-1-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

Nothing big this time. Some fixes and new hardware features.
Please pull

The following changes since commit 79a3aaa7b82e3106be97842dedfd8429248896e6:

  Linux 5.1-rc3 (2019-03-31 14:39:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-5.2-1

for you to fetch changes up to b2d0371d2e374facd45e115d3668086df13730ff:

  KVM: s390: vsie: Return correct values for Invalid CRYCB format (2019-04-29 09:01:22 +0200)

----------------------------------------------------------------
KVM: s390: Features and fixes for 5.2

- VSIE crypto fixes
- new guest features for gen15
- disable halt polling for nested virtualization with overcommit

----------------------------------------------------------------
Christian Borntraeger (9):
      KVM: s390: add vector enhancements facility 2 to cpumodel
      KVM: s390: add vector BCD enhancements facility to cpumodel
      KVM: s390: add MSA9 to cpumodel
      KVM: s390: provide query function for instructions returning 32 byte
      KVM: s390: add enhanced sort facilty to cpu model
      KVM: s390: add deflate conversion facilty to cpu model
      KVM: s390: enable MSA9 keywrapping functions depending on cpu model
      KVM: polling: add architecture backend to disable polling
      KVM: s390: provide kvm_arch_no_poll function

Eric Farman (1):
      KVM: s390: Fix potential spectre warnings

Pierre Morel (2):
      KVM: s390: vsie: Do not shadow CRYCB when no AP and no keys
      KVM: s390: vsie: Return correct values for Invalid CRYCB format

 Documentation/virtual/kvm/devices/vm.txt |   3 +-
 arch/s390/include/asm/cpacf.h            |   1 +
 arch/s390/include/asm/kvm_host.h         |   2 +
 arch/s390/include/uapi/asm/kvm.h         |   5 +-
 arch/s390/kvm/Kconfig                    |   1 +
 arch/s390/kvm/interrupt.c                |  11 ++-
 arch/s390/kvm/kvm-s390.c                 | 117 ++++++++++++++++++++++++++++++-
 arch/s390/kvm/vsie.c                     |  13 ++--
 arch/s390/tools/gen_facilities.c         |   3 +
 include/linux/kvm_host.h                 |  10 +++
 tools/arch/s390/include/uapi/asm/kvm.h   |   3 +-
 virt/kvm/Kconfig                         |   3 +
 virt/kvm/kvm_main.c                      |   2 +-
 13 files changed, 163 insertions(+), 11 deletions(-)
