Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26298 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729576AbhAUKfm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 21 Jan 2021 05:35:42 -0500
Date: Thu, 21 Jan 2021 11:34:38 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH 1/1] s390/vfio-ap: No need to disable IRQ after queue
 reset
Message-ID: <20210121113438.2e40c5f9.pasic@linux.ibm.com>
In-Reply-To: <20210121092044.628b77c7.cohuck@redhat.com>
References: <20210121072008.76523-1-pasic@linux.ibm.com>
        <20210121092044.628b77c7.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, stable@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com

On Thu, 21 Jan 2021 09:20:44 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 21 Jan 2021 08:20:08 +0100
> Halil Pasic <pasic@linux.ibm.com> wrote:
[..]
> > --- a/drivers/s390/crypto/vfio_ap_private.h
> > +++ b/drivers/s390/crypto/vfio_ap_private.h
> > @@ -88,11 +88,6 @@ struct ap_matrix_mdev {
> >  	struct mdev_device *mdev;
> >  };
> >  
> > -extern int vfio_ap_mdev_register(void);
> > -extern void vfio_ap_mdev_unregister(void);
> > -int vfio_ap_mdev_reset_queue(unsigned int apid, unsigned int apqi,
> > -			     unsigned int retry);
> > -
> >  struct vfio_ap_queue {
> >  	struct ap_matrix_mdev *matrix_mdev;
> >  	unsigned long saved_pfn;
> > @@ -100,5 +95,10 @@ struct vfio_ap_queue {
> >  #define VFIO_AP_ISC_INVALID 0xff
> >  	unsigned char saved_isc;
> >  };
> > -struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q);
> > +
> > +int vfio_ap_mdev_register(void);
> > +void vfio_ap_mdev_unregister(void);  
> 
> Nit: was moving these two necessary?
> 

No not strictly necessary. I decided that having the data types
first and the function prototypes in one place after the former
is nicer.

> > +int vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q,
> > +			     unsigned int retry);
> > +
> >  #endif /* _VFIO_AP_PRIVATE_H_ */
> > 
> > base-commit: 9791581c049c10929e97098374dd1716a81fefcc  
> 
> Anyway, if I didn't entangle myself in the various branches, this seems
> sane.
> 
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> 

Thank you very much!

Regards,
Halil
