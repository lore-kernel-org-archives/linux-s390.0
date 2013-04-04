From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH] KVM: s390: virtio-ccw bugfix.
Date: Thu,  4 Apr 2013 10:25:05 +0200
Message-ID: <1365063906-61392-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Hi,

another virtio-ccw bugfix for a problem where we would not reset
old I/O errors. Please apply.

Cornelia Huck (1):
  KVM: s390: virtio_ccw: reset errors for new I/O.

 drivers/s390/kvm/virtio_ccw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

-- 
1.7.12.4
