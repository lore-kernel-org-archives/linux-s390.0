From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL v2 0/1] s390/virtio update
Date: Mon, 18 Dec 2017 17:21:22 +0100
Message-ID: <20171218162123.963-1-cohuck@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: mst@redhat.com
Cc: jasowang@redhat.com, pasic@linux.vnet.ibm.com, linux-s390@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

The following changes since commit 20677394b78ed4c4baa09c9a1bcfdf24d2b09fe4:

  Merge branch 'vhost' into vhost-next (2017-12-18 08:21:38 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/linux.git tags/virtio-s390-20171218-v2

for you to fetch changes up to 352d303fa99330e5d197afcc28b5270734e5c541:

  virtio/s390: implement PM operations for virtio_ccw (2017-12-18 10:23:47 +0100)

----------------------------------------------------------------
Hibernation support for virtio-ccw.

----------------------------------------------------------------

Christian Borntraeger (1):
  virtio/s390: implement PM operations for virtio_ccw

 drivers/s390/virtio/virtio_ccw.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

-- 
2.13.6
