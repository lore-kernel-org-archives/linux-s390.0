From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 0/8] vfio: ccw: Refactoring the VFIO CCW state
 machine
Date: Tue, 26 Jun 2018 18:00:52 +0200
Message-ID: <20180626180052.7412ee79.cohuck@redhat.com>
References: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
        <20180613165151.056ecaec.cohuck@redhat.com>
        <bd5fb44e-3395-63bc-23a5-b9b6a8a8f1ef@linux.ibm.com>
        <20180619160045.13caf12e.cohuck@redhat.com>
        <63d1948a-3844-26e3-fc4f-0e7da7b4f515@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <63d1948a-3844-26e3-fc4f-0e7da7b4f515@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 26 Jun 2018 13:04:12 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 19/06/2018 16:00, Cornelia Huck wrote:
> > On Thu, 14 Jun 2018 10:06:31 +0200
> > Pierre Morel<pmorel@linux.ibm.com>  wrote:
> >  
> >> I tried to make a better description to add later in documentation
> >> or in the next cover-letter.
> >>
> >> Note that in the current patch series I did not implement online/offline
> >> events but just kept the previous state changes.
> >> Not sure if it was a good idea, the goal was to be as simple as possible
> >> for this iteration.
> >> If you think it is worth to continue in this direction I will re-introduce
> >> these as events.  
> > I'm still trying to figure out what we want from the state machine.
> > I've tried sketching your fsm proposal as outlined by you below for
> > myself and I have some remarks :)  
> 
> Hi,
> 
> Sorry for the delay in my answer, I was away from my keyboard
> almost the all week :) .

np :)

> 
> >  
> >> ======================
> >>
> >> 1) In CCW VFIO, Finite State Machine is used to clarify the VFIO CCW driver
> >> actions to be take depending on the events occurring in a device.
> >>
> >> To protect the state transitions, a mutex protect the action
> >> started when an event occurs in a specific state.
> >>
> >> The actions must never sleep or keep the mutex a long timer.
> >>
> >> To be able to take the mutex when hardware events occur we start
> >> a work on a dedicated workqueue, posting the event from inside the
> >> workqueue.
> >>
> >> The state machine has very few states describing the device driver life.
> >>
> >> ------------------------------------------------------------
> >> | NOT_OPERATIONAL  | No guest is associated with the device|  
> > I don't think that this is the right description. It is either the
> > initial state, or something has happened that rendered the device
> > inaccessible.  
> 
> The goal of the state machine is to describe the device driver state.
> Not the device state which is hold by the CIO level.

I don't think there really is such a thing as "device driver state" (or
maybe I don't understand what you mean by it). The state is attached to
the individual device, isn't it?

> 
> I think this has lead to some confusion since I tried to keep the old
> naming convention.
> So, I agree that a state named "NON_INIT" or "UNCONFIGUED" would be better
> to distinguish it from the device state "NOT_OPERATIONAL"
> 
> > Also, we need to be careful with the virtual machine vs. guest
> > terminology. The only thing that has an impact from the guest is when
> > it does I/O and when an interrupt is generated as a result (i.e., the
> > IDLE/BUSY transitions). The other transitions are triggered by virtual
> > machine setup.  
> 
> Absolutely.
> 
> >> ------------------------------------------------------------
> >> | STANDBY          | A guest is associated but not started |  
> > This is basically "device is bound to driver, but no mdev has been set
> > up".  
> 
> When the device is bound to the driver, the device driver
> is still in NOT_OPERATIONAL state.
> 
> The transition to STANDBY is done when the virtual machine starts and
> opens the mediated device.
> Note that the device is still not usable until it is reseted.

Hm, isn't that transition happening when the mdev is created?

> 
> >   In my understanding, we need to get the device to IDLE state
> > before the vm can present it to the guest (be it before the machine is
> > up or during hotplug).  
> 
> The virtual machine needs to RESET the device sending the VFIO_RESET
> to the device driver to make the device driver go to the IDLE state.
> 
> >> ------------------------------------------------------------
> >> | IDLE             | Guest started device ready            |  
> > Agree with "device ready", disagree with "guest started" (see above).
> > "Device ready, accepting I/O requests"?  
> 
> Indeed bad description, VM started, and almost as you said
> "Device driver ready, accepting I/O requests for device"
> (Device is ready too)
> 
> >> ------------------------------------------------------------
> >> | BUSY             | The device is busy doing IO           |
> >> ------------------------------------------------------------
> >> | QUIESCING        | The driver is releasing the device    |  
> > Now you are talking about the driver :) This should probably be done
> > for the other states as well.  
> 
> Ill update the description to make clear that the state is the
> driver state (device driver) and not the device state.
> The device state is handled by the firmware.

Now you have managed to confuse me completely... isn't the firmware
only handling the (real) subchannel state?

> 
> > Isn't that state for waiting for outstanding I/O to be terminated
> > before the mdev is destroyed? IOW, the device may stay bound to the
> > driver afterwards?  
> 
> Yes it is.
> 
> >> ------------------------------------------------------------
> >>
> >>
> >> 2) The following Events may apply to the state machine:
> >>
> >> If the event is not described, it means it has no influence
> >> on the state and that no action is required.
> >>
> >> 2.1) FSM in state NOT_OPERATIONAL
> >> ------------------------------------------------------------
> >> | INIT             | a guest will drive the SC             |  
> > Better to write out "subchannel", I could not figure out the
> > abbreviation immediately.  
> 
> OK, right, Ill do.
> 
> > Also, doesn't the event really mean "we're initializing the device"?  
> 
> No, just the device driver.
> 
> > The ultimate intention is of course for a guest to use the device, but
> > the immediate intention is just "get the device through the first
> > initialization steps".
> >  
> >> | |                                       |
> >> |                  | triggered by: mdev_open               |
> >> |                  | action: initialize driver structures  |
> >> |                  | action: register IOMMU notifier       |
> >> |                  | state on success: STANDBY             |
> >> |                  | state on error  : NOT_OPERATIONAL     |
> >> ------------------------------------------------------------
> >>
> >> 2.2) FSM in state STANDBY
> >>
> >> ------------------------------------------------------------
> >> | ONLINE           | The host wants the SC online          |  
> > Isn't that rather "an mdev is created"?  
> 
> No, ONLINE is triggered by VFIO_RESET, after the mdev has been created
> and when the VM is started or restarted by QEMU.
> 
> I see that I did not do a good job describing what triggers the events.
> I will try again in a dedicated document.

It might be good to combine the two.

> 
> >  
> >> | |                                       |
> >> |                  | triggered by: vfio_reset              |
> >> |                  | action: enable SC                     |
> >> |                  | state on success: IDLE                |
> >> |                  | state on error  : STANDBY             |  
> > What happens if the subchannel is not operational when we try to get it
> > ready? Can it go to NOT_OPERATIONAL in that case?  
> 
> I think we have a confusion between the sub-channel being non operational
> and the device driver being non operational.
> Here, the device driver is operational, even the device may not.

How can something be operational if the device is not? It could be in a
state like the ccw device's disconnected state, but it's certainly not
ready for requests.

> 
> For the VM perspective, if the device is not operational we send a RESET.
> 
> For the guest perspective we can do what ever instruction we needs to
> get the device operational, therefor we need the driver to be operational
> to process the instruction.

Ah, do you mean 'subchannel enabled'? I was thinking about 'device
dead, we get cc 3 or somesuch'.

> 
> 
> 
> >  
> >> ------------------------------------------------------------
> >>
> >> Some operations may be intercepted by the state machine but
> >> will not induce a state change:
> >> OFFLINE: re-issue the disabling of the SC  
> > Should that even be possible? If we're still busy tearing it down,
> > shouldn't we be in QUIESCING state?  
> 
> So yes, I think you are right, after a OFFLINE, triggered by
> the VFIO_release the state is QUESCING
> 
> >  
> >> IRQ    : re-issue the disabling of the SC  
> > Either we should have cleared the subchannel out during QUIESCING, or
> > we got an unsolicited interrupt. The latter can be avoided if we make
> > sure that the device is disabled when we go to STANDBY.  
> 
> I will take a new look at cause of the unsolicited interrupts and
> awaited actions.
> 
> >  
> >> 2.3) FSM in state IDLE
> >>
> >> ------------------------------------------------------------
> >> | SSCH             | The guest issue the ssch instruction  |
> >> | |                                       |
> >> |                  | triggered by: vfio_write SSCH=1       |
> >> |                  | action: start an IO request           |
> >> |                  | state on success: BUSY                |
> >> |                  | state on error  : IDLE                |  
> > Should there be any way to drop to NOT_OPERATIONAL as well? We'll
> > probably get a notification from the common I/O layer if that happens,
> > though.  
> 
> I think this is the duty of the guest to handle this kind of thing.
> The device driver must stay operational.

See above. I think we'll get a notification from the common I/O layer,
and it probably makes sense to inject the same notification (CRW) into
the guest.

> 
> >  
> >> ------------------------------------------------------------
> >> 2.4) FSM in states IDLE or BUSY
> >>
> >> ------------------------------------------------------------
> >> | IRQ              | The hardware issue an interrupt       |  
> > I think we can get this in QUIESCING as well, and it is an indication
> > that QUIESCING is done (for final states).  
> 
> Yes. I did not describe the QUIESCING state in this email.
> because I did not add the patch on QUIESCING.
> With our discussion things becomes clearer and I will
> add it back after corrections.

Ok.

> 
> >
> > If the subchannel is enabled while in STANDBY, we could get an
> > interrupt there as well.  
> 
> No, the subchannel is not enabled while in STANDBY.
> The cio_enable() is issued during the transition from STANDBY
> to IDLE and the event should only happen when the transition
> completed, in IDLE.
> 
> How ever spurious interrupt may happen which should be handled
> locally in the STANDBY state.

Yes, that's what I meant.

> 
> >  
> >> | |                                       |
> >> |                  | triggered by: vfio_ccw_sch_irq        |
> >> |                  | action: update SCSW forward IRQ       |
> >> |                  | state on success: IDLE                |  
> > One thing to consider (and I'm not sure we're handling it correctly
> > right now): What if we don't have a final status for the I/O yet, i.e.
> > there will be another interrupt for the I/O? Should we stay in BUSY in
> > that case?  
> 
> I will take a new look at the interrupt processing.
> If we can be sure another interrupt will come, we may
> wait for it in BUSY.
> In case of doubt we better not and handle the interrupt in IDLE
> otherwise we hang in BUSY.

Agreed. But we should be able to find out whether we got a final state.

> 
> >  
> >> |                  | state on error  : IDLE                |  
> > Hm, what error?  
> 
> There are no error there, therefor no state change.
> A better description is "state on error: NA"

Ok.

> 
> >  
> >> ------------------------------------------------------------
> >>
> >> ------------------------------------------------------------
> >> | OFFLINE          | The host wants the SC offline         |  
> > That's mdev teardown, I guess?
> >  
> >> | |                                       |
> >> |                  | triggered by: css remove              |
> >> |                  | triggered by: css shutdown            |  
> > These as well.
> >  
> >> |                  | action: disable SC                    |
> >> |                  | state on success: STANDBY             |  
> > If it's really a css remove (unbind from driver or device removal), it
> > should not really have a target state, as the vfio-ccw device will be
> > gone, no? This is only correct for mdev removal.  
> 
> May be more complex.
> 
> The event is not right, we should have two different:
> 
> - On css remove and shutdown
> There we have a serious problem, a sub-channel disappeared.
> CIO level handle the quiescing of the sub-channel.
> The final state is NOT_OPER and we must somehow say the guest
> that the hardware configuration changed (machine check?).
> Don't we ?

I think there's a comment/TODO in the code for that.

> 
> - On vfio_release
> This is another thing, the guest goes away, so we need to
> smoothly shut down the sub channel using the QUIESCING state.
> 
> Once again this an indication to rework the OFFLINE event.
> 
> >  
> >> |                  | state on error  : NOT_OPERATIONAL     |
> >> ------------------------------------------------------------
> >>
> >> ------------------------------------------------------------
> >> | STORE_SCHIB      | The hardware issue "schib updated"    |  
> > This is the common I/O layer's sch_event callback. That can mean
> > different things:
> > - Something regarding the paths to the device changed. We can translate
> >    that to "schib updated".
> > - Device is gone. This is a different situation; we may either try to
> >    implement the disconnected state, or we may give up the device.
> >
> > Also, can't we get this event in QUIESCING or STANDBY as well?  
> 
> I think it should be ignored in STANDBY as we did not even
> start to use the sub-channel we have no information on it
> at that moment.

As long as we do update it some time before we need the information, ok.

> 
> In QUIESCING we may have to handle it for internal purpose
> to make sure to shutdown smoothly.
> I will work on this again.
> (Still this OFFLINE refactoring)
> 
> >  
> >> | |                                       |
> >> |                  | triggered by: sch_event               |
> >> |                  | action: Store the SCHIB in IO region  |
> >> |                  | state on success: no change           |  
> > As said, we may want some different handling for "device gone"
> > situations.
> >
> > Also, what happens if we get that event in BUSY? Is the I/O still
> > running?  
> 
> AFAIK yes, it is an asynchronous event.
> It can happen during BUSY.
> However AFAIU we still get an IRQ even we get the device gone
> during I/O operation.

It depends. We either get a deferred cc 3, or a machine check (but no
interrupt).

> 
> >  
> >> |                  | state on error  : NOT_OPERATIONAL     |
> >> ------------------------------------------------------------
> >>
> >> NOTE 1:
> >>      All out of band IO related instructions, XSCH, CSCH, HSCH
> >>      can be started in both states IDLE and BUSY.  
> > Hm. What do you mean by "out of band"?  
> May be a bad description, I made a difference between SSCH/IRQ
> two event handling I/O operations with a little protocoling:
> We send SSCH during IDLE we move to BUSY we expect IRQ
> and when IRQ we move to IDLE.
> 
> And the other instructions which can go aside of the
> protocoling direct to the hardware whatever the state is.
> 
> >
> > You can, of course, get all of the instructions above in both IDLE and
> > BUSY states. The question is what we want to do with them. Do we want
> > to put them through to the hardware in any case? If we do e.g. a hsch
> > and get a cc 2, we don't want to drop to IDLE, but stay in BUSY (as the
> > start function is likely still running).  
> 
> In the case the instruction is accepted (CC=0):
> 
> CANCEL: XSCH
>      in a first draw should not go to the device driver.
>      later we may check if we got a cancel before starting the SSCH 
> instruction
>      inside of the SSCH action.

Ok. Although we probably don't need to dwell on this too much, the
"always cc 2 on xsch" approach should already cover guest usage, I
guess.

> 
> CLEAR: CSCH
>      goes directly to hardware, no state change.
>      BUSY state: we will get an interrupt with clear pending which drive 
> us to IDLE
> 
> HALT: HSCH
>      goes directly to hardware, no state change.
>      BUSY state: we will get an interrupt with halt pending which drive 
> us to IDLE

I'm not sure about that; csch/hsch are different. csch clears any other
pending state; hsch may return busy, pending on what is currently going
on.

> 
> In all cases the CCW chain is kept until we get the confirmation that the
> program is not used any more by the sub-channel.

For csch, that would be immediately after cc 0.

> 
> In the case the instruction is not accepted (CC!=0)
> we must return the answer to the guest.

Yes, that's only for hsch, though.

> 
> >
> > What about RSCH?  
> 
> The CCW program must be kept "alive" in the kernel waiting to be resumed.
> 
> If we find the SUSPEND bit inside the CCW program during the processing
> of a SSCH, we should return a new "SUSPENDED" state to the state machine.
> 
> When we receive the RSCH from the guest
>      - We verify that guest cleared the SUSPEND bit of the current CCW
>        and fetch the new chain starting at this CCW
>      - we forward it to the hardware and go to BUSY state
> 
> 
> Another thing which will induce a new state is the CCW PCI bit which will
> induce intermediate status.
> (by the way we also should handle the ORB I bit)

This is something that needs handling, agreed.

> 
> >  
> >> NOTE 2:
> >>      Currently IRQ means solicited interrupt, but handle both
> >>      solicited and unsolicited interrupts.
> >>      The unsolicited interrupt event may be implemented separatly.  
> > We need to be ready for unsolicited interrupts at any point in time. It
> > mainly depends on the state whether we want to forward them to the
> > guest (BUSY, IDLE) or not (QUIESCING, STANDBY).  
> 
> 100% agree
> 
> >  
> >> 2.5) FSM in any state
> >>
> >> ------------------------------------------------------------
> >> | NOT_OPERATIONAL  | The device is released                |
> >> | |                                       |
> >> |                  | triggered by: mdev_release            |
> >> |                  | action: unregister IOMMU notifier     |
> >> |                  | state on success: NOT_OPERATIONAL     |
> >> ------------------------------------------------------------  
> > Confused. Isn't that "device gone or not operational" as well?
> >  
> 
> It is confusing, as said before, I need to revisit the OFFLINE event.
> 
> instead of using the cover letter, I will enhance the vfio-ccw documentation
> to cover the state machine.

Sounds like a good idea.

> 
> Thanks a lot for the reviewing.

I hope I did not add to the confusion :)
