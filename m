From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 0/1] s390/virtio update
Date: Thu, 14 Dec 2017 10:59:53 +0100
Message-ID: <20171214095954.7615-1-cohuck@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: mst@redhat.com
Cc: jasowang@redhat.com, pasic@linux.vnet.ibm.com, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

The following changes since commit e073f74a5a39c6dc45f28a5006c21aa94490d9b8:

  Merge branch 'this' into vhost (2017-12-07 18:39:24 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/virtio-s390-20171214

for you to fetch changes up to 619b4b0ba832144d4be899640a2047f9675df849:

  virtio/s390: implement PM operations for virtio_ccw (2017-12-14 10:32:21 +0100)

----------------------------------------------------------------
Hibernation support for virtio-ccw.

----------------------------------------------------------------

Christian Borntraeger (1):
  virtio/s390: implement PM operations for virtio_ccw

 drivers/s390/virtio/virtio_ccw.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

-- 
2.13.6
