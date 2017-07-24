From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 0/1] vfio-ccw: one bugfix for 4.12
Date: Mon, 24 Jul 2017 18:47:00 +0200
Message-ID: <20170724164701.26715-1-cohuck@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: bjsdjshi@linux.vnet.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

The following changes since commit 97ca7bfc19605bc08e9183441b8b8545e84032d6:

  s390/mm: set change and reference bit on lazy key enablement (2017-07-13 11:28:29 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20170724

for you to fetch changes up to c389377c01bf2d6e2a178e86aef8535931bfbd75:

  vfio: ccw: fix bad ptr math for TIC cda translation (2017-07-24 09:54:37 +0200)

----------------------------------------------------------------
A bugfix in the ccw translation code.

----------------------------------------------------------------
Jason J. Herne (1):
      vfio: ccw: fix bad ptr math for TIC cda translation

 drivers/s390/cio/vfio_ccw_cp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


Jason J. Herne (1):
  vfio: ccw: fix bad ptr math for TIC cda translation

 drivers/s390/cio/vfio_ccw_cp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.13.3
