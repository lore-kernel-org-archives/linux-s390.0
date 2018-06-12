From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v3 0/8] vfio: ccw: Refactoring the VFIO CCW state machine
Date: Tue, 12 Jun 2018 09:56:42 +0200
Message-ID: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

The goal of the patch serie is to secure the state machine by:
- centralizing all state changes inside the state machine wrapper
- make the state change atomic using mutexes
- refactor the initialization to avoid using a subchannel without a guest


This series introduces new states and events and suppressed
others.
Here the list of states and events used in this serie:
- VFIO_CCW_STATE_NOT_OPER    : when the Sub-Channel is KO
- VFIO_CCW_STATE_STANDBY     : when it is offline
- VFIO_CCW_STATE_IDLE        : when it is ready for I/O
- VFIO_CCW_STATE_BUSY        : when it is busy doing I/O
- VFIO_CCW_STATE_QUIESCING(N): when it is busy going offline

- VFIO_CCW_EVENT_INIT            : the channel setup (admin)
- VFIO_CCW_EVENT_NOT_OPER        : something really wrong happened
- VFIO_CCW_EVENT_IO_REQ          : Starting a SSCH request (UAPI)
- VFIO_CCW_EVENT_INTERRUPT(N)    : Receiving an interrupt (callback)
- VFIO_CCW_EVENT_SCHIB_CHANGED(N): Receiving a channel event (callback)

The user's ABI do not change.



Pierre Morel (8):
  vfio: ccw: Moving state change out of IRQ context
  vfio: ccw: Transform FSM functions to return state
  vfio: ccw: new VFIO_CCW_EVENT_SCHIB_CHANGED event
  vfio: ccw: Only accept SSCH as an IO request
  vfio: ccw: Suppress unused event parameter
  vfio: ccw: Make FSM functions atomic
  vfio: ccw: Introduce the INIT event
  vfio: ccw: Suppressing the BOXED state

 drivers/s390/cio/vfio_ccw_drv.c     |  71 ++++++-----------
 drivers/s390/cio/vfio_ccw_fsm.c     | 147 +++++++++++++++++++++---------------
 drivers/s390/cio/vfio_ccw_ops.c     |  41 +++++-----
 drivers/s390/cio/vfio_ccw_private.h |  12 ++-
 4 files changed, 137 insertions(+), 134 deletions(-)

-- 
2.7.4

Changelog:

From v2 to v3:
- Concentrate more on securing the FSM:
 - abandonned ONLINE/OFFLINE events
 - abandonned make user wait on busy
 - abandonned switch case on command to keep old
   way of testing the START_SSCH bit in write syscall

From v1 to v2:
- rebased on current Linux branch
- change the name of VFIO_CCW_EVENT_SCH_EVENT to
  VFIO_CCW_EVENT_SCHIB_CHANGED
- refactoring the initialization (mdev create/open
  and driver probe)
- return -EAGAIN to let the low level retry the
  sending of events
- make wait_for_completion interruptible
