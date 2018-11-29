From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [qemu-s390x] [PATCH 3/3] vfio-ccw: add handling
 for asnyc channel instructions
Date: Thu, 29 Nov 2018 18:24:11 +0100
Message-ID: <20181129182411.1a2913dc@oc2783563651>
References: <20181122165432.4437-1-cohuck@redhat.com>
	<20181122165432.4437-4-cohuck@redhat.com>
	<20181128173604.24b301a3@oc2783563651>
	<20181129175234.5e8d9f7b.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <qemu-devel-bounces+gceq-qemu-devel2=m.gmane.org@nongnu.org>
In-Reply-To: <20181129175234.5e8d9f7b.cohuck@redhat.com>
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

On Thu, 29 Nov 2018 17:52:34 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Wed, 28 Nov 2018 17:36:04 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Thu, 22 Nov 2018 17:54:32 +0100
> > Cornelia Huck <cohuck@redhat.com> wrote:
> > 
> > > Add a region to the vfio-ccw device that can be used to submit
> > > asynchronous I/O instructions. ssch continues to be handled by the
> > > existing I/O region; the new region handles hsch and csch.
> > > 
> > > Interrupt status continues to be reported through the same channels
> > > as for ssch.
> > > 
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > ---
> > >  drivers/s390/cio/Makefile           |   3 +-
> > >  drivers/s390/cio/vfio_ccw_async.c   |  88 ++++++++++++++++
> > >  drivers/s390/cio/vfio_ccw_drv.c     |  48 ++++++---
> > >  drivers/s390/cio/vfio_ccw_fsm.c     | 158 +++++++++++++++++++++++++++-
> > >  drivers/s390/cio/vfio_ccw_ops.c     |  13 ++-
> > >  drivers/s390/cio/vfio_ccw_private.h |   6 ++
> > >  include/uapi/linux/vfio.h           |   4 +
> > >  include/uapi/linux/vfio_ccw.h       |  12 +++
> > >  8 files changed, 313 insertions(+), 19 deletions(-)
> > >  create mode 100644 drivers/s390/cio/vfio_ccw_async.c
> 
> > > +static size_t vfio_ccw_async_region_read(struct vfio_ccw_private *private,
> > > +					 char __user *buf, size_t count,
> > > +					 loff_t *ppos)
> > > +{
> > > +	unsigned int i = VFIO_CCW_OFFSET_TO_INDEX(*ppos) - VFIO_CCW_NUM_REGIONS;
> > > +	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
> > > +	struct ccw_cmd_region *region;
> > > +
> > > +	if (pos + count > sizeof(*region))
> > > +		return -EINVAL;
> > > +
> > > +	region = private->region[i].data;
> > > +	if (copy_to_user(buf, (void *)region + pos, count))
> > > +		return -EFAULT;
> > > +
> > > +	return count;
> > > +
> > > +}
> > > +
> > > +static size_t vfio_ccw_async_region_write(struct vfio_ccw_private *private,
> > > +					  const char __user *buf, size_t count,
> > > +					  loff_t *ppos)
> > > +{
> > > +	unsigned int i = VFIO_CCW_OFFSET_TO_INDEX(*ppos) - VFIO_CCW_NUM_REGIONS;
> > > +	loff_t pos = *ppos & VFIO_CCW_OFFSET_MASK;
> > > +	struct ccw_cmd_region *region;
> > > +
> > > +	if (pos + count > sizeof(*region))
> > > +		return -EINVAL;
> > > +
> > > +	if (private->state == VFIO_CCW_STATE_NOT_OPER ||
> > > +	    private->state == VFIO_CCW_STATE_STANDBY)
> > > +		return -EACCES;
> > > +
> > > +	region = private->region[i].data;
> > > +	if (copy_from_user((void *)region + pos, buf, count))
> > > +		return -EFAULT;  
> > 
> > I guess vfio_ccw_async_region_write() is supposed to be reentrant in a
> > sense that there may be more that one 'instances' of the function
> > executing at the same time, or am I wrong?
> > 
> > If it is reenarant, I wonder what protects private->region[i].data from
> > corruption or simply being changed 'while at it'?
> 
> Interesting question. AFAICS this same issue applies to the existing
> I/O region as well.
>

I'm aware of this. IMHO the answer to this question as quite some
implications, but I wanted to start with something simple and tangible.

One difference between async and existing I/O region is, that we, kind
of, do implement mutex of io requests using private->state and the state
machine. It is racy, but AFAIU the idea of at most one io request is
processed at any time is recognizable in the the state machine.

Frankly I never understood how synchronization worked for vfio-ccw.

BTW considering current QEMU, I guess we kind of do have one event at
a time situation (not quite sure about stuff that is not triggered by
a channel instruction interpreted by QEMU). But the documentation does
not say anything, and I don't think relying on QEMU implementation
details is a good idea.

Pierre had a patch called '[PATCH v3 6/6] vfio: ccw: serialize the write
system calls' which  makes all the write calls mutually exclusive but
I'm not sure if that is what we want. In the end, it is a design
decision: making it one at the time simplifies implementation but makes
us different.

One way or the other, IMHO, it is a decision that needs to be made soon.


> There's nothing in common code enforcing any exclusivity. 

Nod.

> If I
> understand the code correctly, the common vfio-pci code reads/writes in
> 1/2/4 byte chunks for most accesses. There's igd code that does not do
> that, though.
> 

I didn't examine the vfio-pci stuff jet because my understanding of pci
is very limited.

Regards,
Halli
