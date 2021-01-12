Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:62268 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731029AbhALR4o (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 12 Jan 2021 12:56:44 -0500
Date: Tue, 12 Jan 2021 18:55:50 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v13 09/15] s390/vfio-ap: allow hot plug/unplug of AP
 resources using mdev device
Message-ID: <20210112185550.1ac49768.pasic@linux.ibm.com>
In-Reply-To: <20210112021251.0d989225.pasic@linux.ibm.com>
References: <20201223011606.5265-1-akrowiak@linux.ibm.com>
        <20201223011606.5265-10-akrowiak@linux.ibm.com>
        <20210112021251.0d989225.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Tue, 12 Jan 2021 02:12:51 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> > @@ -1347,8 +1437,11 @@ void vfio_ap_mdev_remove_queue(struct ap_device *apdev)
> >  	apqi = AP_QID_QUEUE(q->apqn);
> >  	vfio_ap_mdev_reset_queue(apid, apqi, 1);
> >  
> > -	if (q->matrix_mdev)
> > +	if (q->matrix_mdev) {
> > +		matrix_mdev = q->matrix_mdev;
> >  		vfio_ap_mdev_unlink_queue(q);
> > +		vfio_ap_mdev_refresh_apcb(matrix_mdev);
> > +	}
> >  
> >  	kfree(q);
> >  	mutex_unlock(&matrix_dev->lock);  

Shouldn't we first remove the queue from the APCB and then
reset? Sorry, I missed this one yesterday.

Regards,
Halil
