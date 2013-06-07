From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH RFC] qemu: Adapter interrupts for virtio-ccw.
Date: Fri,  7 Jun 2013 12:37:07 +0200
Message-ID: <1370601428-23447-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>, virtualization@lists.linux-foundation.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

here's the qemu patch that implements the new adapter indicators ccw
in virtio-ccw and injects adapter interrupts for the devices enabled
for it.

Cornelia Huck (1):
  s390/virtio-ccw: Adapter interrupt support.

 hw/s390x/css.c        |   10 ++++++++
 hw/s390x/css.h        |    2 ++
 hw/s390x/virtio-ccw.c |   66 ++++++++++++++++++++++++++++++++++++++++++++++++-
 hw/s390x/virtio-ccw.h |    4 +++
 target-s390x/ioinst.h |    2 ++
 target-s390x/kvm.c    |    8 ++++--
 trace-events          |    1 +
 7 files changed, 90 insertions(+), 3 deletions(-)

-- 
1.7.9.5
