From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v4 14/16] docs: add documentation for vfio-ccw
Date: Tue, 28 Mar 2017 10:16:23 +0200
Message-ID: <20170328101623.1b07cf1f.cornelia.huck@de.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
        <20170317031743.40128-15-bjsdjshi@linux.vnet.ibm.com>
        <20170321124716.19f90fd6@t450s.home>
        <20170322023422.GP10704@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170322023422.GP10704@bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 22 Mar 2017 10:34:22 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Alex Williamson <alex.williamson@redhat.com> [2017-03-21 12:47:16 -0600]:
> 
> [...]
> 
> > > +vfio-ccw I/O region
> > > +-------------------
> > > +
> > > +An I/O region is used to accept channel program request from user
> > > +space and store I/O interrupt result for user space to retrieve. The
> > > +defination of the region is:
> > > +
> > > +struct ccw_io_region {
> > > +#define ORB_AREA_SIZE 12
> > > +	__u8	orb_area[ORB_AREA_SIZE];
> > > +#define SCSW_AREA_SIZE 12
> > > +	__u8	scsw_area[SCSW_AREA_SIZE];
> > > +#define IRB_AREA_SIZE 96
> > > +	__u8	irb_area[IRB_AREA_SIZE];
> > > +	__u32	ret_code;
> > > +} __packed;
> > > +
> > > +While starting an I/O request, orb_area should be filled with the
> > > +guest ORB, and scsw_area should be filled with the SCSW of the Virtual
> > > +Subchannel.
> > > +
> > > +irb_area stores the I/O result.
> > > +
> > > +ret_code stores a return code for each access of the region.
> Hi Alex,
> 
> > 
> > Pardon if these questions expose my lack of familiarity with S390:
> > 
> > So I/O requests are asynchronous, the user is notified via interrupt
> > when completed, can more than one request be queued at a time?
> The answer is no. The subchannel will stay in a state that prohibiting
> from a new request if there is processing for a previous request
> ongoing. And we need to issue an explit I/O instruction to retrieve and
> (or) clear the pending interruption before issue another I/O request.
> 
> > The communication format doesn't seem like it'd easily support that.
> > Is it possible?  A future enhancement that we should design for now?
> As the above statements said, it's not possible.
> 
> > 
> > I'm also a little unclear what sort of I/O a user has access to via
> > this interface and how the kernel polices that access. For instance,
> > are multiple tape or disk devices available through a single I/O
> > channel?
> No. An I/O subchannel is dedicated to one device, and...
> 
> > How does the user configure which devices a user has access to when
> > creating the vfio-ccw device?
> ...this mapping is usually determined/configured before the machine
> startup by the administrtor of the upper level hypervisor. So when
> creating the vfio-ccw device, we do not configure/modify this mapping.
> When the guest I/O subchannel driver probing, it will issue a SENSE
> command on the subchannel to recognize/find what kind of device is
> behind the subchannel, and then it uses corresponding CCW device driver
> serving the I/O device.
> 
> @Conny, please correct me if my understanding is not right.

No, it's fine.

FWIW:
https://virtualpenguins.blogspot.com/2017/02/channel-io-demystified.html

(I plan to write more in the future.)

> 
> > 
> > Otherwise I think the interface looks great.  Thanks,
> This is good news. :>
> 
> Thanks!
> > 
> > Alex
> > 
> 
