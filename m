From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH] kvm-s390: Bugfix for handling of iscs.
Date: Thu,  7 Feb 2013 13:20:51 +0100
Message-ID: <1360239652-52350-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi,

here's another kvm-s390 bugfix for kvm-next, this time fixing a
thinko in the I/O interrupt injection.

Please apply.

Cornelia Huck (1):
  KVM: s390: Fix handling of iscs.

 arch/s390/kvm/interrupt.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

-- 
1.7.12.4
