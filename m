From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 00/11] KVM: s390: Features and fixes for 4.1 (kvm/next)
Date: Wed, 18 Mar 2015 12:43:58 +0100
Message-ID: <1426679049-37696-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Marcelo,

here is the followup pull request. As Marcelo has not yet pushed out
queue or next to git.kernel.org, this request is based on the previous
s390 pull request and should merge without conflicts.

For details see tag description.

Christian

The following changes since commit 13211ea7b47db3d8ee2ff258a9a973a6d3aa3d43:

  KVM: s390: Enable vector support for capable guest (2015-03-06 13:49:35 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-20150318

for you to fetch changes up to 18280d8b4bcd4a2b174ee3cd748166c6190acacb:

  KVM: s390: represent SIMD cap in kvm facility (2015-03-17 16:33:14 +0100)

----------------------------------------------------------------
KVM: s390: Features and fixes for 4.1 (kvm/next)

1. Fixes
2. Implement access register mode in KVM
3. Provide a userspace post handler for the STSI instruction
4. Provide an interface for compliant memory accesses
5. Provide an interface for getting/setting the guest storage key
6. Fixup for the vector facility patches: do not announce the
   vector facility in the guest for old QEMUs.

1-5 were initially shown as RFC in

http://www.spinics.net/lists/kvm/msg114720.html

some small review changes
- added some ACKs
- have the AR mode patches first
- get rid of unnecessary AR_INVAL define
- typos and language

6. two new patches
The two new patches fixup the vector support patches that were
introduced in the last pull request for QEMU versions that dont
know about vector support and guests that do. (We announce the
facility bit, but dont enable the facility so vector aware guests
will crash on vector instructions).

----------------------------------------------------------------
Alexander Yarygin (4):
      KVM: s390: Fix low-address protection for real addresses
      KVM: s390: Guest's memory access functions get access registers
      KVM: s390: Optimize paths where get_vcpu_asce() is invoked
      KVM: s390: Add access register mode

Dominik Dingel (1):
      KVM: s390: cleanup jump lables in kvm_arch_init_vm

Ekaterina Tumanova (1):
      KVM: s390: introduce post handlers for STSI

Geert Uytterhoeven (1):
      KVM: s390: Spelling s/intance/instance/

Jason J. Herne (1):
      KVM: s390: Create ioctl for Getting/Setting guest storage keys

Michael Mueller (2):
      KVM: s390: drop SIMD bit from kvm_s390_fac_list_mask
      KVM: s390: represent SIMD cap in kvm facility

Thomas Huth (1):
      KVM: s390: Add MEMOP ioctls for reading/writing guest memory

 Documentation/virtual/kvm/api.txt | 132 +++++++++++++++++
 arch/s390/include/asm/kvm_host.h  |   2 +-
 arch/s390/kvm/diag.c              |   4 +-
 arch/s390/kvm/gaccess.c           | 294 +++++++++++++++++++++++++++++++-------
 arch/s390/kvm/gaccess.h           |  21 +--
 arch/s390/kvm/intercept.c         |   4 +-
 arch/s390/kvm/kvm-s390.c          | 238 +++++++++++++++++++++++++++---
 arch/s390/kvm/kvm-s390.h          |  38 ++++-
 arch/s390/kvm/priv.c              |  93 +++++++-----
 arch/s390/kvm/sigp.c              |   4 +-
 include/uapi/linux/kvm.h          |  46 ++++++
 11 files changed, 752 insertions(+), 124 deletions(-)
