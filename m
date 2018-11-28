From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 0/6] vfio: ccw: VFIO CCW cleanup part1
Date: Wed, 28 Nov 2018 13:41:01 +0100
Message-ID: <1543408867-16465-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com
Cc: cohuck@redhat.com, farman@linux.ibm.com, alifm@linux.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The goal of the patches of this serie is to clarify the code
of state/event handling.

- First patch (already acked/applied) makes sure that every structures are initialized
  before the mediated device is registered.
  (Only here to apply the serie on the main tree).

- vfio: ccw: Rework subchannel state on setup
  makes sure that the device can not be used before a guest is
  ready to drive it.

- vfio: ccw: Rework subchannel state on removing
  could be squash with the previous: same kind of rewriting
  but for the removing/release callbacks.

- vfio: ccw: Rework subchannel state on sch_event
  sch_event handling seems quite poor to me.
  Anyway, I do not understand why we hould have state change there.

- vfio: ccw: Documenting state transitions

- vfio: ccw: serialize the write system calls
  Quite independent of the previous patches, this makes sure
  that the entry in the driver is serialized.

Pierre Morel (6):
  vfio: ccw: Register mediated device once all structures are
    initialized
  vfio: ccw: Rework subchannel state on setup
  vfio: ccw: Rework subchannel state on removing
  vfio: ccw: Rework subchannel state on sch_event
  vfio: ccw: Documenting state transitions
  vfio: ccw: serialize the write system calls

 Documentation/s390/vfio-ccw.txt     | 45 +++++++++++++++++++++++++
 drivers/s390/cio/vfio_ccw_async.c   | 11 +++++++
 drivers/s390/cio/vfio_ccw_drv.c     | 30 ++++-------------
 drivers/s390/cio/vfio_ccw_ops.c     | 65 ++++++++++++++++++++++++-------------
 drivers/s390/cio/vfio_ccw_private.h |  1 +
 5 files changed, 105 insertions(+), 47 deletions(-)

-- 
2.7.4

Changelog:

from v2:
- adaptation after Conny's hlt/clr patches
- integration of Conny's comments
- reworking of the state changes to make it clearer
- added documentation
- added serialization

from v1:
- change commit message
- add reviewed-by from Eric (Really this time)

from v0:
- isolate these two patches from the previous serie
- Added Reviewed-by Eric
- Ortographic correction
