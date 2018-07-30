From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 30 Jul 2018 16:10:11 +0000
Subject: Re: [PATCH v7 00/22] vfio-ap: guest dedicated crypto adapters
Message-Id: <20180730101011.5a429b07@t450s.home>
In-Reply-To: <ad81821d-d1ab-fdc3-ebc5-af64ad99f049@de.ibm.com>
References: <ad81821d-d1ab-fdc3-ebc5-af64ad99f049@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 30 Jul 2018 08:05:32 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 07/27/2018 06:53 PM, Alex Williamson wrote:
> > On Fri, 27 Jul 2018 12:59:50 +0200
> > Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >   
> >> On 07/27/2018 10:38 AM, Cornelia Huck wrote:  
> >>> On Thu, 26 Jul 2018 21:54:07 +0200
> >>> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> >>>      
> >>>> * The mediated device gained an 'activate' attribute. Sharing conflicts are
> >>>>   checked on activation now. If the device was not activated, the mdev
> >>>>   open still implies activation. An active ap_matrix_mdev device claims
> >>>>   it's resources -- an inactive does not.    
> >>>
> >>> This means we have a 'commit' workflow?    
> >>
> >> Yes. We want to be able to "overcommit" definitions. For example when you
> >> have 2 guests that you never start at the same time. Then you can give both
> >> guests the same disks. If you start at the same time, libvirt will complain.
> >> Now: you want to do the same for matrixes. Allocation at definition time
> >> would limit that flexibility. When we check at "commit" this allows overcommit.  
> > 
> > I raised an eyebrow to this 'activate' attribute as well and I think we
> > struggled through the same sort of thing when defining mdev initially
> > with NVIDIA.  IIRC there was a proposal that mdev devices could
> > effectively be overcommitted on the parent and only when they were
> > opened, would the allocation count against the available instances.
> > The trouble is then that libvirt has no guarantee that a given mdev
> > device is usable.  I believe we decided that the creation of the mdev
> > device is the point at which we want to reserve resources because it
> > provides a better synchronization point.  I don't really see what
> > advantage we have by having these matrices on 'standby', shouldn't
> > userspace be able to manipulate these dynamically and on-demand of
> > starting a VM?  Thanks,  
> 
> We had this discussion as well and there is a case where not-predefining
> things might complicate matters:
> Daniel, please correct me if this is not so:
> As far as I understand the libvirt folks want to have host devices and guest
> instances decoupled. So a guest startup will not trigger a define of the mdev
> instance. (instead it has to be a separate step). This might work with virsh
> (but it now requires two steps as you can not predefine instances) but it
> might break things like virt-manager.

If this is a libvirt requirement, then it's creating a different model
for AP mdev devices since existing mdev devices do not allow
overcommit.  libvirt currently does no mdev lifecycle management, it's
entirely left to the user to decide on a static configuration or
dynamic creation.  Dynamic creation can be done via qemu hooks  until
libvirt decides how/if they'll take on creation.  So I don't think it
makes sense to make AP mdev devices behave different from others in
this respect.  Thanks,

Alex
