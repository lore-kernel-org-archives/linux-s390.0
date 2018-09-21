From: Halil Pasic <pasic@linux.ibm.com>
Date: Fri, 21 Sep 2018 12:46:19 +0000
Subject: [PATCH 0/2]  virtio/s390: fix some races in virtio-ccw
Message-Id: <20180921124621.43649-1-pasic@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The trigger for the series is this bug report:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1788432

Changelog:
RFC -> v1:
* do mutual exclusion on a per device basis in ccw_io_helper() 

Halil Pasic (2):
  virtio/s390: avoid race on vcdev->config
  virtio/s390: fix race in ccw_io_helper()

 drivers/s390/virtio/virtio_ccw.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

-- 
2.16.4
