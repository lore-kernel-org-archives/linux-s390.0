From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 25 Oct 2018 17:15:18 +0000
Subject: [PATCH v2 0/2] vfio: ccw: VFIO CCW cleanup part1
Message-Id: <1540487720-11634-1-git-send-email-pmorel@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The goal of the patches of this serie is to clarify the code
and to prepare for a better state/event handling.

Pierre Morel (2):
  vfio: ccw: Merge BUSY and BOXED states
  vfio: ccw: Register mediated device once all structures are
    initialized

 drivers/s390/cio/vfio_ccw_drv.c     | 8 ++++----
 drivers/s390/cio/vfio_ccw_fsm.c     | 7 +------
 drivers/s390/cio/vfio_ccw_private.h | 1 -
 3 files changed, 5 insertions(+), 11 deletions(-)

-- 
2.17.0


Changelog:

from v1:
- change commit message
- add reviewed-by from Eric (Really this time)

from v0:
- isolate these two patches from the previous serie
- Added Reviewed-by Eric
- Ortographic correction
