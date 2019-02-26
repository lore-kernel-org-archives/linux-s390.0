From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 26 Feb 2019 11:05:03 +0000
Subject: Re: Mapping memory regions on s390
Message-Id: <20190226120503.7bd9f699.cohuck@redhat.com>
In-Reply-To: <20190221171747.64181ee8@oc2783563651>
References: <20190221171747.64181ee8@oc2783563651>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 21 Feb 2019 17:17:47 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Thu, 21 Feb 2019 15:46:08 +0000
> "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> 
> > * Cornelia Huck (cohuck@redhat.com) wrote:  
> > > On Thu, 21 Feb 2019 15:11:50 +0000
> > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > >   
> > > > * Cornelia Huck (cohuck@redhat.com) wrote:  
> > > > > On Thu, 21 Feb 2019 13:39:46 +0000
> > > > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > > > >     
> > > > > > * Cornelia Huck (cohuck@redhat.com) wrote:    
> > > > > > > On Mon, 18 Feb 2019 15:41:07 +0000
> > > > > > > "Dr. David Alan Gilbert" <dgilbert@redhat.com> wrote:
> > > > > > >       
> > > > > > > > * Cornelia Huck (cohuck@redhat.com) wrote:      
> > > > > > >       
> > > > > > > > > > >> We can of course switch the order of mappings
> > > > > > > > > > >>
> > > > > > > > > > >> [0x000000000000000      ]
> > > > > > > > > > >> ... Memory region containing RAM
> > > > > > > > > > >> [ram_size         	]
> > > > > > > > > > >> ... Memory region for memory devices (virtio-pmem, virtio-mem ...)
> > > > > > > > > > >> [maxram_size - ram_size ]
> > > > > > > > > > >> ... Memory region for e.g. special PCI/CCW devices
> > > > > > > > > > >> [                    TBD]
> > > > > > > > > > >>
> > > > > > > > > > >> We can size TBD in a way that we e.g. max out the current page table
> > > > > > > > > > >> size before having to switch to more levels.          
> > > > > > > > > > > 
> > > > > > > > > > > Yes, that's fine to set some upper limit; you've just got to make sure
> > > > > > > > > > > that the hypervisor knows where it can put stuff and if the guest
> > > > > > > > > > > does PCI that it knows where it's allowed to put stuff and as long
> > > > > > > > > > > as the two don't overlap everyone is happy.        
> > > > > > > > > 
> > > > > > > > > Hm... is that an issue for pci? Do we need to care, as s390 uses
> > > > > > > > > special instructions anyway? Or do we want to avoid going through them,
> > > > > > > > > so that the guest can use normal read/write?        
> > > > > > > > 
> > > > > > > > That depends.
> > > > > > > > The stuff we use for virtio-fs we need the shared region to be
> > > > > > > > accessible by the guest via normal instructions because we're using for
> > > > > > > > DAX.  For PCI you might be able to avoid it for most other PCI cases.      
> > > > > > > 
> > > > > > > So,
> > > > > > > - virtio-fs regions need to be accessible like normal memory, so they
> > > > > > >   need to show up in the region labeled 'TBD' above       
> > > > > > 
> > > > > > Yes.
> > > > > >     
> > > > > > >  (it would fine to
> > > > > > >   communicate the 'where' through pci structures)      
> > > > > > 
> > > > > > Hmm, mixing PCI structures into something you're not treating as PCI
> > > > > > seems weird to me.    
> > > > > 
> > > > > I was thinking about the addresses in the TBD area... they need to go
> > > > > through _some_ pci structure, I assume?    
> > > > 
> > > > Well I think it depends how you make it work with CCW;
> > > > 
> > > > if the addresses being assigned are assigned by the host then I believe you should use
> > > > the CCW mechanism you suggested to discover the addresses in the guest.
> > > > 
> > > > If the host is going to allocate a block of PCI space and the guest is
> > > > going to allocate the use within that space and access it with normal
> > > > instructions then I think it should go via PCI.  
> > > 
> > > This is getting a bit confusing... let me try to summarize:
> > > 
> > > - We introduce a special area where shared memory areas are supposed to
> > >   live.
> > > - If a virtio device accessed via ccw defines shared regions, the
> > >   driver can discover them via a new ccw that indicates an address in
> > >   that special area.  
> > 
> > Right.
> >   
> > > - If a virtio device accessed via pci defines shared regions, the
> > >   driver will want to discover them via the same mechanism as on other
> > >   platforms. If I read
> > >   https://lists.oasis-open.org/archives/virtio-comment/201901/msg00003.html
> > >   correctly, this will mean an offset into a BAR. This will be a normal
> > >   pci memory region.  
> > 
> > Right; note that like any other BAR it's upto the guest to write the BAR
> > to select which area of GPA it wants the BAR to map to.
> >   
> > > Now, this sounds to me that we'll have regions in different memory
> > > regions, depending on whether they are accessed via ccw or via pci. Not
> > > sure if that's a problem.  
> > 
> > As long as they stay out of each others way it shouldn't be.
> >   
> 
> I'm not sure. What I'm concerted about is:
> * if it is a virtio-ccw device it would need to access the shared memory via
> normal memory access instructions.

Just for reference, my current draft for the ccw spec looks as follows:
