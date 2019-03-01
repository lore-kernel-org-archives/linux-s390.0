From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Date: Fri, 01 Mar 2019 15:26:56 +0000
Subject: Re: Mapping memory regions on s390
Message-Id: <20190301152656.GC2851@work-vm>
In-Reply-To: <2507cc07-41fe-adf9-851e-e7197f528c81@redhat.com>
References: <2507cc07-41fe-adf9-851e-e7197f528c81@redhat.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

* David Hildenbrand (david@redhat.com) wrote:
> On 01.03.19 14:45, Cornelia Huck wrote:
> > On Fri, 1 Mar 2019 14:18:21 +0100 (CET)
> > Sebastian Ott <sebott@linux.ibm.com> wrote:
> > 
> >> On Fri, 1 Mar 2019, Cornelia Huck wrote:
> >>> On Fri, 1 Mar 2019 13:14:38 +0100 (CET)
> >>> Sebastian Ott <sebott@linux.ibm.com> wrote:  
> > 
> >>>> The iomap, readb stuff is only usable in a PCI context on s390. But what
> >>>> is the problem here? virtio_ccw knows it's not a PCI driver - it doesn't
> >>>> have to use this stuff..  
> >>>
> >>> The device has to put the shared regions somewhere. If the virtio-pci
> >>> transport is used, it's just a normal area within a BAR (IIUC), and
> >>> should be handled just like normal pci memory.
> >>>
> >>> The problem is where to put it if the virtio-ccw transport is used. The
> >>> idea was to put it in its own region (a device-memory region) and allow
> >>> the guest some way to discover that region (which is not within the
> >>> normal system memory from the guest's POW, just as pci memory isn't).
> >>> However, if we do that, we end up having the shared regions in
> >>> different regions depending upon whether the pci or the ccw transport
> >>> is used. Having pci use the special device memory on s390x does not
> >>> really sound like a good idea, either. Nor does putting it into pci
> >>> memory and accessing it from the ccw transport...  
> >>
> >> How should virtio_ccw access this memory? Only via CCW programs? In this
> >> case you don't have to put it in the guests address space. Or should
> >> standard memory instructions (lg,st) be used? In this case maybe the
> >> 1-to-1 mapping or the vmalloc space??
> > 
> > The idea was to use standard memory instructions (i.e. both host and
> > guest can read from/write to the region at any time). There was also
> > the idea to read/write this from the guest side only via ccws, for
> > which we wouldn't need a new address space, but that would have serious
> > drawbacks like not being able to read/write from an atomic context.
> > 
> 
> Or mapping into into user space, if that would ever be required.

The specific case this discussion started for was explicitly allowing
it to be mapped all the way to user space;  in virtio-fs we're mapping
normal files into this space in the qemu and they're presented as DAX
inside the guest kernel and eventually mapped through to the user
process.

Dave

> -- 
> 
> Thanks,
> 
> David / dhildenb
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
