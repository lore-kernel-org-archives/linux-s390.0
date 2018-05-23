From: Dong Jia Shi <bjsdjshi@linux.ibm.com>
Subject: [PATCH v3 0/4] vfio: ccw: error handling fixes and improvements
Date: Wed, 23 May 2018 04:44:58 +0200
Message-ID: <20180523024502.94244-1-bjsdjshi@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.ibm.com, pasic@linux.ibm.com, pmorel@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dear Reviewers,

Here is a new version for this patch series.

We didn't get agreement on patch #4 (#5 in v2) in the former cycle though,
I made it based on my understanding. We can continue discussing on it.

Changelog:
v2->v3:
 - #2. Reworded comment message.
 - #4. Trace failure only, trace all error path, and a common knob for all
       failure paths.

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

Halil Pasic (1):
  vfio: ccw: add traceponits for interesting error paths

 drivers/s390/cio/Makefile         |   1 +
 drivers/s390/cio/vfio_ccw_cp.c    | 121 +++++++++++++++++++-------------------
 drivers/s390/cio/vfio_ccw_fsm.c   |  17 +++++-
 drivers/s390/cio/vfio_ccw_trace.h |  54 +++++++++++++++++
 4 files changed, 130 insertions(+), 63 deletions(-)
 create mode 100644 drivers/s390/cio/vfio_ccw_trace.h

-- 
2.16.3
