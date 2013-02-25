From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v3 0/2] qemu: ioeventfd for virtio-ccw.
Date: Mon, 25 Feb 2013 16:28:01 +0100
Message-ID: <1361806083-62838-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Alexander Graf <agraf@suse.de>
Cc: qemu-devel <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Here's the current version of my patch enabling ioeventfds for virtio-ccw.

The linux-headers patch only adds the new flag for ioeventfds.

Wiring up ioeventfds has improved performance drastically (up to twice
as fast for a simple dd). Notifier support is something we plan to do
next.

Please consider applying if this makes sense.

v2 -> v3:
- Adapt to changed ioeventfd interface again.
v1 -> v2:
- Adapt to changed ioeventfd interface.

Cornelia Huck (2):
  linux-headers: Update with ioeventfd changes.
  virtio-ccw: Wire up ioeventfd.

 hw/s390x/css.c            |   2 +-
 hw/s390x/css.h            |   1 +
 hw/s390x/virtio-ccw.c     | 114 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.h     |   7 +++
 linux-headers/linux/kvm.h |   3 ++
 target-s390x/cpu.h        |  16 +++++++
 target-s390x/kvm.c        |  19 ++++++++
 7 files changed, 161 insertions(+), 1 deletion(-)

-- 
1.7.12.4
