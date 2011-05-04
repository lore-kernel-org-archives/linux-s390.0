From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 0/3] virtio-net: 64 bit features, event index
Date: Thu, 5 May 2011 00:01:48 +0300
Message-ID: <cover.1304542880.git.mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kvm-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org
Cc: Rusty Russell <rusty@rustcorp.com.au>, Carsten Otte <cotte@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Shirley Ma <xma@us.ibm.com>, lguest@lists.ozlabs.org, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Krishna Kumar <krkumar2@in.ibm.com>, Tom Lendacky <tahm@linux.vnet.ibm.com>, steved@us.ibm.com, habanero@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

OK, here's a patch that implements the virtio spec update that I
sent earlier. It supercedes the PUBLISH_USED_IDX patches
I sent out earlier.

Support is added in both userspace and vhost-net.

I see nice performance improvements: e.g. from 12 to 18 Gbit/s host
to guest with netperf, but did not spend a lot of time testing
performance. I hope others will try this out and report.

Note: there are 2 new features, reducing the number
of interrupts (used_event) and of exits (avail_event).

If you see issues or are just curious, you can
turn them off separately. For example:

-global virtio-net-pci.avail_event=on -global
virtio-net-pci.used_event=on -global virtio-blk-pci.avail_event=off
-global virtio-blk-pci.used_event=off

Also, it's possible to try both vhost-net and virtio-net.

Michael S. Tsirkin (3):
  virtio/vhost: support 64 bit features
  virtio+vhost: used_event feature
  virtio: avail_event index support

 hw/qdev-properties.c   |   39 +++++++++++++---
 hw/qdev.h              |   10 ++++
 hw/s390-virtio-bus.c   |    5 +-
 hw/s390-virtio-bus.h   |    2 +-
 hw/syborg_virtio.c     |    7 ++-
 hw/vhost_net.c         |   20 +++++++--
 hw/vhost_net.h         |    4 +-
 hw/virtio-9p.c         |    2 +-
 hw/virtio-balloon.c    |    2 +-
 hw/virtio-blk.c        |    2 +-
 hw/virtio-blk.h        |    2 +-
 hw/virtio-net.c        |   11 +++--
 hw/virtio-net.h        |   34 +++++++-------
 hw/virtio-pci.c        |   91 +++++++++++++++++++++++++++----------
 hw/virtio-serial-bus.c |    2 +-
 hw/virtio.c            |  116 ++++++++++++++++++++++++++++++++++++++++++------
 hw/virtio.h            |   27 ++++++++---
 17 files changed, 284 insertions(+), 92 deletions(-)

-- 
1.7.5.53.gc233e
