From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v2 2/5] vfio-ccw: concurrent I/O handling
Date: Wed, 23 Jan 2019 14:06:01 +0100
Message-ID: <20190123140601.54b2c768@oc2783563651>
References: <20190121110354.2247-1-cohuck@redhat.com>
	<20190121110354.2247-3-cohuck@redhat.com>
	<20190121212018.4e377e59@oc2783563651>
	<20190122112926.4ff54f9f.cohuck@redhat.com>
	<20190122121737.49c3f900@oc2783563651>
	<20190122125322.4bb04921.cohuck@redhat.com>
	<20190122134612.40a7745e@oc2783563651>
	<20190122182617.23fab5e9.cohuck@redhat.com>
	<20190122200331.14ff2818@oc2783563651>
	<20190123113447.04354ae4.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20190123113447.04354ae4.cohuck@redhat.com>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, Eric Farman <farman@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org, qemu-s390x@nongnu.org, Farhan Ali <alifm@linux.ibm.com>, qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 23 Jan 2019 11:34:47 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Tue, 22 Jan 2019 20:03:31 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Tue, 22 Jan 2019 18:26:17 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> > > On Tue, 22 Jan 2019 13:46:12 +0100
> > > Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > > > Unsolicited interrupts are another
> > > > piece of cake -- I have no idea how may of those do we get.  
> > > 
> > > They at least don't have the "free the cp before we got final state"
> > > bug. But I think both are reasons to get away from "use the BUSY state
> > > to ensure the right sequence".
> > >   
> > 
> > I'm not sure I understand you correctly. I was under the impression that
> > the whole point in having a state machine was to ensure the states are
> > traversed in the right sequence with the right stuff being done on each
> > transition. At least in theory.
> 
> Sequence in user space programs, not in the state machine.
> 

I'm a bit confused.

> > 
> > You've probably figured out that IMHO vfio-ccw is not in a good shape
> > (to put it mildly). I have a hard time reviewing a non-holistic
> > concurrency fix. Please tell sould I get perceived as non-constructive,
> > I will try to cut back on criticism. 
> 
> I'm afraid this is just confusing me :(
> 
> > 
> > > > And because
> > > > of this the broken sequencing in userspace could actually be the kernels
> > > > fault.  
> > > 
> > > Here, I can't follow you at all :(
> > >   
> > 
> > Should we ever deliver a zeroed out IRB to the userspace, for the next
> > ioinst it would look like we have no status nor FC bit set. That is, the
> > guest could end up with stuff in parallel that was never supposed to
> > be in parallel (i.e. broken sequencing because kernel feeds false
> > information due to race with unsolicited interrupt).
> > 
> > Does that help?
> 
> Not at all, I'm afraid :( User space programs still need to make sure
> they poke the interfaces in the right order IMO...
> 

Yes, one can usually think of interfaces as contracts: both sides need
to keep their end for things to work as intended. Unfortunately the
vfio-ccw iterface is not a very well specified one, and that makes
reasoning about right order so much harder.

I was under the impression that the right ordering is dictated by the
SCSW in userspace. E.g. if there is an FC bit set there userspace is not
ought to issue a SSCH request (write to the io_region). The kernel part
however may say 'userspace read the actual SCSW' by signaling
the io_trigger eventfd. Userspace is supposed to read the IRB from the
region and update it's SCSW.

Now if userspace reads a broken SCSW from the IRB, because of a race
(due to poorly written kernel part -- userspace not at fault), it is
going to make wrong assumptions about currently legal and illegal
operations (ordering).

Previously I described a scenario where IRB can break without userspace
being at fault (race between unsolicited interrupt -- can happen at any
time -- and a legit io request). I was under the impression we agreed on
this.

This in turn could lead to userspace violating the contract, as perceived
by the kernel side.

> At this point, I'm mostly confused... I'd prefer to simply fix things
> as they come up so that we can finally move forward with the halt/clear
> handling (and probably rework the state machine on top of that.)
> 

I understand. I guess you will want to send a new version because of the
stuff that got lost in the rebase, or?

Regards,
Halil
