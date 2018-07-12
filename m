From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 0/8] vfio: ccw: Refactoring the VFIO CCW state
 machine
Date: Thu, 12 Jul 2018 17:22:36 +0200
Message-ID: <20180712172236.2e038b8c.cohuck@redhat.com>
References: <1528790210-19535-1-git-send-email-pmorel@linux.ibm.com>
        <20180613165151.056ecaec.cohuck@redhat.com>
        <bd5fb44e-3395-63bc-23a5-b9b6a8a8f1ef@linux.ibm.com>
        <20180619160045.13caf12e.cohuck@redhat.com>
        <63d1948a-3844-26e3-fc4f-0e7da7b4f515@linux.ibm.com>
        <20180626180052.7412ee79.cohuck@redhat.com>
        <3406a24b-1e3a-ac23-c5d0-87c9a3b5515c@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3406a24b-1e3a-ac23-c5d0-87c9a3b5515c@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: pasic@linux.vnet.ibm.com, bjsdjshi@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 27 Jun 2018 12:00:41 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

Apologies for the late answer, this topic had dropped off my radar.

> On 26/06/2018 18:00, Cornelia Huck wrote:
> > On Tue, 26 Jun 2018 13:04:12 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >  
> >> On 19/06/2018 16:00, Cornelia Huck wrote:  
> >>> On Thu, 14 Jun 2018 10:06:31 +0200
> >>> Pierre Morel<pmorel@linux.ibm.com>  wrote:
> >>>     
> ...snip...
> >> The goal of the state machine is to describe the device driver state.
> >> Not the device state which is hold by the CIO level.  
> > I don't think there really is such a thing as "device driver state" (or
> > maybe I don't understand what you mean by it). The state is attached to
> > the individual device, isn't it?  
> Yes but it is related to the software handling the device and not to the 
> device.
> This is a difference between QEMU, Linux VFIO driver and Hardware.
> 
> In my point of view:
> 
> QEMU                  : Emulates a device, internal state is state of 
> the device
> Linux VFIO driver: Handle the device, internal state is driver state
> Hardware            : obviously get the device state

OK, I understand where you're coming from, but I find your terminology
a bit confusing :)

Maybe call the state that is tracked by the vfio driver "vfio device
state"?

> >>>> ------------------------------------------------------------
> >>>> | STANDBY          | A guest is associated but not started |  
> >>> This is basically "device is bound to driver, but no mdev has been set
> >>> up".  
> >> When the device is bound to the driver, the device driver
> >> is still in NOT_OPERATIONAL state.
> >>
> >> The transition to STANDBY is done when the virtual machine starts and
> >> opens the mediated device.
> >> Note that the device is still not usable until it is reseted.  
> > Hm, isn't that transition happening when the mdev is created?  
> No, when the mdev is created the VM is not started.
> The STANDBY state is entered when the mdev_open is called,
> this is when the VFIO framework is initialized as QEMU starts.
> 
> When the mdev is created the mdev_create is called but do not
> induce any state change.

Ah, now I understand where the disconnect here came from: Your patch 7
changed this :)

I have to think further about this (still undecided).

> ...snip...
> >> Now you are talking about the driver :) This should probably be done  
> >>> for the other states as well.  
> >> Ill update the description to make clear that the state is the
> >> driver state (device driver) and not the device state.
> >> The device state is handled by the firmware.  
> > Now you have managed to confuse me completely... isn't the firmware
> > only handling the (real) subchannel state?  
> 
> Yes and QEMU the virtual one.
> But the driver does not need to handle the device state
> but the driver state. Which is quite different.

That's again the terminology confusion from above.

> >>> Isn't that rather "an mdev is created"?  
> >> No, ONLINE is triggered by VFIO_RESET, after the mdev has been created
> >> and when the VM is started or restarted by QEMU.
> >>
> >> I see that I did not do a good job describing what triggers the events.
> >> I will try again in a dedicated document.  
> > It might be good to combine the two.  
> 
> When mdev is created the VM does not exist, it is created by the admin.
> 
> The mdev_open() is called once when the VM starts.
> VFIO_RESET is called on start and every time the VM is reseted.

And this was again /me looking at the current code.

> 
> These are three different events occuring in the life of the driver.
> mdev creation do not influence the way the driver works.

I'm wondering if it should. Having an mdev is a prereq for any setup.
So a device in not oper state without mdev is a different thing from a
device in not oper state with an mdev that received e.g. some path
failures.

> mdev open does, and issues the INIT event
> VFIO_RESET does and issues the ONLINE event

The last one is possibly a bit unintuitive (might be a naming issue).

> >>>> |                  | triggered by: vfio_reset              |
> >>>> |                  | action: enable SC                     |
> >>>> |                  | state on success: IDLE                |
> >>>> |                  | state on error  : STANDBY             |  
> >>> What happens if the subchannel is not operational when we try to get it
> >>> ready? Can it go to NOT_OPERATIONAL in that case?  
> >> I think we have a confusion between the sub-channel being non operational
> >> and the device driver being non operational.
> >> Here, the device driver is operational, even the device may not.  
> > How can something be operational if the device is not? It could be in a
> > state like the ccw device's disconnected state, but it's certainly not
> > ready for requests.  
> 
> The driver may be operational even the device is not.
> Depending on the protocol between device and driver it allows
> the driver to reset the device.
> We have two drivers here speaking with the device, the one in the guest
> and the VFIO driver.
> The VFIO driver works is to handle the virtualization infrastructure,
> not to handle the device. Handling the device is done by the guest
> driver.

Hm, let's assume the hardware device is not operational (cc 3 on ssch
or whatever).

What I'd assume to happen would be:
- The vfio driver notices that the subchannel is not operational, and
  switches state or flips an indication somewhere.
- The vfio driver is probably also notified by the common I/O layer
  (because of machine check on the hardware). It has two choices: give
  up on the device (the common I/O layer will deregister the device),
  or keep it (which would mean something similar to the disconnected
  state for ccw devices; I guess that is what you meant with 'the
  driver is operational'?).
- If the (subchannel) device is gone, the child mdev should be gone as
  well.

What would be the best way to interact with the guest? On real
hardware, I'd expect both cc 3 and crws. Regardless whether we
unregister or do something like the disconnected state, we should relay
the cc 3 to the guest *and* inject a machine check to kick the guest's
handling.

If we use the disconnected state approach, what should the guest get if
it tries to interact with the device anyway? We could answer with cc 3
immediately, or let the hardware give us the cc 3 that we relay back to
the guest. (We should get a notification from the common I/O layer when
it is informed via a machine check that the device is alive again.)

What do you think?

> >> For the VM perspective, if the device is not operational we send a RESET.
> >>
> >> For the guest perspective we can do what ever instruction we needs to
> >> get the device operational, therefor we need the driver to be operational
> >> to process the instruction.  
> > Ah, do you mean 'subchannel enabled'? I was thinking about 'device
> > dead, we get cc 3 or somesuch'.  
> 
> What can we do on the host level that the guest can not do?
> If we have a way to retrieve a dead device in the host, shouldn't
> we give the guest this possibility?

See above... we can get the machine checks, but the guest can't.

> Speaking about sub-channel enabled:
> 
> We currently have very restricted possibilities for the guest
> to manage the sub-channel or even to get real information
> on the sub-channel.
> Dong-Jia began working in this direction with his last patch series
> and I think it is a way to follow.

Is anyone at IBM picking up this work?

> My point of view is that we should not do too much in the VFIO
> driver but only take care of the virtualization of the SCHIB.
> But this is beyond the scope of this patch .

The main thing missing is probably machine check handling. But probably
msch passthrough as well.

> >>> This is the common I/O layer's sch_event callback. That can mean
> >>> different things:
> >>> - Something regarding the paths to the device changed. We can translate
> >>>     that to "schib updated".
> >>> - Device is gone. This is a different situation; we may either try to
> >>>     implement the disconnected state, or we may give up the device.
> >>>
> >>> Also, can't we get this event in QUIESCING or STANDBY as well?  
> >> I think it should be ignored in STANDBY as we did not even
> >> start to use the sub-channel we have no information on it
> >> at that moment.  
> > As long as we do update it some time before we need the information, ok.  
> 
> AFAIK we currently never forward this information to the guest,
> when we do it we will need to virtualize this information.

Agreed.
  
> >>>> | |                                       |
> >>>> |                  | triggered by: sch_event               |
> >>>> |                  | action: Store the SCHIB in IO region  |
> >>>> |                  | state on success: no change           |  
> >>> As said, we may want some different handling for "device gone"
> >>> situations.
> >>>
> >>> Also, what happens if we get that event in BUSY? Is the I/O still
> >>> running?  
> >> AFAIK yes, it is an asynchronous event.
> >> It can happen during BUSY.
> >> However AFAIU we still get an IRQ even we get the device gone
> >> during I/O operation.  
> > It depends. We either get a deferred cc 3, or a machine check (but no
> > interrupt).  
> 
> I understood from current code that all kind of CRW do not
> imply that the sub-channel is gone.
> I must investigate a little more.

Path handling is sometimes a bit odd...

> 
> Anyway, the CRW should be handled and forwarded to the guest
> but I would prefer not to change too much in this series,
> shouldn't this changes be part of a next series?

Yes, that should be a different series, as it will probably be quite
complex and needs thought. Anyway, I've updated
https://wiki.qemu.org/ToDo/Channel_I/O_Passthrough with some machine
check considerations.
