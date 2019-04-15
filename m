Return-Path: <SRS0=kLZb=SR=vger.kernel.org=kvm-owner@kernel.org>
Date: Mon, 15 Apr 2019 19:02:52 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 1/7] s390: zcrypt: driver callback to indicate resource
 in use
Message-ID: <20190415190252.3759a479.cohuck@redhat.com>
In-Reply-To: <3d762e51-7210-529f-61de-98d80689bff6@linux.ibm.com>
References: <1555016604-2008-1-git-send-email-akrowiak@linux.ibm.com>
        <1555016604-2008-2-git-send-email-akrowiak@linux.ibm.com>
        <223c82c7-6a75-7209-3652-c2341c83878f@linux.ibm.com>
        <20190412114313.0156c01b.cohuck@redhat.com>
        <89f09e58-eab6-94d4-c5aa-937162d60744@linux.ibm.com>
        <20190415115030.1df61182.cohuck@redhat.com>
        <3d762e51-7210-529f-61de-98d80689bff6@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Reinhard Buendgen <buendgen@de.ibm.com>, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 15 Apr 2019 12:51:23 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 4/15/19 5:50 AM, Cornelia Huck wrote:
> > On Fri, 12 Apr 2019 15:38:21 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >   
> >> On 4/12/19 5:43 AM, Cornelia Huck wrote:  
> >>> On Fri, 12 Apr 2019 08:54:54 +0200
> >>> Harald Freudenberger <freude@linux.ibm.com> wrote:
> >>>      
> >>>> On 11.04.19 23:03, Tony Krowiak wrote:  
> >>>>> Introduces a new driver callback to prevent a root user from unbinding
> >>>>> an AP queue from its device driver if the queue is in use. This prevents
> >>>>> a root user from inadvertently taking a queue away from a guest and
> >>>>> giving it to the host, or vice versa. The callback will be invoked
> >>>>> whenever a change to the AP bus's apmask or aqmask sysfs interfaces may
> >>>>> result in one or more AP queues being removed from its driver. If the
> >>>>> callback responds in the affirmative for any driver queried, the change
> >>>>> to the apmask or aqmask will be rejected with a device in use error.
> >>>>>
> >>>>> For this patch, only non-default drivers will be queried. Currently,
> >>>>> there is only one non-default driver, the vfio_ap device driver. The
> >>>>> vfio_ap device driver manages AP queues passed through to one or more
> >>>>> guests and we don't want to unexpectedly take AP resources away from
> >>>>> guests which are most likely independently administered.
> >>>>>
> >>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>  
> >>>>
> >>>> Hello Tony
> >>>>
> >>>> you are going out with your patches but ... what is the result of the discussions
> >>>> we had in the past ? Do we have a common understanding that we want to have
> >>>> it this way ? A driver which is able to claim resources and the bus code
> >>>> has lower precedence ?  
> >>
> >> This is what Reinhard suggested and what we agreed to as a team quite
> >> some time ago. I submitted three versions of this patch to our
> >> internal mailing list, all of which you reviewed, so I'm not sure
> >> why you are surprised by this now.
> >>  
> >>>
> >>> I don't know about previous discussions, but I'm curious how you
> >>> arrived at this design. A driver being able to override the bus code
> >>> seems odd. Restricting this to 'non-default' drivers looks even more
> >>> odd.
> >>>
> >>> What is this trying to solve? Traditionally, root has been able to
> >>> shoot any appendages of their choice. I would rather expect that in a
> >>> supported setup you'd have some management software keeping track of
> >>> device usage and making sure that only unused queues can be unbound. Do
> >>> we need to export more information to user space so that management
> >>> software can make better choices?  
> >>
> >> Is there a reason other than tradition to prevent root from accidentally
> >> shooting himself in the foot or any other appendage? At present,
> >> sysfs is the only supported setup, so IMHO it makes sense to prevent as
> >> much accidentally caused damage as possible in the kernel.  
> > 
> > I don't think anybody wants an interface where it is easy for root to
> > accidentally cause damage... but from the patch description, it sounds
> > like you're creating an interface which makes it easy for a
> > badly-acting driver to hog resources without any way for root to remove
> > them forcefully.
> > 
> > Therefore, again my question: What is this trying to solve? I see a
> > management layer as a better place to make sure that queues are not
> > accidentally yanked from guests that are using them. Does more
> > information about queue usage need to be made available to userspace
> > for this to be feasible? Is anything else missing?  
> 
> Accidentally yanking queues from guests is only part of the equation.
> One has to consider the case where queues go away without root user
> intervention. Take, for example, the case where an AP card temporarily
> goes offline for some reason; possibly, due to glich or temporary
> hardware malfunction of some sort. When the AP bus scan subsequently
> runs, the card device and all associated queue devices will be unbound
> from their respective device drivers. If the card then comes back
> online, the next bus scan will recreate the card and queue devices and
> bind them to their respective device drivers. These patches ensure the
> queues are given back to the guest from which they were taken when
> unbound.

Ok, that sounds a bit like the 'disconnected' state for ccw devices,
and this sounds more useful to me than trying to prevent root from
removing devices. (Put that explanation in the patch description,
maybe?)

> 
> Having said that, I understand your concern about a driver hogging
> resources. I think I can provide a solution that serves both the
> purpose of preventing problems associated with accidental removal
> of AP resources as well as allowing root to remove them
> forcefully. I'll work on that for v2.

Ok, that and the explanation above makes this approach a lot more
reasonable.

> 
> >   
> >>  
> >>>      
> >>>>     
> >>>>> ---
> >>>>>    drivers/s390/crypto/ap_bus.c | 138 +++++++++++++++++++++++++++++++++++++++++--
> >>>>>    drivers/s390/crypto/ap_bus.h |   3 +
> >>>>>    2 files changed, 135 insertions(+), 6 deletions(-)  
> >>>      
> >>  
> >   
> 
