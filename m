From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 0/8] vfio: ccw: Refactoring the VFIO CCW state
 machine
Date: Wed, 13 Jun 2018 16:51:51 +0200
Message-ID: <20180613165151.056ecaec.cohuck@redhat.com>
References: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 12 Jun 2018 09:56:42 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> The goal of the patch serie is to secure the state machine by:
> - centralizing all state changes inside the state machine wrapper
> - make the state change atomic using mutexes
> - refactor the initialization to avoid using a subchannel without a guest
> 
> 
> This series introduces new states and events and suppressed
> others.
> Here the list of states and events used in this serie:

I've tried to come up with some annotations (without looking at the
code :); please correct me if I'm wrong. I want to understand the
design better.

> - VFIO_CCW_STATE_NOT_OPER    : when the Sub-Channel is KO

These are cases of "not operational, we can't even talk to it anymore",
right? If so, the only way out is unregistration of the subchannel,
unless we want to keep it around in case it revives and we get a machine
check. So this is likely a transient state?

> - VFIO_CCW_STATE_STANDBY     : when it is offline

Bound to the driver, but no mdev (and subchannel disabled). The target
states that could happen are either not oper (device gone; we notice
via machine check or when we try to enable the subchannel) or idle (we
enable the subchannel and make it ready for use). Non-transient state
(will stay there until something happens).

> - VFIO_CCW_STATE_IDLE        : when it is ready for I/O

Can go to not oper (device gone), standby (via quiescing?) or busy
(guest does I/O). Non-transient state.

> - VFIO_CCW_STATE_BUSY        : when it is busy doing I/O

Can go to idle (all done), or to not oper, I guess. Transient state.

> - VFIO_CCW_STATE_QUIESCING(N): when it is busy going offline

We're doing cancel/halt/clear. Target is standby, but can go to not
oper if device gone. Transient state.

The boxed state you're removing might have served as a non-transient
equivalent to busy (device does not respond, needs a kick to get out of
the state), but we can re-introduce it if we find it useful in the
future.

> 
> - VFIO_CCW_EVENT_INIT            : the channel setup (admin)

By "admin" you mean "action triggered by admin", right?

> - VFIO_CCW_EVENT_NOT_OPER        : something really wrong happened

That's device gone resp. not operational. Anything else?

I suppose that can only trigger as a reaction to some hardware
reconfiguration or malfunction.

> - VFIO_CCW_EVENT_IO_REQ          : Starting a SSCH request (UAPI)

Triggered by guest action.

> - VFIO_CCW_EVENT_INTERRUPT(N)    : Receiving an interrupt (callback)

Triggered by hardware.

> - VFIO_CCW_EVENT_SCHIB_CHANGED(N): Receiving a channel event (callback)

Also triggered by hardware? Can this also trigger a not oper event?

> 
> The user's ABI do not change.
> 
> 
> 
> Pierre Morel (8):
>   vfio: ccw: Moving state change out of IRQ context
>   vfio: ccw: Transform FSM functions to return state
>   vfio: ccw: new VFIO_CCW_EVENT_SCHIB_CHANGED event
>   vfio: ccw: Only accept SSCH as an IO request
>   vfio: ccw: Suppress unused event parameter
>   vfio: ccw: Make FSM functions atomic
>   vfio: ccw: Introduce the INIT event
>   vfio: ccw: Suppressing the BOXED state
> 
>  drivers/s390/cio/vfio_ccw_drv.c     |  71 ++++++-----------
>  drivers/s390/cio/vfio_ccw_fsm.c     | 147 +++++++++++++++++++++---------------
>  drivers/s390/cio/vfio_ccw_ops.c     |  41 +++++-----
>  drivers/s390/cio/vfio_ccw_private.h |  12 ++-
>  4 files changed, 137 insertions(+), 134 deletions(-)
> 
