From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PULL 0/1] vfio-ccw: one patch
Date: Mon, 22 May 2017 16:21:16 +0200
Message-ID: <20170522142117.29775-1-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The following changes since commit 2ea659a9ef488125eb46da6eb571de5eae5c43f6:

  Linux 4.12-rc1 (2017-05-13 13:19:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20170522

for you to fetch changes up to 5bf185366bfca4ab7730c607f530188e1591a4c0:

  s390/vfio_ccw: make some symbols static (2017-05-22 15:37:11 +0200)

----------------------------------------------------------------
Make some symbols in vfio-ccw static, as detected by sparse.

----------------------------------------------------------------

Sebastian Ott (1):
  s390/vfio_ccw: make some symbols static

 drivers/s390/cio/vfio_ccw_ops.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

-- 
2.13.0
