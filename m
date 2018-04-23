From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH v2 0/5] vfio: ccw: error handling fixes and improvements
Date: Mon, 23 Apr 2018 13:01:08 +0200
Message-ID: <20180423110113.59385-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com, pasic@linux.ibm.com, pmorel@linux.ibm.com, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Dear Reviewers,

Here is a new version for this patch series.

We didn't get agreement on patch #5 (#4 in v1) in the former cycle though,
I made it based on my understanding. We can continue discussing on it.

Changelog:
v1->v2:
 - #1. Reworded commit message and comment, plus some typo fixes.
 - #2. New patch.
 - #3. Added the missing suggested-by Pierre.
       Fixed typos.
       Added sanity check on pa->pa_iova_pfn and updated comments accordingly.
 - #4. Removed unused idaw_nr.
 - #5. Replaced leading white spaces with TABs.
       Traced the function in anycase.

Dong Jia Shi (3):
  vfio: ccw: shorten kernel doc description for pfn_array_pin()
  vfio: ccw: refactor and improve pfn_array_alloc_pin()
  vfio: ccw: set ccw->cda to NULL defensively

Halil Pasic (2):
  vfio: ccw: fix cleanup if cp_prefetch fails
  vfio: ccw: add traceponits for interesting error paths

 drivers/s390/cio/Makefile         |   1 +
 drivers/s390/cio/vfio_ccw_cp.c    | 134 ++++++++++++++++++++------------------
 drivers/s390/cio/vfio_ccw_fsm.c   |  16 ++++-
 drivers/s390/cio/vfio_ccw_trace.h |  77 ++++++++++++++++++++++
 4 files changed, 164 insertions(+), 64 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_trace.h

-- 
2.13.5
