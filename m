Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 1 Dec 2020 11:19:14 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v12 12/17] s390/vfio-ap: allow hot plug/unplug of AP
 resources using mdev device
Message-ID: <20201201111914.25a80561.pasic@linux.ibm.com>
In-Reply-To: <65834705-347c-1e8d-f33f-b64bc2501b37@linux.ibm.com>
References: <20201124214016.3013-1-akrowiak@linux.ibm.com>
        <20201124214016.3013-13-akrowiak@linux.ibm.com>
        <20201129025250.16eb8355.pasic@linux.ibm.com>
        <103cbe02-2093-c950-8d65-d3dc385942ce@linux.ibm.com>
        <20201201003227.0c3696fc.pasic@linux.ibm.com>
        <65834705-347c-1e8d-f33f-b64bc2501b37@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, mjrosato@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, fiuczy@linux.ibm.com, frankja@linux.ibm.com, david@redhat.com, hca@linux.ibm.com, gor@linux.ibm.com

On Mon, 30 Nov 2020 19:18:30 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> >>>> +static bool vfio_ap_assign_apid_to_apcb(struct ap_matrix_mdev *matrix_mdev,
> >>>> +					unsigned long apid)
> >>>> +{
> >>>> +	unsigned long apqi, apqn;
> >>>> +	unsigned long *aqm = matrix_mdev->shadow_apcb.aqm;
> >>>> +
> >>>> +	/*
> >>>> +	 * If the APID is already assigned to the guest's shadow APCB, there is
> >>>> +	 * no need to assign it.
> >>>> +	 */
> >>>> +	if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm))
> >>>> +		return false;
> >>>> +
> >>>> +	/*
> >>>> +	 * If no domains have yet been assigned to the shadow APCB and one or
> >>>> +	 * more domains have been assigned to the matrix mdev, then use
> >>>> +	 * the domains assigned to the matrix mdev; otherwise, there is nothing
> >>>> +	 * to assign to the shadow APCB.
> >>>> +	 */
> >>>> +	if (bitmap_empty(matrix_mdev->shadow_apcb.aqm, AP_DOMAINS)) {
> >>>> +		if (bitmap_empty(matrix_mdev->matrix.aqm, AP_DOMAINS))
> >>>> +			return false;
> >>>> +
> >>>> +		aqm = matrix_mdev->matrix.aqm;
> >>>> +	}
> >>>> +
> >>>> +	/* Make sure all APQNs are bound to the vfio_ap driver */
> >>>> +	for_each_set_bit_inv(apqi, aqm, AP_DOMAINS) {
> >>>> +		apqn = AP_MKQID(apid, apqi);
> >>>> +
> >>>> +		if (vfio_ap_mdev_get_queue(matrix_mdev, apqn) == NULL)
> >>>> +			return false;
> >>>> +	}
> >>>> +
> >>>> +	set_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
> >>>> +
> >>>> +	/*
> >>>> +	 * If we verified APQNs using the domains assigned to the matrix mdev,
> >>>> +	 * then copy the APQIs of those domains into the guest's APCB
> >>>> +	 */
> >>>> +	if (bitmap_empty(matrix_mdev->shadow_apcb.aqm, AP_DOMAINS))
> >>>> +		bitmap_copy(matrix_mdev->shadow_apcb.aqm,
> >>>> +			    matrix_mdev->matrix.aqm, AP_DOMAINS);
> >>>> +
> >>>> +	return true;
> >>>> +}  
> >>> What is the rationale behind the shadow aqm empty special handling?  
> >> The rationale was to avoid taking the VCPUs
> >> out of SIE in order to make an update to the guest's APCB
> >> unnecessarily. For example, suppose the guest is started
> >> without access to any APQNs (i.e., all matrix and shadow_apcb
> >> masks are zeros). Now suppose the administrator proceeds to
> >> start assigning AP resources to the mdev. Let's say he starts
> >> by assigning adapters 1 through 100. The code below will return
> >> true indicating the shadow_apcb was updated. Consequently,
> >> the calling code will commit the changes to the guest's
> >> APCB. The problem there is that in order to update the guest's
> >> VCPUs, they will have to be taken out of SIE, yet the guest will
> >> not get access to the adapter since no domains have yet been
> >> assigned to the APCB. Doing this 100 times - once for each
> >> adapter 1-100 - is probably a bad idea.
> >>  
> > Not yanking the VCPUs out of SIE does make a lot of sense. At least
> > I understand your motivation now. I will think some more about this,
> > but in the meanwhile, please try to answer one more question (see
> > below).
> >     
> >>>    I.e.
> >>> why not simply:
> >>>
> >>>
> >>> static bool vfio_ap_assign_apid_to_apcb(struct ap_matrix_mdev *matrix_mdev,
> >>>                                           unsigned long apid)
> >>> {
> >>>           unsigned long apqi, apqn;
> >>>           unsigned long *aqm = matrix_mdev->shadow_apcb.aqm;
> >>>                                                                                   
> >>>           /*
> >>>            * If the APID is already assigned to the guest's shadow APCB, there is
> >>>            * no need to assign it.
> >>>            */
> >>>           if (test_bit_inv(apid, matrix_mdev->shadow_apcb.apm))
> >>>                   return false;
> >>>                                                                                   
> >>>           /* Make sure all APQNs are bound to the vfio_ap driver */
> >>>           for_each_set_bit_inv(apqi, aqm, AP_DOMAINS) {
> >>>                   apqn = AP_MKQID(apid, apqi);
> >>>                                                                                   
> >>>                   if (vfio_ap_mdev_get_queue(matrix_mdev, apqn) == NULL)
> >>>                           return false;
> >>>           }
> >>>                                                                                   
> >>>           set_bit_inv(apid, matrix_mdev->shadow_apcb.apm);
> >>>                                                                                   
> >>>           return true;  
> > Would
> > s/return true/return !bitmap_empty(matrix_mdev->shadow_apcb.aqm,
> > AP_DOMAINS)/
> > do the trick?
> >
> > I mean if empty, then we would not commit the APCB, so we would
> > not take the vCPUs out of SIE -- see below.  
> 
> At first glance I'd say yes, it does the trick; but, I need to consider
> all possible scenarios. For example, that will work fine when someone
> either assigns all of the adapters or all of the domains first, then assigns
> the other.

Maybe I can help you. The only caveat I have in mind is the show of the
guest_matrix attribute. We probably don't want to display adapters
without domains and vice-versa. But that can be easily handled with
a flag.

Regards,
Halil
