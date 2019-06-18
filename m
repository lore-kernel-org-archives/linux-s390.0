Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47312 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729308AbfFRQ0W (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 18 Jun 2019 12:26:22 -0400
Date: Tue, 18 Jun 2019 18:25:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v4 3/7] s390: zcrypt: driver callback to indicate
 resource in use
Message-ID: <20190618182558.7d7e025a.cohuck@redhat.com>
In-Reply-To: <1560454780-20359-4-git-send-email-akrowiak@linux.ibm.com>
References: <1560454780-20359-1-git-send-email-akrowiak@linux.ibm.com>
        <1560454780-20359-4-git-send-email-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, freude@linux.ibm.com, borntraeger@de.ibm.com, frankja@linux.ibm.com, david@redhat.com, mjrosato@linux.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com, alex.williamson@redhat.com, kwankhede@nvidia.com

On Thu, 13 Jun 2019 15:39:36 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> Introduces a new driver callback to prevent a root user from unbinding
> an AP queue from its device driver if the queue is in use. This prevents
> a root user from inadvertently taking a queue away from a guest and
> giving it to the host, or vice versa. The callback will be invoked
> whenever a change to the AP bus's apmask or aqmask sysfs interfaces may
> result in one or more AP queues being removed from its driver. If the
> callback responds in the affirmative for any driver queried, the change
> to the apmask or aqmask will be rejected with a device in use error.
> 
> For this patch, only non-default drivers will be queried. Currently,
> there is only one non-default driver, the vfio_ap device driver. The
> vfio_ap device driver manages AP queues passed through to one or more
> guests and we don't want to unexpectedly take AP resources away from
> guests which are most likely independently administered.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/ap_bus.c | 138 +++++++++++++++++++++++++++++++++++++++++--
>  drivers/s390/crypto/ap_bus.h |   3 +
>  2 files changed, 135 insertions(+), 6 deletions(-)

Hm... I recall objecting to this patch before, fearing that it makes it
possible for a bad actor to hog resources that can't be removed by
root, even forcefully. (I have not had time to look at the intervening
versions, so I might be missing something.)

Is there a way for root to forcefully override this?
