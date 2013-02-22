From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [RFC PATCH v2 0/2] qemu: ioeventfd for virtio-ccw.
Date: Fri, 22 Feb 2013 13:09:58 +0100
Message-ID: <1361535000-39210-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Here's the next version of ioeventfd support for virtio-ccw, again
against master.

v1 -> v2:
- Adapt to changed ioeventfd interface.

Cornelia Huck (2):
  linux-headers: Update with ioeventfd changes.
  virtio-ccw: Wire up ioeventfd.

 hw/s390x/css.c            |   2 +-
 hw/s390x/css.h            |   1 +
 hw/s390x/virtio-ccw.c     | 114 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/s390x/virtio-ccw.h     |   7 +++
 linux-headers/linux/kvm.h |   2 +
 target-s390x/cpu.h        |  16 +++++++
 target-s390x/kvm.c        |  18 ++++++++
 7 files changed, 159 insertions(+), 1 deletion(-)

-- 
1.7.12.4
