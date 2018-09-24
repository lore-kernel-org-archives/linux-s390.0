From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v10 13/26] s390: vfio-ap: zeroize the AP queues
Date: Mon, 24 Sep 2018 14:32:47 +0200
Message-ID: <20180924143247.4f4d656e.cohuck@redhat.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
        <1536781396-13601-14-git-send-email-akrowiak@linux.vnet.ibm.com>
        <20180924133611.01fef50e.cohuck@redhat.com>
        <b2eae775-0917-8c71-4ecf-6ef921ac9b0b@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b2eae775-0917-8c71-4ecf-6ef921ac9b0b@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 24 Sep 2018 14:16:42 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 09/24/2018 01:36 PM, Cornelia Huck wrote:
> > On Wed, 12 Sep 2018 15:43:03 -0400
> > Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> >> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> >> index f8b276a..48b1b78 100644
> >> --- a/drivers/s390/crypto/vfio_ap_ops.c
> >> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> >> @@ -829,6 +829,49 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
> >>  	return NOTIFY_OK;
> >>  }
> >>  
> >> +static int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
> >> +				    unsigned int retry)
> >> +{
> >> +	struct ap_queue_status status;
> >> +
> >> +	do {
> >> +		status = ap_zapq(AP_MKQID(apid, apqi));
> >> +		switch (status.response_code) {
> >> +		case AP_RESPONSE_NORMAL:
> >> +			return 0;
> >> +		case AP_RESPONSE_RESET_IN_PROGRESS:
> >> +		case AP_RESPONSE_BUSY:
> >> +			msleep(20);
> >> +			break;
> >> +		default:
> >> +			/* things are really broken, give up */
> >> +			return -EIO;
> >> +		}
> >> +	} while (retry--);
> >> +
> >> +	return -EBUSY;  
> > 
> > So, this function may either return 0, -EIO (things are really broken),
> > or -EBUSY (still busy after multiple tries)...
> >   
> >> +}
> >> +
> >> +static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev)
> >> +{
> >> +	int ret;
> >> +	int rc = 0;
> >> +	unsigned long apid, apqi;
> >> +	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> >> +
> >> +	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm,
> >> +			     matrix_mdev->matrix.apm_max + 1) {
> >> +		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm,
> >> +				     matrix_mdev->matrix.aqm_max + 1) {
> >> +			ret = vfio_ap_mdev_reset_queue(apid, apqi, 1);
> >> +			if (ret)
> >> +				rc = ret;  
> > 
> > ...and here, we return the last error of any of the resets. Two
> > questions:
> > 
> > - Does it make sense to continue if we get -EIO? IOW, does "really
> >   broken" only refer to a certain tuple and other tuples still can/need
> >   to be reset?  
> 
> I think it does make sense to continue, because IMHO "things are really
> broken" is an overstatement (I mean the APQN invalid case). One could
> argue would skipping the current card (adapter) be justified or not.

A short comment ("even after -EIO, other devices still need to be
reset") may be helpful here (remember that I don't have any way to
verify this with the architecture).

> 
> IMHO the current code is good enough for the first shot, and we can think
> about fine-tuning it later.

Sure.

> 
> > - Is the return code useful in any way, as we don't know which tuple it
> >   refers to?
> >   
> 
> Well, good question. It conveys that the operation can 'fail'. AFAIR -EBUSY
> is mostly fine given what the architecture say if we are satisfied with just
> reset. And the cases behind -EIO might actually be OK too in the same sense.
> My guess is, that based on the return value client code can tell if we have
> zeroize for all queues or basically just reset (like rapq). We could log that
> to some debug facility or whatever -- I guess, but at the moment we don't care.

Logging would probably be more useful than the return code, but that
can be added later.

> 
> In the end I think the code is good enough as is, and if we want we can
> improve on it later.

I don't object to that; but this is all a bit confusing to readers
without access to the architecture, so I think a comment or two would
really improve things.

> 
> Regards,
> Halil
> 
> 
> >> +		}
> >> +	}
> >> +
> >> +	return rc;
> >> +}
> >> +
> >>  static int vfio_ap_mdev_open(struct mdev_device *mdev)
> >>  {
> >>  	struct ap_matrix_mdev *matrix_mdev = mdev_get_drvdata(mdev);
> >> @@ -859,6 +902,7 @@ static void vfio_ap_mdev_release(struct mdev_device *mdev)
> >>  	if (matrix_mdev->kvm)
> >>  		kvm_arch_crypto_clear_masks(matrix_mdev->kvm);
> >>  
> >> +	vfio_ap_mdev_reset_queues(mdev);
> >>  	vfio_unregister_notifier(mdev_dev(mdev), VFIO_GROUP_NOTIFY,
> >>  				 &matrix_mdev->group_notifier);
> >>  	matrix_mdev->kvm = NULL;  
> >   
> 
