Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 3 Dec 2020 18:01:41 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH] s390/vfio-ap: Clean up vfio_ap resources when KVM
 pointer invalidated
Message-ID: <20201203180141.19425931.pasic@linux.ibm.com>
In-Reply-To: <20201203111907.72a89884.cohuck@redhat.com>
References: <20201202234101.32169-1-akrowiak@linux.ibm.com>
        <20201203111907.72a89884.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com, david@redhat.com

On Thu, 3 Dec 2020 11:19:07 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> > @@ -1095,7 +1106,7 @@ static int vfio_ap_mdev_group_notifier(struct notifier_block *nb,
> >  	matrix_mdev = container_of(nb, struct ap_matrix_mdev, group_notifier);
> >  
> >  	if (!data) {
> > -		matrix_mdev->kvm = NULL;
> > +		vfio_ap_mdev_put_kvm(matrix_mdev);  
> 
> Hm. I'm wondering whether you need to hold the maxtrix_dev lock here as
> well?

In v12 we eventually did come along and patch "s390/vfio-ap: allow hot
plug/unplug of AP resources using mdev device" made this a part of a
critical section protected by the matrix_dev->lock.

IMHO the cleanup should definitely happen with the matrix_dev->lock held.

Regards,
Halil
