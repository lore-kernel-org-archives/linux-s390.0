From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH v2] Update virtio spec for virtio-ccw.
Date: Tue,  4 Sep 2012 17:14:00 +0200
Message-ID: <1346771641-12136-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Rusty Russell <rusty@rustcorp.com.au>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi,

this is the second revision of the virtio-ccw spec.

The interface has been improved to support more than 32 feature bits
as well as allocating less that the requested queue size and specifying
alignment.

(Note: I folded the changes with git into my initial spec; I hope LyX can
handle this :)

Cornelia Huck (1):
  virtio-spec: Add virtio-ccw spec.

 virtio-spec.lyx |  534 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 534 insertions(+), 0 deletions(-)

-- 
1.7.5.4
