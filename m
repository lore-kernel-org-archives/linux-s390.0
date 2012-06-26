From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 0/6] kvm/s390: sigp related changes for 3.6
Date: Tue, 26 Jun 2012 16:06:35 +0200
Message-ID: <1340719601-11867-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Avi, Marcelo,

here are some more s390 patches for the next release.

Patches 1 and 2 are included for dependency reasons; they will also
be sent through Martin's s390 tree.

The other patches fix several problems in our sigp handling code
and make it nicer to read.

Cornelia Huck (1):
  KVM: s390: Fix sigp sense handling.

Heiko Carstens (5):
  s390/smp: remove redundant check
  s390/smp/kvm: unifiy sigp definitions
  KVM: s390: fix sigp sense running condition code handling
  KVM: s390: fix sigp set prefix status stored cases
  KVM: s390: use sigp condition code defines

 arch/s390/include/asm/sigp.h |   32 ++++++++++++
 arch/s390/kernel/smp.c       |   76 ++++++++++-----------------
 arch/s390/kvm/sigp.c         |  117 +++++++++++++++++-------------------------
 3 files changed, 106 insertions(+), 119 deletions(-)
 create mode 100644 arch/s390/include/asm/sigp.h

-- 
1.7.10.4
