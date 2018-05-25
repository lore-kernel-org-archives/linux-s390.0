From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: [PATCH v2 00/10] vfio: ccw: Refactoring the VFIO CCW state machine
Date: Fri, 25 May 2018 12:21:08 +0200
Message-ID: <1527243678-3140-1-git-send-email-pmorel@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

The goal of the patch serie is to enhance the state machine by:
- centralizing all state changes inside the state machine wrapper
- make the state change atomic using mutexes
- change user busy waiting for a passive wait on completion
- refactoring the initialization to avoid using a subchannel without a guest


This series introduces new states and events and suppressed
others.
- VFIO_CCW_STATE_NOT_OPER : when the Sub-Channel is KO
- VFIO_CCW_STATE_STANDBY  : when it is offline
- VFIO_CCW_STATE_IDLE     : when it is ready for I/O
- VFIO_CCW_STATE_BUSY     : when it is busy doing I/O
- VFIO_CCW_STATE_QUIESCING: when it is busy going offline

- VFIO_CCW_EVENT_INIT     : the channel setup (admin)
- VFIO_CCW_EVENT_NOT_OPER : something really wrong happened
- VFIO_CCW_EVENT_SSCH_REQ : Starting an I/O request (UAPI)
- VFIO_CCW_EVENT_INTERRUPT: Receiving an interrupt (callback)
- VFIO_CCW_EVENT_SCHIB_CHANGED: Receiving a channel event (callback)
- VFIO_CCW_EVENT_ONLINE   : Channel is set online (admin)
- VFIO_CCW_EVENT_OFFLINE  : Channel is set offline (admin)

The ABI did not change a lot beside letting the user sleep
when the driver is busy doing a SSCH, so a standard QEMU
devel branch can be used.


Pierre Morel (10):
  vfio: ccw: Moving state change out of IRQ context
  vfio: ccw: Transform FSM functions to return state
  vfio: ccw: new SCH_EVENT event
  vfio: ccw: replace IO_REQ event with SSCH_REQ event
  vfio: ccw: Suppress unused event parameter
  vfio: ccw: Make FSM functions atomic
  vfio: ccw: FSM and mediated device initialization
  vfio: ccw: Handling reset and shutdown with states
  vfio: ccw: Suppressing the BOXED state
  vfio: ccw: Let user wait when busy on IO

 drivers/s390/cio/vfio_ccw_drv.c     | 112 +++++-------------
 drivers/s390/cio/vfio_ccw_fsm.c     | 218 ++++++++++++++++++++++++------------
 drivers/s390/cio/vfio_ccw_ops.c     |  62 +++++-----
 drivers/s390/cio/vfio_ccw_private.h |  18 ++-
 4 files changed, 219 insertions(+), 191 deletions(-)

-- 
2.7.4

Changelog:
- rebased on current Linux branch
- change the name of VFIO_CCW_EVENT_SCH_EVENT to
  VFIO_CCW_EVENT_SCHIB_CHANGED
- refactoring the initialization (mdev create/open
  and driver probe)
- return -EAGAIN to let the low level retry the
  sending of events
- make wait_for_completion interruptible
