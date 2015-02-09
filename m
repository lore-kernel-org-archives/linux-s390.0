From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/7] KVM: s390: fixes and features for kvm/next (3.20)
Date: Mon,  9 Feb 2015 13:33:40 +0100
Message-ID: <1423485227-51721-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

some minor changes since last posting
- I dropped the storage key interface due to some review comments
- added the removal of compat support on s390

The following changes since commit f7819512996361280b86259222456fcf15aad926:

  kvm: add halt_poll_ns module parameter (2015-02-06 13:08:37 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-20150209

for you to fetch changes up to de8e5d744051568c8aad35c1c2dcf8fd137d10c9:

  KVM: Disable compat ioctl for s390 (2015-02-09 12:44:14 +0100)

----------------------------------------------------------------
KVM: s390: fixes and features for kvm/next (3.20)

1. Fixes
- Fix user triggerable endless loop
- reenable LPP facility
- disable KVM compat ioctl on s390 (untested and broken)

2. cpu models for s390
- provide facilities and instruction blocking per VM
- add s390 specific vm attributes for setting values

3. crypto
- toleration patch for z13 support

4. add uuid and long name to /proc/sysinfo (stsi 322)
- patch Acked by Heiko Carstens (touches non-kvm s390 code)

----------------------------------------------------------------
Christian Borntraeger (2):
      KVM: s390: reenable LPP facility
      KVM: Disable compat ioctl for s390

David Hildenbrand (1):
      KVM: s390: floating irqs: fix user triggerable endless loop

Ekaterina Tumanova (1):
      s390/kernel: Update /proc/sysinfo file with Extended Name and UUID

Michael Mueller (2):
      KVM: s390: use facilities and cpu_id per KVM
      KVM: s390: add cpu model support

Tony Krowiak (1):
      KVM: s390/CPACF: Choose crypto control block format

 Documentation/virtual/kvm/devices/vm.txt |  45 +++++
 arch/s390/include/asm/kvm_host.h         |  27 ++-
 arch/s390/include/asm/sysinfo.h          |  10 +-
 arch/s390/include/uapi/asm/kvm.h         |  21 +++
 arch/s390/kernel/sysinfo.c               |  29 ++++
 arch/s390/kvm/gaccess.c                  |   4 +-
 arch/s390/kvm/interrupt.c                |   2 +
 arch/s390/kvm/kvm-s390.c                 | 273 +++++++++++++++++++++++++++----
 arch/s390/kvm/kvm-s390.h                 |  13 +-
 arch/s390/kvm/priv.c                     |  13 +-
 virt/kvm/Kconfig                         |   4 +
 virt/kvm/kvm_main.c                      |  12 +-
 12 files changed, 397 insertions(+), 56 deletions(-)
