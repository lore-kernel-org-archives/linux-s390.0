Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61382 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726008AbgDXDNZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 23 Apr 2020 23:13:25 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03O2VpQS007970
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 23:13:24 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30kppdj383-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 23 Apr 2020 23:13:24 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 24 Apr 2020 04:12:56 +0100
Date: Fri, 24 Apr 2020 05:13:15 +0200
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v7 04/15] s390/vfio-ap: implement in-use callback for
 vfio_ap driver
In-Reply-To: <5cf7d611-e30c-226d-0d3d-d37170f117f4@linux.ibm.com>
References: <20200407192015.19887-1-akrowiak@linux.ibm.com>
        <20200407192015.19887-5-akrowiak@linux.ibm.com>
        <20200416131845.3ef6b3b5.cohuck@redhat.com>
        <5cf7d611-e30c-226d-0d3d-d37170f117f4@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Message-Id: <20200424051315.20f17133.pasic@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pmorel@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, jjherne@linux.ibm.com, fiuczy@linux.ibm.com

On Thu, 16 Apr 2020 10:45:20 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> 
> 
> On 4/16/20 7:18 AM, Cornelia Huck wrote:
> > On Tue,  7 Apr 2020 15:20:04 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >
> >> Let's implement the callback to indicate when an APQN
> >> is in use by the vfio_ap device driver. The callback is
> >> invoked whenever a change to the apmask or aqmask would
> >> result in one or more queue devices being removed from the driver. The
> >> vfio_ap device driver will indicate a resource is in use
> >> if the APQN of any of the queue devices to be removed are assigned to
> >> any of the matrix mdevs under the driver's control.
> >>
> >> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> >> ---
> >>   drivers/s390/crypto/vfio_ap_drv.c     |  1 +
> >>   drivers/s390/crypto/vfio_ap_ops.c     | 47 +++++++++++++++++----------
> >>   drivers/s390/crypto/vfio_ap_private.h |  2 ++
> >>   3 files changed, 33 insertions(+), 17 deletions(-)
> >> @@ -1369,3 +1371,14 @@ void vfio_ap_mdev_remove_queue(struct ap_queue *queue)
> >>   	kfree(q);
> >>   	mutex_unlock(&matrix_dev->lock);
> >>   }
> >> +
> >> +bool vfio_ap_mdev_resource_in_use(unsigned long *apm, unsigned long *aqm)
> >> +{
> >> +	bool in_use;
> >> +
> >> +	mutex_lock(&matrix_dev->lock);
> >> +	in_use = vfio_ap_mdev_verify_no_sharing(NULL, apm, aqm) ? true : false;
> > Maybe
> >
> > in_use = !!vfio_ap_mdev_verify_no_sharing(NULL, apm, aqm);
> >
> > ?
> 
> To be honest, I find the !! expression very confusing. Every time I see 
> it, I have
> to spend time thinking about what the result of !! is going to be. I think
> the statement should be left as-is because it more clearly expresses
> the intent.
> 

This is discussion is just about cosmetics, I believe. Just a piece of
advice: try to be sensitive about the community. In this community, and
I believe in C general !! is the idiomatic way to convert number to
boolean. Why would one want to do that is a bit longer story. The short
version is in logic condition context the value 0 is false and any
other value is true. !! keeps false value (0) false, and forces a true to
the most true true value. If you keep getting confused every time you
run across a !! that won't help with reading other peoples C.

Regards,
Halil 

> >
> >> +	mutex_unlock(&matrix_dev->lock);
> >> +
> >> +	return in_use;
> >> +}
> 
