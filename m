Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:6858 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725306AbgI2Nin (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 29 Sep 2020 09:38:43 -0400
Date: Tue, 29 Sep 2020 15:37:55 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v10 02/16] s390/vfio-ap: use new AP bus interface to
 search for queue devices
Message-ID: <20200929153755.20bdd94f.pasic@linux.ibm.com>
In-Reply-To: <ed021f29-927d-5bd6-4f2c-466f502f49f4@linux.ibm.com>
References: <20200821195616.13554-1-akrowiak@linux.ibm.com>
        <20200821195616.13554-3-akrowiak@linux.ibm.com>
        <20200925042729.3b9d5704.pasic@linux.ibm.com>
        <ed021f29-927d-5bd6-4f2c-466f502f49f4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, kernel test robot <lkp@intel.com>

On Tue, 29 Sep 2020 09:07:40 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> 
> 
> On 9/24/20 10:27 PM, Halil Pasic wrote:
> > On Fri, 21 Aug 2020 15:56:02 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >
> >> --- a/drivers/s390/crypto/vfio_ap_ops.c
> >> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> >> @@ -26,43 +26,26 @@
> >>   
> >>   static int vfio_ap_mdev_reset_queues(struct mdev_device *mdev);
> >>   
> >> -static int match_apqn(struct device *dev, const void *data)
> >> -{
> >> -	struct vfio_ap_queue *q = dev_get_drvdata(dev);
> >> -
> >> -	return (q->apqn == *(int *)(data)) ? 1 : 0;
> >> -}
> >> -
> >>   /**
> >> - * vfio_ap_get_queue: Retrieve a queue with a specific APQN from a list
> >> - * @matrix_mdev: the associated mediated matrix
> >> + * vfio_ap_get_queue: Retrieve a queue with a specific APQN.
> >>    * @apqn: The queue APQN
> >>    *
> >> - * Retrieve a queue with a specific APQN from the list of the
> >> - * devices of the vfio_ap_drv.
> >> - * Verify that the APID and the APQI are set in the matrix.
> >> + * Retrieve a queue with a specific APQN from the AP queue devices attached to
> >> + * the AP bus.
> >>    *
> >> - * Returns the pointer to the associated vfio_ap_queue
> >> + * Returns the pointer to the vfio_ap_queue with the specified APQN, or NULL.
> >>    */
> >> -static struct vfio_ap_queue *vfio_ap_get_queue(
> >> -					struct ap_matrix_mdev *matrix_mdev,
> >> -					int apqn)
> >> +static struct vfio_ap_queue *vfio_ap_get_queue(unsigned long apqn)
> >>   {
> >> +	struct ap_queue *queue;
> >>   	struct vfio_ap_queue *q;
> >> -	struct device *dev;
> >>   
> >> -	if (!test_bit_inv(AP_QID_CARD(apqn), matrix_mdev->matrix.apm))
> >> -		return NULL;
> >> -	if (!test_bit_inv(AP_QID_QUEUE(apqn), matrix_mdev->matrix.aqm))
> >> +	queue = ap_get_qdev(apqn);
> >> +	if (!queue)
> >>   		return NULL;
> >>   
> >> -	dev = driver_find_device(&matrix_dev->vfio_ap_drv->driver, NULL,
> >> -				 &apqn, match_apqn);
> >> -	if (!dev)
> >> -		return NULL;
> >> -	q = dev_get_drvdata(dev);
> >> -	q->matrix_mdev = matrix_mdev;
> >> -	put_device(dev);
> >> +	q = dev_get_drvdata(&queue->ap_dev.device);
> > Is this cast here safe? (I don't think it is.)
> 
> In the probe, we execute:
> dev_set_drvdata(&queue->ap_dev.device, q);
> 
> I don't get any compile nor execution errors. Why wouldn't it be safe?
> 

Because the queue may or may not be bound to the vfio_ap driver. AFAICT
this function can be called with an arbitrary APQN.

If it is bound to another driver then drvdata is not likely to hold a
struct vfio_ap_queue.


> >
> >> +	put_device(&queue->ap_dev.device);
> >>   
> >>   	return q;
> >>   }
> 
