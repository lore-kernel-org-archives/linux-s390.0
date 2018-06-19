From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 0/8] vfio: ccw: Refactoring the VFIO CCW state
 machine
Date: Tue, 19 Jun 2018 16:00:45 +0200
Message-ID: <20180619160045.13caf12e.cohuck@redhat.com>
References: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
        <20180613165151.056ecaec.cohuck@redhat.com>
        <bd5fb44e-3395-63bc-23a5-b9b6a8a8f1ef@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bd5fb44e-3395-63bc-23a5-b9b6a8a8f1ef@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 14 Jun 2018 10:06:31 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> I tried to make a better description to add later in documentation
> or in the next cover-letter.
> 
> Note that in the current patch series I did not implement online/offline
> events but just kept the previous state changes.
> Not sure if it was a good idea, the goal was to be as simple as possible
> for this iteration.
> If you think it is worth to continue in this direction I will re-introduce
> these as events.

I'm still trying to figure out what we want from the state machine.
I've tried sketching your fsm proposal as outlined by you below for
myself and I have some remarks :)

> 
> ======================
> 
> 1) In CCW VFIO, Finite State Machine is used to clarify the VFIO CCW driver
> actions to be take depending on the events occurring in a device.
> 
> To protect the state transitions, a mutex protect the action
> started when an event occurs in a specific state.
> 
> The actions must never sleep or keep the mutex a long timer.
> 
> To be able to take the mutex when hardware events occur we start
> a work on a dedicated workqueue, posting the event from inside the
> workqueue.
> 
> The state machine has very few states describing the device driver life.
> 
> ------------------------------------------------------------
> | NOT_OPERATIONAL  | No guest is associated with the device|

I don't think that this is the right description. It is either the
initial state, or something has happened that rendered the device
inaccessible.

Also, we need to be careful with the virtual machine vs. guest
terminology. The only thing that has an impact from the guest is when
it does I/O and when an interrupt is generated as a result (i.e., the
IDLE/BUSY transitions). The other transitions are triggered by virtual
machine setup.

> ------------------------------------------------------------
> | STANDBY          | A guest is associated but not started |

This is basically "device is bound to driver, but no mdev has been set
up". In my understanding, we need to get the device to IDLE state
before the vm can present it to the guest (be it before the machine is
up or during hotplug).

> ------------------------------------------------------------
> | IDLE             | Guest started device ready            |

Agree with "device ready", disagree with "guest started" (see above).
"Device ready, accepting I/O requests"?

> ------------------------------------------------------------
> | BUSY             | The device is busy doing IO           |
> ------------------------------------------------------------
> | QUIESCING        | The driver is releasing the device    |

Now you are talking about the driver :) This should probably be done
for the other states as well.

Isn't that state for waiting for outstanding I/O to be terminated
before the mdev is destroyed? IOW, the device may stay bound to the
driver afterwards?

> ------------------------------------------------------------
> 
> 
> 2) The following Events may apply to the state machine:
> 
> If the event is not described, it means it has no influence
> on the state and that no action is required.
> 
> 2.1) FSM in state NOT_OPERATIONAL
> ------------------------------------------------------------
> | INIT             | a guest will drive the SC             |

Better to write out "subchannel", I could not figure out the
abbreviation immediately.

Also, doesn't the event really mean "we're initializing the device"?
The ultimate intention is of course for a guest to use the device, but
the immediate intention is just "get the device through the first
initialization steps".

> | |                                       |
> |                  | triggered by: mdev_open               |
> |                  | action: initialize driver structures  |
> |                  | action: register IOMMU notifier       |
> |                  | state on success: STANDBY             |
> |                  | state on error  : NOT_OPERATIONAL     |
> ------------------------------------------------------------
> 
> 2.2) FSM in state STANDBY
> 
> ------------------------------------------------------------
> | ONLINE           | The host wants the SC online          |

Isn't that rather "an mdev is created"?

> | |                                       |
> |                  | triggered by: vfio_reset              |
> |                  | action: enable SC                     |
> |                  | state on success: IDLE                |
> |                  | state on error  : STANDBY             |

What happens if the subchannel is not operational when we try to get it
ready? Can it go to NOT_OPERATIONAL in that case?

> ------------------------------------------------------------
> 
> Some operations may be intercepted by the state machine but
> will not induce a state change:
> OFFLINE: re-issue the disabling of the SC

Should that even be possible? If we're still busy tearing it down,
shouldn't we be in QUIESCING state?

> IRQ    : re-issue the disabling of the SC

Either we should have cleared the subchannel out during QUIESCING, or
we got an unsolicited interrupt. The latter can be avoided if we make
sure that the device is disabled when we go to STANDBY.

> 
> 2.3) FSM in state IDLE
> 
> ------------------------------------------------------------
> | SSCH             | The guest issue the ssch instruction  |
> | |                                       |
> |                  | triggered by: vfio_write SSCH=1       |
> |                  | action: start an IO request           |
> |                  | state on success: BUSY                |
> |                  | state on error  : IDLE                |

Should there be any way to drop to NOT_OPERATIONAL as well? We'll
probably get a notification from the common I/O layer if that happens,
though.

> ------------------------------------------------------------
> 2.4) FSM in states IDLE or BUSY
> 
> ------------------------------------------------------------
> | IRQ              | The hardware issue an interrupt       |

I think we can get this in QUIESCING as well, and it is an indication
that QUIESCING is done (for final states).

If the subchannel is enabled while in STANDBY, we could get an
interrupt there as well.

> | |                                       |
> |                  | triggered by: vfio_ccw_sch_irq        |
> |                  | action: update SCSW forward IRQ       |
> |                  | state on success: IDLE                |

One thing to consider (and I'm not sure we're handling it correctly
right now): What if we don't have a final status for the I/O yet, i.e.
there will be another interrupt for the I/O? Should we stay in BUSY in
that case?

> |                  | state on error  : IDLE                |

Hm, what error?

> ------------------------------------------------------------
> 
> ------------------------------------------------------------
> | OFFLINE          | The host wants the SC offline         |

That's mdev teardown, I guess?

> | |                                       |
> |                  | triggered by: css remove              |
> |                  | triggered by: css shutdown            |

These as well.

> |                  | action: disable SC                    |
> |                  | state on success: STANDBY             |

If it's really a css remove (unbind from driver or device removal), it
should not really have a target state, as the vfio-ccw device will be
gone, no? This is only correct for mdev removal.

> |                  | state on error  : NOT_OPERATIONAL     |
> ------------------------------------------------------------
> 
> ------------------------------------------------------------
> | STORE_SCHIB      | The hardware issue "schib updated"    |

This is the common I/O layer's sch_event callback. That can mean
different things:
- Something regarding the paths to the device changed. We can translate
  that to "schib updated".
- Device is gone. This is a different situation; we may either try to
  implement the disconnected state, or we may give up the device.

Also, can't we get this event in QUIESCING or STANDBY as well?

> | |                                       |
> |                  | triggered by: sch_event               |
> |                  | action: Store the SCHIB in IO region  |
> |                  | state on success: no change           |

As said, we may want some different handling for "device gone"
situations.

Also, what happens if we get that event in BUSY? Is the I/O still
running?

> |                  | state on error  : NOT_OPERATIONAL     |
> ------------------------------------------------------------
> 
> NOTE 1:
>     All out of band IO related instructions, XSCH, CSCH, HSCH
>     can be started in both states IDLE and BUSY.

Hm. What do you mean by "out of band"?

You can, of course, get all of the instructions above in both IDLE and
BUSY states. The question is what we want to do with them. Do we want
to put them through to the hardware in any case? If we do e.g. a hsch
and get a cc 2, we don't want to drop to IDLE, but stay in BUSY (as the
start function is likely still running).

What about RSCH?

> 
> NOTE 2:
>     Currently IRQ means solicited interrupt, but handle both
>     solicited and unsolicited interrupts.
>     The unsolicited interrupt event may be implemented separatly.

We need to be ready for unsolicited interrupts at any point in time. It
mainly depends on the state whether we want to forward them to the
guest (BUSY, IDLE) or not (QUIESCING, STANDBY).

> 
> 2.5) FSM in any state
> 
> ------------------------------------------------------------
> | NOT_OPERATIONAL  | The device is released                |
> | |                                       |
> |                  | triggered by: mdev_release            |
> |                  | action: unregister IOMMU notifier     |
> |                  | state on success: NOT_OPERATIONAL     |
> ------------------------------------------------------------

Confused. Isn't that "device gone or not operational" as well?
