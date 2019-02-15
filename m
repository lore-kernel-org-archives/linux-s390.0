From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 4/9] s390: ap: tools to find a queue with a specific
 APQN
Date: Fri, 15 Feb 2019 11:24:06 +0100
Message-ID: <20190215112406.1ff79c50.cohuck@redhat.com>
References: <1550152269-6317-1-git-send-email-pmorel@linux.ibm.com>
        <1550152269-6317-5-git-send-email-pmorel@linux.ibm.com>
        <20190215104904.5cbe31bb.cohuck@redhat.com>
        <423e3f5b-dbbe-92b1-cfd3-d5a6f4e38f37@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <423e3f5b-dbbe-92b1-cfd3-d5a6f4e38f37@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Fri, 15 Feb 2019 11:10:43 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 15/02/2019 10:49, Cornelia Huck wrote:
> > On Thu, 14 Feb 2019 14:51:04 +0100
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> >   
> >> We need to find the queue with a specific APQN during the
> >> handling of the interception of the PQAP/AQIC instruction.
> >>
> >> To handle the AP associated device reference count we keep
> >> track of it in the vfio_ap_queue until we put the device.  
> > 
> > So, the relationship is
> > (struct ap_device)--(driver_data)-->(struct vfio_ap_queue)--(pointer)-->(struct ap_device)
> > ? IOW, a backlink?
> > 
> > If so, can't you already set that up during probe?  
> 
> Will do.
> 
> > 
> > Or am I confused by the various similar devices again? Maybe a diagram
> > would help...  
> 
> No you are right.

Good, I was fearing that I was more confused than normal for Fridays ;)

> 
> 
> >   
> >>
> >> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> >> ---
> >>   drivers/s390/crypto/vfio_ap_ops.c     | 54 +++++++++++++++++++++++++++++++++++
> >>   drivers/s390/crypto/vfio_ap_private.h |  1 +
> >>   2 files changed, 55 insertions(+)
> >>
> >> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> >> index 900b9cf..2a52c9b 100644
> >> --- a/drivers/s390/crypto/vfio_ap_ops.c
> >> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> >> @@ -24,6 +24,60 @@
> >>   #define VFIO_AP_MDEV_TYPE_HWVIRT "passthrough"
> >>   #define VFIO_AP_MDEV_NAME_HWVIRT "VFIO AP Passthrough Device"
> >>   
> >> +/**
> >> + * vfio_ap_check_apqn: check if a ap_queue is of a given APQN
> >> + *
> >> + * Returns 1 if we have a match.
> >> + * Otherwise returns 0.
> >> + */
> >> +static int vfio_ap_check_apqn(struct device *dev, void *data)
> >> +{
> >> +	struct vfio_ap_queue *q = dev_get_drvdata(dev);
> >> +
> >> +	return (q->apqn == *(int *)data);
> >> +}
> >> +
> >> +/**
> >> + * vfio_ap_get_queue: Retrieve a queue with a specific APQN
> >> + * @apqn: The queue APQN
> >> + *
> >> + * Retrieve a queue with a specific APQN from the list of the
> >> + * devices associated to the vfio_ap_driver.
> >> + *
> >> + * The vfio_ap_queue has been already associated with the device
> >> + * during the probe.
> >> + * Store the associated device for reference counting
> >> + *
> >> + * Returns the pointer to the associated vfio_ap_queue
> >> + */
> >> +static  __attribute__((unused))  
> > 
> > Eww. Can you get rid of that by reordering or squashing patches?  
> 
> I did this to avoid posting a very big patch.
> I will of course squash 4 and 5 with patch 6, when the two patches 4 and 
> 5 are reviewed.
> 
> If you think it brings more clarity to squash all for the next iteration 
> I will do.

Let's just see what the patches look like in the end. If a squashed
patch is not too unwieldy, I'd prefer that over those unused
annotations, though.

Hoping for review from others as well ;)
