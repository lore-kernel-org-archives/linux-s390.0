From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 0/5] virtio/s390 patches for -next
Date: Mon, 16 Jan 2017 15:04:28 +0100
Message-ID: <20170116140433.21301-1-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: mst@redhat.com
Cc: borntraeger@de.ibm.com, jasowang@redhat.com, virtualization@lists.linux-foundation.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Michael,

the following patches have all been posted in the past. I've
collected them on top of your vhost branch -- please let me
know whether this works for you.

The following changes since commit 6bdf1e0efb04a1716373646cb6f35b73addca492:

  Makefile: drop -D__CHECK_ENDIAN__ from cflags (2016-12-16 00:13:43 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/virtio-s390-20170116

for you to fetch changes up to 364cf19a474501cf157f1d09895ebab71e603c77:

  virtio/s390: virtio: constify virtio_config_ops structures (2017-01-16 12:26:07 +0100)

----------------------------------------------------------------
- ringtest fixes to make it work on s390
- support new READ_STATUS command
- minor cleanups

----------------------------------------------------------------

Bhumika Goyal (1):
  virtio/s390: virtio: constify virtio_config_ops structures

Colin Ian King (1):
  virtio/s390: add missing \n to end of dev_err message

Halil Pasic (2):
  tools/virtio/ringtest: fix run-on-all.sh for offline cpus
  tools/virtio/ringtest: tweaks for s390

Pierre Morel (1):
  virtio/s390: support READ_STATUS command for virtio-ccw

 drivers/s390/virtio/virtio_ccw.c    | 29 +++++++++++++++++++++++++++--
 tools/virtio/ringtest/main.h        | 12 ++++++++++++
 tools/virtio/ringtest/run-on-all.sh |  5 +++--
 3 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.11.0
