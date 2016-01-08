From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390: Feature and fix for 4.5
Date: Fri,  8 Jan 2016 10:14:36 +0100
Message-ID: <1452244478-151381-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

some last changes for kvm/s390 targetted for 4.5

The following changes since commit da3f7ca3e85642627a8db37ba337eb5f424339f1:

  Merge tag 'kvm-s390-next-4.5-2' of git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux into HEAD (2015-12-16 18:49:29 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-next-4.5-3

for you to fetch changes up to c6e5f166373a20a433c38a34bd16f2b62bd0864c:

  KVM: s390: implement the RI support of guest (2016-01-07 14:48:26 +0100)

----------------------------------------------------------------
KVM: s390: Feature and fix for 4.5

- allow the runtime instrumentation support inside the guests
- remove a useless memory barrier

----------------------------------------------------------------
Fan Zhang (1):
      KVM: s390: implement the RI support of guest

Michael S. Tsirkin (1):
      kvm/s390: drop unpaired smp_mb

 arch/s390/include/asm/kvm_host.h |  3 ++-
 arch/s390/include/uapi/asm/kvm.h |  3 +++
 arch/s390/kvm/kvm-s390.c         | 23 ++++++++++++++++++++++-
 include/uapi/linux/kvm.h         |  1 +
 4 files changed, 28 insertions(+), 2 deletions(-)
