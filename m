From: Cornelia Huck <cohuck@redhat.com>
Date: Fri, 26 Apr 2019 11:31:51 +0000
Subject: Re: Mapping memory regions on s390
Message-Id: <20190426133151.58ed1a16.cohuck@redhat.com>
In-Reply-To: <20190301152656.GC2851@work-vm>
References: <20190301152656.GC2851@work-vm>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Fri, 1 Mar 2019 14:50:14 +0100
David Hildenbrand <david@redhat.com> wrote:

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
> 

Sorry about the thread necromancy here, but I'm still not quite sure
how to proceed.

My understanding is that we can't use any other way to access this
memory than normal read/write, or it would clash with at least one of
the main use cases for this.

This leaves the problem that we support both virtio-ccw and virtio-pci
devices on s390 guests. The three options I see are:

(1) use a special device memory area for ccw and normal pci memory for
pci

(2) have pci use the special device memory area as well

(3) have ccw use pci memory

I don't really like any of these... (2) would make pci different on
s390 than anywhere else (well, even more so than it already is), and
(3) feels wrong as well. (1) is probably most benign in practice, but
would likely require us to configure devices differently depending on
the transport used, which seems troublesome as well.

I also have no idea if the protected guest thing will bite us here in
any way, especially as I have no access to the architecture.

Thoughts? Am I missing a fourth solution, or will we have to pick the
least bad one?
