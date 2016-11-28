From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390: Changes for 4.10 (via kvm/next)
Date: Mon, 28 Nov 2016 10:06:36 +0100
Message-ID: <1480323998-210045-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

several things in the making but not ready yet. So here is a very
small set of patches for the next merge window.

The following changes since commit 813ae37e6aed72cc457094b6066aa38efd66c9e9:

  Merge branch 'x86/cpufeature' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip into kvm/next (2016-11-16 22:07:36 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.10-1

for you to fetch changes up to e1788bb995befed5831c99cee6527dfb080a46c0:

  KVM: s390: handle floating point registers in the run ioctl not in vcpu_put/load (2016-11-22 19:32:35 +0100)

----------------------------------------------------------------
KVM: s390: Changes for 4.10 (via kvm/next)

Two small optimizations to not do register reloading in
vcpu_put/get, instead do it in the ioctl path. This reduces
the overhead for schedule-intense workload that does not
exit to QEMU. (e.g. KVM guest with eventfd/irqfd that
does a lot of context switching with vhost or iothreads).

----------------------------------------------------------------
Christian Borntraeger (2):
      KVM: s390: handle access registers in the run ioctl not in vcpu_put/load
      KVM: s390: handle floating point registers in the run ioctl not in vcpu_put/load

 arch/s390/kvm/interrupt.c |  2 +-
 arch/s390/kvm/kvm-s390.c  | 57 +++++++++++++++++++++--------------------------
 2 files changed, 27 insertions(+), 32 deletions(-)
