From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 0/2] KVM: s390: Fixes for kvm/next (3.17)
Date: Thu, 31 Jul 2014 09:59:00 +0200
Message-ID: <1406793542-3043-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Gleb Natapov <gleb@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Paolo,

The following changes since commit b55a8144d1807f9e74c51cb584f0dd198483d86c:

  x86/kvm: Resolve shadow warning from min macro (2014-07-25 16:05:54 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git  tags/kvm-s390-20140730

for you to fetch changes up to db3738614767e1f2dfe69afca070d7bc46266cca:

  KVM: s390: rework broken SIGP STOP interrupt handling (2014-07-31 09:20:35 +0200)

----------------------------------------------------------------
Two fixes for recently introduced regressions
- a memory leak on busy SIGP
- pontentially lost SIGP stop in rare situations (shutdown loops)

The first issue is not part of a released kernel. The 2nd issue is
present in all KVM versions, but did not trigger before commit
7dfc63cf977447e09b1072911c2 (KVM: s390: allow only one SIGP STOP
(AND STORE STATUS) at a time) with Linux as a guest.
So no need for cc stable

----------------------------------------------------------------
Christian Borntraeger (1):
      KVM: s390: Fix memory leak on busy SIGP stop

David Hildenbrand (1):
      KVM: s390: rework broken SIGP STOP interrupt handling

 arch/s390/kvm/interrupt.c | 3 +++
 arch/s390/kvm/sigp.c      | 1 +
 2 files changed, 4 insertions(+)
