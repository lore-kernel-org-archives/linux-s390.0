From: Dong Jia <bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC 0/8] basic vfio-ccw infrastructure
Date: Mon, 9 May 2016 17:59:36 +0800
Message-ID: <20160509175936.03b1cf50@oc7835276234>
References: <1461931915-22397-1-git-send-email-bjsdjshi@linux.vnet.ibm.com>
	<20160429111735.0358be80@t450s.home>
	<20160504172629.77226d35@oc7835276234>
	<20160504132653.766c54db@t450s.home>
	<20160505182908.7dec8f4e@oc7835276234>
	<20160505131945.1dd6ca88@t450s.home>
	<20160505202311.GA28046@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20160505202311.GA28046@nvidia.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Neo Jia <cjia@nvidia.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, "Tian, Kevin" <kevin.tian@intel.com>, "Song, Jike" <jike.song@intel.com>, Kirti Wankhede <kwankhede@nvidia.com>, Dong Jia <bjsdjshi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, 5 May 2016 13:23:11 -0700
Neo Jia <cjia@nvidia.com> wrote:

> > > I also noticed in another thread:
> > > ---------------------------------
> > > [Qemu-devel] [RFC PATCH v3 3/3] VFIO Type1 IOMMU change: to support with iommu and without iommu
> > > 
> > > Kirti did:
> > > 1. don't pin the pages in the map ioctl for the vGPU case.
> > > 2. export vfio_pin_pages and vfio_unpin_pages.
> > > 
> > > Although their patches didn't show how these interfaces were used, I
> > > guess them can either use these interfaces to pin/unpin all of the
> > > guest memory, or pin/unpin memory on demand. So can I reuse their work
> > > to finish my #1? If the answer is yes, then I could change my plan and  
> > 
> > Yes, we would absolutely only want one vfio iommu backend doing this,
> > there's nothing device specific about it.  We're looking at supporting
> > both modes of operation, fully pinned and pin-on-demand.  NVIDIA vGPU
> > wants the on-demand approach while Intel vGPU wants to pin the entire
> > guest, at least for an initial solution.  This iommu backend would need
> > to support both as determined by the mediated device backend.  
> 
> Right, we will add a new callback to mediated device backend interface for this
> purpose in v4 version patch.
Dear Neo:
Thanks for this information.

What I interest most is the new vfio iommu backend. Looking forward to
your new patches. :>

> 
> Thanks,
> Neo
> 
> >   
> > > do:
> > > #1. Introduce a vfio_iommu_type1_ccw as the vfio iommu backend for ccw.
> > > When starting the guest, form the <vaddr, iova, size> database.
> > > 
> > > #2. In the driver of the ccw devices, when an I/O instruction was
> > > intercepted, call vfio_pin_pages (Kirti's version) to get the host
> > > physical address, then translate the ccw program for I/O operation.
> > > 
> > > So which one is the right way to go?  
> > 
> > As above, I think we have a need to support both approaches in this new
> > iommu backend, it will be up to you to determine which is appropriate
> > for your devices and guest drivers.  A fully pinned guest has a latency
> > advantage, but obviously there are numerous disadvantages for the
> > pinning itself.  Pinning on-demand has overhead to setup each DMA
> > operations by the device but has a much smaller pinning footprint.


--------
Dong Jia
