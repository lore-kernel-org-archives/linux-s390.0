Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23588 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729493AbgLDQ6s (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 4 Dec 2020 11:58:48 -0500
Date: Fri, 4 Dec 2020 17:57:07 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] s390/vfio-ap: Clean up vfio_ap resources when KVM
 pointer invalidated
Message-ID: <20201204175707.13f019cf.cohuck@redhat.com>
In-Reply-To: <a5a613ef-4c74-ad68-46bd-7159fbafef47@linux.ibm.com>
References: <20201202234101.32169-1-akrowiak@linux.ibm.com>
        <20201203185514.54060568.pasic@linux.ibm.com>
        <a5a613ef-4c74-ad68-46bd-7159fbafef47@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com

On Fri, 4 Dec 2020 11:48:24 -0500
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 12/3/20 12:55 PM, Halil Pasic wrote:
> > On Wed,  2 Dec 2020 18:41:01 -0500
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >  
> >> The vfio_ap device driver registers a group notifier with VFIO when the
> >> file descriptor for a VFIO mediated device for a KVM guest is opened to
> >> receive notification that the KVM pointer is set (VFIO_GROUP_NOTIFY_SET_KVM
> >> event). When the KVM pointer is set, the vfio_ap driver stashes the pointer
> >> and calls the kvm_get_kvm() function to increment its reference counter.
> >> When the notifier is called to make notification that the KVM pointer has
> >> been set to NULL, the driver should clean up any resources associated with
> >> the KVM pointer and decrement its reference counter. The current
> >> implementation does not take care of this clean up.
> >>
> >> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>  
> > Do we need a Fixes tag? Do we need this backported? In my opinion
> > this is necessary since the interrupt patches.  
> 
> I'll put in a fixes tag:
> Fixes: 258287c994de (s390: vfio-ap: implement mediated device open callback)

The canonical format would be

Fixes: 258287c994de ("s390: vfio-ap: implement mediated device open callback")

> 
> Yes, this should probably be backported.
> 
> >  
> >> ---
> >>   drivers/s390/crypto/vfio_ap_ops.c | 21 +++++++++++++--------
> >>   1 file changed, 13 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> >> index e0bde8518745..eeb9c9130756 100644
> >> --- a/drivers/s390/crypto/vfio_ap_ops.c
> >> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> >> @@ -1083,6 +1083,17 @@ static int vfio_ap_mdev_iommu_notifier(struct notifier_block *nb,
> >>   	return NOTIFY_DONE;
> >>   }
> >>   
> >> +static void vfio_ap_mdev_put_kvm(struct ap_matrix_mdev *matrix_mdev)  
> > I don't like the name. The function does more that put_kvm. Maybe
> > something  like _disconnect_kvm()?  
> Since the vfio_ap_mdev_set_kvm() function is called by the
> notifier when the KVM pointer is set, how about:
> 
> vfio_ap_mdev_unset_kvm()
> 
> for when the KVM pointer is nullified?

Sounds good to me.
