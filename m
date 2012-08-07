From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH] Update virtio spec for virtio-ccw.
Date: Tue,  7 Aug 2012 16:52:57 +0200
Message-ID: <1344351178-18972-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

here's an update to the virtio spec describing the basics of
the virtio-ccw mechanism.

Cornelia Huck (1):
  virtio-spec: Add virtio-ccw spec.

 virtio-spec.lyx |  433 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 433 insertions(+), 0 deletions(-)

-- 
1.7.5.4
