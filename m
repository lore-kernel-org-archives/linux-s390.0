Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726326AbgIUL5y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Sep 2020 07:57:54 -0400
Date: Mon, 21 Sep 2020 13:56:55 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] s390/vfio-ap: fix unregister GISC when KVM is already
 gone results in OOPS
Message-ID: <20200921135655.152c77c6.pasic@linux.ibm.com>
In-Reply-To: <a108cd19-8c4b-908f-844d-5717ca405559@de.ibm.com>
References: <20200918170234.5807-1-akrowiak@linux.ibm.com>
        <a108cd19-8c4b-908f-844d-5717ca405559@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, pmorel@linux.ibm.com, alex.williamson@redhat.com, cohuck@redhat.com, kwankhede@nvidia.com

On Mon, 21 Sep 2020 07:48:58 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> 
> 
> On 18.09.20 19:02, Tony Krowiak wrote:
> > Attempting to unregister Guest Interruption Subclass (GISC) when the
> > link between the matrix mdev and KVM has been removed results in the
> > following:
> > 
> >    "Kernel panic -not syncing: Fatal exception: panic_on_oops"
> 
> I think the full backtrace would be better in case someone runs into this
> and needs to compare this patch to its oops. This also makes it easier to
> understand the fix. 
> > 
> > This patch fixes this bug by verifying the matrix mdev and KVM are still
> > linked prior to unregistering the GISC.
> > 
> > Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> 
> Do we need a Fixes tag and cc stable?
> 

I believe we do!

> 
> > ---
> >  drivers/s390/crypto/vfio_ap_ops.c | 14 +++++++++-----
> >  1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> > index e0bde8518745..847a88642644 100644
> > --- a/drivers/s390/crypto/vfio_ap_ops.c
> > +++ b/drivers/s390/crypto/vfio_ap_ops.c
> > @@ -119,11 +119,15 @@ static void vfio_ap_wait_for_irqclear(int apqn)
> >   */
> >  static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
> >  {
> > -	if (q->saved_isc != VFIO_AP_ISC_INVALID && q->matrix_mdev)
> 
> So we already check for q->matrix_mdev here
> 
> > -		kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->saved_isc);
> > -	if (q->saved_pfn && q->matrix_mdev)
> 
> and here
> > -		vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev),
> > -				 &q->saved_pfn, 1);
> > +	if (q->matrix_mdev) {
> > +		if (q->saved_isc != VFIO_AP_ISC_INVALID && q->matrix_mdev->kvm)
>                                                            ^^^^ and this is the only
> 		new check? Cant we just add this condition to the first if?

You are technically right, but I'm not comfortable with my level of
understanding of this logic regardless of the coding style. Will ask
some questions directly.

Regards,
Halil

> 
> > +			kvm_s390_gisc_unregister(q->matrix_mdev->kvm,
> > +						 q->saved_isc);
> > +		if (q->saved_pfn)
> > +			vfio_unpin_pages(mdev_dev(q->matrix_mdev->mdev),
> > +					 &q->saved_pfn, 1);
> > +	}
> > +
> >  	q->saved_pfn = 0;
> >  	q->saved_isc = VFIO_AP_ISC_INVALID;
> >  }
> > 
