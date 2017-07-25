From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/1] KVM: s390: fixup missing srcu lock for 4.13 (kvm/master)
Date: Tue, 25 Jul 2017 15:21:05 +0200
Message-ID: <1500988866-28288-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Paolo, Radim,

The following changes since commit f1ff89ec4447c4e39d275a1ca3de43eed2a92745:

  kvm: x86: hyperv: avoid livelock in oneshot SynIC timers (2017-07-20 17:00:00 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-master-4.13-1

for you to fetch changes up to 4f899147424a189b0ad1fdd6f35784ed5a642e83:

  KVM: s390: take srcu lock when getting/setting storage keys (2017-07-25 14:59:52 +0200)

----------------------------------------------------------------
KVM: s390: fixup missing srcu lock

We need to hold the srcu lock when accessing memory slots
during migration

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: take srcu lock when getting/setting storage keys

 arch/s390/kvm/kvm-s390.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
