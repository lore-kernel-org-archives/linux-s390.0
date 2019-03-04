From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 6/7] s390: ap: Cleanup on removing the AP device
Date: Mon, 4 Mar 2019 14:02:22 +0100
Message-ID: <20190304140222.6d694479.cohuck@redhat.com>
References: <1550849400-27152-1-git-send-email-pmorel@linux.ibm.com>
        <1550849400-27152-7-git-send-email-pmorel@linux.ibm.com>
        <3f15bd09-8a90-ed8a-e15a-0f3bac1a3528@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3f15bd09-8a90-ed8a-e15a-0f3bac1a3528@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, borntraeger@de.ibm.com, alex.williamson@redhat.com, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, frankja@linux.ibm.com, pasic@linux.ibm.com, david@redhat.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, freude@linux.ibm.com, mimu@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Tue, 26 Feb 2019 13:27:57 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 2/22/19 10:29 AM, Pierre Morel wrote:
> > When the device is remove, we must make sure to
> > clear the interruption and reset the AP device.
> > 
> > We also need to clear the CRYCB of the guest.
> > 
> > Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> > ---
> >   drivers/s390/crypto/vfio_ap_drv.c     | 35 +++++++++++++++++++++++++++++++++++
> >   drivers/s390/crypto/vfio_ap_ops.c     |  3 ++-
> >   drivers/s390/crypto/vfio_ap_private.h |  3 +++
> >   3 files changed, 40 insertions(+), 1 deletion(-)
(...)
> >   /**
> > + * vfio_ap_update_crycb
> > + * @q: A pointer to the queue being removed
> > + *
> > + * We clear the APID of the queue, making this queue unusable for the guest.
> > + * After this function we can reset the queue without to fear a race with
> > + * the guest to access the queue again.
> > + * We do not fear race with the host as we still get the device.
> > + */
> > +static void vfio_ap_update_crycb(struct vfio_ap_queue *q)
> > +{
> > +	struct ap_matrix_mdev *matrix_mdev = q->matrix_mdev;
> > +
> > +	if (!matrix_mdev)
> > +		return;
> > +
> > +	clear_bit_inv(AP_QID_CARD(q->apqn), matrix_mdev->matrix.apm);
> > +
> > +	if (!matrix_mdev->kvm)
> > +		return;
> > +
> > +	kvm_arch_crypto_set_masks(matrix_mdev->kvm,
> > +				  matrix_mdev->matrix.apm,
> > +				  matrix_mdev->matrix.aqm,
> > +				  matrix_mdev->matrix.adm);
> > +}
> > +
> > +/**
> >    * vfio_ap_queue_dev_remove:
> >    *
> >    * Free the associated vfio_ap_queue structure
> > @@ -70,6 +100,11 @@ static void vfio_ap_queue_dev_remove(struct ap_device *apdev)
> >   	struct vfio_ap_queue *q;
> >   
> >   	q = dev_get_drvdata(&apdev->device);
> > +	if (!q)
> > +		return;
> > +
> > +	vfio_ap_update_crycb(q);
> > +	vfio_ap_mdev_reset_queue(q);  
> 
> The reset is unnecessary because once the card is removed from the
> CRYCB, the ZAPQ may fail with because the queue may not exist anymore.
> Besides, once the card is removed from the guest's CRYCB, the bus
> running in the guest will do a reset.

You cannot rely on whatever a sane guest would do, any needed cleanup
needs to be done by the host.

(No idea what actually needs to be done here :)

> 
> >   	list_del(&q->list);
> >   	kfree(q);
> >   }
