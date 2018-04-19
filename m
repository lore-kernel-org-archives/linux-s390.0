From: Pierre Morel <pmorel@linux.vnet.ibm.com>
Subject: [PATCH 00/10] vfio: ccw: Refactoring the VFIO CCW state machine
Date: Thu, 19 Apr 2018 16:48:03 +0200
Message-ID: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, cohuck@redhat.com
List-ID: <linux-s390.vger.kernel.org>

The goal of the patch serie is to enhance the state machine by
centralizing all state changes inside the state machine wrapper
and have a clear view of state changes.

Doing this will:
- facilitate the introduction of new events received from QEMU
  (cancel/clear/stsh) or from the hardware (chr events).
- produce small, easy to maintain FSM functions with clear
  incoming events and outgoing states

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
- VFIO_CCW_EVENT_SCH_EVENT: Receiving a channel event (callback)
- VFIO_CCW_EVENT_ONLINE   : Channel is set online (admin)
- VFIO_CCW_EVENT_OFFLINE  : Channel is set offline (admin)

The ABI did not change, so a standard QEMU devel branch can be used.


Pierre Morel (10):
  vfio: ccw: Moving state change out of IRQ context
  vfio: ccw: Transform FSM functions to return state
  vfio: ccw: new SCH_EVENT event
  vfio: ccw: replace IO_REQ event with SSCH_REQ event
  vfio: ccw: Suppress unused event parameter
  vfio: ccw: Make FSM functions atomic
  vfio: ccw: Introduce the INIT event
  vfio: ccw: Handling reset and shutdown with states
  vfio: ccw: Suppressing the BOXED state
  vfio: ccw: Let user wait when busy on IO

 drivers/s390/cio/vfio_ccw_drv.c     | 120 +++++++-------------
 drivers/s390/cio/vfio_ccw_fsm.c     | 215 +++++++++++++++++++++++++-----------
 drivers/s390/cio/vfio_ccw_ops.c     |  58 +++++-----
 drivers/s390/cio/vfio_ccw_private.h |  21 +++-
 4 files changed, 232 insertions(+), 182 deletions(-)

-- 
2.7.4
