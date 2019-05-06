Return-Path: <SRS0=l9rD=TG=vger.kernel.org=kvm-owner@kernel.org>
From: Pierre Morel <pmorel@linux.ibm.com>
Subject: [PATCH v1 0/2] New state handling for VFIO CCW
Date: Mon,  6 May 2019 15:11:08 +0200
Message-Id: <1557148270-19901-1-git-send-email-pmorel@linux.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: cohuck@redhat.com
Cc: pasic@linux.vnet.ibm.com, farman@linux.ibm.com, alifm@linux.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi,

I did not integrate all my patches for state handling like I had
before but just two patches which seems interresting to me:

- The first one allows the device ti be used only when a guest
  is currently using it.
  Otherwise the device is in NOT_OPER state
 
- The second rework the sch_event callback: AFAIU we can not
  consider that the event moves the device in IDLE state.
  I think we better let it as it is currently.

Regards,
Pierre

Pierre Morel (2):
  vfio-ccw: Set subchannel state STANDBY on open
  vfio-ccw: rework sch_event

 drivers/s390/cio/vfio_ccw_drv.c     | 21 ++-------------------
 drivers/s390/cio/vfio_ccw_fsm.c     |  7 +------
 drivers/s390/cio/vfio_ccw_ops.c     | 36 ++++++++++++++++++------------------
 drivers/s390/cio/vfio_ccw_private.h |  1 -
 4 files changed, 21 insertions(+), 44 deletions(-)

-- 
2.7.4
