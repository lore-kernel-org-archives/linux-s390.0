From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [FIXUP v11] fixup! s390: vfio-ap: implement mediated device
 open callback
Date: Fri, 28 Sep 2018 15:46:47 +0200
Message-ID: <20180928154647.5092c8e9.cohuck@redhat.com>
References: <20180928121429.7323d78b.cohuck@redhat.com>
        <20180928133321.31884-1-akrowiak@linux.vnet.ibm.com>
        <20180928153506.3521bc33.cohuck@redhat.com>
        <9da2f32b-2d58-fcd1-a830-1fba0ed8bc0c@linux.ibm.com>
        <feaecda1-0da7-a23e-671b-a98799481aaf@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <feaecda1-0da7-a23e-671b-a98799481aaf@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, Tony Krowiak <akrowiak@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 28 Sep 2018 15:42:35 +0200
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> On 09/28/2018 03:41 PM, Halil Pasic wrote:
> > 
> > 
> > On 09/28/2018 03:35 PM, Cornelia Huck wrote:  
> >> On Fri, 28 Sep 2018 09:33:21 -0400
> >> Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:
> >>  
> >>> From: Tony Krowiak <akrowiak@linux.ibm.com>
> >>>
> >>> Fixes case statement in vfio_ap_mdev_copy_masks() function in
> >>> vfio-ap-ops.c.
> >>> ---
> >>>  drivers/s390/crypto/vfio_ap_ops.c | 3 ++-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> >>> index e1e1beaaeba5..86b42487a51c 100644
> >>> --- a/drivers/s390/crypto/vfio_ap_ops.c
> >>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> >>> @@ -741,11 +741,12 @@ static void vfio_ap_mdev_copy_masks(struct ap_matrix_mdev *matrix_mdev)
> >>>  		break;
> >>>  	case CRYCB_FORMAT1:
> >>>  	case CRYCB_FORMAT0:
> >>> -	default:
> >>>  		apm = (unsigned long *)crycb->apcb0.apm;
> >>>  		aqm = (unsigned long *)crycb->apcb0.aqm;
> >>>  		adm = (unsigned long *)crycb->apcb0.adm;
> >>>  		break;
> >>> +	default:
> >>> +		return;  
> >>
> >> /* cannot happen */
> >>
> >> ?  
> > 
> > Or use something like BUG(). Without conveying that default is illegal we
> > don't gain anything over the previous version IMHO.  
> 
> Only WARN_ON, if at all.

Agreed.

This is only a marker for some future developer who might need to deal
with a new format.
