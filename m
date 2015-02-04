From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/7] KVM: s390: fixes and features for kvm/next (3.20)
Date: Wed,  4 Feb 2015 10:44:45 +0100
Message-ID: <1423043092-34044-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

here is my remaining bunch of patches for 3.20 for review. All patches
have been in linux-next via
git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git next
(well a tiny fix went in today, so the commit id for the last 3 patches
has changed)

I think it makes sense to give some of these patches some more days
for external review. Is it ok to send a pull request early next week
or do you want it before 3.19?

There is one non-KVM s390 patch, but it has an ACK from Heiko Carstens

Christian Borntraeger (1):
  KVM: s390: reenable LPP facility

David Hildenbrand (1):
  KVM: s390: floating irqs: fix user triggerable endless loop

Ekaterina Tumanova (1):
  s390/kernel: Update /proc/sysinfo file with Extended Name and UUID

Jason J. Herne (1):
  KVM: s390: Create ioctl for Getting/Setting guest storage keys

Michael Mueller (2):
  KVM: s390: use facilities and cpu_id per KVM
  KVM: s390: add cpu model support

Tony Krowiak (1):
  KVM: s390/CPACF: Choose crypto control block format

 Documentation/virtual/kvm/api.txt        |  58 +++++
 Documentation/virtual/kvm/devices/vm.txt |  45 ++++
 arch/s390/include/asm/kvm_host.h         |  27 ++-
 arch/s390/include/asm/sysinfo.h          |  10 +-
 arch/s390/include/uapi/asm/kvm.h         |  21 ++
 arch/s390/kernel/sysinfo.c               |  29 +++
 arch/s390/kvm/gaccess.c                  |   4 +-
 arch/s390/kvm/interrupt.c                |   2 +
 arch/s390/kvm/kvm-s390.c                 | 394 ++++++++++++++++++++++++++++---
 arch/s390/kvm/kvm-s390.h                 |  13 +-
 arch/s390/kvm/priv.c                     |  13 +-
 include/uapi/linux/kvm.h                 |  14 ++
 12 files changed, 580 insertions(+), 50 deletions(-)

-- 
1.9.3
