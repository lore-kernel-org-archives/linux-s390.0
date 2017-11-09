From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 0/1] vfio-ccw: bugfix
Date: Thu,  9 Nov 2017 17:21:19 +0100
Message-ID: <20171109162120.27453-1-cohuck@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: bjsdjshi@linux.vnet.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

The following changes since commit 978fa72e82e375764e6e31e7a721408c5186918f:

  s390: remove named saved segment support (2017-11-08 09:47:54 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20171109

for you to fetch changes up to 408358b50deaf59b07c82a7bff8c7e7cce031fae:

  s390: vfio-ccw: Do not attempt to free no-op, test and tic cda. (2017-11-08 14:39:53 +0100)

----------------------------------------------------------------
A vfio-ccw bugfix: avoid freeing that which should not be freed.

----------------------------------------------------------------

Jason J. Herne (1):
  s390: vfio-ccw: Do not attempt to free no-op, test and tic cda.

 drivers/s390/cio/vfio_ccw_cp.c | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.13.6
