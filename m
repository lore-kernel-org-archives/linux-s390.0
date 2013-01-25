From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 0/3] s390/kvm fixes
Date: Fri, 25 Jan 2013 15:34:14 +0100
Message-ID: <1359124457-51126-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Marcelo Tossati <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Gleb, Marcelo,

here are 3 kvm fixes for kvm-next.

Christian Borntraeger (3):
  s390/kvm: Fix store status for ACRS/FPRS
  s390/virtio-ccw: Fix setup_vq error handling.
  s390/kvm: Fix instruction decoding

 arch/s390/kvm/kvm-s390.c      |  8 ++++++++
 arch/s390/kvm/kvm-s390.h      | 25 ++++++++++++++-----------
 drivers/s390/kvm/virtio_ccw.c | 20 +++++++++++---------
 3 files changed, 33 insertions(+), 20 deletions(-)

-- 
1.7.12.4
