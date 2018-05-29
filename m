From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 0/6] vfio-ccw updates for 4.18
Date: Tue, 29 May 2018 14:35:06 +0200
Message-ID: <20180529123512.14393-1-cohuck@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

The following changes since commit 3376d98021e915196f4894d835325a884e635a04:

  s390/archrandom: Rework arch random implementation. (2018-05-25 08:12:58 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvms390/vfio-ccw.git tags/vfio-ccw-20180529

for you to fetch changes up to 3cd90214b70f7f971496bffc3c34d23b2141feb3:

  vfio: ccw: add tracepoints for interesting error paths (2018-05-29 09:27:42 +0200)

----------------------------------------------------------------
Various fixes and improvements in vfio-ccw, including a first stab
at adding tracepoints.

----------------------------------------------------------------

Dong Jia Shi (4):
  vfio: ccw: fix error return in vfio_ccw_sch_event
  vfio: ccw: shorten kernel doc description for pfn_array_pin()
  vfio: ccw: refactor and improve pfn_array_alloc_pin()
  vfio: ccw: set ccw->cda to NULL defensively

Halil Pasic (2):
  vfio: ccw: push down unsupported IDA check
  vfio: ccw: add tracepoints for interesting error paths

 drivers/s390/cio/Makefile         |   1 +
 drivers/s390/cio/vfio_ccw_cp.c    | 140 ++++++++++++++++++++------------------
 drivers/s390/cio/vfio_ccw_drv.c   |   5 +-
 drivers/s390/cio/vfio_ccw_fsm.c   |  17 ++++-
 drivers/s390/cio/vfio_ccw_trace.h |  54 +++++++++++++++
 5 files changed, 150 insertions(+), 67 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_trace.h

-- 
2.14.3
