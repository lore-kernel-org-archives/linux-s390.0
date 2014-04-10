From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/3]  Introduce per-vm kvm device attributes
Date: Thu, 10 Apr 2014 13:16:41 +0200
Message-ID: <1397128604-50161-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Dominik Dingel <dingel@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Marcelo, Gleb, Alex,

this is a followup to the recent discussion (re config device)

To avoid a bunch of new ioctl, lets reuse the device attributes on
the "VM device". All of these attributes are architecture specific.
Patch1 introduces the interface,
Patch2 makes CMMA configurable
Patch3 uses the interface introduced in patch1

Marcelo, Gleb, Alex, are you ok with the approach of patch 1? Then we
will continue using that for VM specific controls instead of adding
new ioctls. (Otherwise we will continue with new ioctl).

Dominik Dingel (3):
  kvm: s390: Per-vm kvm device controls
  kvm: s390: make cmma usage conditionally
  kvm: s390: Exploiting generic userspace interface for cmma

 Documentation/virtual/kvm/api.txt        |   8 +-
 Documentation/virtual/kvm/devices/vm.txt |  24 +++++
 arch/s390/include/asm/kvm_host.h         |   1 +
 arch/s390/include/uapi/asm/kvm.h         |   7 ++
 arch/s390/kvm/kvm-s390.c                 | 155 ++++++++++++++++++++++++++-----
 arch/s390/kvm/kvm-s390.h                 |   7 +-
 arch/s390/kvm/priv.c                     |   2 +-
 include/uapi/linux/kvm.h                 |   1 +
 8 files changed, 176 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/virtual/kvm/devices/vm.txt

-- 
1.8.4.2
